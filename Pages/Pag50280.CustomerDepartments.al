page 50280 "Customer Departments"
{
    ApplicationArea = All;
    Caption = 'Customer Departments';
    PageType = List;
    SourceTable = "Customer Departments";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Department Positions")
            {
                Caption = 'Positions';
                ApplicationArea = All;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Department Positions";
                RunPageLink = "Department Code" = field("Department Code"), "Customer No." = field("Customer No.");
            }
        }
    }
}