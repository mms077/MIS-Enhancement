page 50296 "Workflow User Groups-ER"
{
    ApplicationArea = Suite;
    Caption = 'Workflow User Groups-ER';
    CardPageID = "Workflow User Group-ER";
    PageType = List;
    SourceTable = "Workflow User Group-ER";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the workflow user group.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the workflow user group.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Workflow Activities")
            {
                ApplicationArea = all;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Workflow Activities - ER";
                RunPageLink = "Workflow User Group Code" = field("Code");
            }
        }
    }
}

