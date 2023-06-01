table 50241 "Design Type"
{
    Caption = 'Design Type';
    DataPerCompany = false;

    fields
    {
        field(2; Name; Text[100])
        {
            Caption = 'Name';

        }
        field(3; "Name Local"; Text[100])
        {
            Caption = 'Name Local';

        }
        field(4; "Category"; Code[20])
        {
            Caption = 'Category';

            TableRelation = "Item Category".Code;
        }
    }
    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
}
