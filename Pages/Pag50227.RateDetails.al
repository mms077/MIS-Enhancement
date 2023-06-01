page 50227 "Rate Details"
{
    ApplicationArea = All;
    Caption = 'Rate Details';
    PageType = List;
    SourceTable = "Rate Detail";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Value"; Rec."Value")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Rate Code"; Rec."Rate Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}