page 50297 "Workflow User Group Members-ER"
{
    Caption = 'Workflow User Group Members-ER';
    PageType = ListPart;
    SourceTable = "Workflow User Group Member-ER";

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
                field("Sequence No."; Rec."Sequence No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the order of approvers when an approval workflow involves more than one approver.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Workflow User Group Member Details")
            {
                ApplicationArea = all;
                Image = Navigate;
                /*Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;*/
                RunObject = page "Workflow User Grp Mem. Details";
                RunPageLink = "Workflow User Group Code" = field("Workflow User Group Code"),
                "Workflow User Group Seq. No." = field("Sequence No."),
                "Workflow User Group Name" = field(Name);
            }
        }
    }
}

