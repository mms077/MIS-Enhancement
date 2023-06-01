page 50299 "Wizard Departments"
{
    Caption = 'Wizard Departments';
    PageType = NavigatePage;
    SourceTable = "Wizard Departments";
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        WizardPositions: Record "Wizard Positions";
                        WizardPositionsPage: page "Wizard Positions";
                    begin
                        WizardPositions.SetRange("Parameter Header Id", Rec."Parameter Header Id");
                        WizardPositions.SetRange("Department Code", Rec."Department Code");
                        if WizardPositions.FindSet() then begin
                            CurrPage.Close();
                            Commit();
                            WizardPositionsPage.SetTableView(WizardPositions);
                            WizardPositionsPage.RunModal();
                        end;
                    end;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = all;
                }
                field("Quantity To Assign"; Rec."Quantity To Assign")
                {
                    ApplicationArea = all;
                }
                field("Par Level"; Rec."Par Level")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ParameterHeader: Record "Parameter Header";
        ItemWizard: page "Item Wizard";
        QtyAssignmentWizard: Record "Qty Assignment Wizard";
    begin
        ParameterHeader.Get(Rec."Parameter Header Id");
        ParameterHeader."Quantity To Assign" := CalculateAssignedQty();
        ParameterHeader.Modify();
        //Update Qauntity Assignment wizard
        Clear(QtyAssignmentWizard);
        QtyAssignmentWizard.SetRange("Header Id", Rec."Parameter Header Id");
        if QtyAssignmentWizard.FindFirst() then begin
            QtyAssignmentWizard.Validate("Quantity To Assign", ParameterHeader."Quantity To Assign");
            QtyAssignmentWizard.Modify();
        end;

    end;

    procedure CalculateAssignedQty(): Decimal
    var
        WizardDepartments: Record "Wizard Departments";
        WizardPositions: Record "Wizard Positions";
        WizardStaff: Record "Wizard Staff";
        AssignedQty: Decimal;
    begin
        WizardDepartments.SetRange("Parameter Header Id", Rec."Parameter Header Id");
        if WizardDepartments.FindSet() then
            repeat
                AssignedQty := AssignedQty + WizardDepartments."Quantity To Assign";
            until WizardDepartments.Next() = 0;
        WizardPositions.SetRange("Parameter Header Id", Rec."Parameter Header Id");
        if WizardPositions.FindSet() then
            repeat
                AssignedQty := AssignedQty + WizardPositions."Quantity To Assign";
            until WizardPositions.Next() = 0;
        WizardStaff.SetRange("Parameter Header Id", Rec."Parameter Header Id");
        if WizardStaff.FindSet() then
            repeat
                AssignedQty := AssignedQty + WizardStaff."Quantity To Assign";
            until WizardStaff.Next() = 0;
        exit(AssignedQty)
    end;

    procedure Next(): Boolean
    begin
        exit(NextPressed);
    end;

    procedure Back(): Boolean
    begin
        exit(BackPressed);
    end;

    var
        NextPressed: Boolean;
        BackPressed: Boolean;
}
