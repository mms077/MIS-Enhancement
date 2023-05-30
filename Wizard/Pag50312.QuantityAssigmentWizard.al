page 50312 "Quantity Assigment Wizard"
{
    Caption = 'Quantity Assigment Wizard';
    PageType = NavigatePage;
    SourceTable = "Qty Assignment Wizard";
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Size; Rec.Size)
                {
                    ApplicationArea = All;
                    Caption = 'Size';
                    Lookup = true;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemSizePage: Page "Item Sizes";
                        ItemSizeRec: Record "Item Size";
                    begin
                        Clear(ItemSizePage);
                        Clear(ItemSizeRec);
                        ItemSizeRec.SetRange("Item No.", ParentParameterHeader."Item No.");
                        if ItemSizeRec.FindSet() then begin
                            ItemSizePage.SetTableView(ItemSizeRec);
                            //ItemColorPage.Editable(true);
                            ItemSizePage.LookupMode(true);
                            if ItemSizePage.RunModal() = Action::LookupOK then begin
                                ItemSizePage.GetRecord(ItemSizeRec);
                                Rec.Validate("Size", ItemSizeRec."Item Size Code");
                            end;
                        end;
                    end;
                }
                field(Fit; Rec.Fit)
                {
                    ApplicationArea = All;
                    Caption = 'Fit';
                    Lookup = true;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemFitPage: Page "Item Fits";
                        ItemFitRec: Record "Item Fit";
                    begin
                        Clear(ItemFitPage);
                        Clear(ItemFitRec);
                        ItemFitRec.SetRange("Item No.", ParentParameterHeader."Item No.");
                        if ItemFitRec.FindSet() then begin
                            ItemFitPage.SetTableView(ItemFitRec);
                            //ItemColorPage.Editable(true);
                            ItemFitPage.LookupMode(true);
                            if ItemFitPage.RunModal() = Action::LookupOK then begin
                                ItemFitPage.GetRecord(ItemFitRec);
                                Rec.Validate("Fit", ItemFitRec."Fit Code");
                            end;
                        end;
                    end;
                }
                field(Cut; Rec.Cut)
                {
                    ApplicationArea = All;
                    Caption = 'Cut';
                    Lookup = true;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemCutPage: Page "Item Cuts";
                        ItemCutRec: Record "Item Cut";
                    begin
                        Clear(ItemCutPage);
                        Clear(ItemCutRec);
                        ItemCutRec.SetRange("Item No.", ParentParameterHeader."Item No.");
                        if ItemCutRec.FindSet() then begin
                            ItemCutPage.SetTableView(ItemCutRec);
                            //ItemColorPage.Editable(true);
                            ItemCutPage.LookupMode(true);
                            if ItemCutPage.RunModal() = Action::LookupOK then begin
                                ItemCutPage.GetRecord(ItemCutRec);
                                Rec.Validate("Cut", ItemCutRec."Cut Code");
                            end;
                        end;
                    end;
                }
                field("Quantity To Assign"; Rec."Quantity To Assign")
                {
                    ApplicationArea = all;
                    Visible = ShowNonVariantControls;
                    trigger OnDrillDown()
                    begin
                        //Commit before RunModal
                        Rec.Modify();
                        //CurrPage.Close();
                        Commit();
                        //DeleteTempTables();
                        FillTempTables();
                    end;
                }

            }

        }
    }
    actions
    {
        area(Processing)
        {
            action(SaveAndClose)
            {
                Caption = 'Save And Close';
                InFooterBar = true;
                ApplicationArea = all;
                Visible = ShowNonVariantControls;
                trigger OnAction()
                var
                    CUManagement: Codeunit Management;
                    ParameterHeader: Record "Parameter Header";
                begin
                    Clear(ParameterHeader);
                    ParameterHeader.Get(Rec."Parent Header Id");
                    CUManagement.UpdateAndClose(ParameterHeader);
                    CurrPage.Close();
                end;
            }
            action(Backaction)
            {
                Caption = 'Back';
                //Enabled = BackEnable;
                Image = PreviousRecord;
                InFooterBar = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    BackPressed := true;
                    CurrPage.Close();
                end;
            }
            action(NextAction)
            {
                Caption = 'Next';
                //Enabled = CanFinish;
                //Enabled = CanContinue;
                Image = Approve;
                InFooterBar = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    NextPressed := true;
                    CurrPage.Close();
                end;
            }
            action(DeleteLine)
            {
                Caption = 'Delete Line';
                InFooterBar = true;
                Image = Delete;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    DeleteRelated(Rec);
                    Rec.Delete(true);
                end;
            }
        }
    }
    var
        NextPressed: Boolean;
        BackPressed: Boolean;
        CanContinue: Boolean;
        DesignSectionParameterHeader: Record "Parameter Header";
        ColorEditable: Boolean;
        Enabled: Boolean;
        ParentParameterHeader: Record "Parameter Header";
        MyParameterHeaderId: Integer;
        ShowNonVariantControls: Boolean;

    trigger OnOpenPage()
    var
        ParameterHeaderLoc: Record "Parameter Header";
    begin
        ShowNonVariantControls := true;
        if ParameterHeaderLoc.Get(MyParameterHeaderId) then
            if ParameterHeaderLoc."Create Variant" then
                ShowNonVariantControls := false;
    end;

    procedure Next(): Boolean
    begin
        exit(NextPressed);
    end;

    procedure Back(): Boolean
    begin
        exit(BackPressed);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if ParentParameterHeader.Get(Rec."Parent Header Id") then;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Parent Header Id" := ParentParameterHeader.ID;
        GetRelatedInfo(ParentParameterHeader."Item No.", Rec);
    end;

    procedure GetRelatedInfo(ItemNo: Code[20]; var QtyAssignmentPar: Record "Qty Assignment Wizard")
    var
        ItemFit: Record "Item Fit";
        ItemCut: Record "Item Cut";
        NewParameterHeader: Record "Parameter Header";
        LastParameterHeader: Record "Parameter Header";
        LastQuantityAssignment: Record "Qty Assignment Wizard";
    begin
        Clear(ItemFit);
        Clear(ItemCut);
        ItemFit.SetRange("Item No.", ItemNo);
        ItemFit.SetRange(Default, true);
        if ItemFit.FindFirst() then
            QtyAssignmentPar.Validate("Fit", ItemFit."Fit Code");

        ItemCut.SetRange("Item No.", ItemNo);
        ItemCut.SetRange(Default, true);
        if ItemCut.FindFirst() then
            QtyAssignmentPar.Validate("Cut", ItemCut."Cut Code");
        if QtyAssignmentPar."Header Id" = 0 then begin
            NewParameterHeader.Init();
            NewParameterHeader.TransferFields(ParentParameterHeader);
            if LastParameterHeader.FindLast() then
                NewParameterHeader.ID := LastParameterHeader.ID + 1
            else
                NewParameterHeader.ID := 1;
            NewParameterHeader.Insert();
            QtyAssignmentPar."Header Id" := NewParameterHeader.ID;
            //Get Last Line No
            LastQuantityAssignment.SetCurrentKey("Line No.");
            LastQuantityAssignment.SetRange("Parent Header Id", ParentParameterHeader.ID);
            if LastQuantityAssignment.FindLast() then
                QtyAssignmentPar."Line No." := LastQuantityAssignment."Line No." + 1
            else
                QtyAssignmentPar."Line No." := 1;
        end;
    end;

    procedure FillTempTables()
    var
        WizardDepartmentsPage: Page "Wizard Departments";
        CustomerDepartments: Record "Customer Departments";
        CustomerDepartmentPositions: Record "Department Positions";
        StaffSizes: Record "Staff Sizes";
        Staff: Record Staff;
        WizardDepartments: Record "Wizard Departments";
        WizardPositions: Record "Wizard Positions";
        WizardStaff: Record "Wizard Staff";
        Design: Record Design;
        Item: Record Item;
    begin
        Item.Get(ParentParameterHeader."Item No.");
        Design.Get(Item."Design Code");
        //Fill Departments
        CustomerDepartments.SetRange("Customer No.", ParentParameterHeader."Customer No.");
        if CustomerDepartments.FindSet() then
            repeat
                WizardDepartments.Init();
                WizardDepartments."Parameter Header Id" := Rec."Header Id";
                WizardDepartments."Department Code" := CustomerDepartments."Department Code";
                IF WizardDepartments.Insert() then;
                //Fill Positions
                CustomerDepartmentPositions.SetRange("Customer No.", ParentParameterHeader."Customer No.");
                CustomerDepartmentPositions.SetRange("Department Code", CustomerDepartments."Department Code");
                if CustomerDepartmentPositions.FindSet() then
                    repeat
                        WizardPositions.Init();
                        WizardPositions."Parameter Header Id" := Rec."Header Id";
                        WizardPositions."Department Code" := CustomerDepartmentPositions."Department Code";
                        WizardPositions."Position Code" := CustomerDepartmentPositions."Position Code";
                        If WizardPositions.Insert() then;
                        //Fill Staff
                        StaffSizes.SetRange("Customer No.", ParentParameterHeader."Customer No.");
                        StaffSizes.SetRange("Department Code", CustomerDepartmentPositions."Department Code");
                        StaffSizes.SetRange("Position Code", CustomerDepartmentPositions."Position Code");
                        StaffSizes.SetRange("Size Code", Rec.Size);
                        StaffSizes.SetRange(Type, Design.Type);
                        if StaffSizes.FindSet() then
                            repeat
                                WizardStaff.Init();
                                WizardStaff."Parameter Header Id" := Rec."Header Id";
                                WizardStaff."Department Code" := CustomerDepartmentPositions."Department Code";
                                WizardStaff."Position Code" := CustomerDepartmentPositions."Position Code";
                                WizardStaff."Staff Code" := StaffSizes."Staff Code";
                                WizardStaff."Size Code" := StaffSizes."Size Code";
                                If WizardStaff.Insert() then;
                            until StaffSizes.Next() = 0;
                    until CustomerDepartmentPositions.Next() = 0;
            until CustomerDepartments.Next() = 0;
        Clear(WizardDepartments);
        WizardDepartments.SetRange("Parameter Header Id", Rec."Header Id");
        WizardDepartmentsPage.SetTableView(WizardDepartments);
        //Commit before RunModal
        CurrPage.Update(false);
        Commit();
        WizardDepartmentsPage.RunModal();
    end;

    procedure SetParameterHeaderID(ParameterHeaderID: Integer)
    begin
        MyParameterHeaderId := ParameterHeaderID;
    end;

    procedure DeleteRelated(QtyAssWizard: Record "Qty Assignment Wizard")
    var
        WizardDepartments: Record "Wizard Departments";
        WizardPositions: Record "Wizard Positions";
        WizardStaff: Record "Wizard Staff";
    begin
        Clear(WizardDepartments);
        WizardDepartments.SetRange("Parameter Header Id", QtyAssWizard."Header Id");
        if WizardDepartments.FindSet() then
            WizardDepartments.DeleteAll();

        Clear(WizardPositions);
        WizardPositions.SetRange("Parameter Header Id", QtyAssWizard."Header Id");
        if WizardPositions.FindSet() then
            WizardPositions.DeleteAll();

        Clear(WizardStaff);
        WizardStaff.SetRange("Parameter Header Id", QtyAssWizard."Header Id");
        if WizardStaff.FindSet() then
            WizardStaff.DeleteAll();
    end;
}