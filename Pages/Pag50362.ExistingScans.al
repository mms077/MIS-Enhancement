page 50362 "Existing Scans"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Scan Activities-History";
    Caption = 'Existing Scans';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Unit Ref"; Rec."Unit Ref")
                {
                    ApplicationArea = All;
                }
                field("Activity Date"; Rec."Activity Date")
                {
                    ApplicationArea = All;
                }
                field("Activity Code"; Rec."Activity Code") { ApplicationArea = all; }

                
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