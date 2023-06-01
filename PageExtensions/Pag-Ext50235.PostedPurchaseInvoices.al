pageextension 50235 "Posted Purchase Invoices" extends "Posted Purchase Invoices"
{
    layout
    {
        modify(Amount)
        {
            Visible = CostVisible;
        }
        modify("Amount Including VAT")
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