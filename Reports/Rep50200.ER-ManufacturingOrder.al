report 50200 "ER - Manufacturing Order"
{
    Caption = 'ER - Manufacturing Order';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-Manufacturing Order.rdlc';

    dataset
    {
        dataitem("ER - Manufacturing Order"; "ER - Manufacturing Order")
        {
            RequestFilterFields = "No.";
            DataItemTableView = sorting("No.");
            column(IsCopy; IsCopy)
            {
            }
            column(TotalMainItemQty; TotalMainItemQty)
            {
            }
            column(Manufacturing_Order_No; "ER - Manufacturing Order"."No.")
            {

            }
            column(SalesReceivablesSetupPicture; SalesReceivablesSetup.Picture)
            {

            }
            dataitem("Assembly Header"; "Assembly Header")
            {
                DataItemLink = "ER - Manufacturing Order No." = field("No.");
                RequestFilterFields = "No.", "Item No.";
                //DataItemTableView = SORTING("ER - Manufacturing Order No.");

                //Assembly Header Columns + 
                column(AssemblyNo; "Assembly Header"."No.")
                {

                }
                column(AssemblyHeaderQuantity; "Assembly Header".Quantity)
                {

                }
                column(AssemblyHeaderUOM; "Assembly Header"."Unit of Measure Code")
                {

                }
                /*column(AssemblyGrpNo; "Assembly Header"."ER - Manufacturing Order No.")
                {

                }*/
                // Column that stores the barcode encoded string
                column(Barcode; EncodedText)
                {
                }

                //Header Item Columns +
                column(Header_Item_No; GlobalItem."No.")
                {

                }
                column(Header_Item_Description; GlobalItem.Description)
                {

                }
                column(Header_Item_Picture; GlobalItem.Picture)
                {

                }
                column(Header_Brand_Name; GlobalBrand."Name")
                {

                }
                column(HasItemPicture; HasItemPicture)
                {

                }

                //Header Variant Columns +
                column(Variant_Picture; TenanantMediaThumbnailsVariant.Content)
                {

                }
                column(Variant_Code; GlobalItemVariant.Code)
                {

                }
                column(GlobalVariantQtyByMO; GlobalVariantQtyByMO)
                {

                }
                column(HasVariantPicture; HasVariantPicture)
                {

                }
                column(TotalVariantQty; TotalVariantQty)
                {

                }

                //Design Columns +
                column(Design_Code;
                GlobalDesign.Code)
                {

                }
                column(Design_Name; GlobalDesign.Name)
                {

                }
                column(Design_Gender; GlobalDesign.Gender)
                {

                }
                column(Design_Type; GlobalDesign.Type)
                {

                }
                column(Design_Category_Name; GlobalItemCategory.Description)
                {

                }

                //Sales Order Columns +
                column(Sales_Order_No; GlobalSalesHeader."No.")
                {

                }
                column(Sales_Order_Order_Date; GlobalSalesHeader."Order Date")
                {

                }
                column(WeekNumber; WeekNumber)
                {

                }
                column(Sales_Order_Order_Type; OrderType)
                {

                }

                //Sales Line Columns +
                column(Department_Name; GlobalDepartment.Name)
                {

                }
                column(Position_Name; GlobalPosition.Name)
                {

                }
                column(Staff_Name; GlobalStaff.Name)
                {

                }
                column(Sales_Line_Number; GlobalSalesLine."Line No.")
                {

                }
                //Customer Columns + 
                column(Customer_Name; GlobalCustomer.Name)
                {

                }
                column(Customer_No; GlobalCustomer."No.")
                {

                }
                column(Customer_Project; GlobalCustomerProject."Project Name")
                {

                }
                column(Customer_Country_Name; CustomerCountryName)
                {

                }

                //IC Customer Columns + 
                column(IC_Customer_Name; GlobalICCustomer.Name)
                {

                }
                column(IC_Customer_No; GlobalICCustomer."No.")
                {

                }
                column(IC_Customer_Project; GlobalICCustomerProject."Project Name")
                {

                }
                column(IC_Customer_Country_Name; ICCustomerCountryName)
                {

                }

                //Parameters Header Columns +
                column(Parameter_ID; GlobalParameters.ID)
                {

                }
                column(Item_Size_Name; Size.Name)
                {

                }
                column(Item_Fit_Name; Fit.Name)
                {

                }
                column(Item_Color_Name; Color.Name)
                {

                }
                column(Item_Tonality_Name; Tonality.Name)
                {

                }
                column(Item_Cut_Name; Cut.Name)
                {

                }
                //Company Columns +
                column(Company_Picture; CompanyInformation.Picture)
                {

                }

                dataitem("Section Group"; "Section Group")
                {
                    column(Section_Code; "Section Group"."Section Code")
                    {

                    }
                    column(Section_Group; "Section Group"."Group Code")
                    {

                    }
                    column(SectionGroupRM_Name; SectionGroupRM.Name)
                    {

                    }
                    trigger OnPreDataItem()
                    begin
                        "Section Group".SetRange("Show On MO Report", true);
                    end;

                    trigger OnAfterGetRecord()
                    var
                        ParameterHeaderLoc: Record "Parameter Header";
                        ItemDesignSecRMLoc: Record "Item Design Section RM";
                        DesignSectionParamLines: Record "Design Section Param Lines";
                    begin
                        Clear(ParameterHeaderLoc);
                        Clear(ItemDesignSecRMLoc);
                        Clear(SectionGroupRM);
                        Clear(DesignSectionParamLines);
                        if ParameterHeaderLoc.Get("Assembly Header"."Parameters Header ID") then begin
                            ItemDesignSecRMLoc.SetRange("Item No.", "Assembly Header"."Item No.");
                            ItemDesignSecRMLoc.SetRange("Section Group", "Section Group"."Group Code");
                            if ItemDesignSecRMLoc.FindFirst() then begin
                                DesignSectionParamLines.SetRange("Header ID", "Assembly Header"."Parameters Header ID");
                                DesignSectionParamLines.SetRange("Design Section Code", ItemDesignSecRMLoc."Design Section Code");
                                if DesignSectionParamLines.FindFirst() then;
                                SectionGroupRM.SetRange("Raw Material Category", ItemDesignSecRMLoc."Raw Material Category");
                                //All the design sections parameters related to the same Section Group have same Color
                                SectionGroupRM.SetRange("Color ID", DesignSectionParamLines."Color ID");
                                if SectionGroupRM.FindFirst() then;
                            end;
                        end;
                    end;
                }

                dataitem("Assembly Line"; "Assembly Line")
                {
                    DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                    DataItemTableView = SORTING("Line No.");

                    //Assembly Line Columns + 
                    column(Assembly_Line_No; "Assembly Line"."No.")
                    {
                    }
                    column(Assembly_Line_Desciption; "Assembly Line".Description)
                    {
                    }
                    column(Assembly_Line_Quantity; "Assembly Line".Quantity)
                    {
                    }
                    column(Assembly_Line_UOM; "Assembly Line"."Unit of Measure Code")
                    {
                    }
                    column(SectionSortingNumber; SectionSortingNumber)
                    {

                    }
                    column(Section_Name; GlobalSection.Name)
                    {

                    }
                    trigger OnAfterGetRecord()
                    var
                        NeededRawMaterial: Record "Needed Raw Material";

                    begin
                        Clear(NeededRawMaterial);
                        Clear(SectionSortingNumber);
                        NeededRawMaterial.SetRange("Assembly Order No.", "Assembly Line"."Document No.");
                        NeededRawMaterial.SetRange("Assembly Order Line No.", "Assembly Line"."Line No.");
                        if NeededRawMaterial.FindFirst() then begin
                            Clear(GlobalSection);
                            if GlobalSection.Get(NeededRawMaterial."Design Detail Section Code") then
                                SectionSortingNumber := GlobalSection.Number;
                        end else
                            //Did not find needed raw material relation
                            Clear(GlobalSection);

                    end;
                }

                //The Design sections color Different to main item
                dataitem("GlobalDesignSecParLines"; "Design Section Param Lines")
                {
                    DataItemLink = "Header ID" = field("Parameters Header ID");
                    DataItemTableView = SORTING("Design Section Code");
                    //Design Section Color Columns +
                    column(Different_Design_Section_Code; "Design Section Code")
                    {

                    }
                    column(Different_Design_Section_Name; DifferentDesignSection.Name)
                    {

                    }
                    column(Different_Design_Section_Color_Name; "Color Name")
                    {
                        AutoCalcField = true;
                    }

                    column(Different_Design_Section_Section_Code; DifferentDesignSection."Section Code")
                    {

                    }
                    column(ItemDesignSectionColorPicture; TenanantMediaThumbnailsDesignSection.Content)
                    {
                    }
                    column(DesignSectionHasPicture; DesignSectionHasPicture)
                    {
                    }
                    column(DesignSection_RawMaterial_Name; DesignSectionRawMaterial.Name)
                    {

                    }
                    column(DesignSection_Section_Group; GlobalDesignDetail."Section Group")
                    {

                    }
                    trigger OnPreDataItem()
                    begin
                        TempDesinSecParLines.DeleteAll();
                        LineNumber := 0;
                    end;

                    trigger OnAfterGetRecord()
                    var
                        DesignSectionLoc: Record "Design Section";
                    begin
                        if DifferentDesignSection.Get("GlobalDesignSecParLines"."Design Section Code") then;
                        //Get Related Raw Material
                        Clear(DesignSectionRawMaterial);
                        DesignSectionRawMaterial.SetRange(Code, GlobalDesignSecParLines."Raw Material Code");
                        if DesignSectionRawMaterial.FindFirst() then;
                        //Get Section Group
                        Clear(GlobalDesignDetail);
                        GlobalDesignDetail.SetCurrentKey("Fit Code", "Size Code", "Section Number", "Design Section Code");
                        GlobalDesignDetail.SetRange("Design Code", GlobalItem."Design Code");
                        GlobalDesignDetail.SetRange("Design Section Code", GlobalDesignSecParLines."Design Section Code");
                        if GlobalDesignDetail.FindFirst() then;

                        //Add the Different Design Section to temporary table
                        TempDesinSecParLines.Init();
                        TempDesinSecParLines."Line No." := LineNumber + 10000;
                        TempDesinSecParLines."Header ID" := GlobalDesignSecParLines."Header ID";
                        TempDesinSecParLines."Design Section Code" := GlobalDesignSecParLines."Design Section Code";
                        TempDesinSecParLines.Insert();
                        LineNumber := LineNumber + 10000;

                        Clear(DifferentItemDesignSectionColor);
                        DesignSectionHasPicture := false;
                        DifferentItemDesignSectionColor.SetRange("Item No.", "Assembly Header"."Item No.");
                        DifferentItemDesignSectionColor.SetRange("Design Section Code", GlobalDesignSecParLines."Design Section Code");
                        DifferentItemDesignSectionColor.SetRange("Color ID", "GlobalDesignSecParLines"."Color ID");
                        DifferentItemDesignSectionColor.SetRange("Tonality Code", GlobalDesignSecParLines."Tonality Code");
                        if DifferentItemDesignSectionColor.FindFirst() then
                            if DifferentItemDesignSectionColor.Picture.Count <> 0 then begin
                                Clear(DesignSectionLoc);
                                DesignSectionLoc.Get(DifferentItemDesignSectionColor."Design Section Code");
                                if DesignSectionLoc."Show Picture On Report" then begin
                                    DesignSectionHasPicture := true;
                                    Clear(TenanantMediaThumbnailsDesignSection);
                                    Clear(TenantMediaSet);
                                    TenantMediaSet.Setfilter("ID", Format(DifferentItemDesignSectionColor.Picture));
                                    if TenantMediaSet.FindFirst() then begin
                                        TenanantMediaThumbnailsDesignSection.SetCurrentKey(Width);
                                        TenanantMediaThumbnailsDesignSection.SetAscending(Width, false);
                                        TenanantMediaThumbnailsDesignSection.Setfilter("Media Id", Format(TenantMediaSet."Media ID"));
                                        if TenanantMediaThumbnailsDesignSection.FindFirst() then
                                            TenanantMediaThumbnailsDesignSection.CalcFields(Content);
                                    end;
                                end;
                            end else
                                DesignSectionHasPicture := false;
                    end;
                }

                //The Design sections color similar to main item
                /*dataitem("DesignDetail"; "Design Detail")
                {
                    DataItemTableView = SORTING("Design Section Code");
                    //Design Section Color Columns +
                    column(Similar_Design_Section_Code; "Design Section Code")
                    {

                    }
                    column(Similar_Design_Section_Name; "Design Section Name")
                    {
                        AutoCalcField = true;
                    }

                    column(UniqueColor; DesignSectionUniqueColor."Unique Color")
                    {

                    }
                    column(UniqueColorName; UniqueColorName)
                    {

                    }
                    column(Similar_Design_Section_Section_Code; "Section Code")
                    {

                    }
                    trigger OnPreDataItem()
                    begin
                        SetRange("Size Code", GlobalParameters."Item Size");
                        SetRange("Fit Code", GlobalParameters."Item Fit");
                        SetRange("Design Code", GlobalDesign.Code);
                        if FindSet() then;
                    end;

                    trigger OnAfterGetRecord()
                    var
                        LocColor: Record Color;
                    begin
                        //If the design section existing in the temporary(Different Design Section than main item) then skip 
                        if TempDesinSecParLines.FindFirst() then
                            repeat
                                if TempDesinSecParLines."Design Section Code" = DesignDetail."Design Section Code" then
                                    CurrReport.Skip()
                                else begin
                                    Clear(DesignSectionUniqueColor);
                                    DesignSectionUniqueColor.Get(DesignDetail."Design Section Code");
                                    if DesignSectionUniqueColor."Unique Color" <> 0 then begin
                                        LocColor.Get(DesignSectionUniqueColor."Unique Color");
                                        UniqueColorName := LocColor.Name;
                                    end;
                                end;
                            until TempDesinSecParLines.Next() = 0;
                    end;
                }*/
                dataitem("GlobalItemFeaturesParLines"; "Item Features Param Lines")
                {
                    DataItemLink = "Header ID" = field("Parameters Header ID");
                    DataItemTableView = SORTING("Line No.");
                    //Item Features Columns +
                    column(Feature_Name;
                    "Feature Name")
                    {

                    }
                    column(Feature_Value; "Value")
                    {

                    }
                    column(Feature_Color_Name; "Color Name")
                    {
                        AutoCalcField = true;
                    }
                    column(Feature_Instructions; "Instructions")
                    {
                        AutoCalcField = true;
                    }
                    column(Feature_Sorting_Number; GlobalFeature."Sorting Number")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Clear(GlobalFeature);
                        GlobalFeature.Get(GlobalItemFeaturesParLines."Feature Name");
                    end;
                }

                dataitem("GlobalItemBrandingParLines"; "Item Branding Param Lines")
                {
                    DataItemLink = "Header ID" = field("Parameters Header ID");
                    DataItemTableView = SORTING("Line No.");
                    //Item Brandings Columns +
                    column(Branding_Code; "Code")
                    {

                    }
                    column(Branding_Name; "Name")
                    {

                    }
                    column(Branding_Description; "Description")
                    {

                    }
                    column(Branding_Picture; TenanantMediaThumbnailsBranding.Content)
                    {

                    }
                    column(Branding_Position; GlobalBranding.Position)
                    {

                    }
                    column(TenanantMedia_Content; TenanantMediaThumbnailsICBranding.Content)
                    {

                    }
                    column(HasBrandingPicture; HasBrandingPicture)
                    {

                    }
                    column(HasBrandingDetailPicture; HasBrandingDetailPicture)
                    {

                    }
                    trigger OnAfterGetRecord()
                    var
                    begin
                        Clear(GlobalBranding);
                        Clear(GlobalBrandingDetails);
                        GlobalBranding.SetRange(Code, GlobalItemBrandingParLines.Code);
                        if GlobalBranding.FindFirst() then begin
                            HasBrandingPicture := false;
                            if GlobalBranding.Picture.Count = 0 then
                                HasBrandingPicture := false
                            else begin
                                HasBrandingPicture := true;
                                Clear(TenanantMediaThumbnailsBranding);
                                Clear(TenantMediaSet);
                                TenantMediaSet.Setfilter("ID", Format(GlobalBranding.Picture));
                                if TenantMediaSet.FindFirst() then begin
                                    TenanantMediaThumbnailsBranding.SetCurrentKey(Width);
                                    TenanantMediaThumbnailsBranding.SetAscending(Width, false);
                                    TenanantMediaThumbnailsBranding.Setfilter("Media Id", Format(TenantMediaSet."Media ID"));
                                    if TenanantMediaThumbnailsBranding.FindFirst() then
                                        TenanantMediaThumbnailsBranding.CalcFields(Content);
                                end;
                            end;
                            if GlobalSalesHeader."IC Company Name" <> '' then
                                GlobalBrandingDetails.ChangeCompany(GlobalSalesHeader."IC Company Name");
                            GlobalBrandingDetails.SetRange("Branding Code", GlobalBranding.Code);
                            "Assembly Header".CalcFields("Item Color ID");
                            GlobalBrandingDetails.SetRange("Item Color ID", "Assembly Header"."Item Color ID");
                            if GlobalBrandingDetails.FindFirst() then begin
                                HasBrandingDetailPicture := false;
                                if GlobalBrandingDetails."Image File".Count = 0 then
                                    HasBrandingDetailPicture := false
                                else begin
                                    HasBrandingDetailPicture := true;
                                    Clear(TenanantMediaThumbnailsICBranding);
                                    Clear(TenantMediaSet);
                                    TenantMediaSet.Setfilter("ID", Format(GlobalBrandingDetails."Image File"));
                                    if TenantMediaSet.FindFirst() then begin
                                        TenanantMediaThumbnailsICBranding.Setfilter("Media Id", Format(TenantMediaSet."Media ID"));
                                        if TenanantMediaThumbnailsICBranding.FindFirst() then
                                            TenanantMediaThumbnailsICBranding.CalcFields(Content);
                                    end;
                                end;
                            end;
                        end;
                    end;
                }

                //Plotting 
                dataitem("Design Plotting"; "Design Plotting")
                {
                    dataitem("Plotting File"; "Plotting File")
                    {
                        dataitem("Plotting File Measurement"; "Plotting File Measurement")
                        {
                            column(Plotting_File_Size; "Plotting File".Size)
                            {

                            }
                            column(Plotting_File_Cut; "Plotting File".Cut)
                            {

                            }
                            column(Plotting_File_Fit; "Plotting File".Fit)
                            {

                            }
                            column(Plotting_File_Measurement_Efficiency; "Plotting File Measurement"."Efficiency %")
                            {

                            }
                            column(Plotting_File_Measurement_Quantity; "Plotting File Measurement".Quantity)
                            {

                            }
                            column(Plotting_File_Measurement_UOM; "Plotting File Measurement".UOM)
                            {

                            }
                            column(Plotting_File_Measurement_Fabric_Width; "Plotting File Measurement"."Fabric Width")
                            {

                            }
                            column(TotalQtyNeeded; TotalQtyNeeded)
                            {

                            }
                            column(PlottingFileRatio; PlottingFileRatio)
                            {

                            }
                            column(Plotting_File_Section_Name; "Plotting File Measurement"."Section Name")
                            {

                            }
                            column(Plotting_File_Section_Group; "Plotting File Measurement"."Section Group")
                            {

                            }
                            //Plotting File Measurement
                            trigger OnPreDataItem()
                            begin
                                Clear("Plotting File Measurement");
                                "Plotting File Measurement".SetRange("Plotting File ID", "Plotting File".ID);
                                if "Plotting File Measurement".FindSet() then;
                            end;

                            trigger OnAfterGetRecord()
                            var
                            begin
                                "Plotting File Measurement".calcfields("Section Name");
                                "Plotting File".CalcFields(Size, Fit);
                                PlottingFileRatio := 0;
                                TotalQtyNeeded := 0;
                                if "Plotting File Measurement"."Efficiency %" <> 0 then begin
                                    PlottingFileRatio := (1 / "Plotting File Measurement"."Efficiency %") * 100;
                                    if PlottingFileRatio >= 2 then begin
                                        PlottingFileRatio := Round(PlottingFileRatio, 1, '<');
                                        TotalQtyNeeded := Round((TotalVariantQty / PlottingFileRatio), 1, '>') * "Plotting File Measurement".Quantity;
                                        //If the needed qty should not be less than plotting file qty
                                        if TotalQtyNeeded < "Plotting File Measurement".Quantity then
                                            TotalQtyNeeded := "Plotting File Measurement".Quantity;
                                    end else begin
                                        PlottingFileRatio := 1;
                                        TotalQtyNeeded := TotalVariantQty * "Plotting File Measurement".Quantity;
                                        //If the needed qty should not be less than plotting file qty
                                        if TotalQtyNeeded < "Plotting File Measurement".Quantity then
                                            TotalQtyNeeded := "Plotting File Measurement".Quantity;
                                    end;
                                end;
                            end;
                        }
                        //Plotting File
                        trigger OnPreDataItem()
                        begin
                            Clear("Plotting File");
                            "Assembly Header".CalcFields("Item Cut Code", "Item Features Set ID");
                            "Plotting File".SetRange("Design Code", GlobalDesign.Code);
                            "Plotting File".SetRange(Size, "Assembly Header"."Item Size");
                            "Plotting File".SetRange(Fit, "Assembly Header"."Item Fit");
                            "Plotting File".SetRange("Item Features Set", "Assembly Header"."Item Features Set ID");
                            "Plotting File".SetRange("Design Plotting ID", "Design Plotting".ID);
                            if "Plotting File".FindSet() then;
                        end;
                    }

                    //Design Plotting
                    trigger OnPreDataItem()
                    begin
                        Clear("Design Plotting");
                        "Assembly Header".CalcFields("Item Size", "Item Fit");
                        "Design Plotting".SetRange("Design Code", GlobalDesign.Code);
                        "Design Plotting".SetRange(Size, "Assembly Header"."Item Size");
                        "Design Plotting".SetRange(Fit, "Assembly Header"."Item Fit");
                        if "Design Plotting".FindSet() then;
                    end;
                }


                //Assembly Header Triggers
                trigger OnAfterGetRecord()
                var
                    BarcodeString: Text;
                    BarcodeSymbology: Enum "Barcode Symbology";
                    BarcodeFontProvider: Interface "Barcode Font Provider";
                    CountryRegion: Record "Country/Region";
                    ICCountryRegion: Record "Country/Region";
                    ParameterHeader: Record "Parameter Header";
                    AssemblyHeaderLoc: Record "Assembly Header";
                    AssemblyHeaderVar: Record "Assembly Header";
                begin
                    Clear(GlobalParameters);
                    Clear(GlobalSalesHeader);
                    Clear(GlobalSalesLine);
                    Clear(GlobalDepartment);
                    Clear(GlobalPosition);
                    Clear(GlobalStaff);
                    WeekNumber := 0;
                    AssembleOrderToLink.SetRange("Assembly Document Type", "Assembly Header"."Document Type");
                    AssembleOrderToLink.SetRange("Assembly Document No.", "Assembly Header"."No.");
                    if AssembleOrderToLink.FindFirst() then
                        if GlobalSalesHeader.GET(AssembleOrderToLink."Document Type", AssembleOrderToLink."Document No.") then begin
                            if (GlobalSalesHeader."Order Type" = GlobalSalesHeader."Order Type"::"Re-order") or (GlobalSalesHeader."Order Type" = GlobalSalesHeader."Order Type"::"Re-order & New order") then
                                OrderType := true
                            else
                                OrderType := false;
                            if GlobalSalesHeader."Requested Delivery Date" <> 0D then
                                WeekNumber := System.Date2DWY(GlobalSalesHeader."Requested Delivery Date", 2);
                            GlobalCustomer.GET(GlobalSalesHeader."Sell-to Customer No.");
                            if CountryRegion.get(GlobalCustomer."Country/Region Code") then
                                CustomerCountryName := CountryRegion.Name;
                            GlobalSalesLine.SetRange("Assembly No.", "Assembly Header"."No.");
                            //Should Return only one line (one assembly to one sales line)
                            if GlobalSalesLine.FindFirst() then begin
                                if GlobalParameters.GET(GlobalSalesLine."Parameters Header ID") then begin
                                    if Fit.Get(GlobalParameters."Item Fit") then;
                                    if Size.Get(GlobalParameters."Item Size") then;
                                    if Color.Get(GlobalParameters."Item Color ID") then;
                                    if Tonality.Get(GlobalParameters."Tonality Code") then;
                                    if Cut.Get(GlobalParameters."Item Cut") then;
                                    if GlobalSalesHeader."IC Source No." = '' then begin
                                        if GlobalSalesLine."Allocation Type" = GlobalSalesLine."Allocation Type"::Department then
                                            if GlobalDepartment.Get(GlobalSalesLine."Allocation Code") then;
                                        if GlobalSalesLine."Allocation Type" = GlobalSalesLine."Allocation Type"::Position then begin
                                            Clear(ParameterHeader);
                                            if ParameterHeader.Get(GlobalSalesLine."Parameters Header ID") then
                                                if GlobalDepartment.Get(ParameterHeader."Department Code") then;
                                            if GlobalPosition.Get(GlobalSalesLine."Allocation Code") then;
                                        end;
                                        if GlobalSalesLine."Allocation Type" = GlobalSalesLine."Allocation Type"::Staff then begin
                                            Clear(ParameterHeader);
                                            if ParameterHeader.Get(GlobalSalesLine."Parameters Header ID") then begin
                                                if GlobalDepartment.Get(ParameterHeader."Department Code") then;
                                                if GlobalPosition.Get(ParameterHeader."Position Code") then;
                                            end;
                                            GlobalStaff.SetRange("Department Code", GlobalDepartment.Code);
                                            GlobalStaff.SetRange("Position Code", GlobalPosition.Code);
                                            GlobalStaff.SetRange("Customer No.", GlobalSalesLine."Sell-to Customer No.");
                                            GlobalStaff.SetRange(Code, GlobalSalesLine."Allocation Code");
                                            if not GlobalStaff.FindFirst() then begin
                                                Clear(GlobalStaff);
                                                GlobalStaff.SetRange("Customer No.", GlobalSalesLine."Sell-to Customer No.");
                                                GlobalStaff.SetRange(Code, GlobalSalesLine."Allocation Code");
                                                if GlobalStaff.FindFirst() then;
                                            end;
                                        end;
                                    end else begin
                                        GetICAllocationName(Globalsalesheader."IC Company Name", Globalsalesheader."IC Source No.", Globalsalesheader."IC Customer SO No.");
                                    end;
                                end;
                            end;
                            //Get Project Name
                            Clear(GlobalCustomerProject);
                            GlobalCustomerProject.ChangeCompany(GlobalSalesHeader."IC Company Name");
                            if GlobalCustomerProject.Get(GlobalSalesHeader."Cust Project", GlobalSalesHeader."Sell-to Customer No.") then;

                            //Get IC Details 
                            Clear(GlobalICCustomer);
                            Clear(ICCountryRegion);
                            Clear(ICCustomerCountryName);
                            Clear(GlobalICCustomerProject);
                            if GlobalSalesHeader."IC Company Name" <> '' then begin
                                GlobalICCustomer.ChangeCompany(GlobalSalesHeader."IC Company Name");
                                GlobalICCustomer.Get(GlobalSalesHeader."IC Source No.");
                                if ICCountryRegion.get(GlobalICCustomer."Country/Region Code") then
                                    ICCustomerCountryName := ICCountryRegion.Name;

                                //Get IC Project Name
                                GlobalICCustomerProject.ChangeCompany(GlobalSalesHeader."IC Company Name");
                                if GlobalICCustomerProject.Get(GlobalSalesHeader."IC Customer Project Code", GlobalSalesHeader."IC Source No.") then;
                            end;
                        end;
                    Clear(GlobalItem);
                    Clear(GlobalItemCategory);
                    Clear(GlobalItemVariant);
                    If GlobalItem.Get("Assembly Header"."Item No.") then begin
                        HasItemPicture := false;
                        if GlobalItem.Picture.Count = 0 then
                            HasItemPicture := false
                        else
                            HasItemPicture := true;

                        Clear(GlobalDesign);
                        if GlobalDesign.Get(GlobalItem."Design Code") then;
                        if GlobalItemCategory.Get(GlobalDesign.Category) then;
                    end;
                    if GlobalBrand.Get(GlobalItem."Brand Code") then;
                    if GlobalItemVariant.Get("Assembly Header"."Item No.", "Assembly Header"."Variant Code") then begin
                        HasVariantPicture := false;
                        if GlobalItemVariant.Picture.Count = 0 then
                            HasVariantPicture := false
                        else begin
                            HasVariantPicture := true;
                            Clear(TenanantMediaThumbnailsVariant);
                            Clear(TenantMediaSet);
                            TenantMediaSet.Setfilter("ID", Format(GlobalItemVariant.Picture));
                            if TenantMediaSet.FindFirst() then begin
                                TenanantMediaThumbnailsVariant.SetCurrentKey(Width);
                                TenanantMediaThumbnailsVariant.SetAscending(Width, false);
                                TenanantMediaThumbnailsVariant.Setfilter("Media Id", Format(TenantMediaSet."Media ID"));
                                if TenanantMediaThumbnailsVariant.FindFirst() then
                                    TenanantMediaThumbnailsVariant.CalcFields(Content);
                            end;
                        end;

                        //Get Total Variant Qty
                        TotalVariantQty := 0;
                        Clear(AssemblyHeaderLoc);
                        AssemblyHeaderLoc.SetRange("ER - Manufacturing Order No.", "ER - Manufacturing Order"."No.");
                        AssemblyHeaderLoc.SetRange("Variant Code", GlobalItemVariant.Code);
                        if AssemblyHeaderLoc.FindSet() then
                            repeat
                                TotalVariantQty := TotalVariantQty + AssemblyHeaderLoc.Quantity;
                            until AssemblyHeaderLoc.Next() = 0;
                    end;
                    TotalMainItemQty := TotalMainItemQty + "Assembly Header".Quantity;
                    #region[Barcode]
                    // Declare the barcode provider using the barcode provider interface and enum
                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    // Declare the font using the barcode symbology enum
                    BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
                    // Set data string source 
                    BarcodeString := "No.";
                    // Validate the input. This method is not available for 2D provider
                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    // Encode the data string to the barcode font
                    EncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
                    #endregion[Barcode]

                    //Calculate Total Variant Qty By MO
                    GlobalVariantQtyByMO := 0;
                    Clear(AssemblyHeaderVar);
                    AssemblyHeaderVar.SetRange("ER - Manufacturing Order No.", "Assembly Header"."ER - Manufacturing Order No.");
                    AssemblyHeaderVar.SetRange("Item No.", "Assembly Header"."Item No.");
                    AssemblyHeaderVar.SetRange("Variant Code", "Assembly Header"."Variant Code");
                    if AssemblyHeaderVar.FindSet() then
                        repeat
                            GlobalVariantQtyByMO += AssemblyHeaderVar.Quantity;
                        until AssemblyHeaderVar.Next() = 0;
                end;
            }
            //Manufacturing Order Triggers
            trigger OnAfterGetRecord()
            begin
                SalesReceivablesSetup.Get();
                TotalMainItemQty := 0;

                if "ER - Manufacturing Order"."No. Of Copies" = 0 then
                    IsCopy := false
                else
                    IsCopy := true;
                "ER - Manufacturing Order"."No. Of Copies" := "ER - Manufacturing Order"."No. Of Copies" + 1;
                "ER - Manufacturing Order".Modify();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
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

    //Report Triggers
    trigger OnInitReport()
    begin
        CompanyInformation.get();
        CompanyInformation.CalcFields(Picture);
    end;

    procedure GetICAllocationName(ICCompany: Code[20]; ICCustomerNo: Code[20]; ICCustomerSONo: Code[20])
    var
        ICSalesHeader: Record "Sales Header";
        ICSalesLine: Record "Sales Line";
        CustomerDepartment: Record "Customer Departments";
        CustomerPosition: Record "Department Positions";
        ParameterHeader: Record "Parameter Header";
        SalesHeader: Record "Sales Header";
    begin
        Clear(SalesHeader);
        Clear(CustomerDepartment);
        Clear(CustomerPosition);
        Clear(ParameterHeader);
        CustomerDepartment.ChangeCompany(ICCompany);
        CustomerPosition.ChangeCompany(ICCompany);
        GlobalStaff.ChangeCompany(ICCompany);
        GlobalDepartment.ChangeCompany(ICCompany);
        GlobalPosition.ChangeCompany(ICCompany);
        ParameterHeader.ChangeCompany(ICCompany);
        ICSalesHeader.ChangeCompany(ICCompany);
        if ICSalesHeader.get(ICSalesHeader."Document Type"::Order, ICCustomerSONo) then begin
            ICSalesLine.ChangeCompany(ICCompany);
            ICSalesLine.SetRange("Document No.", ICSalesHeader."No.");
            /*ICSalesLine.SetRange("Allocation Type", GlobalSalesLine."Allocation Type");
            icSalesLine.SetRange("Allocation Code", GlobalSalesLine."Allocation Code");*/
            ICSalesLine.SetRange("Parameters Header ID", GlobalSalesLine."IC Parameters Header ID");
            if ICSalesLine.FindFirst() then begin
                //Get Department
                if GlobalDepartment.Get(ICSalesLine."Department Code") then;
                //Get Position
                if GlobalPosition.Get(ICSalesLine."Position Code") then;
                //Get Staff
                GlobalStaff.SetRange(Code, ICSalesLine."Staff Code");
                GlobalStaff.SetRange("Customer No.", ICSalesLine."Sell-to Customer No.");
                GlobalStaff.SetRange("Department Code", ICSalesLine."Department Code");
                GlobalStaff.SetRange("Position Code", ICSalesLine."Position Code");
                if GlobalStaff.FindFirst() then;
            end;
        end;
    end;

    //Global Variables
    var
        GlobalSalesHeader: Record "Sales Header";
        GlobalSalesLine: Record "Sales Line";
        AssembleOrderToLink: Record "Assemble-to-Order Link";
        CompanyInformation: Record "Company Information";
        GlobalParameters: Record "Parameter Header";
        // Variable for the barcode encoded string
        EncodedText: Text;
        GlobalItem: Record Item;
        GlobalDesign: Record Design;
        GlobalCustomer: Record Customer;
        Fit: Record Fit;
        Size: Record Size;
        Color: Record Color;
        Cut: Record Cut;
        Tonality: Record Tonality;
        DifferentDesignSection: Record "Design Section";
        GlobalItemCategory: Record "Item Category";
        GlobalBrand: Record Brand;
        TempDesinSecParLines: Record "Design Section Param Lines" temporary;
        LineNumber: Integer;
        DesignSectionUniqueColor: Record "Design Section";
        UniqueColorName: Text[50];
        GlobalItemVariant: Record "Item Variant";
        CustomerCountryName: Text[100];
        ICCustomerCountryName: Text[100];
        OrderType: Boolean;
        GlobalDepartment: Record Department;
        GlobalPosition: Record Position;
        GlobalStaff: Record Staff;
        GlobalBranding: Record Branding;
        WeekNumber: Integer;
        IsCopy: Boolean;
        GlobalFeature: Record Feature;
        DifferentItemDesignSectionColor: Record "Item Design Section Color";
        DesignSectionHasPicture: Boolean;
        TotalMainItemQty: Decimal;
        GlobalICCustomer: Record Customer;
        GlobalICCustomerProject: Record "Customer Projects";
        GlobalCustomerProject: Record "Customer Projects";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        GlobalBrandingDetails: Record "Branding Detail";
        HasItemPicture: Boolean;
        HasVariantPicture: Boolean;
        HasBrandingPicture: Boolean;
        HasBrandingDetailPicture: Boolean;
        TenanantMediaThumbnailsBranding: Record "Tenant Media Thumbnails";
        TenanantMediaThumbnailsICBranding: Record "Tenant Media Thumbnails";
        TenanantMediaThumbnailsVariant: Record "Tenant Media Thumbnails";
        TenanantMediaThumbnailsDesignSection: Record "Tenant Media Thumbnails";
        TenantMediaSet: Record "Tenant Media Set";
        PlottingFileRatio: Decimal;
        TotalVariantQty: Decimal;
        TotalQtyNeeded: Decimal;
        GlobalVariantQtyByMO: Decimal;
        DesignSectionRawMaterial: Record "Raw Material";
        GlobalDesignDetail: Record "Design Detail";
        SectionGroupRM: Record "Raw Material";
        SectionSortingNumber: Integer;
        GlobalSection: Record Section;
}
