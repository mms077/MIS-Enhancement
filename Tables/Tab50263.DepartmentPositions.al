table 50263 "Department Positions"
{
    Caption = 'Department Positions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Department Code"; Code[50])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = Department.Code;
        }
        field(2; "Position Code"; Code[50])
        {
            Caption = 'Position Code';
            DataClassification = ToBeClassified;
            TableRelation = Position.Code;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(4; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Department.Name where(Code = field("Department Code")));
            Editable = false;
        }
        field(5; "Position Name"; Text[100])
        {
            Caption = 'Position Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Position.Name where(Code = field("Position Code")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Department Code", "Position Code", "Customer No.")
        {
            Clustered = true;
        }
    }
}
