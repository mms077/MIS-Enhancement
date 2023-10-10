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
    actions
    {
        addafter("&Invoice")

        {
            action("Adjust ACY Rate")
            {
                ApplicationArea = All;
                RunObject = report "Adjust Acy Rate";
                Visible = AdjustRateVisible;
                Image = EditAdjustments;
            }

        }
        addfirst(Promoted)
        {
            group(AdjustAcyRate)
            {
                Caption = 'Adjust ACY Rate';
                actionref("Adjust_ACY_Rate"; "Adjust ACY Rate")
                {
                }
            }
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

        if UserSetup.Get(UserId) then begin
            if UserSetup."Adjust ACY Rate" then
                AdjustRateVisible := true
            else
                AdjustRateVisible := false;
        end;


    end;

    var
        CostVisible: Boolean;
        AdjustRateVisible: Boolean;
        UserSetup: Record "User Setup";

}