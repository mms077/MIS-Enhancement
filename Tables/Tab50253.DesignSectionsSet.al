table 50253 "Design Sections Set"
{
    DataPerCompany = false;
    Caption = 'Design Sections Set';


    fields
    {
        field(1; "Design Section Set ID"; Integer)
        {
            Caption = 'Design Section Set ID';

            Editable = false;
        }
        field(2; "Design Section Code"; Code[50])
        {
            Caption = 'Design Section Code';

            TableRelation = "Design Section"."Code";
            Editable = false;
        }
        field(3; "Color Id"; Integer)
        {
            Caption = 'Color Id';

            TableRelation = Color."ID";
            Editable = false;
        }
        field(7; "Design Sections Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Design Sections Set" where("Design Section Set ID" = field("Design Section Set ID")));
            Editable = false;
        }
        field(8; "Color Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Color".Name where(ID = field("Color Id")));
            Editable = false;
        }
        field(9; "Unique Combination"; Text[2048])
        {
            Caption = 'Unique Combination';
        }
    }
    keys
    {
        key(PK; "Design Section Set ID", "Design Section Code", "Color Id")
        {
            Clustered = true;
        }
    }
}
