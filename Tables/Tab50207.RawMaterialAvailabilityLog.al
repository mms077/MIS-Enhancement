table 50207 "Raw Material Availability Log"
{
    Caption = 'Raw Material Availability Log';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SQ Number"; Code[20])
        {
            Caption = 'SQ Number';
        }
        field(2; User; Code[20])
        {
            Caption = 'User';
        }
        field(3; "Number of unique items"; Integer)
        {
            Caption = 'Number of unique items';
        }
    }
    keys
    {
        key(PK; "SQ Number")
        {
            Clustered = true;
        }
    }
}
