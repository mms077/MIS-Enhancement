report 50207 "Item Label Printing"
{
    ApplicationArea = All;
    Caption = 'Sales Line Label Printing EN';
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = true;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ItemLabelPrinting.rdlc';
    dataset
    {

        dataitem(Item; Item)
        {
            dataitem(ItemReference; "Item Reference")
            {
                DataItemLink = "Item No." = field("No.");
                //Item Reference Columns +
                column(ItemNo; "Item No.")
                {
                }
                column(VariantCode; "Variant Code")
                {
                }
                column(UnitofMeasure; "Unit of Measure")
                {
                }
                column(UniqueCode; "Unique Code")
                {
                }
                column(Variant_ColorName; GlobalItemVariantColor.Name)
                {
                }

                //Item Columns + 
                column(Item_Description; GlobalItem.Description)
                {
                }

                //Variant Columns + 
                column(Variant_ItemSize; SizeCode)
                {
                }
                column(Variant_ItemFit; GlobalFit.Name)
                {
                }
                column(Variant_ItemCut; GlobalCut.Name)
                {
                }
                column(Variant_ItemColor; GlobalItemVariant."Item Color ID")
                {
                }
                column(Variant_Tonality; GlobalItemVariant."Tonality Code")
                {
                }
                column(Variant_DesignSectionsSet; GlobalItemVariant."Design Sections Set ID")
                {
                }
                column(Variant_ItemFeaturesSet; GlobalItemVariant."Item Features Set ID")
                {
                }
                column(Variant_ItemBrandingsSet; GlobalItemVariant."Item Brandings Set ID")
                {
                }

                dataitem(CopyLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    dataitem(PageLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        //Sales Line Columns +
                        // column(SalesLine_IC_Source_No; GlobalSalesHeader."IC Source No.")//TODO:Delete
                        // {
                        // }
                        column(SalesLine_CustomerName; GlobalCustomer.Name)
                        {
                        }
                        column(SalesLine_IC_CustomerName; ICGlobalCustomer.Name)
                        {
                        }
                        column(SalesLine_Project; GlobalCustProject."Project Name")
                        {
                        }
                        // column(SalesLine_IC_Project; ICGlobalCustProject."Project Name")//TODO: Delete
                        // {
                        // }
                        column(SalesLine_DepartmentName; GlobalDepartment."Name")
                        {
                        }
                        column(SalesLine_PositionName; GlobalPosition."Name")
                        {
                        }
                        column(SalesLine_StaffName; GlobalStaff."Name")
                        {
                        }
                        // column(SalesLine_LineNo; "Sales Line"."Line No.")
                        // {
                        // }
                        column(SalesLine_MeasurementValue1; StaffMeasurementValue[1])
                        {

                        }
                        column(SalesLine_MeasurementValue2; StaffMeasurementValue[2])
                        {

                        }
                        column(SalesLine_MeasurementValue3; StaffMeasurementValue[3])
                        {

                        }
                        column(SalesLine_MeasurementUOM1; StaffMeasurementUOM[1])
                        {

                        }
                        column(SalesLine_MeasurementUOM2; StaffMeasurementUOM[2])
                        {

                        }
                        column(SalesLine_MeasurementUOM3; StaffMeasurementUOM[3])
                        {

                        }
                        column(SalesLine_MeasurementCode1; MeasurementCode[1])
                        {

                        }
                        column(SalesLine_MeasurementCode2; MeasurementCode[2])
                        {

                        }
                        column(SalesLine_MeasurementCode3; MeasurementCode[3])
                        {

                        }
                        // column(SalesHeader_No; GlobalSalesHeader."No.")
                        // {

                        // }
                        column(Outputno; OutputNo)
                        {
                        }
                    }
                    trigger OnPreDataItem();
                    begin
                        CopyLoop.SETRANGE(Number, 1, G_Quantity);
                        OutputNo := 0;
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        if "CopyLoop".Number >= 1 then begin
                            OutputNo += 1;
                        end;
                    end;
                }

                trigger OnPreDataItem()
                var
                    SalesLine: Record "Sales Line";
                begin
                    // Filter based on request page parameters
                    if G_Variant <> '' then
                        ItemReference.SetRange("Variant Code", G_Variant);

                    // If document info is provided, filter by related sales line information
                    // if ("Document No." <> '') then begin
                    //     SalesLine.Reset();
                    //     SalesLine.SetRange("Document Type", G_DocumentType);
                    //     SalesLine.SetRange("Document No.", "Document No.");

                    //     if "Line No." <> 0 then
                    //         SalesLine.SetRange("Line No.", "Line No.");

                    //     if SalesLine.FindFirst() then begin
                    //         ItemReference.SetRange("Item No.", SalesLine."No.");
                    //         if SalesLine."Variant Code" <> '' then
                    //             ItemReference.SetRange("Variant Code", SalesLine."Variant Code");
                    //     end;
                    //end;
                end;

                //Item Reference
                trigger OnAfterGetRecord()
                var
                begin
                    Clear(GlobalItem);
                    Clear(GlobalItemVariant);
                    Clear(GlobalItemVariantColor);
                    GlobalItem.Get(ItemReference."Item No.");
                    //Skip Raw Materials
                    GlobalItem.CalcFields(IsRawMaterial);
                    if GlobalItem.IsRawMaterial then
                        CurrReport.Skip();
                    If GlobalItemVariant.Get(ItemReference."Item No.", ItemReference."Variant Code") then begin
                        if GlobalItemVariantColor.Get(GlobalItemVariant."Item Color ID") then;
                        SizeCode := '';
                        if GlobalSize.Get(GlobalItemVariant."Item Size") then
                            if SizeOption = SizeOption::ER then
                                SizeCode := GlobalSize.ER
                            else
                                if SizeOption = SizeOption::INTL then
                                    SizeCode := GlobalSize.INTL;
                        if GlobalFit.Get(GlobalItemVariant."Item Fit") then;
                        if GlobalCut.Get(GlobalItemVariant."Item Cut Code") then;
                    end;
                end;

            }
            //Sales Line
            trigger OnAfterGetRecord()
            var
                MeasurementLoc: Record Measurement;
                i: Integer;
            begin
                Clear(GlobalCustomer);
                Clear(ICGlobalCustomer);
                Clear(GlobalCustomerDepartment);
                Clear(GlobalDepartmentPosition);
                Clear(GlobalStaff);
                Clear(GlobalStaffMeasurement);
                Clear(GlobalDepartment);
                Clear(GlobalPosition);
                Clear(GlobalCustProject);
                Clear(StaffMeasurementValue);
                Clear(StaffMeasurementUOM);
                Clear(MeasurementCode);

                // Check if customer-related fields are selected without a customer
                if G_Customer = '' then begin
                    if G_CustProject <> '' then
                        Error('Customer must be selected before specifying a Project.');
                    if G_DepartmentCode <> '' then
                        Error('Customer must be selected before specifying a Department.');
                    if G_Position <> '' then
                        Error('Customer must be selected before specifying a Position.');
                    if G_Staff <> '' then
                        Error('Customer must be selected before specifying a Staff.');
                end else begin
                    // Customer is selected, proceed with customer-related lookups
                    if GlobalCustomer.Get(G_Customer) then begin
                        // Lookup project if specified
                        if G_CustProject <> '' then
                            if not GlobalCustProject.Get(G_CustProject, GlobalCustomer."No.") then
                                Error('Project %1 not found for customer %2.', G_CustProject, G_Customer);

                        // Check department-related fields
                        if G_DepartmentCode = '' then begin
                            // Department not selected, check if position or staff is specified
                            if G_Position <> '' then
                                Error('Department must be selected before specifying a Position.');
                            if G_Staff <> '' then
                                Error('Department must be selected before specifying a Staff.');
                        end else begin
                            // Department is selected, verify it exists and proceed with department lookups
                            if GlobalCustomerDepartment.Get(GlobalCustomer."No.", G_DepartmentCode) then begin
                                if not GlobalDepartment.Get(G_DepartmentCode) then
                                    Error('Department %1 not found.', G_DepartmentCode);

                                // Handle position selection
                                if G_Position <> '' then begin
                                    if GlobalDepartmentPosition.Get(G_DepartmentCode, G_Position, GlobalCustomer."No.") then begin
                                        if not GlobalPosition.Get(G_Position) then
                                            Error('Position %1 not found.', G_Position);

                                        // Handle staff selection
                                        if G_Staff <> '' then begin
                                            GlobalStaff.SetRange("Code", G_Staff);
                                            GlobalStaff.SetRange("Customer No.", G_Customer);
                                            if GlobalStaff.FindFirst() then begin
                                                // Get Staff Measurement
                                                Clear(MeasurementLoc);
                                                MeasurementLoc.SetRange("Show On Label", true);
                                                if MeasurementLoc.FindFirst() then begin
                                                    i := 0;
                                                    repeat
                                                        Clear(GlobalStaffMeasurement);
                                                        GlobalStaffMeasurement.SetRange("Staff Code", GlobalStaff.Code);
                                                        GlobalStaffMeasurement.SetRange("Measurement Code", MeasurementLoc.Code);
                                                        if GlobalStaffMeasurement.FindFirst() then begin
                                                            i := i + 1;
                                                            StaffMeasurementValue[i] := GlobalStaffMeasurement.Value;
                                                            StaffMeasurementUOM[i] := GlobalStaffMeasurement."UOM Code";
                                                            MeasurementCode[i] := MeasurementLoc.Code;
                                                        end;
                                                    until (MeasurementLoc.Next() = 0) or (i = 3)
                                                end;
                                            end else
                                                Error('Staff %1 not found for Customer %2.', G_Staff, G_Customer);
                                        end;
                                    end else
                                        Error('Position %1 not found for Department %2 and Customer %3.', G_Position, G_DepartmentCode, G_Customer);
                                end;
                            end else
                                Error('Department %1 not found for Customer %2.', G_DepartmentCode, G_Customer);
                        end;
                    end else
                        Error('Customer %1 not found.', G_Customer);
                end;
            end;

        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Size)
                {
                    field(SizeOption; SizeOption)
                    {
                        Caption = 'Size Option';
                        ApplicationArea = all;
                    }
                }
                Group(General)
                {
                    field("Req Quantity"; G_Quantity)
                    {
                        Caption = 'Quantity';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if G_Quantity <= 1 then
                                Error('Quantity cannot be under 1.');
                        end;
                    }
                    field("Req Item No."; G_ItemNo)
                    {
                        Caption = 'Item No.';
                        ApplicationArea = All;
                        TableRelation = Item."No.";
                        Editable = false;
                    }
                    field("Req Variant"; G_Variant)
                    {
                        Caption = 'Variant';
                        ApplicationArea = All;
                        ShowMandatory = true;
                        //Lookup = true;
                        //LookupPageId = "Item Variants" where("Item No." = filter(format(G_ItemNo)));
                        //TableRelation = "Item Variant".Code WHERE("Item No." = const(G_ItemNo));
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ItemVariantRec: Record "Item Variant";
                        begin
                            ItemVariantRec.Reset();
                            ItemVariantRec.SetRange("Item No.", G_ItemNo);
                            if ItemVariantRec.FindFirst() then;

                            if Page.RunModal(Page::"Item Variants", ItemVariantRec) = Action::LookupOK then begin
                                G_Variant := ItemVariantRec.Code;
                                RequestOptionsPage.Update();
                            end;
                        end;

                        trigger OnValidate()
                        var
                            ItemVariantRec: Record "Item Variant";
                        begin
                            ItemVariantRec.SetRange("Item No.", G_ItemNo);
                            ItemVariantRec.SetRange("Code", G_Variant);
                            if not ItemVariantRec.FindFirst() then
                                Error('Variant not found.');
                        end;
                    }
                    field("Req Unit of Measure"; G_UOM)
                    {
                        Caption = 'Unit of Measure';
                        ApplicationArea = All;
                        ShowMandatory = true;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ItemUoMRec: Record "Item Unit of Measure";
                        begin
                            ItemUoMRec.Reset();
                            ItemUoMRec.SetRange("Item No.", G_ItemNo);
                            if ItemUoMRec.FindFirst() then;

                            if Page.RunModal(Page::"Item Units of Measure", ItemUoMRec) = Action::LookupOK then begin
                                G_UOM := ItemUoMRec.Code;
                                RequestOptionsPage.Update();
                            end;
                        end;

                        trigger OnValidate()
                        var
                            ItemUoMRec: Record "Item Unit of Measure";
                        begin
                            ItemUoMRec.SetRange("Item No.", G_ItemNo);
                            ItemUoMRec.SetRange("Code", G_UOM);
                            if not ItemUoMRec.FindFirst() then
                                Error('Unit of Measure not found.');
                        end;
                    }
                    field("Req Customer"; G_Customer)
                    {
                        Caption = 'Customer';
                        ApplicationArea = All;
                        TableRelation = Customer."No.";
                        Lookup = true;
                        LookupPageId = "Customer List";
                        ShowMandatory = true;
                    }
                    field("Req Cust Project"; G_CustProject)
                    {
                        Caption = 'Customer Project';
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            CustProjectRec: Record "Customer Projects";
                        begin
                            CustProjectRec.Reset();
                            CustProjectRec.SetRange("Customer No.", G_Customer);
                            if CustProjectRec.FindFirst() then;

                            if Page.RunModal(Page::"Customer Projects", CustProjectRec) = Action::LookupOK then begin
                                G_CustProject := CustProjectRec.Code;
                                RequestOptionsPage.Update();
                            end;
                        end;
                    }
                    field("Req Department"; G_DepartmentCode)
                    {
                        Caption = 'Department';
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            DepartmentRec: Record "Customer Departments";
                        begin
                            DepartmentRec.Reset();
                            DepartmentRec.SetRange("Customer No.", G_Customer);
                            if DepartmentRec.FindFirst() then;

                            if Page.RunModal(Page::"Customer Departments", DepartmentRec) = Action::LookupOK then begin
                                G_DepartmentCode := DepartmentRec."Department Code";
                                RequestOptionsPage.Update();
                            end;
                        end;
                    }
                    field("Req Position"; G_Position)
                    {
                        Caption = 'Position';
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            PositionRec: Record "Department Positions";
                        begin
                            PositionRec.Reset();
                            PositionRec.SetRange("Customer No.", G_Customer);
                            PositionRec.SetRange("Department Code", G_DepartmentCode);
                            if PositionRec.FindFirst() then;

                            if Page.RunModal(Page::"Department Positions", PositionRec) = Action::LookupOK then begin
                                G_Position := PositionRec."Position Code";
                                RequestOptionsPage.Update();
                            end;
                        end;
                    }
                    field("Req Staff"; G_Staff)
                    {
                        Caption = 'Staff';
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            StaffRec: Record Staff;
                        begin
                            StaffRec.Reset();
                            StaffRec.SetRange("Position Code", G_Position);
                            StaffRec.SetRange("Customer No.", G_Customer);
                            StaffRec.SetRange("Department Code", G_DepartmentCode);
                            if StaffRec.FindFirst() then;

                            if Page.RunModal(Page::"Staff", StaffRec) = Action::LookupOK then begin
                                G_Staff := StaffRec.Code;
                                RequestOptionsPage.Update();
                            end;
                        end;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }

        trigger OnOpenPage()
        begin
            // Initialize with filter values if needed
            if G_Quantity = 0 then
                G_Quantity := 1;

            // If item was not passed through InitializeRequest, try to get from filter
            if G_ItemNo = '' then begin
                if Item.GetFilter("No.") <> '' then
                    G_ItemNo := Item.GetFilter("No.");
            end;
        end;
    }
    var
        //RequestPage
        G_Quantity: Integer;
        G_ItemNo: Code[20];
        G_Variant: Code[20];
        G_UOM: Code[10];
        G_Customer: Code[20];
        G_CustProject: Code[20];
        G_DepartmentCode: Code[20];
        G_Position: Code[20];
        G_Staff: Code[20];
        G_ItemIsFilled: Boolean;
        //DataItem
        GlobalItem: Record Item;
        GlobalItemVariant: Record "Item Variant";
        GlobalItemVariantColor: Record Color;
        GlobalDesignSection: Record "Design Section";
        GlobalBranding: Record Branding;
        GlobalCut: Record Cut;
        GlobalSize: Record Size;
        SizeCode: Code[20];
        GlobalFit: Record Fit;
        GlobalCustomer: Record Customer;
        ICGlobalCustomer: Record Customer;
        //GlobalSalesHeader: Record "Sales Header";
        //ICGlobalSalesHeader: Record "Sales Header";
        GlobalCustomerDepartment: Record "Customer Departments";
        GlobalDepartmentPosition: Record "Department Positions";
        GlobalStaff: Record Staff;
        GlobalStaffMeasurement: Record "Staff Measurements";
        GlobalDepartment: Record "Department";
        GlobalPosition: Record "Position";
        GlobalCustProject: Record "Customer Projects";
        //ICGlobalCustProject: Record "Customer Projects";
        NoOfLoops: Integer;
        OutputNo: Integer;
        SizeOption: Option ER,INTL;
        StaffMeasurementValue: Array[3] of Decimal;
        StaffMeasurementUOM: Array[3] of Code[10];
        MeasurementCode: array[3] of Code[50];

    procedure InitializeRequest(ItemNo: Code[20])
    var
        ItemUOMRec: Record "Item Unit of Measure";
    begin
        G_ItemNo := ItemNo;
        // Clear related fields when item changes
        G_Variant := '';
        ItemUOMRec.SetRange("Item No.", G_ItemNo);
        if ItemUOMRec.Count = 1 then
            if ItemUOMRec.FindFirst() then
                G_UOM := ItemUOMRec.Code
            else
                G_UOM := '';
    end;
}

