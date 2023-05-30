table 50273 "Workflow User Group-ER"
{
    Caption = 'Workflow User Group-ER';
    DataCaptionFields = "Code", Description;
    LookupPageID = "Workflow User Groups-ER";
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
        WorkflowUserGroupMemberER: Record "Workflow User Group Member-ER";
    begin
        WorkflowUserGroupMemberER.SetRange("Workflow User Group Code", Code);
        if not WorkflowUserGroupMemberER.IsEmpty() then
            WorkflowUserGroupMemberER.DeleteAll(true);
    end;
}

