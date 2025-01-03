pageextension 50252 "Sales Quotes" extends "Sales Quotes"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("Lines Count"; Rec."Lines Count")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addfirst(Reporting)
        {
            group("ER - Reports")
            {
                Caption = 'ER Reports';
                action("ER - Sales Quote With Visuals")
                {
                    Caption = 'ER - Sales Quote W/ Visuals';
                    ApplicationArea = All;
                    Image = Report;
                    trigger OnAction()
                    begin
                        G_SalesHeader.SetFilter("No.", Rec."No.");
                        Report.Run(Report::"ER - Sales Quote With Visuals", true, true, G_SalesHeader);
                    end;
                }
            }
        }
        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                if ((Rec."Promised Delivery Date" = 0D) or (Rec."Requested Delivery Date" = 0D)) then
                    Error('Please fill the Promised Delivery Date and Requested Delivery Date');
            end;

            trigger OnAfterAction()
            var
                MissingRMCU: Codeunit "Missing RM";
            begin
                MissingRMCU.DeletePreviousRMperSQ(Rec."No.");
                MissingRMCU.FillRequiredRM(Rec."No.");
            end;
        }
    }
    var
        G_SalesHeader: Record "Sales Header";
}
