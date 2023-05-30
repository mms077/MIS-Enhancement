report 50203 "Sales Line Label Printing EN"
{
    ApplicationArea = All;
    Caption = 'Sales Line Label Printing EN';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Reports Layouts/SalesLineLabelPrintingEN.rdl';
    dataset
    {
        dataitem("ER - Manufacturing Order"; "ER - Manufacturing Order")
        {
            dataitem("Assembly Header"; "Assembly Header")
            {
                DataItemLink = "ER - Manufacturing Order No." = field("No.");
                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document No." = field("Source No."), "Line No." = field("Source Line No.");
                    RequestFilterFields = "Document Type", "Document No.";
                    dataitem(ItemReference; "Item Reference")
                    {
                        RequestFilterFields = "Item No.";
                        DataItemLink = "Item No." = field("No."), "Variant Code" = field("Variant Code"), "Unit Of Measure" = field("Unit Of Measure Code");
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
                        column(ReferenceNo; "Reference No.")
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

                        //Design Sections Set
                        dataitem("Design Sections Set"; "Design Sections Set")
                        {
                            //Design Section Columns + 
                            column(DesignSectionSet_DesignSectionCode; "Design Sections Set"."Design Section Code")
                            {
                            }
                            column(DesignSectionSet_Name; GlobalDesignSection.Name)
                            {
                            }
                            trigger OnPreDataItem()
                            begin
                                Clear(GlobalDesignSection);
                                "Design Sections Set".SetRange("Design Section Set ID", GlobalItemVariant."Design Sections Set ID");
                                if "Design Sections Set".FindSet() then;
                            end;

                            trigger OnAfterGetRecord()
                            var
                            begin
                                Clear(GlobalDesignSection);
                                if GlobalDesignSection.Get("Design Sections Set"."Design Section Code") then;
                            end;
                        }
                        //Item Features Set
                        dataitem("Item Features Set"; "Item Features Set")
                        {
                            //Item Features Column + 
                            column(ItemFeaturesSet_ItemFeatureName; "Item Features Set"."Item Feature Name")
                            {
                            }
                            column(ItemFeaturesSet_ItemFeatureValue; "Item Features Set".Value)
                            {
                            }
                            trigger OnPreDataItem()
                            begin
                                "Item Features Set".SetRange("Item Feature Set ID", GlobalItemVariant."Item Features Set ID");
                                if "Item Features Set".FindSet() then;
                            end;

                            trigger OnAfterGetRecord()
                            var
                            begin
                            end;
                        }
                        //Brandings Set
                        dataitem("Item Brandings Set"; "Item Brandings Set")
                        {
                            //Item Brandings Column
                            column(ItemBrandingsSet_ItemBrandingCode; "Item Brandings Set"."Item Branding Code")
                            {
                            }
                            column(ItemBrandingsSet_ItemBrandingName; GlobalBranding.Name)
                            {
                            }
                            trigger OnPreDataItem()
                            begin
                                "Item Brandings Set".SetRange("Item Branding Set ID", GlobalItemVariant."Item Brandings Set ID");
                                if "Item Brandings Set".FindSet() then;
                            end;

                            trigger OnAfterGetRecord()
                            begin
                                GlobalBranding.SetRange(Code, "Item Brandings Set"."Item Branding Code");
                                if GlobalBranding.FindFirst() then;
                            end;

                        }
                        dataitem(CopyLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            dataitem(PageLoop; "Integer")
                            {
                                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                                //Sales Line Columns +
                                column(SalesLine_IC_Source_No; GlobalSalesHeader."IC Source No.")
                                {
                                }
                                column(SalesLine_CustomerName; GlobalCustomer.Name)
                                {
                                }
                                column(SalesLine_IC_CustomerName; ICGlobalCustomer.Name)
                                {
                                }
                                column(SalesLine_Project; GlobalCustProject."Project Name")
                                {
                                }
                                column(SalesLine_IC_Project; ICGlobalCustProject."Project Name")
                                {
                                }
                                column(SalesLine_DepartmentName; GlobalDepartment."Name")
                                {
                                }
                                column(SalesLine_PositionName; GlobalPosition."Name")
                                {
                                }
                                column(SalesLine_StaffName; GlobalStaff."Name")
                                {
                                }
                                column(SalesLine_LineNo; "Sales Line"."Line No.")
                                {
                                }
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
                                column(SalesHeader_No; GlobalSalesHeader."No.")
                                {

                                }
                                column(Outputno; OutputNo)
                                {
                                }
                            }
                            trigger OnPreDataItem();
                            begin
                                CopyLoop.SETRANGE(Number, 1, "Assembly Header".Quantity);
                                OutputNo := 0;
                            end;

                            trigger OnAfterGetRecord();
                            begin
                                if "CopyLoop".Number >= 1 then begin
                                    OutputNo += 1;
                                end;
                            end;
                        }

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
                        Clear(GlobalSalesHeader);
                        Clear(GlobalCustomerDepartment);
                        Clear(GlobalDepartmentPosition);
                        Clear(GlobalStaff);
                        Clear(GlobalStaffMeasurement);
                        Clear(GlobalDepartment);
                        Clear(GlobalPosition);
                        Clear(GlobalCustProject);
                        Clear(ICGlobalSalesHeader);
                        Clear(ICGlobalCustProject);
                        Clear(StaffMeasurementValue);
                        Clear(StaffMeasurementUOM);
                        Clear(MeasurementCode);
                        if "Sales Line"."Sell-to Customer No." = '' then
                            CurrReport.Skip()
                        else
                            GlobalCustomer.Get("Sales Line"."Sell-to Customer No.");
                        GlobalSalesHeader.Get("Sales Line"."Document Type", "Sales Line"."Document No.");
                        if GlobalCustProject.Get(GlobalSalesHeader."Cust Project", GlobalSalesHeader."Sell-to Customer No.") then;
                        //Check if there is IC Customer
                        if GlobalSalesHeader."IC Source No." <> '' then begin
                            GlobalSalesHeader.TestField("IC Customer SO No.");
                            ICGlobalSalesHeader.ChangeCompany(GlobalSalesHeader."IC Company Name");
                            ICGlobalSalesHeader.Get(ICGlobalSalesHeader."Document Type"::Order, GlobalSalesHeader."IC Customer SO No.");
                            ICGlobalCustProject.ChangeCompany(GlobalSalesHeader."IC Company Name");
                            if ICGlobalCustProject.Get(ICGlobalSalesHeader."Cust Project", GlobalSalesHeader."IC Source No.") then;
                            ICGlobalCustomer.ChangeCompany(GlobalSalesHeader."IC Company Name");
                            if ICGlobalCustomer.Get(ICGlobalSalesHeader."Sell-to Customer No.") then;
                        end;
                        ///Allocation   
                        if GlobalSalesHeader."IC Source No." <> '' then begin
                            GlobalDepartmentPosition.ChangeCompany(GlobalSalesHeader."IC Company Name");
                            GlobalPosition.ChangeCompany(GlobalSalesHeader."IC Company Name");
                            GlobalDepartment.ChangeCompany(GlobalSalesHeader."IC Company Name");
                            GlobalCustomerDepartment.ChangeCompany(GlobalSalesHeader."IC Company Name");
                            GlobalStaff.ChangeCompany(GlobalSalesHeader."IC Company Name");
                            GlobalStaffMeasurement.ChangeCompany(GlobalSalesHeader."IC Company Name");
                        end;

                        //Department
                        if "Sales Line"."Department Code" <> '' then begin
                            if GlobalSalesHeader."IC Source No." <> '' then begin
                                if GlobalCustomerDepartment.Get(GlobalSalesHeader."IC Source No.", "Sales Line"."Department Code") then;
                            end else
                                if GlobalCustomerDepartment.Get("Sales Line"."Sell-to Customer No.", "Sales Line"."Department Code") then;
                            if GlobalDepartment.Get("Sales Line"."Department Code") then;
                        end;

                        //Position
                        if "Sales Line"."Position Code" <> '' then begin
                            GlobalDepartmentPosition.SetRange("Position Code", "Sales Line"."Position Code");
                            if GlobalSalesHeader."IC Source No." <> '' then begin
                                GlobalDepartmentPosition.SetRange("Customer No.", GlobalSalesHeader."IC Source No.");
                            end else
                                GlobalDepartmentPosition.SetRange("Customer No.", "Sell-to Customer No.");
                            GlobalDepartmentPosition.FindFirst();

                            if GlobalPosition.Get("Sales Line"."Position Code") then;
                        end;

                        //Staff
                        if "Sales Line"."Staff Code" <> '' then begin
                            GlobalStaff.SetRange("Code", "Sales Line"."Staff Code");
                            if GlobalSalesHeader."IC Source No." <> '' then begin
                                GlobalStaff.SetRange("Customer No.", GlobalSalesHeader."IC Source No.");
                            end else
                                GlobalStaff.SetRange("Customer No.", "Sell-to Customer No.");
                            if GlobalStaff.FindFirst() then begin
                                //Get Staff Measurement
                                Clear(MeasurementLoc);
                                MeasurementLoc.SetRange("Show On Label", true);
                                if MeasurementLoc.FindFirst() then begin
                                    i := 0;
                                    repeat
                                        Clear(GlobalStaffMeasurement);
                                        if GlobalSalesHeader."IC Source No." <> '' then
                                            GlobalStaffMeasurement.ChangeCompany(GlobalSalesHeader."IC Company Name");
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
                            end;
                        end;
                    end;

                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(General)
                {
                    field(SizeOption; SizeOption)
                    {
                        Caption = 'Size Option';
                        ApplicationArea = all;
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
    }
    var
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
        GlobalSalesHeader: Record "Sales Header";
        ICGlobalSalesHeader: Record "Sales Header";
        GlobalCustomerDepartment: Record "Customer Departments";
        GlobalDepartmentPosition: Record "Department Positions";
        GlobalStaff: Record Staff;
        GlobalStaffMeasurement: Record "Staff Measurements";
        GlobalDepartment: Record "Department";
        GlobalPosition: Record "Position";
        GlobalCustProject: Record "Customer Projects";
        ICGlobalCustProject: Record "Customer Projects";
        NoOfLoops: Integer;
        OutputNo: Integer;
        SizeOption: Option ER,INTL;
        StaffMeasurementValue: Array[3] of Decimal;
        StaffMeasurementUOM: Array[3] of Code[10];
        MeasurementCode: array[3] of Code[50];
}
