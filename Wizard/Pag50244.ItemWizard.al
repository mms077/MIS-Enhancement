page 50244 "Item Wizard"
{
    Caption = 'Item Wizard';
    PageType = NavigatePage;
    SourceTable = "Parameter Header";
    layout
    {
        area(content)
        {
            //Caption = 'General';

            field(ItemNo; Rec."Item No.")
            {
                ApplicationArea = All;
                Caption = 'Item No.';
                Lookup = true;
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemPage: Page "Item List";
                    ItemRec: Record Item;
                begin
                    Clear(ItemPage);
                    Clear(ItemRec);
                    ItemRec.SetFilter("Design Code", '<>''''');
                    if ItemRec.FindSet() then begin
                        ItemPage.SetTableView(ItemRec);
                        //ItemColorPage.Editable(true);
                        ItemPage.LookupMode(true);
                        if ItemPage.RunModal() = Action::LookupOK then begin
                            ItemPage.GetRecord(ItemRec);
                            Rec.Validate("Item No.", ItemRec."No.");
                            CheckCanContinue;
                            Rec.CalcFields("Item Description");
                        end;
                    end;
                end;
            }
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = all;
            }
            /*field(SizeCode; Rec."Item Size")
            {
                ApplicationArea = All;
                Caption = 'Size';
                Lookup = true;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    Clear(ItemSizePage);
                    Clear(ItemSizeRec);
                    ItemSizeRec.SetRange("Item No.", Rec."Item No.");
                    if ItemSizeRec.FindSet() then begin
                        ItemSizePage.SetTableView(ItemSizeRec);
                        //ItemColorPage.Editable(true);
                        ItemSizePage.LookupMode(true);
                        if ItemSizePage.RunModal() = Action::LookupOK then begin
                            ItemSizePage.GetRecord(ItemSizeRec);
                            Rec.Validate("Item Size", ItemSizeRec."Item Size Code");
                            CheckCanContinue;
                        end;
                    end;
                end;
            }
            field("Item Size Name"; Rec."Item Size Name")
            {
                ApplicationArea = all;
            }
            field(FitCode; Rec."Item Fit")
            {
                ApplicationArea = All;
                Caption = 'Fit';
                Lookup = true;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    Clear(ItemFitPage);
                    Clear(ItemFitRec);
                    ItemFitRec.SetRange("Item No.", Rec."Item No.");
                    if ItemFitRec.FindSet() then begin
                        ItemFitPage.SetTableView(ItemFitRec);
                        //ItemColorPage.Editable(true);
                        ItemFitPage.LookupMode(true);
                        if ItemFitPage.RunModal() = Action::LookupOK then begin
                            ItemFitPage.GetRecord(ItemFitRec);
                            Rec.Validate("Item Fit", ItemFitRec."Fit Code");
                            CheckCanContinue;
                        end;
                    end;
                end;
            }
            field("Item Fit Name"; Rec."Item Fit Name")
            {
                ApplicationArea = all;
            }
            field(Cut; Rec."Item Cut")
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
                    ItemCutRec.SetRange("Item No.", Rec."Item No.");
                    if ItemCutRec.FindSet() then begin
                        ItemCutPage.SetTableView(ItemCutRec);
                        //ItemColorPage.Editable(true);
                        ItemCutPage.LookupMode(true);
                        if ItemCutPage.RunModal() = Action::LookupOK then begin
                            ItemCutPage.GetRecord(ItemCutRec);
                            Rec.Validate("Item Cut", ItemCutRec."Cut Code");
                            CheckCanContinue;
                        end;
                    end;
                end;
            }
            field("Item Cut Name"; Rec."Item Cut Name")
            {
                ApplicationArea = all;
            }*/
            field(ColorID; Rec."Item Color ID")
            {
                ApplicationArea = All;
                Caption = 'Color';
                Lookup = true;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    Clear(ItemColorPage);
                    Clear(ItemColorRec);
                    ItemColorRec.SetRange("Item No.", Rec."Item No.");
                    if ItemColorRec.FindSet() then begin
                        ItemColorPage.SetTableView(ItemColorRec);
                        //ItemColorPage.Editable(true);
                        ItemColorPage.LookupMode(true);
                        if ItemColorPage.RunModal() = Action::LookupOK then begin
                            ItemColorPage.GetRecord(ItemColorRec);
                            Rec.Validate("Item Color ID", ItemColorRec."Color ID");
                            Rec.Validate("Tonality Code", ItemColorRec."Tonality Code");
                            CheckCanContinue;
                            Rec.CalcFields("Item Color Name");
                        end;
                    end;
                end;
            }
            field("Item Color Name"; Rec."Item Color Name")
            {
                ApplicationArea = all;
            }
            field("Tonality Code"; Rec."Tonality Code")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Sales Line Quantity"; Rec."Sales Line Quantity")
            {
                ApplicationArea = all;
                Caption = 'Total Quantity';
                Visible = ShowNonVariantControls;
                trigger OnValidate()
                begin
                    CheckCanContinue;
                end;
            }
            /*field("Quantity To Assign"; Rec."Quantity To Assign")
            {
                ApplicationArea = all;
                trigger OnDrillDown()
                begin
                    //Commit before RunModal
                    Rec.Modify();
                    //CurrPage.Close();
                    Commit();
                    //DeleteTempTables();
                    FillTempTables();
                end;
            }*/
            field("UOM"; Rec."Sales Line UOM")
            {
                ApplicationArea = all;
                Caption = 'Unit Of Measure';
                Visible = ShowNonVariantControls;
                trigger OnValidate()
                begin
                    CheckCanContinue;
                end;
            }
            field("Sales Line Location Code"; Rec."Sales Line Location Code")
            {
                ApplicationArea = all;
                Visible = ShowNonVariantControls;
                Editable = false;
                trigger OnValidate()
                begin
                    CheckCanContinue;
                end;
            }


        }
    }
    actions
    {
        area(Processing)
        {
            action(Continueaction)
            {
                Caption = 'Next';
                Enabled = CanContinue;
                Image = NextRecord;
                InFooterBar = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    /*DoStep(CurrentStep + 1);
                    CurrPage.UPDATE;*/
                    ContinuePressed := true;
                    CurrPage.Close();
                end;
            }
            action(SaveAndClose)
            {
                Caption = 'Save And Close';
                InFooterBar = true;
                ApplicationArea = all;
                Visible = ShowNonVariantControls;
                trigger OnAction()
                var
                    CUManagement: Codeunit Management;
                begin
                    CUManagement.UpdateAndClose(Rec);
                    CurrPage.Close();
                end;
            }
        }
    }
    var

        ItemColorPage: Page "Item Colors";
        ItemDesignSecFabricPage: Page "Item Design Section RM";
        ItemSizePage: Page "Item Sizes";
        ItemFitPage: Page "Item Fits";
        ItemColorRec: Record "Item Color";
        ItemSizeRec: Record "Item Size";
        ItemFitRec: Record "Item Fit";
        ContinuePressed: Boolean;
        BackPressed: Boolean;
        CanContinue: Boolean;
        MyParameterHeaderId: Integer;
        ShowNonVariantControls: Boolean;

    trigger OnOpenPage()
    var
        ParameterHeaderLoc: Record "Parameter Header";
    begin
        ContinuePressed := false;
        CheckCanContinue;
        ShowNonVariantControls := true;
        if ParameterHeaderLoc.Get(MyParameterHeaderId) then
            if ParameterHeaderLoc."Create Variant" then
                ShowNonVariantControls := false;
    end;

    procedure Continue(): Boolean
    begin
        exit(ContinuePressed);
    end;

    procedure Back(): Boolean
    begin
        exit(BackPressed);
    end;

    procedure CheckCanContinue()
    var
        Item: Record Item;
    begin
        // check if item is RM to skip checking for location 
        if item.get(rec."Item No.") then begin
            Item.CalcFields(IsRawMaterial);
            if not item.IsRawMaterial then
                CanContinue := (Rec."Item Color ID" <> 0) and (Rec."Item No." <> '') and (Rec."Tonality Code" <> '')
                                 and (Rec."Sales Line Quantity" <> 0) and (Rec."Sales Line UOM" <> '') and (Rec."Sales Line Location Code" <> '')
            else
                CanContinue := (Rec."Item Color ID" <> 0) and (Rec."Item No." <> '') and (Rec."Tonality Code" <> '')
                                 and (Rec."Sales Line Quantity" <> 0) and (Rec."Sales Line UOM" <> '');
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
        Item.Get(Rec."Item No.");
        Design.Get(Item."Design Code");
        //Fill Departments
        CustomerDepartments.SetRange("Customer No.", Rec."Customer No.");
        if CustomerDepartments.FindSet() then
            repeat
                WizardDepartments.Init();
                WizardDepartments."Parameter Header Id" := Rec.ID;
                WizardDepartments."Department Code" := CustomerDepartments."Department Code";
                IF WizardDepartments.Insert() then;
                //Fill Positions
                CustomerDepartmentPositions.SetRange("Customer No.", Rec."Customer No.");
                CustomerDepartmentPositions.SetRange("Department Code", CustomerDepartments."Department Code");
                if CustomerDepartmentPositions.FindSet() then
                    repeat
                        WizardPositions.Init();
                        WizardPositions."Parameter Header Id" := Rec.ID;
                        WizardPositions."Department Code" := CustomerDepartmentPositions."Department Code";
                        WizardPositions."Position Code" := CustomerDepartmentPositions."Position Code";
                        If WizardPositions.Insert() then;
                        //Fill Staff
                        StaffSizes.SetRange("Customer No.", Rec."Customer No.");
                        StaffSizes.SetRange("Department Code", CustomerDepartmentPositions."Department Code");
                        StaffSizes.SetRange("Position Code", CustomerDepartmentPositions."Position Code");
                        StaffSizes.SetRange(Type, Design.Type);
                        if StaffSizes.FindSet() then
                            repeat
                                WizardStaff.Init();
                                WizardStaff."Parameter Header Id" := Rec.ID;
                                WizardStaff."Department Code" := StaffSizes."Department Code";
                                WizardStaff."Position Code" := StaffSizes."Position Code";
                                WizardStaff."Staff Code" := StaffSizes."Staff Code";
                                WizardStaff."Size Code" := StaffSizes."Size Code";
                                If WizardStaff.Insert() then;
                            until StaffSizes.Next() = 0;
                    until CustomerDepartmentPositions.Next() = 0;
            until CustomerDepartments.Next() = 0;
        Clear(WizardDepartments);
        WizardDepartments.SetRange("Parameter Header Id", Rec.ID);
        WizardDepartmentsPage.SetTableView(WizardDepartments);
        //Commit before RunModal
        CurrPage.Update();
        Commit();
        WizardDepartmentsPage.RunModal();
    end;

    Procedure DeleteTempTables()
    var
        WizardDepartments: Record "Wizard Departments";
        WizardPositions: Record "Wizard Positions";
        WizardStaff: Record "Wizard Staff";
    begin
        //Delete Departments
        WizardDepartments.SetRange("Parameter Header Id", Rec.ID);
        if WizardDepartments.FindSet() then
            WizardDepartments.DeleteAll();
        //Delete Positions
        WizardPositions.SetRange("Parameter Header Id", Rec.ID);
        if WizardPositions.FindSet() then
            WizardPositions.DeleteAll();
        //Delete Staff
        WizardStaff.SetRange("Parameter Header Id", Rec.ID);
        if WizardStaff.FindSet() then
            WizardStaff.DeleteAll();
    end;

    procedure SetParameterHeaderID(ParameterHeaderID: Integer)
    begin
        MyParameterHeaderId := ParameterHeaderID;
    end;
}
