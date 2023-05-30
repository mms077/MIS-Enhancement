table 50242 "Feature"
{
    Caption = 'Feature';
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
        field(4; "Cost"; Decimal)
        {
            Caption = 'Cost';

        }
        /*field(5; Picture; MediaSet)
        {
            Caption = 'Picture';
        }*/
        /*field(6; Instructions; Text[2048])
        {
            Caption = 'Instructions';
        }*/
        field(7; "Has Color"; Boolean)
        {
            Caption = 'Has Color';
        }
        field(8; "Sorting Number"; Integer)
        {

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
