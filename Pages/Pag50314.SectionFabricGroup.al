page 50314 "Section Group"
{
    ApplicationArea = All;
    Caption = 'Section Group';
    PageType = List;
    SourceTable = "Section Group";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Show On MO Report"; Rec."Show On MO Report")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
