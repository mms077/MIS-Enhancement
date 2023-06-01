table 50222 "Item Design Section RM"
{
    Caption = 'Item Design Section RM';
    DataPerCompany = false;

    fields
    {
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';

            TableRelation = Item."No.";
        }
        field(3; "Raw Material Category"; Code[50])
        {
            Caption = 'Raw Material Category';

            TableRelation = "RM Category Design Section"."RM Category Code"
            where("Design Section Code" = field("Design Section Code"), "Design Type" = field("Design Type"));
        }
        field(4; "Design Section Code"; Code[50])
        {
            Caption = 'Design Section Code';

            TableRelation = "Design Section".Code;
        }
        field(5; "Design Section Name"; Text[100])
        {
            Caption = 'Design Section Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Design Section".Name where(Code = field("Design Section Code")));
            Editable = false;
        }
        field(6; "RM Category Name"; Text[100])
        {
            Caption = 'RM Category Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Raw Material Category".Name where(Code = field("Raw Material Category")));
            Editable = false;
        }
        field(7; "Design Code"; Code[50])
        {
            Caption = 'Design Code';
            FieldClass = FlowField;
            CalcFormula = lookup(item."Design Code" where("No." = field("Item No.")));
            Editable = false;
        }
        field(8; "Design Type"; Text[100])
        {
            Caption = 'Design Type';
            FieldClass = FlowField;
            CalcFormula = lookup(Design.Type where(Code = field("Design Code")));
            Editable = false;
        }
        field(9; "Avlbl. In Design Details"; Boolean)
        {
            Caption = 'Avlbl. In Design Details';
            FieldClass = FlowField;
            CalcFormula = exist("Design Detail" where("Design Section Code" = field("Design Section Code"), "Design Code" = field("Design Code")));
            Editable = false;
        }
        field(10; "Section Code"; Code[50])
        {
            Caption = 'Section Code';
            FieldClass = FlowField;
            TableRelation = Section.Code;
            CalcFormula = lookup("Design Section"."Section Code" where(Code = field("Design Section Code")));
            Editable = false;
        }
        field(11; "Section Group"; Code[50])
        {
            Caption = 'Section Group';
            FieldClass = FlowField;
            TableRelation = "Section Group"."Group Code" where("Section Code" = field("Section Code"));
            CalcFormula = lookup("Design Detail"."Section Group" where("Design Code" = field("Design Code"), "Design Section Code" = field("Design Section Code")));
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Item No.", "Design Section Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        //Prevent Blank Design Section And Fabric
        //TestField("Design Section Code");
        //TestField("Raw Material Category");
    end;
}
