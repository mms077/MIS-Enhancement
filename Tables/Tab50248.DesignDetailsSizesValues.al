table 50248 "Design Details Sizes Values"
{
    Caption = 'Design Details Sizes Values';
    DataPerCompany = false;

    fields
    {
        field(1; "Design Code"; Code[50])
        {
            Caption = 'Design Code';

            TableRelation = Design.Code;
        }
        field(2; "Size Code"; Code[50])
        {
            Caption = 'Size Code';

            TableRelation = Size.Code;
        }

    }
    keys
    {
        key(PK; "Design Code", "Size Code")
        {
            Clustered = true;
        }
    }
}
