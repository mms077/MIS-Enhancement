pageextension 50237 "Warehouse Shipment" extends "Warehouse Shipment"
{
    layout
    {
        addafter("Sorting Method")
        {
            field("Sales Invoice No."; rec."Sales Invoice No.") { ApplicationArea = all; }
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
        addafter("Detailed Warehouse Shipment")
        {
            action("ER - Commercial Whse Shipment")//validate the qty to ship of the warehouse shipment line to refresh the qty to assemble in the Assembly Header
            {
                ApplicationArea = All;
                Image = ValidateEmailLoggingSetup;
                Caption = 'ER - Commercial Whse Shipment';
                PromotedCategory = Report;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    WhseShipHeader: Record "Warehouse Shipment Header";

                begin
                    Rec.TestField(rec."Sales Invoice No.");
                    WhseShipHeader.SetFilter("No.", Rec."No.");
                    Report.Run(Report::"ER - Commercial Whse Shipment", true, false, WhseShipHeader);
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


    var
        CanEditERCommercial: boolean;
}

