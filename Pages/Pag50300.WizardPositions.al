page 50300 "Wizard Positions"
{
    Caption = 'Wizard Positions';
    PageType = NavigatePage;
    SourceTable = "Wizard Positions";
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        WizardStaff: Record "Wizard Staff";
                        WizardStaffPage: page "Wizard Staff";
                    begin
                        WizardStaff.SetRange("Parameter Header Id", Rec."Parameter Header Id");
                        WizardStaff.SetRange("Department Code", Rec."Department Code");
                        WizardStaff.SetRange("Position Code", Rec."Position Code");
                        if WizardStaff.FindSet() then begin
                            WizardStaff.SetCurrentKey("Size Code");
                            WizardStaffPage.SetTableView(WizardStaff);
                            WizardStaffPage.RunModal();
                            CurrPage.Close();
                        end;
                    end;
                }
                field("Position Name"; Rec."Position Name")
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
    actions
    {
        area(Processing)
        {
            action(Backaction)
            {
                Caption = 'Back';
                //Enabled = BackEnable;
                Image = PreviousRecord;
                InFooterBar = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    WizardDepartmentsPage: Page "Wizard Departments";
                    WizardDepartments: Record "Wizard Departments";
                begin
                    CurrPage.Close();
                    Clear(WizardDepartments);
                    WizardDepartments.SetRange("Parameter Header Id", Rec."Parameter Header Id");
                    WizardDepartmentsPage.SetTableView(WizardDepartments);
                    //Commit before RunModal
                    //CurrPage.Update(false);
                    Commit();
                    WizardDepartmentsPage.RunModal();
                end;
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
}
