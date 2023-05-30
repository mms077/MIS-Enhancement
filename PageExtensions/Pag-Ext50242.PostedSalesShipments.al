pageextension 50242 "Posted Sales Shipments" extends "Posted Sales Shipments"
{
    actions
    {
        addfirst(Reporting)
        {
            action(PostedSalesShipments)
            {
                Caption = 'Sales - Shipment';
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                var
                    SalesShipmentHeader: Record "Sales Shipment Header";
                begin
                    SalesShipmentHeader.reset;
                    SalesShipmentHeader.SetRange("No.", Rec."No.");
                    if SalesShipmentHeader.FindFirst() then
                        report.run(50213, true, false, SalesShipmentHeader);
                end;
            }
        }
    }
}