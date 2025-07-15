table 50312 "Workflow User Group Scan"
{
    Caption = 'Workflow User Group-ER';
    DataCaptionFields = "Code", Description;
    LookupPageID ="Workflow User Groups-Scan List";
    ReplicateData = true;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        WorkflowUserGroupMemberER: Record "Workflow User Group Member";
    begin
        WorkflowUserGroupMemberER.SetRange("Workflow User Group Code", Code);
        if not WorkflowUserGroupMemberER.IsEmpty() then
            WorkflowUserGroupMemberER.DeleteAll(true);
    end;
}

