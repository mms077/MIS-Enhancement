table 50230 Section
{
    Caption = 'Section';
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
        field(4; Number; Integer)
        {
            Caption = 'Number';

        }
        field(5; "Composition"; Option)
        {
            Caption = 'Composition';
            OptionMembers = Others,Fabrics,Accessories;
            OptionCaption = 'Others,Fabrics,Accessories';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(Number; Number)
        {

        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Name)
        {

        }
    }
}
