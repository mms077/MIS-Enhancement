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
        field(9; "Validated"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec.Validated then begin
                    Rec."Validated by" := UserId;
                    Rec.Modify();
                end else begin
                    Rec."Validated by" := '';
                    Rec.Modify();
                end;
            end;
        }
        field(10; "Particularity 1"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Particularity".Code;
            trigger OnValidate()
            begin
                if (rec."Particularity 1" = rec."Particularity 2") or (rec."Particularity 1" = rec."Particularity 3") then
                    Error('Particularity 1 cannot be the same as Particularity 2 or Particularity 3.');
            end;
        }
        field(11; "Validated by"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Particularity 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Particularity".Code;
            trigger OnValidate()
            begin
                if (rec."Particularity 2" = rec."Particularity 1") or (rec."Particularity 2" = rec."Particularity 3") then
                    Error('Particularity 2 cannot be the same as Particularity 1 or Particularity 3.');
            end;
        }
        field(13; "Particularity 3"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Particularity".Code;
            trigger OnValidate()
            begin
                if (rec."Particularity 3" = rec."Particularity 1") or (rec."Particularity 3" = rec."Particularity 2") then
                    Error('Particularity 3 cannot be the same as Particularity 1 or Particularity 2.');
            end;
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
