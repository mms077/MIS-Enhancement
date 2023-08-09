pageextension 50251 "Bank Account List" extends "Bank Account List"
{
    actions
    {
        addfirst(reporting)
        {
            group("ER - Reports")
            {
                Image = Report;
                action("ER - Bank Account Statement")
                {
                    ApplicationArea = all;
                    Caption = 'ER - Bank Account Statement';
                    Image = Report;
                    trigger OnAction()
                    var
                        BankStatement: Report "ER - Bank Acc. Statement";
                        Bank: Record "Bank Account";
                    begin
                        Bank.SetFilter("No.", Rec."No.");
                        if Bank.FindFirst() then
                            Report.Run(50218, true, true, Bank)
                        else
                            Message('This account does not have entries ');

                    end;
                }
            }
        }
    }
}
