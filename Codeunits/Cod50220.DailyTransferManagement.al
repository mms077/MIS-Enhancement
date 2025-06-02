codeunit 50220 "Daily Transfer Management"
{
    procedure ProcessScannerInput(var DailyTransferHeader: Record "Daily Transfer Header")
    var
        ScannerInputType: Enum "Scanner Input Type";
        PostedAssemblyOrderNo: Code[20];
        LinesCountBefore: Integer;
        LinesCountAfter: Integer;
    begin
        if DailyTransferHeader."Scanner Input" = '' then
            exit;


        ScannerInputType := DetermineScannerInputType(DailyTransferHeader."Scanner Input", PostedAssemblyOrderNo);

        case ScannerInputType of
            ScannerInputType::"Assembly Order":
                ProcessAssemblyOrder(DailyTransferHeader, DailyTransferHeader."Scanner Input");
            ScannerInputType::"Posted Assembly Order":
                ProcessPostedAssemblyOrder(DailyTransferHeader, PostedAssemblyOrderNo);
            ScannerInputType::"Serial Number":
                ProcessSerialNumber(DailyTransferHeader, DailyTransferHeader."Scanner Input");
        end;

        // Count lines after processing and show message if no new lines were added

        DailyTransferHeader."Scanner Input" := ''; // Clear after processing
        DailyTransferHeader.Modify();
    end;

    local procedure DetermineScannerInputType(ScannerInput: Code[50]; var PostedAssemblyOrderNo: Code[20]): Enum "Scanner Input Type"
    var
        AssemblyHeader: Record "Assembly Header";
        PostedAssemblyHeader: Record "Posted Assembly Header";
    begin
        // Check if it's an Assembly Order
        if AssemblyHeader.Get(1, ScannerInput) then
            exit("Scanner Input Type"::"Assembly Order");

        // Check if it's a Posted Assembly Order by No.
        if PostedAssemblyHeader.Get(ScannerInput) then begin
            PostedAssemblyOrderNo := ScannerInput;
            exit("Scanner Input Type"::"Posted Assembly Order");
        end;

        // Check if it's a Posted Assembly Order by Order No.
        PostedAssemblyHeader.SetRange("Order No.", ScannerInput);
        if PostedAssemblyHeader.FindFirst() then begin
            PostedAssemblyOrderNo := PostedAssemblyHeader."No.";
            exit("Scanner Input Type"::"Posted Assembly Order");
        end;

        // Default to Serial Number
        exit("Scanner Input Type"::"Serial Number");
    end;

    local procedure ProcessAssemblyOrder(DailyTransferHeader: Record "Daily Transfer Header"; AssemblyOrderNo: Code[20])
    var
        AssemblyHeader: Record "Assembly Header";
        ReservationEntry: Record "Reservation Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        SerialNo: Code[50];
        WarningText: Text;
    begin
        if not AssemblyHeader.Get(1, AssemblyOrderNo) then
            exit;

        // Warning if not posted
        WarningText := 'WARNING: Assembly Order not posted yet';

        // Find serials related to this assembly order through reservations
        ReservationEntry.SetRange("Source Type", Database::"Assembly Header");
        ReservationEntry.SetRange("Source ID", AssemblyOrderNo);
        ReservationEntry.SetRange("Source Subtype", 1);
        if ReservationEntry.FindSet() then
            repeat
                SerialNo := ReservationEntry."Serial No.";
                if SerialNo <> '' then begin
                    // Check if serial is still in the from location
                    ItemLedgerEntry.SetRange("Serial No.", SerialNo);
                    ItemLedgerEntry.SetRange("Location Code", DailyTransferHeader."From Location");
                    ItemLedgerEntry.SetFilter("Remaining Quantity", '>0');
                    if ItemLedgerEntry.FindFirst() then begin
                        // Find transfer order connection
                        if FindTransferOrderForSerial(SerialNo, TransferHeader, TransferLine) then
                            CreateDailyTransferLine(DailyTransferHeader, SerialNo, TransferHeader."No.", TransferLine."Line No.", WarningText);
                    end;
                end;
            until ReservationEntry.Next() = 0;
    end;

    local procedure ProcessPostedAssemblyOrder(DailyTransferHeader: Record "Daily Transfer Header"; PostedAssemblyOrderNo: Code[20])
    var
        PostedAssemblyHeader: Record "Posted Assembly Header";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        SerialNo: Code[50];
    begin
        if not PostedAssemblyHeader.Get(PostedAssemblyOrderNo) then
            exit;

        // Find serials produced by this posted assembly order
        ItemLedgerEntry.SetRange("Document No.", PostedAssemblyOrderNo);
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::"Assembly Output");
        ItemLedgerEntry.SetRange("Location Code", DailyTransferHeader."From Location");
        ItemLedgerEntry.SetFilter("Remaining Quantity", '>0');
        if ItemLedgerEntry.FindSet() then
            repeat
                SerialNo := ItemLedgerEntry."Serial No.";
                if SerialNo <> '' then begin
                    // Find transfer order connection
                    if FindTransferOrderForSerial(SerialNo, TransferHeader, TransferLine) then
                        CreateDailyTransferLine(DailyTransferHeader, SerialNo, TransferHeader."No.", TransferLine."Line No.", '');
                end;
            until ItemLedgerEntry.Next() = 0;
    end;

    local procedure ProcessSerialNumber(DailyTransferHeader: Record "Daily Transfer Header"; SerialNo: Code[50])
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
    begin
        // Check if serial exists in the from location
        ItemLedgerEntry.SetRange("Serial No.", SerialNo);
        ItemLedgerEntry.SetRange("Location Code", DailyTransferHeader."From Location");
        ItemLedgerEntry.SetFilter("Remaining Quantity", '>0');
        if ItemLedgerEntry.FindFirst() then begin
            // Find transfer order connection
            if FindTransferOrderForSerial(SerialNo, TransferHeader, TransferLine) then
                CreateDailyTransferLine(DailyTransferHeader, SerialNo, TransferHeader."No.", TransferLine."Line No.", '');
        end;
    end;

    local procedure FindTransferOrderForSerial(SerialNo: Code[50]; var TransferHeader: Record "Transfer Header"; var TransferLine: Record "Transfer Line"): Boolean
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        // Find transfer order through reservation entries
        ReservationEntry.SetRange("Serial No.", SerialNo);
        ReservationEntry.SetRange("Source Type", Database::"Transfer Line");
        ReservationEntry.SetRange("Source Subtype", 0); // Outbound
        if ReservationEntry.FindFirst() then begin
            if TransferLine.Get(ReservationEntry."Source ID", ReservationEntry."Source Ref. No.") then begin
                if TransferHeader.Get(TransferLine."Document No.") then
                    exit(true);
            end;
        end;
        exit(false);
    end;

    local procedure CreateDailyTransferLine(DailyTransferHeader: Record "Daily Transfer Header"; SerialNo: Code[50]; TransferOrderNo: Code[20]; TransferLineNo: Integer; Warning: Text)
    var
        DailyTransferLine: Record "Daily Transfer Line";
        ExistingLine: Record "Daily Transfer Line";
        LineNo: Integer;
        TransferLine: Record "Transfer Line";
    begin
        // Check if line with same serial number already exists
        ExistingLine.SetRange("No.", DailyTransferHeader."Code");
        ExistingLine.SetRange("Serial No.", SerialNo);
        if ExistingLine.FindFirst() then begin
            // Update existing line instead of creating duplicate
            if (ExistingLine."Transfer Order No." <> TransferOrderNo) or
               (ExistingLine."Transfer Line No." <> TransferLineNo) or
               (ExistingLine."Warning" <> Warning) then begin
                ExistingLine."Transfer Order No." := TransferOrderNo;
                ExistingLine."Transfer Line No." := TransferLineNo;
                ExistingLine."Warning" := CopyStr(Warning, 1, MaxStrLen(ExistingLine."Warning"));
                if TransferLine.Get(TransferOrderNo, TransferLineNo) then
                    ExistingLine."To Location" := TransferLine."Transfer-to Code";
                ExistingLine.Modify();
            end;
            exit; // Don't create new line
        end;

        // Get next line number
        DailyTransferLine.SetRange("No.", DailyTransferHeader."Code");
        if DailyTransferLine.FindLast() then
            LineNo := DailyTransferLine."Line No." + 10000
        else
            LineNo := 10000;

        // Get locations from transfer line
        if TransferLine.Get(TransferOrderNo, TransferLineNo) then begin
            DailyTransferLine.Init();
            DailyTransferLine."No." := DailyTransferHeader."Code";
            DailyTransferLine."Line No." := LineNo;
            DailyTransferLine."From Location" := DailyTransferHeader."From Location";
            DailyTransferLine."To Location" := TransferLine."Transfer-to Code";
            DailyTransferLine."Serial No." := SerialNo;
            DailyTransferLine."Transfer Order No." := TransferOrderNo;
            DailyTransferLine."Transfer Line No." := TransferLineNo;
            DailyTransferLine."Warning" := CopyStr(Warning, 1, MaxStrLen(DailyTransferLine."Warning"));
            DailyTransferLine.Insert();
        end;
    end;

    procedure GetNextLineNo(DailyTransferHeaderCode: Code[20]): Integer
    var
        DailyTransferLine: Record "Daily Transfer Line";
    begin
        DailyTransferLine.SetRange("No.", DailyTransferHeaderCode);
        if DailyTransferLine.FindLast() then
            exit(DailyTransferLine."Line No." + 10000)
        else
            exit(10000);
    end;



    #region CreateWarehouseShipmentAndPick
    procedure CreateWarehouseShipmentAndPick(DailyTransferHeaderCode: Record "Daily Transfer Header")
    var
        DailyTransferLine: Record "Daily Transfer Line";
        TransferHeader: Record "Transfer Header";
        Location: Record Location;
        WhseShipmentHeader: Record "Warehouse Shipment Header";
        WhseReceiptHeader: Record "Warehouse Receipt Header";
        WhseShipmentLine: Record "Warehouse Shipment Line";
        TempTransferHeader: Record "Transfer Header" temporary;
        ErrorText: Text;
        ProcessTransfer: Boolean;
        ProcessedTOLines: List of [Code[20]];
        WhseManagement: Codeunit "Whse. Management";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        WhseRqst: Record "Warehouse Request";
        GetSourceDocuments: Report "Get Source Documents";
        TOCode: Code[20];
    begin

        // Get all lines for this daily transfer
        DailyTransferLine.SetRange("No.", DailyTransferHeaderCode.Code);
        DailyTransferLine.SetFilter("Transfer Order No.", '<>%1', '');
        if DailyTransferLine.FindSet() then begin
            ReleaseTransferHeader(DailyTransferLine."Transfer Order No.");
            // GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(TransferHeader);
            // GetSourceDocuments.GetLastShptHeader(WhseShipmentHeader);
            CreateWarehouseShiphmentHeader(WhseShipmentHeader, DailyTransferHeaderCode."From Location");
            // Group by transfer order and validate warehouse setup
            repeat
                SerialNoSet.Add(DailyTransferLine."Serial No.");
                if not ProcessedTOLines.Contains(DailyTransferLine."Transfer Order No.") then begin
                    ReleaseTransferHeader(DailyTransferLine."Transfer Order No.");
                    CreateWarehouseShipmentForTransferLine(WhseShipmentHeader, DailyTransferLine."Transfer Order No.", DailyTransferLine."Transfer Line No.", WhShpLine);
                    ProcessedTOLines.add(DailyTransferLine."Transfer Order No.");
                end;
            until DailyTransferLine.Next() = 0;

            // Open the created warehouse shipment
            ProcessWhseShipment(WhseShipmentHeader, DailyTransferHeaderCode."From Location", WhShpLine, SerialNoSet);

            CreateWarehouseReceiptHeader(WhseReceiptHeader, DailyTransferHeaderCode."To Location");
            foreach TOCode in ProcessedTOLines do
                CreateWarehouseReceiptForTransferLine(WhseReceiptHeader, TOCode);
            ProcessWhseReceipt(WhseReceiptHeader."No.", DailyTransferHeaderCode."To Location");
        end else begin
            Error('No transfer lines found for daily transfer header %1.', DailyTransferHeaderCode.Code);
        end;
    end;

    local procedure ProcessWhseReceipt(WhseReceiptHeaderNo: Code[20]; ReceiptLocation: Code[10])
    var
        WhseRecptLine: Record "Warehouse Receipt Line";
        WhsePostReceipt: Codeunit "Whse.-Post Receipt";
        PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header";
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        CreatePutAwayFromWhseSource: Report "Whse.-Source - Create Document";
        WhseActReg: Codeunit "Whse.-Activity-Register";
        WhseActivityLine: Record "Warehouse Activity Line";
    begin
        WhseRecptLine.Get(WhseReceiptHeaderNo, '10000');
        WhsePostReceipt.Run(WhseRecptLine);
        PostedWhseReceiptHeader.SetRange("Whse. Receipt No.", WhseReceiptHeaderNo);
        if PostedWhseReceiptHeader.FindFirst() then begin
            PostedWhseRcptLine.SetRange("No.", PostedWhseReceiptHeader."No.");
            PostedWhseRcptLine.SetFilter(Quantity, '>0');
            PostedWhseRcptLine.SetFilter(Status, '<>%1', PostedWhseRcptLine.Status::"Completely Put Away");
            if PostedWhseRcptLine.Find('-') then begin
                CreatePutAwayFromWhseSource.SetPostedWhseReceiptLine(PostedWhseRcptLine, PostedWhseReceiptHeader."Assigned User ID");
                CreatePutAwayFromWhseSource.SetHideValidationDialog(true);
                CreatePutAwayFromWhseSource.UseRequestPage(false);
                CreatePutAwayFromWhseSource.RunModal();
                WhseActivityLine.SetRange("Whse. Document No.", PostedWhseRcptLine."No.");
                if WhseActivityLine.FindSet() then
                    WhseActReg.Run(WhseActivityLine);
            end;
        end;
    end;

    procedure CreateWarehouseReceiptHeader(var WhseReceiptHeader: Record "Warehouse Receipt Header"; ShipmentLocation: Code[10])
    var
        NoSeries: Codeunit "No. Series";
        WarehouseSetup: Record "Warehouse Setup";
        Location: Record Location;
    begin
        Location.Get(ShipmentLocation);
        WarehouseSetup.Get();
        WhseReceiptHeader.Init();
        WhseReceiptHeader.Validate("No.", NoSeries.GetNextNo(WarehouseSetup."Whse. Receipt Nos."));
        WhseReceiptHeader.Validate("Location Code", ShipmentLocation);
        WhseReceiptHeader.Validate("Posting Date", Today());
        WhseReceiptHeader.Validate("Bin Code", Location."Receipt Bin Code");
        WhseReceiptHeader.Validate("Receiving No. Series", WarehouseSetup."Posted Whse. Receipt Nos.");
        // WhseReceiptHeader."Receiving Agent Code" := TransferHeader."Receiving Agent Code";
        // WhseReceiptHeader."Receiving Agent Service Code" := TransferHeader."Receiving Agent Service Code";
        WhseReceiptHeader.Insert();
    end;

    local procedure CreateWarehouseReceiptForTransferLine(WhseReceiptHeader: Record "Warehouse Receipt Header"; TransferOrderNo: Code[20])
    var
        TransferWhseMgt: Codeunit "Transfer Warehouse Mgt.";
        TransferLine: Record "Transfer Line";
        NoSeries: Codeunit "No. Series";
    begin
        Clear(TransferLine);
        TransferLine.SetRange("Document No.", TransferOrderNo);
        TransferLine.SetFilter("Qty. in Transit", '>0');
        if TransferLine.FindFirst() then
            TransferWhseMgt.TransLine2ReceiptLine(WhseReceiptHeader, TransferLine);
    end;

    local procedure CreateWarehouseShipmentForTransferLine(WhseShipmentHeader: Record "Warehouse Shipment Header"; TransferOrderNo: Code[20]; TransferLineNo: Integer; var WhShpLine: Record "Warehouse Shipment Line")
    var
        WhseShipmentLine: Record "Warehouse Shipment Line";
        TransferLine: Record "Transfer Line";
        NoSeries: Codeunit "No. Series";
        WhseManagement: Codeunit "Whse. Management";
        WarehouseSetup: Record "Warehouse Setup";
        TransferWhseMgt: Codeunit "Transfer Warehouse Mgt.";

    begin
        TransferLine.get(TransferOrderNo, TransferLineNo);
        TransferWhseMgt.FromTransLine2ShptLine(WhseShipmentHeader, TransferLine);
    end;

    local procedure CreateWarehouseShiphmentHeader(var WhseShipmentHeader: Record "Warehouse Shipment Header"; ShipmentLocation: Code[10])
    var
        NoSeries: Codeunit "No. Series";
        WarehouseSetup: Record "Warehouse Setup";
        Location: Record Location;
    begin
        Location.Get(ShipmentLocation);
        WarehouseSetup.Get();
        WhseShipmentHeader.Init();
        WhseShipmentHeader.Validate("No.", NoSeries.GetNextNo(WarehouseSetup."Whse. Ship Nos."));
        WhseShipmentHeader.Validate("Location Code", ShipmentLocation);
        WhseShipmentHeader.Validate("Shipment Date", Today());
        WhseShipmentHeader.Validate("Posting Date", Today());
        WhseShipmentHeader.Validate("Bin Code", Location."Shipment Bin Code");
        WhseShipmentHeader.Validate("Shipping No. Series", WarehouseSetup."Posted Whse. Shipment Nos.");
        // WhseShipmentHeader."Shipping Agent Code" := TransferHeader."Shipping Agent Code";
        // WhseShipmentHeader."Shipping Agent Service Code" := TransferHeader."Shipping Agent Service Code";
        WhseShipmentHeader.Insert();
    end;

    local procedure ProcessWhseShipment(WhseShipmentHeader: Record "Warehouse Shipment Header"; ShipmentLocation: Code[10]; var WhShpLine: Record "Warehouse Shipment Line"; var SerialNoSet: List of [Code[50]])
    var
        WhseActReg: Codeunit "Whse.-Activity-Register";
        WhsePostShipment: Codeunit "Whse.-Post Shipment";
        WhseShipmentRelease: Codeunit "Whse.-Shipment Release";
        WarehouseActivityLine: Record "Warehouse Activity Line";
        DailyTransferLine: Record "Daily Transfer Line";
        WhseShipmentCreatePick: Report "Whse.-Shipment - Create Pick";
        FirstWhseDocNo: Code[20];
        LastWhseDocNo: Code[20];
        Location: Record Location;
    begin
        Location.get(WhseShipmentHeader."Location Code");
        WhseShipmentRelease.Release(WhseShipmentHeader);
        WhShpLine.SetRange("No.", WhseShipmentHeader."No.");
        WhShpLine.SetCurrentKey("Line No.");
        WhShpLine.SetAscending("Line No.", true);
        if WhShpLine.FindLast() then begin
            WhseShipmentCreatePick.SetWhseShipmentLine(WhShpLine, WhseShipmentHeader);
            WhseShipmentCreatePick.SetHideValidationDialog(true);
            WhseShipmentCreatePick.UseRequestPage(false);
            WhseShipmentCreatePick.RunModal();
        end;

        // Filter Warehouse Activity Line for this transfer order/line, but exclude serials in SerialNoSet
        WarehouseActivityLine.SetRange("Whse. Document No.", WhShpLine."No.");
        if WarehouseActivityLine.FindSet() then
            repeat
                if not SerialNoSet.Contains(WarehouseActivityLine."Serial No.") then begin
                    if WarehouseActivityLine."Action Type" = WarehouseActivityLine."Action Type"::"Take" then begin
                        // Set Qty. to Handle (Base) to 0 for all lines not in SerialNoSet
                        WarehouseActivityLine.Validate("Bin Code", Location."From-Assembly Bin Code");
                        WarehouseActivityLine.Validate("Qty. to Handle (Base)", 0);
                        WarehouseActivityLine.Modify();
                    end else begin
                        WarehouseActivityLine.Validate("Qty. to Handle (Base)", 0);
                        WarehouseActivityLine.Modify();
                    end;
                end else if WarehouseActivityLine."Action Type" = WarehouseActivityLine."Action Type"::"Take" then begin
                    WarehouseActivityLine.Validate("Bin Code", Location."From-Assembly Bin Code");
                    WarehouseActivityLine.Modify();
                end;
            until WarehouseActivityLine.Next() = 0;

        WarehouseActivityLine.SetRange("Whse. Document No.", WhShpLine."No.");
        if WarehouseActivityLine.FindSet() then
            //Register the Warehouse Pick
            WhseActReg.Run(WarehouseActivityLine);
        //Post the Warehouse Shipment
        WhsePostShipment.Run(WhShpLine);
        Clear(WarehouseActivityLine);
        WarehouseActivityLine.SetRange("Whse. Document No.", WhShpLine."No.");
        if WarehouseActivityLine.FindSet() then
            WarehouseActivityLine.DeleteAll();
        Clear(WhseShipmentHeader);
        if WhseShipmentHeader.Get(WhShpLine."No.") then begin
            WhseShipmentRelease.Reopen(WhseShipmentHeader);
            WhseShipmentHeader.Delete(true);
        end;
    end;

    procedure ReleaseTransferHeader(TONo: Code[20])
    var
        TransferHeader: Record "Transfer Header";
        ReleaseTransfer: Codeunit "Release Transfer Document";
    begin
        TransferHeader.get(TONo);
        ReleaseTransfer.Release(TransferHeader);
    end;


    #endregion CreateWarehouseShipmentAndPick

    var
        WhShpLine: Record "Warehouse Shipment Line";
        SerialNoSet: List of [Code[50]];
}