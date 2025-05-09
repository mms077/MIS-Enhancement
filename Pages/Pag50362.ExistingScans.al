page 50362 "Existing Scans"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Scan Activities-History"; // Replace with the actual table name for scans
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
                field("Activity Type"; Rec."Activity Type")
                {
                    ApplicationArea = All;
                }
                field("Activity Date"; Rec."Activity Date")
                {
                    ApplicationArea = All;
                }
                field("Activity Time"; Rec."Activity Time")
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