pageextension 50252 "Sales Quotes" extends "Sales Quotes"
{
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
    }
    var
        G_SalesHeader: Record "Sales Header";
}
