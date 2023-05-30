table 50278 "Wizard Positions"
{
    Caption = 'Wizard Positions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Parameter Header Id"; Integer)
        {
            Caption = 'Parameter Header Id';
            DataClassification = ToBeClassified;
            TableRelation = "Parameter Header".ID;
            Editable = false;
        }
        field(2; "Position Code"; Code[50])
        {
            Caption = 'Position Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Quantity To Assign"; Decimal)
        {
            Caption = 'Quantity To Assign';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CheckTotalAssignedQty;
                ValidateRemainder();
            end;
        }
        field(4; "Position Name"; Text[100])
        {
            Caption = 'Position Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Position.Name where(Code = field("Position Code")));
        }
        field(5; "Department Code"; Code[50])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Par Level"; Integer)
        {
            Caption = 'Par Level';
            trigger OnValidate()
            begin
                ValidateRemainder();
            end;
        }
    }
    keys
    {
        key(PK; "Parameter Header Id", "Position Code", "Department Code")
        {
            Clustered = true;
        }
    }
    procedure CheckTotalAssignedQty()
    var
        ParameterHeader: Record "Parameter Header";
        WizardDepartments: Record "Wizard Departments";
        WizardPositions: Record "Wizard Positions";
        WizardStaff: Record "Wizard Staff";
        TotalAssignedQty: Decimal;
        Txt001: Label 'The total assigned qty is greater than line quantity';
        QtyAssignmentWizard: Record "Qty Assignment Wizard";
        QtyAssignmentWizardLoop: Record "Qty Assignment Wizard";
        ParentParameterHeader: Record "Parameter Header";
    begin
        //to get the parent
        ParameterHeader.Get(Rec."Parameter Header Id");
        QtyAssignmentWizard.SetRange("Header Id", ParameterHeader.ID);
        QtyAssignmentWizard.FindFirst();
        ParentParameterHeader.Get(QtyAssignmentWizard."Parent Header Id");
        //
        Clear(QtyAssignmentWizardLoop);
        QtyAssignmentWizardLoop.SetRange("Parent Header Id", QtyAssignmentWizard."Parent Header Id");
        if QtyAssignmentWizardLoop.FindSet() then
            repeat
                WizardDepartments.SetRange("Parameter Header Id", QtyAssignmentWizardLoop."Header Id");
                if WizardDepartments.FindSet() then
                    repeat
                        TotalAssignedQty := TotalAssignedQty + WizardDepartments."Quantity To Assign";
                    until WizardDepartments.Next() = 0;

                WizardPositions.SetRange("Parameter Header Id", QtyAssignmentWizardLoop."Header Id");
                if WizardPositions.FindSet() then
                    repeat
                        //to take the value of the current quantity ... the system read the old value before change
                        if WizardPositions.SystemId = Rec.SystemId then
                            TotalAssignedQty := TotalAssignedQty + Rec."Quantity To Assign"
                        else
                            TotalAssignedQty := TotalAssignedQty + WizardPositions."Quantity To Assign";
                    until WizardPositions.Next() = 0;

                WizardStaff.SetRange("Parameter Header Id", QtyAssignmentWizardLoop."Header Id");
                if WizardStaff.FindSet() then
                    repeat
                        TotalAssignedQty := TotalAssignedQty + WizardStaff."Quantity To Assign";
                    until WizardStaff.Next() = 0;
            until QtyAssignmentWizardLoop.Next() = 0;
        if TotalAssignedQty > ParentParameterHeader."Sales Line Quantity" then
            Error(Txt001);
    end;

    procedure ValidateRemainder()
    var
        Txt001: Label 'The remainder of Quantity To Assign and Par Level should be 0';
    begin
        if ("Quantity To Assign" <> 0) and ("Par Level" <> 0) then
            If (Rec."Quantity To Assign" MOD Rec."Par Level") <> 0 then
                Error(Txt001);
    end;
}
