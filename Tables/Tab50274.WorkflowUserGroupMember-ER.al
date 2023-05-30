table 50274 "Workflow User Group Member-ER"
{
    Caption = 'Workflow User Group Member-ER';
    ReplicateData = true;

    fields
    {
        field(1; "Workflow User Group Code"; Code[20])
        {
            Caption = 'Workflow User Group Code';
            TableRelation = "Workflow User Group-ER".Code;
        }
        field(2; "Name"; Code[100])
        {
            Caption = 'Name';
        }
        field(3; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
            MinValue = 1;
        }
    }

    keys
    {
        key(Key1; "Workflow User Group Code", "Name")
        {
            Clustered = true;
        }
        key(Key2; "Workflow User Group Code", "Sequence No.", "Name")
        {
        }
    }

    fieldgroups
    {
    }
}

