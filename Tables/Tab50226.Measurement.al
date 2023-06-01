table 50226 "Measurement"
{
    Caption = 'Measurement';
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
        /*field(4; "Category"; Code[50])
        {
            Caption = 'Category';
            TableRelation = "Item Category".Code;
        }*/
        field(4; "Show On Label"; Boolean)
        {
            Caption = 'Show On Label';

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
