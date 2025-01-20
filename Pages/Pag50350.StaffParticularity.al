page 50350 "Staff Particularity"
{
    ApplicationArea = All;
    Caption = 'Staff Particularity';
    PageType = List;
    SourceTable = "Staff Particularity";
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
    actions
    {
        area(Processing)
        {
           
    
        }
    }
}
