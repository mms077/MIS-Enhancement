page 50217 "Image Details"
{
    ApplicationArea = All;
    Caption = 'Image Details';
    PageType = List;
    SourceTable = "Image Detail";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Record ID"; Rec."Record ID")
                {
                    ApplicationArea = All;
                }
                field("Type ID"; Rec."Type ID")
                {
                    ApplicationArea = All;
                }
                field("Color ID"; Rec."Color ID")
                {
                    ApplicationArea = All;
                }
                field("Value"; Rec."Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
