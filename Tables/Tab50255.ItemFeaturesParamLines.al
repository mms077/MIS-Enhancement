table 50255 "Item Features Param Lines"
{
    Caption = 'Item Features Param Lines';

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
        field(3; "Feature Name"; Text[100])
        {
            Caption = 'Feature Name';

            TableRelation = "Feature".Name;
            Editable = false;
        }
        field(4; "Value"; Text[100])
        {
            Caption = 'Value';

            TableRelation = "Item Feature Possible Values"."Possible Value" where("Feature Name" = field("Feature Name"));
        }
        field(5; "Cost"; Decimal)
        {
            Caption = 'Cost';

            Editable = false;
        }
        field(6; Instructions; Text[2048])
        {
            Caption = 'Instructions';
        }
        field(7; "Has Color"; Boolean)
        {
            Caption = 'Has Color';
            Editable = false;
        }
        field(8; "Color Id"; Integer)
        {
            TableRelation = Color.ID;
        }
        field(9; "Color Name"; Text[100])
        {
            Caption = 'Color Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Color".Name where(id = field("Color Id")));
            Editable = false;
        }
        field(10; "Item Features Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Features Param Lines" where("Header ID" = field("Header ID")));
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
