page 50351 Dresses
{
    ApplicationArea = All;
    Caption = 'Dress Code';
    PageType = List;
    SourceTable = Dress;
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;


                }
            }

        }
        area(factboxes)
        {
          
        }
    }

    actions
    {
        area(Processing)
        {
          
        }
    }
    

}
