pageextension 50260 "Warehouse Shipment List" extends "Warehouse Shipment List"
{
    actions
    {

        addafter("F&unctions")
        {
            action("Refresh Qty. to Assemble")//validate the qty to ship of the warehouse shipment line to refresh the qty to assemble in the Assembly Header
            {
                ApplicationArea = All;
                Image = ValidateEmailLoggingSetup;
                Caption = 'Refresh Qty. to Assemble';
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
