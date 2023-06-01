table 50276 "Workflow User Names - ER"
{
    Caption = 'Workflow User Names - ER';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Full Name"; Text[100])
        {
            Caption = 'Full Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Full Name")
        {
            Clustered = true;
        }
    }
}
