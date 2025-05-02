table 50309 "Scan Design Stages- ER Temp"
{
    Caption = 'Scan Design Stages - ER';
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; "Workflow User Group Code"; Code[20])
        {
            Caption = 'Workflow User Group Code';
            NotBlank = true;
            TableRelation = "Workflow User Group-ER".Code;
        }
        // field(2; "Workflow User Group Sequence"; Integer)
        // {
        //     Caption = 'Workflow User Group Sequence';
        //     NotBlank = true;
        // }
        field(3; "Activity Name"; Text[100])
        {
            Caption = 'Activity Name';
            NotBlank = true;
        }
        field(4; "Is Done"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Workflow User Group Code", "Activity Name")
        {
            Clustered = true;
        }
    }
}
