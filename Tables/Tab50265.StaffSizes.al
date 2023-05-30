table 50265 "Staff Sizes"
{
    Caption = 'Staff Sizes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Staff Code"; Code[50])
        {
            Caption = 'Staff Code';
            DataClassification = ToBeClassified;
            TableRelation = Staff.Code;
        }
        field(2; "Size Code"; Code[50])
        {
            Caption = 'Size Code';
            DataClassification = ToBeClassified;
            TableRelation = Size.Code;
        }
        field(3; "Fit Code"; Code[50])
        {
            Caption = 'Fit Code';
            DataClassification = ToBeClassified;
            TableRelation = Fit.Code;
        }
        field(4; "Cut Code"; Code[50])
        {
            Caption = 'Cut Code';
            DataClassification = ToBeClassified;
            TableRelation = Cut.Code;
        }
        field(5; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(6; "Department Code"; Code[50])
        {
            TableRelation = Department.Code;
        }
        field(7; "Position Code"; Code[50])
        {
            TableRelation = Position.Code;
        }
        field(8; "Type"; Text[100])
        {
            TableRelation = "Design Type".Name;
        }
        field(9; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Department.Name where(Code = field("Department Code")));
            Editable = false;
        }
        field(10; "Position Name"; Text[100])
        {
            Caption = 'Position Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Position.Name where(Code = field("Position Code")));
            Editable = false;
        }
        field(11; "Staff Name"; Text[100])
        {
            Caption = 'Staff Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Staff.Name where(Code = field("Staff Code")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Staff Code", "Size Code", "Fit Code", "Cut Code", "Customer No.", "Department Code", "Position Code", "Type")
        {
            Clustered = true;
        }
    }
}
