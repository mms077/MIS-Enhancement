table 50251 "RM Category Design Section"
//table 50215 Fabric
{
    Caption = 'RM Category Design Section';
    DataPerCompany = false;

    fields
    {
        field(2; "RM Category Code"; Code[50])
        {
            Caption = 'RM Category Code';

            TableRelation = "Raw Material Category".Code;
        }

        field(3; "Design Section Code"; Code[50])
        {
            Caption = 'Design Section Code';

            TableRelation = "Design Section".Code;
        }
        field(4; "RM Category Name"; Text[100])
        {
            Caption = 'RM Category Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Raw Material Category".Name where(Code = field("RM Category Code")));
            Editable = false;
        }
        field(5; "Design Section Name"; Text[100])
        {
            Caption = 'Design Section Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Design Section".Name where(Code = field("Design Section Code")));
            Editable = false;
        }
        field(6; "Design Type"; Text[100])
        {
            TableRelation = "Design Type".Name;
        }
        field(7; "RM Category Count By DS"; Integer)
        {
            Caption = 'RM Category Count By Design Section By Type';
            FieldClass = FlowField;
            CalcFormula = Count("RM Category Design Section" where("Design Section Code" = field("Design Section Code"), "Design Type" = field("Design Type")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "RM Category Code", "Design Section Code", "Design Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "RM Category Code", "RM Category Name", "Design Section Code", "Design Type")
        {

        }
    }
}
