table 50256 "Item Branding Param Lines"
{
    Caption = 'Item Branding Param Lines';

    fields
    {
        field(1; "Header ID"; Integer)
        {
            Caption = 'Header ID';

            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';

            AutoIncrement = true;
            Editable = false;
        }
        field(3; "Code"; Code[50])
        {
            TableRelation = Branding.Code;
            Editable = false;
        }
        field(4; "Name"; Text[100])
        {
            TableRelation = Branding.Name;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Branding.Name where(Code = field(Code)));
        }
        field(5; "Description"; Text[100])
        {
            TableRelation = Branding.Description;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Branding.Description where(Code = field(Code)));
        }
        field(6; Include; Boolean)
        {

        }
        field(7; "Brandings Count In Parameter"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Branding Param Lines" where("Header ID" = field("Header ID")));
            Editable = false;
        }
        field(8; "Color Id"; Integer)
        {
            TableRelation = "Branding Detail"."Item Color ID" where("Branding Code" = field(Code));
            Editable = false;
        }
        field(9; "Color Name"; Text[100])
        {
            Caption = 'Color Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Color.Name where(ID = field("Color ID")));
            Editable = false;
        }
        field(10; Position; Text[100])
        {
            Caption = 'Position';
            FieldClass = FlowField;
            CalcFormula = lookup(Branding.Position where(Code = field(Code)));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Header ID", "Line No.")
        {
            Clustered = true;
        }
    }
}
