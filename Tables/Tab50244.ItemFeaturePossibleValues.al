table 50244 "Item Feature Possible Values"
{
    Caption = 'Item Feature Possible Values';
    DataPerCompany = false;

    fields
    {
        field(1; "Possible Value"; Text[100])
        {
            Caption = 'Possible Value';

        }
        field(2; "Possible Value Local"; Text[100])
        {
            Caption = 'Possible Value Local';

        }
        field(3; "Feature Name"; Text[100])
        {
            Caption = 'Feature Name';

            TableRelation = "Feature".Name;
        }
        field(4; Instructions; Text[2048])
        {
            Caption = 'Instructions';
        }
        field(5; "Default"; Boolean)
        {
            Caption = 'Default';
        }
        field(6; Picture; MediaSet)
        {
            Caption = 'Picture';
        }
        field(7; "Has Color"; Boolean)
        {

        }
        field(8; "Affect Plotting"; boolean)
        {

        }
    }
    keys
    {
        key(PK; "Possible Value", "Feature Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Feature Name", "Possible Value", Instructions, Default)
        {

        }
    }
}

