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
    }
}
