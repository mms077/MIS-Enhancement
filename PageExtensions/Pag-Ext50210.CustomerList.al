pageextension 50210 "Customer List" extends "Customer List"
{
    layout
    {
        modify("Name 2")
        {
            ApplicationArea = all;
            Visible = true;
            Editable = true;
        }
        addafter("Name 2")
        {
            field("System ID"; Rec.SystemId)
            {
                ApplicationArea = All;
            }
            field("Receivables Account"; Rec."Receivables Account")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addfirst(Reports)
        {
            group("ER - Reports")
            {
                Image = Report;
                action("ER - Customer Statement")
                {
                    Caption = 'ER - Customer Statement';
                    Image = Report;
                    ApplicationArea = All;
                    //RunObject = Report "ER - Customer Statement";

                    trigger OnAction()
                    var
                        CustStatement: Report "ER - Customer Statement";
                        Customer: Record Customer;
                    begin
                        Clear(CustStatement);

                        Customer.SetFilter("No.", Rec."No.");
                        if Customer.FindFirst() then
                            CustStatement.SetCust(Customer."No.");


                        CustStatement.Run();

                    end;
                }
                action("ER - Customer Statement With Dimension")
                {
                    Caption = 'ER - Customer Statement With Dimension';
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = Report "ER - Customer Statement(Dim)";
                    trigger OnAction()
                    var
                        CustStatement: Report "ER - Customer Statement";
                        Customer: Record Customer;
                    begin
                         Customer.SetFilter("No.", Rec."No.");
                         Report.Run(Report::"ER - Customer Statement(Dim)", true, true, Customer);


                    end;
                }
                action("ER - Customer - Summary Aging")
                {
                    Caption = 'ER - Customer - Summary Aging';
                    Image = Report;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Customer.SetFilter("No.", Rec."No.");
                        Report.Run(Report::"ER - Customer - Summary Aging", true, true, Customer);
                    end;
                }
                action("ER - Customer - Trial Balance")
                {
                    Caption = 'ER - Customer - Trial Balance';
                    Image = Report;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Customer.SetFilter("No.", Rec."No.");
                        Report.Run(Report::"ER - Customer Trial Balance", true, true, Customer);
                    end;
                }
            }
        }
    }
    var
        Customer: Record Customer;
}