table 50291 TempGLAccountDim
{
    Caption = 'TempGLAccountDim';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; No; Code[20])
        {
            Caption = 'No';
        }
        field(3; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
        }
        field(4; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
        }
        field(5; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(6; "Value Posting"; Text[100])
        {
            Caption = 'Value Posting';
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
