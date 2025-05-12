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
                field("Sales Line Unit Id."; Rec."Sales Line Unit Id.") { ApplicationArea = all; }

                field("Sales Line Id"; Rec."Sales Line Id") { ApplicationArea = all; }
                field("Assembly No."; Rec."Assembly No.") { ApplicationArea = all; }
                field("ER - Manufacturing Order No."; rec."ER - Manufacturing Order No.") { ApplicationArea = all; }
                field("Source No."; rec."Source No.") { ApplicationArea = all; }
                field("Item No."; Rec."Item No.") { ApplicationArea = all; }
                field("Design Code"; Rec."Design Code") { ApplicationArea = all; }
                field("Variant Code"; Rec."Variant Code") { ApplicationArea = all; }
                field("Activity Remark"; Rec."Activity Remark") { ApplicationArea = all; }
                field("Activity Type"; Rec."Activity Type")
                {
                    ApplicationArea = All;
                }
                field("Activity Code"; Rec."Activity Code") { ApplicationArea = all; }
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