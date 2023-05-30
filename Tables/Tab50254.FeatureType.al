table 50254 "Feature Type"
{
    Caption = 'Feature Type';
    DataPerCompany = false;

    fields
    {
        field(1; "Feature Name"; Text[100])
        {
            Caption = 'Feature Name';

            TableRelation = "Feature".Name;
        }
        field(2; "Type"; Text[100])
        {
            Caption = 'Type';

            TableRelation = "Design Type".Name;
        }
    }
    keys
    {
        key(PK; "Feature Name", Type)
        {
            Clustered = true;
        }
    }
}
