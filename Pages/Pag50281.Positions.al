page 50281 Positions
{
    ApplicationArea = All;
    Caption = 'Positions';
    PageType = List;
    SourceTable = Position;
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
            action("Staff")
            {
                Caption = 'Staff';
                ApplicationArea = All;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page Staff;
                RunPageLink = "Position Code" = field("Code");
            }
        }
    }
}
