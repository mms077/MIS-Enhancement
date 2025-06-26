page 50359 "Workflow User Group Memb-Scan"
{
    Caption = 'Workflow User Group Members-ER';
    PageType = ListPart;
    SourceTable = "Workflow User Memb-Scan";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Name"; Rec.Name)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the workflow user.';
                    TableRelation = "Workflow User Names - ER"."Full Name";
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = Suite;
                   
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

