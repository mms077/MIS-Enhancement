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
            TableRelation = "Department Positions"."Position Code" where("Department Code" = field("Department Code"), "Customer No." = field("Customer No."));
            trigger OnValidate()
            var
                StaffSizes: Record "Staff Sizes";
                OldStaffSizes: Record "Staff Sizes";
                StaffMeasurement: Record "Staff Measurements";
                OldStaffMeasurement: Record "Staff Measurements";
                UpdatedSizes: Integer;
                UpdatedMeasurements: Integer;
            begin
                if (xRec."Position Code" <> Rec."Position Code") then begin
                    UpdatedSizes := 0;
                    UpdatedMeasurements := 0;

                    // Create a copy of the records we need to update
                    OldStaffSizes.Reset();
                    OldStaffSizes.SetRange("Staff Code", Rec.Code);
                    // OldStaffSizes.SetRange("Position Code", xRec."Position Code");

                    // Create array to store key values before modifications
                    if OldStaffSizes.FindSet() then begin
                        repeat
                            // For each record we found, we'll create a new record with updated Position Code
                            StaffSizes.Init();
                            StaffSizes.TransferFields(OldStaffSizes); // Copy all fields
                            StaffSizes."Position Code" := Rec."Position Code"; // Set new Position Code

                            // Insert the new record
                            if StaffSizes.Insert() then begin
                                // Delete the old record
                                OldStaffSizes.Delete();
                                UpdatedSizes += 1;
                            end;
                        until OldStaffSizes.Next() = 0;
                    end;

                    // Similar approach for Staff Measurements
                    OldStaffMeasurement.Reset();
                    OldStaffMeasurement.SetRange("Staff Code", Rec.Code);
                    OldStaffMeasurement.SetRange("Position Code", xRec."Position Code");

                    if OldStaffMeasurement.FindSet() then begin
                        repeat
                            StaffMeasurement.Init();
                            StaffMeasurement.TransferFields(OldStaffMeasurement);
                            StaffMeasurement."Position Code" := Rec."Position Code";

                            if StaffMeasurement.Insert() then begin
                                OldStaffMeasurement.Delete();
                                UpdatedMeasurements += 1;
                            end;
                        until OldStaffMeasurement.Next() = 0;
                    end;
                end;
            end;
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
            trigger OnValidate()
            var
                myInt: Integer;
                StaffSizes: Record "Staff Sizes";
                StaffMeasurement: Record "Staff Measurements";
            begin
                // Check if any of the key fields have changed
                /*  if (xRec."Customer No." <> Rec."Customer No.") then begin
                      // Find all Staff Sizes records for this Staff code
                      StaffSizes.SetRange("Staff Code", Rec.Code);

                      // If we find any related records, update them
                      if StaffSizes.FindSet() then
                          repeat
                              //if xRec."Customer No." <> Rec."Customer No." then begin
                                  //StaffSizes."Position Code" := Rec."Position Code";
                                  // Store current key values
                                  StaffSizes.Rename(StaffSizes."Staff Code",
                                  StaffSizes."Size Code",
                                  StaffSizes."Fit Code",
                                  StaffSizes."Cut Code",
                                  Rec."Customer No.",
                                   StaffSizes."Department Code",
                                                   StaffSizes."Position Code",
                                                    StaffSizes.Type
                                                     )
                              //end;
                          until StaffSizes.Next() = 0;

                      // Update Staff Measurement records
                      StaffMeasurement.SetRange("Staff Code", Rec.Code);
                      if StaffMeasurement.FindSet() then
                          repeat
                              StaffMeasurement.Rename(StaffMeasurement."Staff Code",
                                  StaffMeasurement."Measurement Code",
                                  Rec."Customer No.",
                                  StaffMeasurement."Department Code",
                                                   StaffMeasurement."Position Code")

                          until StaffMeasurement.Next() = 0;
                  end;*/
            end;
        }
        field(6; "Department Code"; Code[50])
        {
            //TableRelation = Department.Code;
            TableRelation = "Customer Departments"."Department Code" where("Customer No." = field("Customer No."));
            trigger OnValidate()
            var
                myInt: Integer;
                StaffSizes: Record "Staff Sizes";
                StaffMeasurement: Record "Staff Measurements";
            begin
                // Check if any of the key fields have changed
                if (xRec."Department Code" <> Rec."Department Code") then begin
                    // Find all Staff Sizes records for this Staff code
                    StaffSizes.SetRange("Staff Code", Rec.Code);

                    // If we find any related records, update them
                    if StaffSizes.FindSet() then
                        repeat
                            //if xRec."Customer No." <> Rec."Customer No." then begin
                            //StaffSizes."Position Code" := Rec."Position Code";
                            // Store current key values
                            StaffSizes.Rename(StaffSizes."Staff Code",
                            StaffSizes."Size Code",
                            StaffSizes."Fit Code",
                            StaffSizes."Cut Code",
                            StaffSizes."Customer No.",
                             Rec."Department Code",
                                             StaffSizes."Position Code",
                                              StaffSizes.Type
                                               )
                        //end;
                        until StaffSizes.Next() = 0;

                    // Update Staff Measurement records
                    StaffMeasurement.SetRange("Staff Code", Rec.Code);
                    if StaffMeasurement.FindSet() then
                        repeat
                            StaffMeasurement.Rename(StaffMeasurement."Staff Code",
                                StaffMeasurement."Measurement Code",
                                StaffMeasurement."Customer No.",
                                Rec."Department Code",
                                                 StaffMeasurement."Position Code")

                        until StaffMeasurement.Next() = 0;
                end;
            end;
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
            var
                Txt001: Label 'Particularity 1 cannot be the same as Particularity 2 or Particularity 3.';
            begin
                if "Particularity 1" <> '' then
                    if (rec."Particularity 1" = rec."Particularity 2") or (rec."Particularity 1" = rec."Particularity 3") then
                        Error(Txt001);
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
            var
                Txt001: Label 'Particularity 2 cannot be the same as Particularity 1 or Particularity 3.';
            begin
                if "Particularity 2" <> '' then
                    if (rec."Particularity 2" = rec."Particularity 1") or (rec."Particularity 2" = rec."Particularity 3") then
                        Error(Txt001);
            end;
        }
        field(13; "Particularity 3"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Particularity".Code;
            trigger OnValidate()
            var
                Txt001: Label 'Particularity 3 cannot be the same as Particularity 1 or Particularity 2.';
            begin
                if "Particularity 3" <> '' then
                    if (rec."Particularity 3" = rec."Particularity 1") or (rec."Particularity 3" = rec."Particularity 2") then
                        Error(Txt001);
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
    trigger OnDelete()
    var
        StaffSizes: Record "Staff Sizes";
        StaffMeasurement: Record "Staff Measurements";
    begin
        // Delete all related Staff Sizes records
        StaffSizes.SetRange("Staff Code", Rec.Code);
        if not StaffSizes.IsEmpty then
            StaffSizes.DeleteAll();

        // Delete all related Staff Measurements records
        StaffMeasurement.SetRange("Staff Code", Rec.Code);
        if not StaffMeasurement.IsEmpty then
            StaffMeasurement.DeleteAll();
    end;
}
