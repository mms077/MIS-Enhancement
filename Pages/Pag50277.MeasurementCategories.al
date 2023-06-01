page 50277 "Measurement Categories"
{
    ApplicationArea = All;
    Caption = 'Measurement Categories';
    PageType = List;
    SourceTable = "Measurement Category";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Measurement Code"; Rec."Measurement Code")
                {
                    ApplicationArea = All;
                }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
