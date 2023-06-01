page 50282 "Department Positions"
{
    ApplicationArea = All;
    Caption = 'Department Positions';
    PageType = List;
    SourceTable = "Department Positions";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = All;
                }
                field("Position Name"; Rec."Position Name")
                {
                    ApplicationArea = All;
                }
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
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Staff")
            {
                Caption = 'Staff';
                ApplicationArea = All;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page Staff;
                RunPageLink = "Position Code" = field("Position Code"), "Customer No." = field("Customer No."),
                              "Department Code" = field("Department Code");
            }
        }
    }
}
