/*page 50234 "UOM Connversion"
{
    ApplicationArea = All;
    Caption = 'UOM Connversion';
    PageType = List;
    SourceTable = "UOM Conversion";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Base UOM Code"; Rec."Base UOM Code")
                {
                    ApplicationArea = All;
                }
                field("Converted To ID"; Rec."Converted To ID")
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
*/