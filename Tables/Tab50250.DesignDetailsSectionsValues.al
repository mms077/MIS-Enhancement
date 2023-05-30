table 50250 "Design Details Sections Values"
{
    Caption = 'Design Details Sections Values';
    DataPerCompany = false;

    fields
    {
        field(1; "Design Code"; Code[50])
        {
            Caption = 'Design Code';

            Editable = false;
        }
        field(2; "Design Name"; Text[100])
        {
            Caption = 'Design Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Design.Name where("Code" = field("Design Code")));
        }
        field(3; "Section Code"; Code[50])
        {
            Caption = 'Section Code';

            TableRelation = Section.Code;
        }
        field(4; "Section Name"; Text[100])
        {
            Caption = 'Section Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Section.Name where("Code" = field("Section Code")));
        }
        field(5; "Design Section Code"; Code[50])
        {
            Caption = 'Design Section Code';

            TableRelation = "Design Section".Code where("Section Code" = field("Section Code"));
            //"UOM Code" = field("UOM Code"));
            trigger OnValidate()
            var
                DesignSection: Record "Design Section";
            begin
                DesignSection.Get(Rec."Design Section Code");
                Rec."UOM Code" := DesignSection."UOM Code";
            end;
        }
        field(6; "Design Section Name"; Text[100])
        {
            Caption = 'Design Section Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Design Section".Name where("Code" = field("Design Section Code")));
        }

        field(7; "UOM Code"; Code[10])
        {
            Caption = 'UOM Code';

            TableRelation = "Unit of Measure".Code;
            Editable = false;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';

        }



    }
    keys
    {
        key(PK; "Design Code", "Design Section Code", "Section Code", "UOM Code", Quantity)
        {
            Clustered = true;
        }
    }
}
