pageextension 50226 "Purchase Order" extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field("IC Status"; Rec."IC Status")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Purchase to Stock"; Rec."Purchase to Stock")
            {
                ApplicationArea = All;
            }
        }
        addbefore(Control94)
        {
            field("IC Company Name"; Rec."IC Company Name")
            {
                Caption = 'IC Company Name';
                ApplicationArea = all;
                Editable = false;
            }
            field("IC Source No."; Rec."IC Source No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("IC Customer SO No."; Rec."IC Customer SO No.")
            {
                ApplicationArea = all;
                ToolTip = 'The no. of the SO related to the end client';
                Editable = false;
            }
            field("IC Customer Project Code"; Rec."IC Customer Project Code")
            {
                ApplicationArea = all;
                Editable = false;
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
                action("ER - Purchase Order")
                {
                    Caption = 'ER - Purchase Order';
                    ApplicationArea = All;
                    Image = Report;
                    trigger OnAction()
                    begin
                        G_PurchaseOrder.SetFilter("No.", Rec."No.");
                        Report.Run(Report::"Standard Purchase", true, true, G_PurchaseOrder);
                    end;
                }
            }
        }
    }
    var
        G_PurchaseOrder: Record "Purchase Header";
}