page 50232 Tonalities
{
    ApplicationArea = All;
    Caption = 'Tonalities';
    PageType = List;
    SourceTable = Tonality;
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
