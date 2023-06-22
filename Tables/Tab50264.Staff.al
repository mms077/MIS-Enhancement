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
    trigger OnDelete()
    var
        StaffSizes: Record "Staff Sizes";
        StaffMeasurements: Record "Staff Measurements";
    begin
        Delete_Related_StaffSizes();
        Delete_Related_StaffMeasurements();
    end;


    procedure Delete_Related_StaffSizes()
    var
        StaffSizes: Record "Staff Sizes";
    begin
        StaffSizes.SetRange(StaffSizes."Staff Code", Rec.Code);
        StaffSizes.SetRange(StaffSizes."Position Code", Rec."Position Code");
        StaffSizes.SetRange(StaffSizes."Customer No.", Rec."Customer No.");
        StaffSizes.SetRange(StaffSizes."Department Code", Rec."Department Code");
        if (StaffSizes.FindSet()) then begin
            StaffSizes.DeleteAll();
        end;
    end;


    procedure Delete_Related_StaffMeasurements()
    var
        StaffMeasurements: Record "Staff Measurements";
    begin
        StaffMeasurements.SetRange(StaffMeasurements."Staff Code", Rec.Code);
        StaffMeasurements.SetRange(StaffMeasurements."Position Code", Rec."Position Code");
        StaffMeasurements.SetRange(StaffMeasurements."Customer No.", Rec."Customer No.");
        StaffMeasurements.SetRange(StaffMeasurements."Department Code", Rec."Department Code");
        if (StaffMeasurements.FindSet()) then begin
            StaffMeasurements.DeleteAll();
        end;
    end;
}
