pageextension 50212 "Workflow User Group Members" extends "Workflow User Group Members"
{
    actions
    {
        addfirst(Processing)
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
                "Workflow User Group Name" = field("User Name");
            }
        }
    }
}

