page 50203 "Branding Categories"
{
    ApplicationArea = All;
    Caption = 'Branding Categories';
    PageType = List;
    SourceTable = "Branding Category";
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
                field("With Embroidery"; Rec."With Embroidery")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
