table 50264 Staff
{
    Caption = 'Staff';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                L_Staff: Record "Staff";
            begin
                L_Staff.SetRange("Code", "Code");
                if L_Staff.FindFirst() then
                    ERROR('Code already exists.');
            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Position Code"; Code[50])
        {
            TableRelation = Position.Code;
        }

        field(4; Gender; Option)
        {
            Caption = 'Gender';

            OptionMembers = " ","Male","Female";
            OptionCaption = ' ,Male,Female';
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
        field(7; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Department.Name where(Code = field("Department Code")));
            Editable = false;
        }
        field(8; "Position Name"; Text[100])
        {
            Caption = 'Position Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Position.Name where(Code = field("Position Code")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Code", "Position Code", "Customer No.", "Department Code")
        {
            Clustered = true;
        }
    }
}
