table 50311 "Workflow User Memb-Scan"
{
    Caption = 'Workflow User Group Member-ER';
    ReplicateData = true;

    fields
    {
        field(1; "Workflow User Group Code"; Code[20])
        {
            Caption = 'Workflow User Group Code';
            TableRelation = "Workflow User Group Scan".Code;
        }
        field(2; "Name"; Code[100])
        {
            Caption = 'Name';
        }
        field(3; "Activity Code"; Integer)
        {
            Caption = 'Activity Code';
            MinValue = 1;
            TableRelation = "Scan Design Stages- ER".Index;
        }
    }

    keys
    {
        key(Key1; "Workflow User Group Code", Name, "Activity Code")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }
}

