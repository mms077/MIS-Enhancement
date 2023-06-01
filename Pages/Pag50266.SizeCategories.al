page 50266 "Size Categories"
{
    ApplicationArea = All;
    Caption = 'Size Categories';
    PageType = List;
    SourceTable = "Size Category";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Size Code"; Rec."Size Code")
                {
                    ApplicationArea = All;
                }
                field("Size Name"; Rec."Size Name")
                {
                    ApplicationArea = All;
                }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field("Size Gender"; Rec."Size Gender")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
