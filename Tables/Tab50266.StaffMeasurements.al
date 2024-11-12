table 50266 "Staff Measurements"
{
    Caption = 'Staff Measurements';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Staff Code"; Code[50])
        {
            Caption = 'Staff Code';
            DataClassification = ToBeClassified;
            TableRelation = Staff.Code;
        }
        field(2; "Measurement Code"; Code[50])
        {
            Caption = 'Measurement Code';

            TableRelation = "Measurement"."Code";
        }
        field(3; "Value"; Decimal)
        {
            Caption = 'Value';
            trigger OnValidate()
            begin
                //Prevent Different Value for the same Measurement and Staff
                //PreventDifferentValueForSameStaffMeasurement(Rec);
            end;
        }
        field(4; "UOM Code"; Code[10])
        {
            Caption = 'UOM Code';

            TableRelation = "Unit of Measure".Code;
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
        field(8; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Department.Name where(Code = field("Department Code")));
            Editable = false;
        }
        field(9; "Position Name"; Text[100])
        {
            Caption = 'Position Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Position.Name where(Code = field("Position Code")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Staff Code", "Measurement Code", "Customer No.", "Department Code", "Position Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        //PreventDifferentValueForSameStaffMeasurement(Rec);
        PreventSametMeasurementForSameStaff(Rec);
    end;

    trigger OnModify()
    begin
        //PreventDifferentValueForSameStaffMeasurement(Rec);
    end;

    trigger OnRename()
    begin
        //PreventDifferentValueForSameStaffMeasurement(Rec);
        if (xRec."Measurement Code" <> Rec."Measurement Code") or (xRec."Staff Code" <> Rec."Staff Code") then
            PreventSametMeasurementForSameStaff(Rec);
    end;
    /// Based on Charbel's Request, we commented the following code
    /*procedure PreventDifferentValueForSameStaffMeasurement(StaffMeasurementPar: Record "Staff Measurements")
    var
        StaffMeasurementLoc: Record "Staff Measurements";
        Lbl001: Label 'You cannot enter a measurement value different than the already entered for this staff which is %1';
    begin
        Clear(StaffMeasurementLoc);
        StaffMeasurementLoc.SetRange("Staff Code", StaffMeasurementPar."Staff Code");
        StaffMeasurementLoc.SetRange("Measurement Code", StaffMeasurementPar."Measurement Code");
        StaffMeasurementLoc.SetRange("Customer No.", StaffMeasurementPar."Customer No.");
        if StaffMeasurementLoc.FindSet() then
            repeat
                if StaffMeasurementLoc.Value <> StaffMeasurementPar.Value then
                    Error(Lbl001, StaffMeasurementLoc.Value);
            until StaffMeasurementLoc.Next() = 0;
    end;
    */
    procedure PreventSametMeasurementForSameStaff(StaffMeasurementPar: Record "Staff Measurements")
    var
        StaffMeasurementLoc: Record "Staff Measurements";
        Lbl001: Label 'You cannot enter the same measurement for the same staff';
    begin
        Clear(StaffMeasurementLoc);
        StaffMeasurementLoc.SetRange("Staff Code", StaffMeasurementPar."Staff Code");
        StaffMeasurementLoc.SetRange("Measurement Code", StaffMeasurementPar."Measurement Code");
        if StaffMeasurementLoc.FindFirst() then
            Error(Lbl001);
    end;
}
