page 50250 "Design Types"
{
    ApplicationArea = All;
    Caption = 'Design Types';
    PageType = List;
    SourceTable = "Design Type";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                }*/
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Name Local"; Rec."Name Local")
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec.Category)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
