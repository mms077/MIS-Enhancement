table 50214 "Design Section"
{
    Caption = 'Design Section';
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
        field(4; "Section Code"; Code[50])
        {
            Caption = 'Section Code';

            TableRelation = Section.Code;
        }
        field(5; "UOM Code"; Code[10])
        {
            Caption = 'UOM Code';

            TableRelation = "Unit Of Measure".Code;
        }
        /*field(6; "Raw Material Code"; Code[100])
        {
            Caption = 'Raw Material Code';
            
            TableRelation = "Raw Material".Code;
        }*/
        field(6; "Related RM Categories Count"; Integer)
        {
            Caption = 'Related RM Categories Count';
            FieldClass = FlowField;
            CalcFormula = count("RM Category Design Section" where("Design Section Code" = field(Code), "Design Type" = field("Design Type Filter")));
            Editable = false;
        }
        field(7; "Composition"; Option)
        {
            Caption = 'Composition';
            OptionMembers = Others,Fabrics,Accessories;
            OptionCaption = 'Others,Fabrics,Accessories';
            FieldClass = FlowField;
            CalcFormula = lookup(Section.Composition where(Code = field("Section Code")));
            Editable = false;
        }
        field(8; "Unique Color"; Integer)
        {
            TableRelation = Color.ID;
        }
        field(9; "Show Picture On Report"; Boolean)
        {

        }
        field(10; "Design Type Filter"; Text[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "Design Type".Name;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }

    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Name)
        {

        }
    }
}
