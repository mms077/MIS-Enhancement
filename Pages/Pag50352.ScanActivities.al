page 50352 "Scan Activities"
{
    ApplicationArea = All;
    Caption = 'Scan Activities';
    PageType = List;
    SourceTable = "Scan Activities";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Activity Code"; Rec."Activity Code") { ApplicationArea = all; Visible = false; }

                field("Activity Name"; Rec."Activity Name") { ApplicationArea = all; }

                field("Sequence No."; Rec."Sequence No.") { ApplicationArea = all; }
                field("Stage Type"; Rec."Stage Type") { ApplicationArea = all; }

                field("Allow Non-Sequential Scanning"; Rec."Allow Non-Sequential Scanning") { ApplicationArea = all; }
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
