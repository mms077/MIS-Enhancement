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

        // Count lines before processing
        LinesCountBefore := CountLines(DailyTransferHeader."Code");

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
        LinesCountAfter := CountLines(DailyTransferHeader."Code");
        if LinesCountAfter = LinesCountBefore then
            Message('No new lines were added. The scanned item may already exist or no valid transfer orders were found.');

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

    procedure ValidateFromLocation(var DailyTransferHeader: Record "Daily Transfer Header")
    var
        DailyTransferLine: Record "Daily Transfer Line";
    begin
        // Update existing lines with new from location
        DailyTransferLine.SetRange("No.", DailyTransferHeader."Code");
        if DailyTransferLine.FindSet() then
            repeat
                DailyTransferLine."From Location" := DailyTransferHeader."From Location";
                DailyTransferLine.Modify();
            until DailyTransferLine.Next() = 0;
    end;

    local procedure CountLines(DailyTransferHeaderCode: Code[20]): Integer
    var
        DailyTransferLine: Record "Daily Transfer Line";
    begin
        DailyTransferLine.SetRange("No.", DailyTransferHeaderCode);
        exit(DailyTransferLine.Count());
    end;

    procedure RemoveDuplicateLines(DailyTransferHeaderCode: Code[20])
    var
        DailyTransferLine: Record "Daily Transfer Line";
        TempDailyTransferLine: Record "Daily Transfer Line" temporary;
        DuplicateLine: Record "Daily Transfer Line";
    begin
        // Find all lines for this header
        DailyTransferLine.SetRange("No.", DailyTransferHeaderCode);
        if DailyTransferLine.FindSet() then begin
            repeat
                // Check if this serial number is already in temp table
                TempDailyTransferLine.SetRange("Serial No.", DailyTransferLine."Serial No.");
                if not TempDailyTransferLine.FindFirst() then begin
                    // First occurrence - keep it
                    TempDailyTransferLine := DailyTransferLine;
                    TempDailyTransferLine.Insert();
                end else begin
                    // Duplicate found - delete it
                    DuplicateLine.Get(DailyTransferLine."No.", DailyTransferLine."Line No.");
                    DuplicateLine.Delete();
                end;
            until DailyTransferLine.Next() = 0;
        end;
    end;
}
