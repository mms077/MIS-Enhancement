page 50294 "Workflow User Grp Mem. Details"
{
    ApplicationArea = All;
    Caption = 'Workflow User Grp Mem. Details';
    PageType = List;
    SourceTable = "Workflow User Grp Mem. Details";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Workflow User Group Code"; Rec."Workflow User Group Code")
                {
                    ApplicationArea = all;
                }
                field("Workflow User Group Seq. No."; Rec."Workflow User Group Seq. No.")
                {
                    ApplicationArea = all;
                }
                field("Workflow User Group Name"; Rec."Workflow User Group Name")
                {
                    ApplicationArea = all;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
                field("Scan Access"; Rec."Scan Access")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
