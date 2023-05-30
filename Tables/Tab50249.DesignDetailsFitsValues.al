table 50249 "Design Details Fits Values"
{
    Caption = 'Design Details Fits Values';
    DataPerCompany = false;

    fields
    {
        field(1; "Design Code"; Code[50])
        {
            Caption = 'Design Code';

            TableRelation = Design.Code;
        }
        field(2; "Fit Code"; Code[50])
        {
            Caption = 'Fit Code';

            TableRelation = Fit.Code;
        }

    }
    keys
    {
        key(PK; "Design Code", "Fit Code")
        {
            Clustered = true;
        }
    }
}