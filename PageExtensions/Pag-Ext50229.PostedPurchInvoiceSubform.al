pageextension 50229 "Posted Purch. Invoice Subform" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        modify("Unit Cost (LCY)")
        {
            Visible = CostVisible;
        }
        modify("Line Amount")
        {
            Visible = CostVisible;
        }
        modify("Total Amount Excl. VAT")
        {
            Visible = CostVisible;
        }
        modify("Total Amount Incl. VAT")
        {
            Visible = CostVisible;
        }
        modify(Control31)
        {
            Visible = CostVisible;
        }
    }
    trigger OnOpenPage()
    var
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.AllowShowSalesPrice() then
            CostVisible := true
        else
            CostVisible := false;
    end;

    var
        CostVisible: Boolean;

}
