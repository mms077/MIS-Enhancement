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
                    begin
                        Report.RunModal(Report::"ER - Bank Acc. Statement");
                    end;
                }
            }
        }
    }
}
