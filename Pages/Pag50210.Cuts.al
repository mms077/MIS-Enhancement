page 50210 "Cuts"
{
    ApplicationArea = All;
    Caption = 'Cuts';
    PageType = List;
    SourceTable = Cut;
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
