table 50272 "Cutting Sheet Scanning Details"
{
    Caption = 'Cutting Sheet Scanning Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Assembly No."; Code[20])
        {
            Caption = 'Assembly No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Scan Type"; Option)
        {
            OptionMembers = " ","Scan In","Scan Out";
            Editable = false;
        }
        field(4; "Username"; Code[50])
        {
            Editable = false;
        }
        field(5; "Sequence No."; Integer)
        {
            Editable = false;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
