table 50252 "Size Category"
{
    Caption = 'Size Category';
    DataPerCompany = false;

    fields
    {
        field(1; "Size Code"; Code[50])
        {
            Caption = 'Size Code';

            TableRelation = Size.Code;
        }
        field(2; "Category Code"; Code[50])
        {
            Caption = 'Category Code';

            TableRelation = "Item Category".Code;
        }
        field(3; "Size Gender"; Option)
        {
            Caption = 'Gender';
            OptionMembers = " ","Male","Female";
            OptionCaption = ' ,Male,Female';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.Gender where(Code = field("Size Code")));
            Editable = false;
        }
        field(4; "Size Name"; Text[100])
        {
            Caption = 'Size Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.Name where(Code = field("Size Code")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Size Code", "Category Code")
        {
            Clustered = true;
        }
    }
}
