page 50218 "Image Types"
{
    ApplicationArea = All;
    Caption = 'Image Types';
    PageType = List;
    SourceTable = "Image Type";
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
