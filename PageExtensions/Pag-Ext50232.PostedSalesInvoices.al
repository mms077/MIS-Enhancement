pageextension 50232 "Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        modify(Amount)
        {
            Visible = PriceVisible;
        }
        modify("Amount Including VAT")
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