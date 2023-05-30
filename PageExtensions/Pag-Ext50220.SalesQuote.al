pageextension 50220 "Sales Quote" extends "Sales Quote"
{
    layout
    {
        moveafter("External Document No."; "Payment Terms Code")

        modify("Payment Terms Code")
        {
            Importance = Promoted;
            ShowMandatory = true;
        }
        modify("Sell-to Customer No.")
        {
            Importance = Promoted;
        }
        modify("Cust Project")
        {
            Importance = Promoted;
            ShowMandatory = true;
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
    }

    trigger OnAfterGetCurrRecord()
    var
        SalesLineLoc: Record "Sales Line";
    begin
        //Update Department Position Staff
        Clear(SalesLineLoc);
        SalesLineLoc.SetRange("Document No.", Rec."No.");
        if SalesLineLoc.FindSet() then
            repeat
                SalesLineLoc.UpdateDepartmentPositionStaff(SalesLineLoc, true, Rec."IC Company Name");
            until SalesLineLoc.Next() = 0;
    end;

    var
        G_SalesHeader: Record "Sales Header";
}
