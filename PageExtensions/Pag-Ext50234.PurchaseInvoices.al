pageextension 50234 "Purchase Invoices" extends "Purchase Invoices"
{
    layout
    {
        modify(Amount)
        {
            Visible = CostVisible;
        }
    }
    trigger OnOpenPage()
    var
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.AllowShowCost() then
            CostVisible := true
        else
            CostVisible := false;
    end;

    var
        CostVisible: Boolean;
}