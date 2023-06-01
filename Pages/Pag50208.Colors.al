page 50208 "Colors"
{
    ApplicationArea = All;
    Caption = 'Colors';
    PageType = List;
    SourceTable = Color;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("French Description"; Rec."French Description")
                {
                    ApplicationArea = All;
                }
                field("Arabic Description"; Rec."Arabic Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
