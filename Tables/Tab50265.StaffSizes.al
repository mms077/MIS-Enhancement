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
            trigger OnValidate()
            begin
                Rec."StaffType Combination" := Rec."Staff Code" + Rec."Type";
            end;
        }
        field(2; "Size Code"; Code[50])
        {
            Caption = 'Size Code';
            DataClassification = ToBeClassified;
            TableRelation = Size.Code;
            trigger OnValidate()
            begin
                //PreventDifferentSizeForSameStaffandType(Rec);
                PreventDifferentSizeForSameStaffandType(Rec);
            end;
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
            trigger OnValidate()
            begin
                Rec."StaffType Combination" := Rec."Staff Code" + Rec."Type";
            end;
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
        field(12; "StaffType Combination"; Text[2048])
        {
            Caption = 'StaffType Combination';
        }
    }
    keys
    {
        key(PK; "Staff Code", "Size Code", "Fit Code", "Cut Code", "Customer No.", "Department Code", "Position Code", "Type")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        PreventDifferentSizeForSameStaffandType(Rec);
    end;

    trigger OnRename()
    begin
        PreventDifferentSizeForSameStaffandType(Rec);
    end;

    /*procedure PreventDifferentSizeForSameStaffandType(var StaffSizePar: Record "Staff Sizes")
    var
        StafSizeLocal: Record "Staff Sizes";
        Txt001: Label 'There is already different Size %1 for the same Staff %2 and Type %3.';
    begin
        StafSizeLocal.Reset();
        StafSizeLocal.SetRange("Staff Code", StaffSizePar."Staff Code");
        StafSizeLocal.SetRange("Type", StaffSizePar.Type);
        if StafSizeLocal.FindSet() then
            repeat
                //Check if it's the same record --> then it's ok
                if (StaffSizePar."Staff Code" <> StafSizeLocal."Staff Code")
                or (StaffSizePar."Fit Code" <> StafSizeLocal."Fit Code")
                or (StaffSizePar."Cut Code" <> StafSizeLocal."Cut Code")
                or (StaffSizePar."Customer No." <> StafSizeLocal."Customer No.")
                or (StaffSizePar."Department Code" <> StafSizeLocal."Department Code")
                or (StaffSizePar."Position Code" <> StafSizeLocal."Position Code")
                or (StaffSizePar."Type" <> StafSizeLocal."Type") then
                    if StafSizeLocal."Size Code" <> StaffSizePar."Size Code" then
                        Error(Txt001, StafSizeLocal."Size Code", StafSizeLocal."Staff Code", StafSizeLocal.Type);
            until StafSizeLocal.Next() = 0;
    end;*/

    procedure PreventDifferentSizeForSameStaffandType(var StaffSizePar: Record "Staff Sizes")
    var
        StafSizeLocal: Record "Staff Sizes";
        Txt001: Label 'There is already different Size %1 for the same Staff %2 and Type %3.';
        StaffTypeCombination: Text[2048];
    begin
        StaffTypeCombination := StaffSizePar."Staff Code" + StaffSizePar."Type";
        StafSizeLocal.Reset();
        StafSizeLocal.SetRange("StaffType Combination", StaffTypeCombination);
        if StafSizeLocal.FindSet() then
            repeat
                if StafSizeLocal.SystemId <> StaffSizePar.SystemId then
                    if StafSizeLocal."Size Code" <> StaffSizePar."Size Code" then
                        Error(Txt001, StafSizeLocal."Size Code", StafSizeLocal."Staff Code", StafSizeLocal.Type);
            until StafSizeLocal.Next() = 0;
    end;

    var
        StaffTypeCombinationGlobal: Text[2048];
}
