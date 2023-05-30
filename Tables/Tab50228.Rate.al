table 50228 Rate
{
    Caption = 'Rate';
    DataPerCompany = false;

    fields
    {
        field(2; "Code"; Code[50])
        {
            Caption = 'Code';

        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';

        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}
