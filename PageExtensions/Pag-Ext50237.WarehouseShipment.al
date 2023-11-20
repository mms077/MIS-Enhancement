pageextension 50237 "Warehouse Shipment" extends "Warehouse Shipment"
{
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
}
