table 50275 "Workflow User Grp Mem. Details"
{
    fields
    {
        field(1; "Workflow User Group Code"; Code[20])
        {
            Caption = 'Workflow User Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group Member-ER"."Workflow User Group Code";
        }
        field(2; "Workflow User Group Name"; Text[100])
        {
            Caption = 'Workflow User Group Name';
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group Member-ER"."Name";
        }
        field(3; "Workflow User Group Seq. No."; Integer)
        {
            Caption = 'Workflow User Group Seqence No.';
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group Member-ER"."Sequence No.";
        }
        field(4; "User Name"; Code[50])
        {
            TableRelation = "User Setup"."User ID";

        }
        field(5; "Scan Access"; Option)
        {
            OptionMembers = "Both","Scan In","Scan Out";
        }
    }
    keys
    {
        key(PK; "Workflow User Group Code", "Workflow User Group Name", "Workflow User Group Seq. No.", "User Name")
        {
            Clustered = true;
        }
    }
}