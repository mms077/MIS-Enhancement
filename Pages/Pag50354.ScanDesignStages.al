page 50355 "Scan Design Stages- ER List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Scan Design Stages- ER";

    layout
    {
        area(Content)
        {
            repeater("Scan Design Stages")
            {
                field("Workflow User Group Code"; Rec."Workflow User Group Code") { ApplicationArea = all; }
               //ield("Workflow User Group Sequence"; rec."Workflow User Group Sequence") { ApplicationArea = all; }
                field("Activity Name"; Rec."Activity Name") { ApplicationArea = all; }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}