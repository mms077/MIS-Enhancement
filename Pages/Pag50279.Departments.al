page 50279 Departments
{
    ApplicationArea = All;
    Caption = 'Departments';
    PageType = List;
    SourceTable = Department;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Sorting Number"; Rec."Sorting Number")
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
                RunPageLink = "Department Code" = field("Code");
            }
        }
    }
}
