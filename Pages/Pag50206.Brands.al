page 50206 "Brands"
{
    ApplicationArea = All;
    Caption = 'ER Brands';
    PageType = List;
    SourceTable = Brand;
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
            }
        }
    }
}
