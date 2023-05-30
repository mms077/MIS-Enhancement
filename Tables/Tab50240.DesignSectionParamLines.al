table 50240 "Design Section Param Lines"
{
    Caption = 'Design Section Param Lines';

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
        field(3; "Design Section Code"; Code[50])
        {
            Caption = 'Design Section Code';

            Editable = false;
        }
        field(4; "Color ID"; Integer)
        {
            Caption = 'Color ID';

        }
        field(5; "Design Section Name"; Text[100])
        {
            Caption = 'Design Section Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Design Section".Name where(Code = field("Design Section Code")));
            Editable = false;
        }
        field(6; "Color Name"; Text[100])
        {
            Caption = 'Color Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Color".Name where(id = field("Color ID")));
            Editable = false;
        }
        field(7; "Design Sections Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Design Section Param Lines" where("Header ID" = field("Header ID")));
            Editable = false;
        }
        field(8; "Tonality Code"; Code[50])
        {
            Caption = 'Tonality Code';
            TableRelation = Tonality.Code;
            Editable = false;
        }
        field(9; "Has Raw Material"; Boolean)
        {
            Caption = 'Has Raw Material';
            Editable = false;
        }
        field(10; "Raw Material Code"; Code[20])
        {
            Caption = 'Raw Material Code';
            TableRelation = "Raw Material".Code;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Header ID", "Line No.")
        {
            Clustered = true;
        }
        key(Key1; "Header ID", "Design Section Code", "Color ID")
        {

        }
    }
}
