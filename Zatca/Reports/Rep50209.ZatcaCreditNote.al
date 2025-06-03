report 50209 "Zatca Credit Note - ER"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Zatca/Layouts/ZatcaCreditNote.rdl';
    //ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'ZATCA Credit Note';
    ApplicationArea = All;
    dataset
    {
        dataitem("ZATCA Integration Logs"; "ZATCA Integration Logs")
        {
            RequestFilterFields = "Document No.";

            column(ZATCA_Invoice_Type; "ZATCA Invoice Type") { }
            column(Invoice_Document_Reference; "Invoice Document Reference") { }
            column(Instruction_Note; "Instruction Note") { }
            column(CompanyPicture; G_CompanyInformation.Picture) { }

            dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
            {
                DataItemLink = "No." = FIELD("Document No.");
                RequestFilterFields = "No.";
                #region QR
                column(QRPicture; "ZATCA Integration Logs"."Phase 2 Qr") { }
                #endregion

                column(ReportTitle; ReportTitle) { }
                column(NominalLabel; NominalLabel) { }
                #region "Sales Invoice Header"
                //English Labels
                column(IRNLabel; IRNLabel) { }
                column(IssueDateLabel; IssueDateLabel) { }
                column(SupplyDateLabel; SupplyDateLabel) { }
                column(SellerIdentificationLabel; SellerIdentificationLabel) { }
                column(SellerNameLabel; SellerNameLabel) { }
                column(VATRegistrationNumber; VATRegistrationNumber) { }
                column(AdditionalSellerIDType; AdditionalSellerIDType) { }
                column(CRType; CRType) { }

                column(AddistonalSellerIDNumber; AddistonalSellerIDNumber) { }
                column(AddressLabel; AddressLabel) { }
                column(StreetNameLabel; StreetNameLabel) { }
                column(BuildingNumberLabel; BuildingNumberLabel) { }
                column(DistrictLabel; DistrictLabel) { }
                column(TaxInvoiceLabel; TaxInvoiceLabel) { }
                column(CountryCodeLabel; CountryCodeLabel) { }
                column(PostalCodeLabel; PostalCodeLabel) { }
                column(CityLabel; CityLabel) { }
                column(BuyerIdentificationLabel; BuyerIdentificationLabel) { }
                column(BuyerNameLabel; BuyerNameLabel) { }


                //Araic labels
                column(TaxInvoiceLabelAraic; TaxInvoiceLabelAraic) { }
                column(IRNLabelAraic; IRNLabelAraic) { }
                column(IssueDateLabelAraic; IssueDateLabelAraic) { }
                column(SupplyDateLabelAraic; SupplyDateLabelAraic) { }
                column(SellerIdentificationLabelAraic; SellerIdentificationLabelAraic) { }
                column(SellerNameLabelAraic; SellerNameLabelAraic) { }
                column(VATRegistrationNumberAraic; VATRegistrationNumberAraic) { }
                column(AdditionalSellerIDTypeAraic; AdditionalSellerIDTypeAraic) { }
                column(CRTypeAraic; CRTypeAraic) { }
                column(AdditionalSellerIDNumberAraic; AdditionalSellerIDNumberAraic) { }
                column(AddressLabelAraic; AddressLabelAraic) { }
                column(StreetNameLabelAraic; StreetNameLabelAraic) { }
                column(BuildingNumberLabelAraic; BuildingNumberLabelAraic) { }
                column(DistrictLabelAraic; DistrictLabelAraic) { }
                column(CountryCodeLabelAraic; CountryCodeLabelAraic) { }
                column(PostalCodeLabelAraic; PostalCodeLabelAraic) { }
                column(CityLabelAraic; CityLabelAraic) { }
                column(BuyerIdentificationLabelAraic; BuyerIdentificationLabelAraic) { }
                column(BuyerNameLabelAraic; BuyerNameLabelAraic) { }

                //Body Labels
                //English
                column(LineItemsLabel; LineItemsLabel) { }
                column(ProductOrServiceDescriptionLabel; ProductOrServiceDescriptionLabel) { }
                column(UnitPriceLabel; UnitPriceLabel) { }
                column(QuantityLabel; QuantityLabel) { }
                column(VatRateLabel; VatRateLabel) { }
                column(VatAmountLabel; VatAmountLabel) { }
                column(SubtotalExclusiveofVatLabel; SubtotalExclusiveofVatLabel) { }
                column(SubtotalInclusiveofVatLabel; SubtotalInclusiveofVatLabel) { }
                column(DiscountorRebateTotalAmountLabel; DiscountorRebateTotalAmountLabel) { }
                column(InvoiceTotalAmountexlVatLabel; InvoiceTotalAmountexlVatLabel) { }
                column(VATTotalAmountLabel; VATTotalAmountLabel) { }
                column(InvoiceGrossTotalinclVATLabel; InvoiceGrossTotalinclVATLabel) { }
                column(InvoiceTotalPayableAmntLabel; InvoiceTotalPayableAmntLabel) { }
                column(SpecialTaxTreatmentLabel; SpecialTaxTreatmentLabel) { }
                column(ApplicabilityofSpecialTaxTreatmentLabel; ApplicabilityofSpecialTaxTreatmentLabel) { }
                column(PaymentTermsLabel; PaymentTermsLabel) { }
                column(PaymentMethodLabel; PaymentMethodLabel) { }
                column(PaymentTermslowercasaeLabel; PaymentTermslowercasaeLabel) { }
                column(TypeOfNoteLabel; TypeOfNoteLabel) { }
                column(DebitNoteReferenceDescriptionLabel; DebitNoteReferenceDescriptionLabel) { }
                column(DebitNoteReferenceLabel; DebitNoteReferenceLabel) { }
                column(DebitNoteReasonLabel; DebitNoteReasonLabel) { }
                column(InvoiceDiscountLabel; InvoiceDiscountLabel) { }
                column(SpecialTaxLabel; SpecialTaxLabel) { }
                column(SpecialTaxDescriptionLabel; SpecialTaxDescriptionLabel) { }
                column(prepaymentSubTotalLabel; prepaymentSubTotalLabel) { }
                column(PrepaymentAmountLabel; PrepaymentAmountLabel) { }
                column(PrepaymentLabel; PrepaymentLabel) { }
                column(PrepaymentVatAmountLabel; PrepaymentVatAmountLabel) { }
                column(PrepaymentVatRateLabel; PrepaymentVatRateLabel) { }
                column(TotalPrepaymentLabel; TotalPrepaymentLabel) { }


                //Arabic
                column(LineItemsLabelArabic; LineItemsLabelArabic) { }
                column(ProductOrServiceDescriptionLabelArabic; ProductOrServiceDescriptionLabelArabic) { }
                column(UnitPriceLabelArabic; UnitPriceLabelArabic) { }
                column(QuantityLabelArabic; QuantityLabelArabic) { }
                column(VatRateLabelArabic; VatRateLabelArabic) { }
                column(VatAmountLabelArabic; VatAmountLabelArabic) { }
                column(SubtotalExclusiveofVatLabelArabic; SubtotalExclusiveofVatLabelArabic) { }
                column(SubtotalInclusiveofVatLabelArabic; SubtotalInclusiveofVatLabelArabic) { }
                column(DiscountorRebateTotalAmountLabelArabic; DiscountorRebateTotalAmountLabelArabic) { }
                column(InvoiceTotalAmountexlVatLabelArabic; InvoiceTotalAmountexlVatLabelArabic) { }
                column(VATTotalAmountLabelArabic; VATTotalAmountLabelArabic) { }
                column(InvoiceGrossTotalinclVATLabelArabic; InvoiceGrossTotalinclVATLabelArabic) { }
                column(InvoiceTotalPayableAmntLabelArabic; InvoiceTotalPayableAmntLabelArabic) { }
                column(SpecialTaxTreatmentLabelArabic; SpecialTaxTreatmentLabelArabic) { }
                column(ApplicabilityofSpecialTaxTreatmentLabelArabic; ApplicabilityofSpecialTaxTreatmentLabelArabic) { }
                column(PaymentTermsLabelArabic; PaymentTermsLabelArabic) { }
                column(PaymentMethodLabelArabic; PaymentMethodLabelArabic) { }
                column(TypeOfNoteLabelArabic; TypeOfNoteLabelArabic) { }
                column(DebitNoteReferenceDescriptionLabelArabic; DebitNoteReferenceDescriptionLabelArabic) { }
                column(DebitNoteReferenceLabelArabic; DebitNoteReferenceLabelArabic) { }
                column(DebitNoteReasonLabelArabic; DebitNoteReasonLabelArabic) { }
                column(InvoiceDiscountLabelArabic; InvoiceDiscountLabelArabic) { }
                column(SpecialTaxLabelArabic; SpecialTaxLabelArabic) { }
                column(SpecialTaxDescriptionLabelArabic; SpecialTaxDescriptionLabelArabic) { }
                column(prepaymentSubTotalLabelArabic; prepaymentSubTotalLabelArabic) { }
                column(PrepaymentAmountLabelArabic; PrepaymentAmountLabelArabic) { }
                column(PrepaymentLabelArabic; PrepaymentLabelArabic) { }
                column(PrepaymentVatAmountLabelArabic; PrepaymentVatAmountLabelArabic) { }
                column(PrepaymentVatRateLabelArabic; PrepaymentVatRateLabelArabic) { }
                column(TotalPrepaymentLabelArabic; TotalPrepaymentLabelArabic) { }



                // column(G_DiscountTotal; G_DiscountTotal) { }
                column(G_InvTotAmntEXVAT; G_InvTotAmntEXVAT) { }
                // column(G_VATTotAmnt; G_VATTotAmnt) { }
                column(G_InvGrossTotAmnt; G_InvGrossTotAmnt) { }
                column(Amount_Including_VAT; Amount_Including_VAT) { }

                column(G_SelectedCurrency; G_SelectedCurrency) { }
                column(G_PTEnglishDesc; G_PTEnglishDesc) { }
                column(G_PTArabicDesc; G_PTArabicDesc) { }
                column(G_PMEnglishDesc; G_PMEnglishDesc) { }
                column(G_PMArabicDesc; G_PMArabicDesc) { }
                #endregion
                #region Company Info
                //Company Infos
                column(CompanyName; CompanyName) { }
                //column(CompanyNameArabicValue;CompanyNameArabicValue){ }
                //column(CompanyAddress; CompanyAddress) { }
                column(CompanyNameArabicValue; CompanyNameArabicValue) { }
                column(StreetNameValue; StreetNameValue) { }
                column(StreetNameArabicValue; StreetNameArabicValue) { }
                column(BuildingNumberValue; BuildingNumberValue) { }
                column(CityValue; CityValue) { }
                column(CityArabicValue; CityArabicValue) { }
                column(DistrictValue; DistrictValue) { }
                column(DistrictArabicValue; DistrictArabicValue) { }
                column(CR_NumberValue; CR_NumberValue) { }
                // column(CompanyDistrictArabicValue;CompanyDistrictArabicValue){ }
                // column(CompanyCity; CompanyCity) { }
                // column(CompanyCityArabicValue;CompanyCityArabicValue){ }

                column(VATRegNumberValue; VATRegNumberValue) { }
                column(CountyCodeValue; CountyCodeValue) { }
                column(PostalCodeValue; PostalCodeValue) { }
                #endregion
                #region Customer Info
                //Customer Infos
                column(CustomerName; CustName) { }
                column(CustomerVATRegNumber; CustVatRegNo) { }
                column(CustomerCountyCode; CustCountryCode) { }
                column(CustomerPostalCode; CustPostCode) { }
                column(CustomerNameArabic; CustNameArabic) { }
                column(CustomerStreetName; CustStreetName) { }
                column(CustomerBuildingNumber; CustBuildingNumber) { }
                column(CustomerDistrict; CustDistrict) { }
                column(CustomerCity; CustCity) { }
                column(CustomerStreetNameArabic; CustStreetNameArabic) { }
                column(CustomerDistrictArabic; CustDistrictArabic) { }
                column(CustomerCityArabic; CustCityArabic) { }
                #endregion
                #region Invoice Info
                //Invoice Infos
                column(InvoiceNo; "No.") { }
                column(InvoiceDate; "Posting Date") { }
                column(InvoiceShipmentDate; "Shipment Date") { }
                column(Invoice_Discount_Amount; "Invoice Discount Amount") { }
                #endregion

                column(IsStandardInvoice; IsStandardInvoice) { }
                column(IsDebitNote; IsDebitNote) { }
                column(IsSimplifiedInvoice; IsSimplifiedInvoice) { }
                dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = sorting("Document No.", "Line No.");
                    #region Sales Invoice Line Columns
                    column(LCY_Code; G_RecGnrlLdgrSetup."LCY Code") { }
                    column(No_; "No.") { }
                    column(G_VATTotAmnt; G_VATTotAmnt) { DecimalPlaces = 2; }
                    column(G_VATTotAmntLCY; G_VATTotAmntLCY) { DecimalPlaces = 2; }
                    column(G_DiscountTotal; G_DiscountTotal) { DecimalPlaces = 2; }
                    column(Unit_Price; "Unit Price") { DecimalPlaces = 2; }
                    column(Quantity; Quantity) { DecimalPlaces = 2; }
                    column(VAT__; "VAT %") { }
                    column(VAT_Amount; G_VatAmnt) { DecimalPlaces = 2; }
                    column(G_TotalExclVAT; G_TotalExclVAT) { DecimalPlaces = 2; }
                    column(G_TotalInclVAT; G_TotalInclVAT) { DecimalPlaces = 2; }
                    column(Description; Description) { }
                    column(G_ItemNameArabic; G_ItemNameArabic) { }
                    column(G_TotalPrepayment; abs(G_TotalPrepayment)) { DecimalPlaces = 2; }
                    column(Line_Discount_Amount; "Line Discount Amount") { }
                    column(InvoiceHasDiscount; InvoiceHasDiscount) { }
                    #endregion

                    // Prepayment

                    column(Prepayment_Line; "Prepayment Line") { }
                    column(InvoiceHasPrepayment; InvoiceHasPrepayment) { }
                    column(ZATCA_VAT_Category; "ZATCA VAT Category") { }
                    column(VatCategoryPercLine; VatCategoryPercLine) { }

                    // Special Tax Treatment
                    column(InvoiceHasSpecialTax; InvoiceHasSpecialTax) { }
                    column(SpecialTaxTreatmentReasonDescription; SpecialTaxTreatmentReasonDescription) { }
                    column(SpecialTaxTreatmentReasonDescription_Ar; SpecialTaxTreatmentReasonDescription_Ar) { }

                    column(ShowOnPrepaymentLine; ("VAT %" = 0)) { }

                    trigger OnAfterGetRecord()
                    var
                        ZatcaVatCategories: Record "ZATCA VAT Category";
                        ZatcaVatCategoryReasons: Record "ZATCA VAT Category Reason";
                    begin
                        if "No." = '' then
                            CurrReport.skip();
                        if G_RecItem.GET("No.") then
                            G_ItemNameArabic := G_RecItem."ZATCA Arabic Description"
                        else
                            G_ItemNameArabic := '';
                        // //add the item description under the G_ItemName2 variable
                        G_TotalExclVAT := Amount + "Line Discount Amount";//Calculating total excluding VAT of invoice
                        G_DiscountTotal += "Line Discount Amount";//Calculating total discount of invoice
                        if G_DiscountTotal <> 0 then InvoiceHasDiscount := true;
                        //G_VatAmnt := "Unit Price" * Quantity * "VAT %" / 100;//Calculating Vat Amount on each line
                        G_VatAmnt := "Amount Including VAT" - Amount;
                        if not "Sales Cr.Memo Line"."Prepayment Line" then begin
                            G_VATTotAmnt := G_VATTotAmnt + ("Amount Including VAT" - Amount);//Calculating total Vat Amount of invoice
                            G_VATTotAmntLCY := CurrExchRate.ExchangeAmtFCYToLCY("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", G_VATTotAmnt, "Sales Cr.Memo Header"."Currency Factor");//Calculating total Vat Amount of invoice in LCY
                        end;
                        G_TotalInclVAT := Amount + "Line Discount Amount" + G_VatAmnt;//Calculating total including VAT of invoice

                        // Special Tax Treatment

                        if ZatcaVatCategories.Get("Sales Cr.Memo Line"."ZATCA VAT Category") then begin
                            VatCategoryPercLine := ZatcaVatCategories.Percentage;

                            if not ZatcaVatCategories.Standard then begin
                                InvoiceHasSpecialTax := true;
                                if ZatcaVatCategoryReasons.Get(ZatcaVatCategories.Code, "Sales Cr.Memo Line"."ZATCA VAT Category Reason") then begin
                                    SpecialTaxTreatmentReasonDescription := ZatcaVatCategoryReasons."VAT Category Reason Desc";
                                    SpecialTaxTreatmentReasonDescription_Ar := ZatcaVatCategoryReasons."VAT Category Reason Ar Desc";
                                end;
                            end;
                        end;

                        // Prepayment

                        if "Sales Cr.Memo Line"."Prepayment Line" then begin
                            InvoiceHasPrepayment := true;
                            G_TotalPrepayment += G_TotalInclVAT;
                        end;


                    end;
                }

                trigger OnPreDataItem()//Check if an invoice is selected
                begin

                    "Sales Cr.Memo Header".SetFilter("No.", "ZATCA Integration Logs"."Document No.");

                    if "Sales Cr.Memo Header".GetFilter("No.") = '' then
                        Error('Please select a Sales Invoice.');
                end;

                trigger OnAfterGetRecord()
                var
                    SI: Record "Sales Invoice Header";
                begin
                    G_Customer.Reset();//Getting customer info
                    G_Customer.SetRange("No.", "Sales Cr.Memo Header"."Bill-to Customer No.");
                    if G_Customer.FindFirst() then begin
                        CustVatRegNo := G_Customer."VAT Registration No.";
                        CustCountryCode := G_Customer."ZATCA Country ISO";
                        CustPostCode := G_Customer."Post Code";
                        CustName := G_Customer.Name;
                        CustNameArabic := G_Customer."ZATCA Arabic Name";
                        CustStreetName := G_Customer."ZATCA Street Name";
                        CustStreetNameArabic := G_Customer."ZATCA Street Name in Arabic";
                        CustBuildingNumber := G_Customer."ZATCA Building Number";
                        CustDistrict := G_Customer."ZATCA District";
                        CustDistrictArabic := G_Customer."ZATCA District in Arabic";
                        CustCity := G_Customer.City;
                        CustCityArabic := G_Customer."ZATCA City in Arabic";
                    end;
                    G_DiscountTotal := 0;
                    G_VatAmnt := 0;
                    G_VATTotAmnt := 0;
                    G_VATTotAmntLCY := 0;
                    G_RecPaymentTerms.Reset();
                    Clear(G_SelectedCurrency);
                    if "Sales Cr.Memo Header"."Currency Code" = '' then//If currency code is empty then set currency code to LCY
                        G_SelectedCurrency := G_RecGnrlLdgrSetup."LCY Code"
                    else
                        G_SelectedCurrency := "Sales Cr.Memo Header"."Currency Code";
                    Clear(G_PTEnglishDesc);
                    Clear(G_PTArabicDesc);
                    if G_RecPaymentTerms.GET("Sales Cr.Memo Header"."Payment Terms Code") then begin //Get payment terms description
                        G_PTEnglishDesc := G_RecPaymentTerms.Description;
                        G_PTArabicDesc := G_RecPaymentTerms."Arabic Description ZATCA";
                    end;
                    Clear(G_PMEnglishDesc);
                    Clear(G_PMArabicDesc);
                    if G_RecPaymentMethod.GET("Sales Cr.Memo Header"."Payment Method Code") then begin //Get payment method description
                        G_PMEnglishDesc := G_RecPaymentMethod.Description;
                        G_PMArabicDesc := G_RecPaymentMethod."Arabic Description";
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                ZatcaLogs: Record "ZATCA Integration Logs";
                SalesCrMemoLineLoc: Record "Sales Cr.Memo Line";
            begin
                Clear(IsStandardInvoice);
                Clear(IsDebitNote);
                clear(IsSimplifiedInvoice);
                //Calculate G_InvTotAmntEXVAT Total excluding VAT of invoice
                G_InvTotAmntEXVAT := 0;
                SalesCrMemoLineLoc.Reset();
                SalesCrMemoLineLoc.SetRange("Document No.", "ZATCA Integration Logs"."Document No.");
                SalesCrMemoLineLoc.SetRange("Prepayment Line", false);
                SalesCrMemoLineLoc.CalcSums(Amount, "Amount Including VAT");
                G_InvTotAmntEXVAT := SalesCrMemoLineLoc.Amount;
                G_InvGrossTotAmnt := SalesCrMemoLineLoc."Amount Including VAT";

                //Calculate Amount Including VAT of invoice 
                Amount_Including_VAT := 0;
                SalesCrMemoLineLoc.Reset();
                SalesCrMemoLineLoc.SetRange("Document No.", "ZATCA Integration Logs"."Document No.");
                if SalesCrMemoLineLoc.FindSet() then
                    repeat
                        Amount_Including_VAT += SalesCrMemoLineLoc."Amount Including VAT";
                    until SalesCrMemoLineLoc.Next() = 0;

                // Get report type

                if ("ZATCA Integration Logs"."ZATCA Invoice Type" = "ZATCA Integration Logs"."ZATCA Invoice Type"::"Tax Credit Note") then begin
                    IsStandardInvoice := true;
                    ReportTitle := TaxInvoiceLabel + ' ' + TaxInvoiceLabelAraic;
                end else
                    if ("ZATCA Integration Logs"."ZATCA Invoice Type" = "ZATCA Integration Logs"."ZATCA Invoice Type"::"Simplified Tax Credit Note") then begin
                        IsSimplifiedInvoice := true;
                        ReportTitle := SimplifiedInvoiceLabel + ' ' + SimplifiedInvoiceLabelArabic;
                    end
                    else begin
                        IsStandardInvoice := true;
                        ReportTitle := TaxInvoiceLabel + ' ' + TaxInvoiceLabelAraic;
                    end;

                "ZATCA Integration Logs".CalcFields("Phase 2 Qr");

                // Check if Nominal

                if "ZATCA Integration Logs"."ZATCA Invoice Type" IN ["ZATCA Integration Logs"."ZATCA Invoice Type"::"Tax Nominal Invoice", "ZATCA Integration Logs"."ZATCA Invoice Type"::"Simplified Nominal Invoice"] then begin
                    NominalLabel := 'Nominal Invoice  ';
                    NominalLabel += ' ' + 'فاتورة لاسمية ';

                end;

                // Get the Qr picture

                // if ZatcaLogs.get("ZATCA Integration Logs"."Document No.") then
                //     if (ZatcaLogs."Phase 2 Qr".Count > 0) then begin
                //         tenantMedia.Get(ZatcaLogs."QR Picture".MediaId);
                //         tenantMedia.CalcFields(Content);
                //     end;

            end;

        }
    }
    trigger OnPreReport()
    begin
        G_CompanyInformation.Get();//Getting company info
        CompanyName := G_CompanyInformation.Name;
        CompanyNameArabicValue := G_CompanyInformation."ZATCA Company Name Arabic";
        VATRegNumberValue := G_CompanyInformation."vat Registration No.";
        StreetNameValue := G_CompanyInformation."ZATCA Street Name";
        StreetNameArabicValue := G_CompanyInformation."ZATCA Street Name Arabic";
        BuildingNumberValue := G_CompanyInformation."ZATCA Building Number";
        CityValue := G_CompanyInformation.City;
        CityArabicValue := G_CompanyInformation."ZATCA City Arabic";
        DistrictValue := G_CompanyInformation."ZATCA District";
        DistrictArabicValue := G_CompanyInformation."ZATCA District Arabic";
        CountyCodeValue := G_CompanyInformation."ZATCA Country ISO Code";
        PostalCodeValue := G_CompanyInformation."Post Code";
        CR_NumberValue := G_CompanyInformation."ZATCA License No.";
        G_CompanyInformation.CalcFields(Picture);
    end;

    trigger OnInitReport()
    begin
        Clear(InvoiceHasSpecialTax);
        Clear(InvoiceHasPrepayment);
        G_RecGnrlLdgrSetup.Get();
    end;

    var

        // Report type

        IsStandardInvoice: Boolean;
        IsSimplifiedInvoice: Boolean;
        IsDebitNote: Boolean;


        //Records
        G_CompanyInformation: Record "Company Information";
        G_Customer: Record Customer;
        G_RecItem: Record item;
        G_RecGnrlLdgrSetup: Record "General Ledger Setup";
        G_RecPaymentTerms: Record "Payment Terms";
        G_RecPaymentMethod: Record "Payment Method";
        G_RecCustomer: Record customer;
        tenantMedia: Record "Tenant Media";
        CurrExchRate: Record "Currency Exchange Rate";


        //Variables
        CustVatRegNo: Text[20];
        CustCountryCode: Code[10];
        CustPostCode: Code[20];
        CustName: Text[100];
        CustNameArabic: Text[100];
        CustStreetName: Text[80];
        CustStreetNameArabic: Text[80];
        CustBuildingNumber: Text[80];
        CustDistrict: Text[80];
        CustDistrictArabic: Text[80];
        CustCity: Text[80];
        CustCityArabic: Text[80];
        G_ItemNameArabic: Text[100];
        G_SelectedCurrency: Code[10];
        G_PTEnglishDesc: Text[100];
        G_PTArabicDesc: Text[100];
        G_PMEnglishDesc: Text[100];
        G_PMArabicDesc: Text[100];
        G_TotalExclVAT: Decimal;
        G_TotalInclVAT: Decimal;
        G_DiscountTotal: Decimal;
        G_VatAmnt: Decimal;
        G_VATTotAmnt: Decimal;
        G_VATTotAmntLCY: Decimal;
        G_TotalPrepayment: Decimal;
        VatCategoryPercLine: Decimal;
        CompanyName: Text;
        CompanyNameArabicValue: Text;
        StreetNameValue: Text;
        StreetNameArabicValue: Text;
        BuildingNumberValue: Text;
        CityValue: Text;
        CityArabicValue: Text;
        VATRegNumberValue: Text;
        CountyCodeValue: Text;
        PostalCodeValue: Text;
        DistrictValue: Text;
        DistrictArabicValue: Text;
        CR_NumberValue: Text;
        ReportTitle: Text;
        InvoiceHasSpecialTax: Boolean;
        InvoiceHasPrepayment: Boolean;
        InvoiceHasDiscount: Boolean;
        SpecialTaxTreatmentReasonDescription: Text;
        SpecialTaxTreatmentReasonDescription_Ar: Text;

        //Arabic
        CustomerNameArabic: Text;

        //Labels
        //English
        TaxInvoiceLabel: label 'Credit Note';
        SimplifiedInvoiceLabel: Label 'Credit Note';
        IRNLabel: label 'Invoice reference number (IRN)';
        IssueDateLabel: label 'Issue Date';
        SupplyDateLabel: label 'Supply Date';
        SellerIdentificationLabel: label 'Company Identification';
        SellerNameLabel: label 'Company name';
        VATRegistrationNumber: label 'VAT registration number';
        AdditionalSellerIDType: label 'Additional seller ID type';
        CRType: label 'Commercial Registration (CR)';
        AddistonalSellerIDNumber: label 'Additional seller ID number';
        AddressLabel: Label 'Address';
        StreetNameLabel: label 'Street Name';
        BuildingNumberLabel: label 'Building number';
        DistrictLabel: label 'District';
        CountryCodeLabel: label 'Country code';
        PostalCodeLabel: label 'Postal code';
        CityLabel: label 'City';
        BuyerIdentificationLabel: label 'Buyer Identification';
        BuyerNameLabel: label 'Buyer name';
        TypeOfNoteLabel: Label 'Type Of Note';
        DebitNoteReferenceLabel: Label 'Reference';
        DebitNoteReferenceDescriptionLabel: Label 'A reference to the original invoice(s) that the credit / debit note is related to';
        DebitNoteReasonLabel: Label 'Reason for issuance of credit / debit note as per the VAT implementing Regulation';
        SpecialTaxLabel: Label 'Special Tax Treatment';
        SpecialTaxDescriptionLabel: Label 'Applicability of special tax treatment';
        PrepaymentLabel: Label 'Prepayment Information';
        PrepaymentVatRateLabel: Label 'Prepayment Vat Rate';
        prepaymentSubTotalLabel: Label 'Prepayment Subtotal (Exclusive of VAT)';
        PrepaymentVatAmountLabel: Label 'Prepayment VAT Amount';
        PrepaymentAmountLabel: Label 'Total Prepayment Amount';
        TotalPrepaymentLabel: Label 'Advance Payment Amount (Inclusive of VAT)';
        NominalLabel: Text;

        //Arabic
        TaxInvoiceLabelAraic: Label 'إشعار دائن';
        SimplifiedInvoiceLabelArabic: Label 'إشعار دائن';
        IRNLabelAraic: label 'الرقم التسلسلي';
        IssueDateLabelAraic: label 'تاريخ اصدار الفاتورة';
        SupplyDateLabelAraic: label 'تاريخ التوريد';
        SellerIdentificationLabelAraic: label 'هوية الشركة';
        SellerNameLabelAraic: label 'اسم الشركة';
        VATRegistrationNumberAraic: label 'رقم تسجيل ضريبة القيمة المضافة';
        AdditionalSellerIDTypeAraic: label 'نوع المعرفات الإضافية للبائع';
        CRTypeAraic: label 'السجل التجاري';
        AdditionalSellerIDNumberAraic: label 'رقم المعرفات الإضافية للبائع';
        AddressLabelAraic: Label 'العنوان';
        StreetNameLabelAraic: label 'اسم الشارع';
        BuildingNumberLabelAraic: label 'رقم المبنى';
        DistrictLabelAraic: label 'المقاطعة';
        CountryCodeLabelAraic: label 'رمز البلد';
        PostalCodeLabelAraic: label 'الرمز البريدي';
        CityLabelAraic: label 'اسم المدينة';
        BuyerIdentificationLabelAraic: label 'تحديد هوية العميل';
        BuyerNameLabelAraic: label 'الاسم';
        TypeOfNoteLabelArabic: Label 'نوع الإشعار';
        DebitNoteReferenceLabelArabic: Label 'المرجع';
        DebitNoteReferenceDescriptionLabelArabic: Label 'الإشارة إلى الفاتورة الصادرة عن التوريد اللمبدئي الذي يتعلق به الإشعار الدائن أو المدين';
        DebitNoteReasonLabelArabic: Label 'سبب إصدار الإشعار من لأسباب التالية';
        SpecialTaxLabelArabic: label 'المعاملة الضريبية الخاصة';
        SpecialTaxDescriptionLabelArabic: Label 'وصف المعاملة الضريبية المنطبقة على التوريد';
        PrepaymentLabelArabic: Label 'معلومات الدفع المسبق';
        PrepaymentVatRateLabelArabic: Label 'معدل القيمة المضافة المدفوعة مقدما';
        prepaymentSubTotalLabelArabic: Label 'المجموع الفرعي للدفع المسبق(غير الشامل للضريبة القيمة المضافة)';
        PrepaymentVatAmountLabelArabic: Label 'مبلغ القيمة المضافة المدفوعة مقدما';
        PrepaymentAmountLabelArabic: Label 'إجمالي مبلغ الدفع المسبق';
        TotalPrepaymentLabelArabic: Label 'مبلغ الدفعة المقدمة (شامل ضريبة القيمة المضافة) ';

        //Body Labels
        //English
        LineItemsLabel: label 'Line Items';
        ProductOrServiceDescriptionLabel: label 'Product or Service Description';
        UnitPriceLabel: label 'Unit Price';
        QuantityLabel: label 'Quantity';
        VatRateLabel: label 'VAT rate';
        VatAmountLabel: label 'VAT amount';
        SubtotalExclusiveofVatLabel: label 'Subtotal Exclusive of VAT';
        SubtotalInclusiveofVatLabel: label 'Subtotal Inclusive of VAT';
        DiscountorRebateTotalAmountLabel: label 'Discount or rebate Total Amount';
        InvoiceTotalAmountexlVatLabel: label 'Invoice Total Amount (excluding VAT)';
        VATTotalAmountLabel: label 'VAT Total Amount';
        InvoiceGrossTotalinclVATLabel: label 'Invoice Gross Total (inclusive of VAT)';
        InvoiceTotalPayableAmntLabel: label 'Invoice Total Payable Amount';
        SpecialTaxTreatmentLabel: label 'Special Tax Treatment';
        ApplicabilityofSpecialTaxTreatmentLabel: label 'Applicability of special tax treatment';
        PaymentTermsLabel: label 'Payment Terms';
        PaymentMethodLabel: label 'Payment method';
        PaymentTermslowercasaeLabel: label 'Payment terms';
        InvoiceDiscountLabel: Label 'Discount at Document Level';

        //Arabic
        LineItemsLabelArabic: label 'معلومات وبيانات السلعة أو الخدمة';
        ProductOrServiceDescriptionLabelArabic: label 'وصف السلعة أو الخدمة';
        UnitPriceLabelArabic: label 'سعر الوحدة';
        QuantityLabelArabic: label 'الكمية';
        VatRateLabelArabic: label 'معدل ضريبة القيمة المضافة المطبق';
        VatAmountLabelArabic: label 'مبلغ ضريبة القيمة';
        SubtotalExclusiveofVatLabelArabic: label 'إجمالي المبلغ غير شامل ضريبة القيمة المضافة';
        SubtotalInclusiveofVatLabelArabic: label 'إجمالي المبلغ شامل ضريبة القيمة المضافة';
        DiscountorRebateTotalAmountLabelArabic: label 'اجمالى مبلغ الخصومات أو الحسومات';
        InvoiceTotalAmountexlVatLabelArabic: label 'المبلغ الخاضع للضريبة  (غير شامل ضريبة  القيمة  المضافة)';
        VATTotalAmountLabelArabic: label 'إجمالي مبلغ ضريبة  القيمة  المضافة';
        InvoiceGrossTotalinclVATLabelArabic: label 'إجمالي قيمة  الفاتورة (شامل ضريبة القيمة  المضافة)';
        InvoiceTotalPayableAmntLabelArabic: label 'إجمالي مبلغ الفاتورة المستحق الدفع';
        SpecialTaxTreatmentLabelArabic: label 'المعاملة  الضريبية  الخاصة';
        ApplicabilityofSpecialTaxTreatmentLabelArabic: label 'وصف المعاملة  الضريبية  المنطبقة  على التوريد';
        PaymentTermsLabelArabic: label 'شروط الدفع';
        PaymentMethodLabelArabic: label 'طريقة  الدفع';
        InvoiceDiscountLabelArabic: Label 'خصم على مستوى الفاتورة';
        G_InvTotAmntEXVAT: Decimal;
        G_InvGrossTotAmnt: Decimal;
        Amount_Including_VAT: Decimal;
}
