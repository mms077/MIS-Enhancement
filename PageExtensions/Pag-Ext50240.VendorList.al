pageextension 50240 "Vendor List" extends "Vendor List"
{
    layout
    {
        addafter(Name)
        {
            field("Payables Account"; Rec."Payables Account")
            {
                ApplicationArea = all;
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = all;
            }
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addfirst(reporting)
        {
            group("ER - Reports")
            {
                Image = Report;
                action("ER - Vendor Statement")
                {
                    ApplicationArea = all;
                    Caption = 'ER - Vendor Statement';
                    Image = Report;
                    trigger OnAction()
                    begin
                        Report.RunModal(Report::"ER - Vendor Statement");
                    end;
                }
                action("ER - Vendor - Summary Aging")
                {
                    Caption = 'ER - Vendor - Summary Aging';
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = Report "ER - Vendor - Summary Aging";
                    trigger OnAction()
                    begin
                        Report.RunModal(Report::"ER - Vendor - Summary Aging");
                    end;
                }
                action("ER - Vendor - Trial Balance")
                {
                    Caption = 'ER - Vendor - Trial Balance';
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = Report "ER - Vendor Trial Balance";
                    trigger OnAction()
                    begin
                        Report.RunModal(Report::"ER - Vendor Trial Balance");
                    end;
                }
            }
        }
    }
}