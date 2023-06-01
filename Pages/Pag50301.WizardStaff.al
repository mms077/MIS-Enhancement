page 50301 "Wizard Staff"
{
    Caption = 'Wizard Staff';
    PageType = NavigatePage;
    SourceTable = "Wizard Staff";
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Staff Code"; Rec."Staff Code")
                {
                    ApplicationArea = all;
                    //StyleExpr = StyleExprTxt;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = all;
                    //StyleExpr = StyleExprTxt;
                }
                field("Quantity To Assign"; Rec."Quantity To Assign")
                {
                    ApplicationArea = all;
                    //Editable = AllowEdit;
                    //StyleExpr = StyleExprTxt;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    //StyleExpr = StyleExprTxt;
                }
                field("Size Code"; Rec."Size Code")
                {
                    //StyleExpr = StyleExprTxt;
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
                    WizardPositionsPage: Page "Wizard Positions";
                    WizardPositions: Record "Wizard Positions";
                begin
                    CurrPage.Close();
                    Clear(WizardPositions);
                    WizardPositions.SetRange("Parameter Header Id", Rec."Parameter Header Id");
                    WizardPositions.SetRange("Department Code", Rec."Department Code");
                    WizardPositionsPage.SetTableView(WizardPositions);
                    //Commit before RunModal
                    //CurrPage.Update(false);
                    Commit();
                    WizardPositionsPage.RunModal();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        //AllowEdit := true;
    end;

    trigger OnAfterGetCurrRecord()
    var

    begin
        /*AllowEdit := true;
        Clear(ParameterHeader);
        ParameterHeader.get(Rec."Parameter Header Id");
        Item.get(ParameterHeader."Item No.");
        Design.Get(Item."Design Code");
        Rec.CalcFields(Gender);
        if (Rec."Size Code" = ParameterHeader."Item Size") then
            if (Rec.Gender = Design.Gender) or (Design.Gender = Design.Gender::Unisex) then
                AllowEdit := true
            else
                AllowEdit := false;*/
    end;

    trigger OnAfterGetRecord()
    var
    begin
        /*StyleExprTxt := '';
        Clear(ParameterHeader);
        ParameterHeader.get(Rec."Parameter Header Id");
        Item.get(ParameterHeader."Item No.");
        Design.Get(Item."Design Code");
        Rec.CalcFields(Gender);
        if (Rec."Size Code" = ParameterHeader."Item Size") then
            if (Rec.Gender = Design.Gender) or (Design.Gender = Design.Gender::Unisex) then
                StyleExprTxt := ''
            else
                StyleExprTxt := 'Unfavorable';*/
    end;

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
        ParameterHeader: Record "Parameter Header";
        Item: Record Item;
        Design: Record Design;
        NextPressed: Boolean;
        BackPressed: Boolean;
}
