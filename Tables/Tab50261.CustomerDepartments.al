table 50261 "Customer Departments"
{
    Caption = 'Customer Departments';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(2; "Department Code"; Code[50])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = Department.Code;
        }
        field(3; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Department.Name where(Code = field("Department Code")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Customer No.", "Department Code")
        {
            Clustered = true;
        }
    }
}
