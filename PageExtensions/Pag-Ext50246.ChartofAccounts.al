pageextension 50246 "Chart of Accounts" extends "Chart of Accounts"
{
    actions
    {
        addfirst(reporting)
        {
            group("ER - Reports")
            {
                Image = Report;
                action("ER - Trial Balance")
                {
                    Caption = 'ER - Trial Balance';
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = Report "ER - Trial Balance";
                    trigger OnAction()
                    begin
                        Report.RunModal(Report::"ER - Trial Balance");
                    end;
                }
                action("ER - Statement Of Account")
                {
                    Caption = 'ER - Statement Of Account';
                    Image = Report;
                    ApplicationArea = All;
                    // RunObject = Report "ER - Statement Of Account";

                    trigger OnAction()
                    var
                        GlEntry: Record "G/L Entry";
                    begin
                        GlEntry.SetFilter("G/L Account No.", Rec."No.");
                        if GlEntry.FindFirst() then
                            Report.Run(50233, true, true, GlEntry)
                        else
                            Message('This account does not have entries ');
                    end;
                }
            }
        }
    }
}
