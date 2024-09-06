pageextension 50237 "Warehouse Shipment" extends "Warehouse Shipment"
{
    layout
    {
        addafter("Sorting Method")
        {
            field("Sales Invoice No."; rec."Sales Invoice No.")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    SalesHeader: Record "Sales Header";
                    XWhseShipHeader: Code[1000];
                    WhseShipHeader: Record "Warehouse Shipment Header";
                    TempWhseShipHeader: Text;
                    NewWhseShipHeader: Text;
                    CurrentSalesInvNo: Text;
                begin
                    // Get the Sales Header record for the provided Sales Invoice No.
                    if SalesHeader.Get(SalesHeader."Document Type"::Invoice, Rec."Sales Invoice No.") then begin
                        CurrentSalesInvNo := rec."No.";
                        // Clear the existing Warehouse Shipment No. in SalesHeader
                        SalesHeader."Warehouse Shipment No." := '';

                        // Initialize TempWhseShipHeader to build the concatenated Warehouse Shipment No.
                        TempWhseShipHeader := '';

                        // Filter WhseShipHeader records based on the Sales Invoice No.
                        WhseShipHeader.SetRange("Sales Invoice No.", Rec."Sales Invoice No.");

                        // If there are related Warehouse Shipment Headers, concatenate them
                        if WhseShipHeader.FindSet() then begin
                            repeat
                                // Concatenate the Warehouse Shipment No. for each WhseShipHeader record
                                if TempWhseShipHeader <> '' then
                                    TempWhseShipHeader := TempWhseShipHeader + '|' + WhseShipHeader."No."
                                else
                                    TempWhseShipHeader := WhseShipHeader."No.";
                            until WhseShipHeader.Next() = 0;

                            // Update the SalesHeader with the concatenated Warehouse Shipment No.
                            SalesHeader."Warehouse Shipment No." := CurrentSalesInvNo + '|' + TempWhseShipHeader;
                            SalesHeader.Modify();
                        end else begin


                            SalesHeader."Warehouse Shipment No." := rec."No.";
                            SalesHeader.Modify();
                        end;
                    end else begin
                        RemoveShipmentFromSalesHeader(xRec."Sales Invoice No.", rec."No.");
                    end;
                end;
            }
            field(Printed; rec.Printed) { ApplicationArea = all; Editable = CanEditERCommercial; }
        }

    }
    actions
    {
        addafter("&Print")
        {
            action("Detailed Warehouse Shipment")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    WarehouseShipmentHeader: Record "Warehouse Shipment Header";
                begin
                    WarehouseShipmentHeader.SetFilter("No.", Rec."No.");
                    Report.Run(Report::"Detailed Warehouse Shipment", true, true, WarehouseShipmentHeader);
                end;
            }
        }

        addbefore("Create Pick")
        {
            action("Refresh Qty. to Assemble")//validate the qty to ship of the warehouse shipment line to refresh the qty to assemble in the Assembly Header
            {
                ApplicationArea = All;
                Image = ValidateEmailLoggingSetup;
                Caption = 'Refresh Qty. to Assemble';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    CeeAntCu: Codeunit CeeAnt;
                begin
                    CeeAntCu.RefreshQtyToAssemble(Rec);
                end;
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        //Prohibit Modifying after Printing
        if Rec.Printed then
            Error('You cannot Modify the Document because it is Printed');
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if UserSetup."Can Edit Print ER- Commercial" then
            CanEditERCommercial := true
        else
            CanEditERCommercial := false;
    end;

    procedure RemoveShipmentFromSalesHeader(SalesInvoiceNo: Code[20]; ShipmentNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
        TempWhseShipHeader: Text[1024];
        Delimiter: Text[1];
        RemainingShipments: Text[1024];
        Pos: Integer;
    begin
        Delimiter := '|';

        // Get the Sales Header record for the provided Sales Invoice No.
        if SalesHeader.Get(SalesHeader."Document Type"::Invoice, SalesInvoiceNo) then begin
            TempWhseShipHeader := '';
            // Get the current value of the Warehouse Shipment No. field
            TempWhseShipHeader := SalesHeader."Warehouse Shipment No.";

            // Find the position of the shipment number in the string
            Pos := StrPos(TempWhseShipHeader, ShipmentNo);
            if Pos > 0 then begin
                // Remove the shipment number with the following delimiter if it exists
                // Remove the leading delimiter if the shipment is in the middle or end
                if Pos > 1 then
                    TempWhseShipHeader := CopyStr(TempWhseShipHeader, 1, Pos - 2) + CopyStr(TempWhseShipHeader, Pos + StrLen(ShipmentNo) + 1)
                else
                    TempWhseShipHeader := CopyStr(TempWhseShipHeader, StrLen(ShipmentNo) + 2);
                if TempWhseShipHeader = '' then begin// if there is no more shipments in whse shipment no. then clear it
                    SalesHeader."Warehouse Shipment No." := TempWhseShipHeader;
                    SalesHeader.Modify();
                    exit;
                end;

                // Clean up any trailing delimiter
                if CopyStr(TempWhseShipHeader, StrLen(TempWhseShipHeader), 1) = Delimiter then
                    TempWhseShipHeader := CopyStr(TempWhseShipHeader, 1, StrLen(TempWhseShipHeader) - 1);

                // Update the SalesHeader with the new concatenated Warehouse Shipment No.
                SalesHeader."Warehouse Shipment No." := TempWhseShipHeader;
                SalesHeader.Modify();
            end;
        end;
    end;






    var
        CanEditERCommercial: boolean;
}

