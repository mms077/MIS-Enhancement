page 50267 "RM Categories Design Sections"
{
    ApplicationArea = All;
    Caption = 'RM Categories Design Sections';
    PageType = List;
    SourceTable = "RM Category Design Section";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("RM Category Code"; Rec."RM Category Code")
                {
                    ApplicationArea = All;
                }
                field("RM Category Name"; Rec."RM Category Name")
                {
                    ApplicationArea = All;
                }
                field("Design Section Code"; Rec."Design Section Code")
                {
                    ApplicationArea = All;
                }
                field("Design Section Name"; Rec."Design Section Name")
                {
                    ApplicationArea = all;
                }
                field("Design Type"; Rec."Design Type")
                {
                    ApplicationArea = all;
                }
                field("RM Category Count"; Rec."RM Category Count By DS")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
