report 50241 "Assembly to Stock Label Print"
{
    ApplicationArea = All;
    Caption = 'Assembly to stock Label Printing';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Reports Layouts/AssemblyLabelPrinting.rdlc';
    dataset
    {
        dataitem("ER - Manufacturing Order"; "ER - Manufacturing Order")
        {
            dataitem("Assembly Header"; "Assembly Header")
            {
                DataItemLink = "ER - Manufacturing Order No." = field("No.");
                DataItemTableView = Sorting("No.") WHERE("Assemble to Order" = CONST(False));
                column(Assemble_to_Order; "Assemble to Order") { }

                /*dataitem("Assembly Line"; "Assembly Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    // RequestFilterFields = "Document Type", "Document No.";*/
                dataitem(ItemReference; "Item Reference")
                {
                    DataItemLink = "Item No." = field("Item No."), "Variant Code" = field("Variant Code"), "Unit Of Measure" = field("Unit Of Measure Code");
                    //Item Reference Columns +
                    column(ItemNo; "Item No.")
                    {
                    }
                    column(Description;Description){}
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

                            column(Outputno; OutputNo)
                            {
                            }
                            column("No_"; "Assembly Header"."No.") { }

                        }
                        trigger OnPreDataItem();
                        begin
                            CopyLoop.SETRANGE(Number, 1, "Assembly Header".Quantity);
                            OutputNo := 0;
                        end;

                        trigger OnAfterGetRecord()
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
                        //   Message('Item Reference OnAfterGetRecord called for Item No. ' + ItemReference."Item No.");
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
