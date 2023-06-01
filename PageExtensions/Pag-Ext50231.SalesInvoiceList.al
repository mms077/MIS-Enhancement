pageextension 50231 "Sales Invoice List" extends "Sales Invoice List"
{
    layout
    {
        modify(Amount)
        {
            Visible = PriceVisible;
        }
    }
    trigger OnOpenPage()
    var
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.AllowShowSalesPrice() then
            PriceVisible := true
        else
            PriceVisible := false;
    end;

    var
        PriceVisible: Boolean;
}
