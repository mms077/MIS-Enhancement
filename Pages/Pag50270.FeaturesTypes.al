page 50270 "Features Types"
{
    ApplicationArea = All;
    Caption = 'Features Types';
    PageType = List;
    SourceTable = "Feature Type";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Feature Name"; Rec."Feature Name")
                {
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
