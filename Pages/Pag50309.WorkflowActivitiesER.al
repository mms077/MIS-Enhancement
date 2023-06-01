page 50309 "Workflow Activities - ER"
{
    ApplicationArea = All;
    Caption = 'Workflow Activities - ER';
    PageType = List;
    SourceTable = "Workflow Activities - ER";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Workflow User Group Code"; Rec."Workflow User Group Code")
                {
                    ApplicationArea = All;
                }
                field("Workflow User Group Sequence"; Rec."Workflow User Group Sequence")
                {
                    ApplicationArea = All;
                }
                field("Activity Name"; Rec."Activity Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
