tableextension 50203 "Sales Line" extends "Sales Line"
{
    fields
    {
        field(50200; Size; Code[50])
        {
            Caption = 'Size';
            Editable = false;
            TableRelation = "Item Size"."Item Size Code" where("Item No." = field("No."));
        }
        field(50201; Fit; Code[50])
        {
            Caption = 'Fit';
            Editable = false;
            TableRelation = "Item Fit"."Fit Code" where("Item No." = field("No."));
        }
        field(50202; Color; Integer)
        {
            Caption = 'Color';
            //Editable = false;
            TableRelation = "Item Color"."Color ID" where("Item No." = field("No."));
        }
        field(50203; "Assembly No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Assembly Header"."No." where("Source No." = field("Document No."),
                                                                "Source Line No." = field("Line No.")));
            Editable = false;
        }
        field(50204; Cut; Code[50])
        {
            Caption = 'Cut';
            Editable = false;
            TableRelation = "Item Cut"."Cut Code" where("Item No." = field("No."));
        }
        field(50205; Tonality; Code[50])
        {
            Caption = 'Tonality';

            Editable = false;
        }
        field(50206; "Parameters Header ID"; Integer)
        {
            Caption = 'Parameters Header ID';

            Editable = false;
            trigger OnValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                Clear(SalesHeader);
                if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then
                    UpdateDepartmentPositionStaff(Rec, false, SalesHeader."IC Company Name");
            end;
        }
        field(50207; "Needed RM Batch"; Integer)
        {
            Caption = 'Needed RM Batch';

            Editable = false;
        }
        field(50208; "Allocation Code"; Code[50])
        {
            Caption = 'Allocation Code';
            //Editable = false;
        }
        field(50209; "Allocation Type"; Option)
        {
            OptionMembers = " ","Department","Position","Staff";
            //Editable = false;
        }
        field(50210; "Parent Parameter Header ID"; Integer)
        {
            Caption = 'Parent Parameters Header ID';

            Editable = false;
            trigger OnValidate()
            begin
                //Update Param Lines
                if ParentParameter.Get("Parent Parameter Header ID") and ChildParameter.Get("Parameters Header ID") then
                    CUManagement.UpdateDesignFeatureBrandingParamLines(ParentParameter, ChildParameter);
            end;
        }
        field(50211; "Control Number"; Text[150])
        {
            Caption = 'Control Number';

        }
        field(50215; "Extra Charge %"; Decimal)
        {
            TableRelation = Size."Extra Charge %" where(Code = field(Size));
            ValidateTableRelation = false;
            trigger Onvalidate()
            var
            begin
                Validate("Line Discount %");
            end;
        }
        field(50216; "Extra Charge Amount"; Decimal)
        {
            Editable = false;
        }
        field(50217; "Qty Assignment Wizard Id"; Integer)
        {
            Editable = false;
        }
        field(50218; "IC Parameters Header ID"; Integer)
        {
            Caption = 'IC Parameters Header ID';
            //Editable = false;
        }
        field(50219; "IC Parent Parameter Header ID"; Integer)
        {
            Caption = 'IC Parent Parameter Header ID';
            Editable = false;
        }
        field(50220; "Par Level"; Integer)
        {
            Caption = 'Par Level';
            Editable = false;
        }
        field(50221; "Department Code"; Code[50])
        {
            Caption = 'Department Code';
            TableRelation = Department.Code;
            ValidateTableRelation = false;
            Editable = false;
        }
        field(50222; "Position Code"; Code[50])
        {
            Caption = 'Position Code';
            TableRelation = "Department Positions"."Position Code";
            ValidateTableRelation = false;
            Editable = false;
        }
        field(50223; "Staff Code"; Code[50])
        {
            Caption = 'Staff Code';
            TableRelation = Staff.Code;
            ValidateTableRelation = false;
            Editable = false;
        }
        field(50224; "Position Sorting"; Integer)
        {
            Caption = 'Position Sorting';
            FieldClass = FlowField;
            CalcFormula = lookup(Position."Sorting Number" where(Code = field("Position Code")));
            Editable = false;
        }
        field(50225; "Design Sections Set"; Integer)
        {
            Caption = 'Design Sections Set';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Design Sections Set ID" where("Item No." = field("No."), "Code" = field("Variant Code")));
        }
        field(50226; "Item Features Set"; Integer)
        {
            Caption = 'Item Features Set';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Item Features Set ID" where("Item No." = field("No."), "Code" = field("Variant Code")));
        }
        field(50227; "Item Brandings Set"; Integer)
        {
            Caption = 'Item Brandings Set';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Item Brandings Set ID" where("Item No." = field("No."), "Code" = field("Variant Code")));
        }
        field(50228; "Quantity in the Inventory"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry"."Quantity" where("Item No." = field("No."), "Variant Code" = field("Variant Code"), "Location Code" = field("Location Code")));
        }
        field(50229; "Reserved Qty in the Inventory"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = CONST(''),
                                                                           "Source Type" = CONST(32),
                                                                           "Source Subtype" = CONST("0"),
                                                                           "Source Batch Name" = CONST(''),
                                                                           "Source Prod. Order Line" = CONST(0),
                                                                           "Reservation Status" = CONST(Reservation),
                                                                           "Item No." = field("No."),
                                                                           "Variant Code" = field("Variant Code"),
                                                                           "Location Code" = field("Location Code")));
        }
        field(50230; "Sales Line Reference"; Guid)
        {
            DataClassification = ToBeClassified;
        }


        modify("Variant Code")
        {
            trigger OnAfterValidate()
            var
                ItemVariant: Record "Item Variant";
                CUMasterItem: Codeunit MasterItem;
                NeededRawMaterial: Record "Needed Raw Material";
            begin
                Clear(ItemVariant);
                if ItemVariant.Get(Rec."No.", Rec."Variant Code") then begin
                    Rec.Validate(Size, ItemVariant."Item Size");
                    Rec.Validate(Fit, ItemVariant."Item Fit");
                    Rec.Validate(Color, ItemVariant."Item Color ID");
                    Rec.Validate(Cut, ItemVariant."Item Cut Code");
                    Rec.Validate(Tonality, ItemVariant."Tonality Code");
                    if Rec."Parameters Header ID" = 0 then
                        CUMasterItem.GenerateParameterHeader(ItemVariant, Rec);
                    //Update the Parameter Header from the IC Parameter
                    if Rec."IC Parameters Header ID" <> 0 then
                        UpdateParameterHeaderFromIC(Rec);
                    if Rec.Modify(true) then;
                end;
            end;

            trigger OnBeforeValidate()
            begin
                //Deny Modification on some fields if a realted MO is already created
                if Rec."Document Type" = Rec."Document Type"::Order then
                    if (Rec."Variant Code" <> xRec."Variant Code") then
                        if HasRelatedMO(xRec) then
                            Error(Txt001, Rec."Line No.");
            end;
        }
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            begin
                if Rec.Amount = Rec."Line Amount" then
                    if Rec."Extra Charge %" <> 0 then
                        Rec.Validate(Amount, "Line Amount" + (("Line Amount" * Rec."Extra Charge %") / 100));
                Rec."Extra Charge Amount" := ("Line Amount" * Rec."Extra Charge %") / 100;
                UpdateParameterAmounts();
            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                UpdateParameterAmounts();
            end;
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            begin
                //Deny Modification on some fields if a realted MO is already created
                if Rec."Document Type" = Rec."Document Type"::Order then
                    if (Rec.Quantity <> xRec.Quantity) then
                        if HasRelatedMO(xRec) then
                            Error(Txt001, Rec."Line No.");
            end;

            trigger OnAfterValidate()
            begin
                UpdateParameterAmounts();
            end;
        }
        modify("Unit of Measure")
        {
            trigger OnBeforeValidate()
            begin
                //Deny Modification on some fields if a realted MO is already created
                if Rec."Document Type" = Rec."Document Type"::Order then
                    if (Rec."Unit of Measure" <> xRec."Unit of Measure") then
                        if HasRelatedMO(xRec) then
                            Error(Txt001, Rec."Line No.");
            end;
        }
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                //Deny Modification on some fields if a realted MO is already created
                if Rec."Document Type" = Rec."Document Type"::Order then
                    if (Rec."Location Code" <> xRec."Location Code") then
                        if HasRelatedMO(xRec) then
                            Error(Txt001, Rec."Line No.");
            end;

            trigger OnAfterValidate()
            var
                ParamHead: Record "Parameter Header";
            begin
                //change location of parameter header
                if ParamHead.get(rec."Parameters Header ID") then begin
                    ParamHead.Validate("Sales Line Location Code", "Location Code");
                    ParamHead.Modify();
                end;
                clear(ParamHead);
                if ParamHead.get(rec."Parent Parameter Header ID") then begin
                    ParamHead.Validate("Sales Line Location Code", "Location Code");
                    ParamHead.Modify();
                end;
                clear(ParamHead);
                if ParamHead.get(rec."Qty Assignment Wizard Id") then begin
                    ParamHead.Validate("Sales Line Location Code", "Location Code");
                    ParamHead.Modify();
                end;
            end;
        }
    }
    keys
    {
        key(Key4; "Allocation Type", "Allocation Code")
        {

        }
        key(key5; "Department Code", "Position Code", "Staff Code")
        {

        }
    }
    trigger OnAfterModify()
    var
        ItemVariant: Record "Item Variant";
        CUMasterItem: Codeunit MasterItem;
    begin
        //If the quantity or UOM or Location or variant changed on the line on a line already had parameter header and needed raw material 
        //  --> should regenerate new parameter header and needed raw materials
        if (Rec.Quantity <> xRec.Quantity)
            or (Rec."Unit of Measure Code" <> xRec."Unit of Measure Code")
            or (Rec."Location Code" <> xRec."Location Code")
            or (Rec."Variant Code" <> xRec."Variant Code") then begin
            if Rec."Parameters Header ID" <> 0 then begin
                Clear(ItemVariant);
                if ItemVariant.Get(Rec."No.", Rec."Variant Code") then begin
                    CUMasterItem.GenerateParameterHeader(ItemVariant, Rec);
                    if Rec.Modify(true) then;
                end;
            end;
        end;
        UpdateParameterAmounts();
        //Update Param Lines
        if (Rec."Parent Parameter Header ID" <> xRec."Parent Parameter Header ID") then
            if ParentParameter.Get("Parent Parameter Header ID") and ChildParameter.Get("Parameters Header ID") then
                CUManagement.UpdateDesignFeatureBrandingParamLines(ParentParameter, ChildParameter);
    end;

    trigger OnAfterInsert()
    begin
        //Update Param Lines
        if ParentParameter.Get("Parent Parameter Header ID") and ChildParameter.Get("Parameters Header ID") then
            CUManagement.UpdateDesignFeatureBrandingParamLines(ParentParameter, ChildParameter);
    end;

    procedure UpdateParameterAmounts()
    var
        ParameterHeader: Record "Parameter Header";
        QtyAssignWizad: Record "Qty Assignment Wizard";
        WizardDepartment: Record "Wizard Departments";
        WizardPosition: Record "Wizard Positions";
        WizardStaff: Record "Wizard Staff";
    begin
        if ParameterHeader.Get("Parameters Header ID") then begin
            ParameterHeader."Sales Line Unit Price" := Rec."Unit Price";
            ParameterHeader."Sales Line Amount" := Rec."Amount";
            ParameterHeader."Sales Line Line Amount" := Rec."Line Amount";
            ParameterHeader."Sales Line Amount Incl. VAT" := Rec."Amount Including VAT";
            ParameterHeader."Sales Line Discount %" := Rec."Line Discount %";
            ParameterHeader."Sales Line Discount Amount" := Rec."Line Discount Amount";
            ParameterHeader."Extra Charge %" := Rec."Extra Charge %";
            ParameterHeader."Extra Charge Amount" := Rec."Extra Charge Amount";
            ParameterHeader."Sales Line Quantity" := Rec.Quantity;
            ParameterHeader.Modify(true);
            //Update Wizard Department
            if Rec."Allocation Type" = Rec."Allocation Type"::Department then begin
                Clear(WizardDepartment);
                WizardDepartment.SetRange("Parameter Header Id", ParameterHeader.ID);
                WizardDepartment.SetRange("Department Code", Rec."Allocation Code");
                if WizardDepartment.FindFirst() then begin
                    WizardDepartment."Quantity To Assign" := Rec.Quantity;
                    WizardDepartment.Modify();
                end;
            end else
                //Update Wizard Position 
                if Rec."Allocation Type" = Rec."Allocation Type"::Position then begin
                    Clear(WizardPosition);
                    WizardPosition.SetRange("Parameter Header Id", ParameterHeader.ID);
                    WizardPosition.SetRange("Department Code", Rec."Allocation Code");
                    if WizardPosition.FindFirst() then begin
                        WizardPosition."Quantity To Assign" := Rec.Quantity;
                        WizardPosition.Modify();
                    end;
                end else
                    //Update Wizard Staff
                    if Rec."Allocation Type" = Rec."Allocation Type"::Staff then begin
                        Clear(WizardStaff);
                        WizardStaff.SetRange("Parameter Header Id", ParameterHeader.ID);
                        WizardStaff.SetRange("Department Code", Rec."Allocation Code");
                        if WizardStaff.FindFirst() then begin
                            WizardStaff."Quantity To Assign" := Rec.Quantity;
                            WizardStaff.Modify();
                        end;
                    end;
        end;
        Clear(QtyAssignWizad);
        QtyAssignWizad.SetRange("Header Id", "Qty Assignment Wizard Id");
        if QtyAssignWizad.FindSet() then
            repeat
                QtyAssignWizad."Sales Line Unit Price" := Rec."Unit Price";
                QtyAssignWizad."Sales Line Discount %" := Rec."Line Discount %";
                //QtyAssignWizad."Sales Line Discount Amount" := Rec."Line Discount Amount";
                QtyAssignWizad."Extra Charge %" := Rec."Extra Charge %";
                //QtyAssignWizad."Extra Charge Amount" := Rec."Extra Charge Amount";
                QtyAssignWizad.Modify(true);
            until QtyAssignWizad.Next() = 0;
    end;

    procedure UpdateParameterHeaderFromIC(SalesLinePar: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
        ICParameterHeader: Record "Parameter Header";
        ParameterHeader: Record "Parameter Header";
    begin
        Clear(SalesHeader);
        SalesHeader.Get(SalesLinePar."Document Type", SalesLinePar."Document No.");
        if SalesHeader."IC Company Name" <> '' then begin
            Clear(ICParameterHeader);
            ICParameterHeader.ChangeCompany(SalesHeader."IC Company Name");
            if ICParameterHeader.Get(SalesLinePar."IC Parameters Header ID") then begin
                Clear(ParameterHeader);
                if ParameterHeader.Get(SalesLinePar."Parameters Header ID") then begin
                    //UpdateDesignSecParLinesFromIC(ParameterHeader, ICParameterHeader);
                    UpdateFeaturesParLinesFromIC(ParameterHeader, ICParameterHeader, SalesHeader."IC Company Name");
                    //UpdateBrandingParLinesFromIC(ParameterHeader, ICParameterHeader);
                end;
            end;
        end;
    end;

    procedure UpdateDesignSecParLinesFromIC(var ParameterHeader: Record "Parameter Header"; var ICParameterHeader: Record "Parameter Header")
    var
    begin

    end;

    procedure UpdateFeaturesParLinesFromIC(var ParameterHeader: Record "Parameter Header"; var ICParameterHeader: Record "Parameter Header"; CompanyName: Text[30])
    var
        ItemFeatureParamSet: Record "Item Features Param Lines";
        ICItemFeatureParamSet: Record "Item Features Param Lines";
        LineNumber: Integer;
    begin
        Clear(ItemFeatureParamSet);
        Clear(LineNumber);
        LineNumber := 1;
        ItemFeatureParamSet.SetRange("Header ID", ParameterHeader.ID);
        if ItemFeatureParamSet.FindSet() then
            ItemFeatureParamSet.DeleteAll();
        Clear(ICItemFeatureParamSet);
        ICItemFeatureParamSet.ChangeCompany(CompanyName);
        ICItemFeatureParamSet.SetRange("Header ID", ICParameterHeader.ID);
        if ICItemFeatureParamSet.FindSet() then
            repeat
                ItemFeatureParamSet.Init();
                ItemFeatureParamSet.TransferFields(ICItemFeatureParamSet);
                ItemFeatureParamSet."Header ID" := ParameterHeader.ID;
                ItemFeatureParamSet."Line No." := LineNumber;
                ItemFeatureParamSet.Insert(true);
                LineNumber += 1;
            until ICItemFeatureParamSet.Next() = 0;

    end;

    procedure UpdateBrandingParLinesFromIC(var ParameterHeader: Record "Parameter Header"; var ICParameterHeader: Record "Parameter Header")
    begin

    end;

    Procedure UpdateDepartmentPositionStaff(var SalesLine: Record "Sales Line"; ShouldModify: Boolean; CompanySource: Text[30])
    ParameterHeaderLoc: Record "Parameter Header";
    begin
        Clear(ParameterHeaderLoc);
        if (CompanySource <> '') and (CompanySource <> CompanyName) then begin
            ParameterHeaderLoc.ChangeCompany(CompanySource);
            if ParameterHeaderLoc.Get(SalesLine."IC Parameters Header ID") then;
        end else
            if ParameterHeaderLoc.Get(SalesLine."Parameters Header ID") then;

        if SalesLine."Allocation Type" = SalesLine."Allocation Type"::Department then
            SalesLine."Department Code" := ParameterHeaderLoc."Allocation Code"
        else
            SalesLine."Department Code" := ParameterHeaderLoc."Department Code";
        if ParameterHeaderLoc."Position Code" <> '' then
            SalesLine."Position Code" := ParameterHeaderLoc."Position Code"
        else
            if ParameterHeaderLoc."Allocation Type" = ParameterHeaderLoc."Allocation Type"::Position then
                SalesLine."Position Code" := ParameterHeaderLoc."Allocation Code";
        if ParameterHeaderLoc."Allocation Type" = ParameterHeaderLoc."Allocation Type"::Staff then
            SalesLine."Staff Code" := ParameterHeaderLoc."Allocation Code";
        if ShouldModify then
            SalesLine.Modify()
    end;

    procedure HasRelatedMO(var SalesLine: Record "Sales Line"): Boolean
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        if SalesLine."Assembly No." <> '' then begin
            Clear(AssemblyHeader);
            AssemblyHeader.SetRange("No.", SalesLine."Assembly No.");
            if AssemblyHeader.FindFirst() then
                if AssemblyHeader."ER - Manufacturing Order No." <> '' then
                    exit(true);
        end;
        exit(false)
    end;

    var
        MasterItemCU: Codeunit MasterItem;
        CUManagement: Codeunit Management;
        ParentParameter: Record "Parameter Header";
        ChildParameter: Record "Parameter Header";
        Txt001: Label 'A related MO is already created. You cannot modify the sales line %1';
}