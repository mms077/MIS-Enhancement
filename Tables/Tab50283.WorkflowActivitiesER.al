table 50283 "Workflow Activities - ER"
{
    Caption = 'Workflow Activities - ER';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Workflow User Group Code"; Code[20])
        {
            Caption = 'Workflow User Group Code';
            NotBlank = true;
            TableRelation = "Workflow User Group-ER".Code;
        }
        field(2; "Workflow User Group Sequence"; Integer)
        {
            Caption = 'Workflow User Group Sequence';
            NotBlank = true;
        }
        field(3; "Activity Name"; Text[100])
        {
            Caption = 'Activity Name';
            NotBlank = true;
        }
    }
    keys
    {
        key(PK; "Workflow User Group Code", "Workflow User Group Sequence", "Activity Name")
        {
            Clustered = true;
        }
    }
}
