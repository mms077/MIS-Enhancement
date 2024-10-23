report 50245 "ER - Posted Sales Invoice ERC"
{
    ApplicationArea = All;
    Caption = 'ER - Posted Sales Invoice ERC';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports Layouts/ER-PostedSalesInvoiceERC.rdlc';
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            #region QR
            column(QRPicture; "QR Picture") { }
            column(Zatca_Invoice_Type; GlobalInvoiceType)
            {

            }
            #endregion
            #region //Header
            #region //G_RecCompanyInformation
            Column(CompanyCity; G_RecCompanyInformation.City)
            {

            }
            Column(Capital_Label; Capital_Label)
            {

            }
            Column(AddressLabel; AddressLabel)
            {

            }
            Column(TLabel; TLabel)
            {

            }
            Column(ELabel; ELabel)
            {

            }
            Column(VATCodeLabel; VATCodeLabel)
            {

            }
            Column(VendorNoLabel; VendorNoLabel)
            {

            }
            column(Company_Picture; G_RecCompanyInformation.Picture)
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(CompanyVat; CompanyVat)
            {

            }
            column(CR_Number; 'CR Number')
            {

            }
            column(Company_Capital; G_RecCompanyInformation.Capital)
            {

            }
            column(Company_Vat; G_RecCompanyInformation."VAT Registration No.")
            {

            }
            column(Comapny_Phone; G_RecCompanyInformation."Phone No.")
            {

            }
            column(Company_Fax; G_RecCompanyInformation."Fax No.")
            {

            }
            column(Company_Email; G_RecCompanyInformation."E-Mail")
            {

            }
            column(Company_Address; G_RecCompanyInformation.Address)
            {
            }
            column(Company_Address2; G_RecCompanyInformation."Address 2")
            {

            }
            column(Company_Bank_Account; G_RecCompanyInformation."Bank Name")
            {

            }
            column(Company_SWIFT; G_RecCompanyInformation."SWIFT Code")
            {

            }
            column(Company_IBAN; G_RecCompanyInformation.IBAN)
            {

            }
            column(Company_CityAndZip; G_RecCompanyInformation.City)
            {

            }
            column(FullyPaidLabel; FullyPaidLabel)
            {

            }
            column(LCY_Code; G_RecGnrlLedgSetup."LCY Code")
            {

            }
            #endregion
            column(SalesInvoiceHeader; SalesInvoiceHeader)
            {

            }
            column(BarcodeText; BarcodeText)
            {

            }
            #endregion
            #region //Footer
            Column(FormNoLabel; FormNoLabel)
            {

            }
            Column(IssueDateLabel; IssueDateLabel)
            {

            }
            Column(RevisionDateLabel; RevisionDateLabel)
            {

            }
            Column(FormNo; FormNo)
            {

            }
            column(IssueDate; IssueDate)
            {

            }
            #endregion
            #region //Body
            #region //Body Information
            #region //LeftLabels
            column(BillToCustomerLabel; BillToCustomerLabel)
            {

            }
            column(PurchaseOrderRefLabel; PurchaseOrderRefLabel)
            {

            }
            column(PurchaseOrderRefLabel_AR; PurchaseOrderRefLabel_AR)
            {

            }
            column(PaymentTermsLabel; PaymentTermsLabel)
            {

            }
            column(PaymentTermsLabel_AR; PaymentTermsLabel_AR)
            {

            }
            column(ShippingAddressLabel; ShippingAddressLabel)
            {

            }
            column(ShippingAddressLabel_AR; ShippingAddressLabel_AR)
            {

            }
            column(ReceiverNameLabel; ReceiverNameLabel)
            {

            }
            column(ReceiverNameLabel_AR; ReceiverNameLabel_AR)
            {

            }
            column(ReceiverContactLabel; ReceiverContactLabel)
            {

            }
            column(ReceiverContactLabel_AR; ReceiverContactLabel_AR)
            {

            }
            column(ShippingModeLabel; ShippingModeLabel)
            {

            }
            column(ShippingModeLabel_AR; ShippingModeLabel_AR)
            {

            }
            column(ShippingTermsLabel; ShippingTermsLabel)
            {

            }
            column(ShippingTermsLabel_AR; ShippingTermsLabel_AR)
            {

            }
            column(CarrierLabel; CarrierLabel)
            {

            }
            column(CarrierLabel_AR; CarrierLabel_AR)
            {

            }
            column(BillRefNoLabel; BillRefNoLabel)
            {

            }
            column(BillRefNoLabel_AR; BillRefNoLabel_AR)
            {

            }
            column(AdvancedPaymentLabel; AdvancedPaymentLabel)
            {

            }
            column(AdvancedPaymentLabel_AR; AdvancedPaymentLabel_AR)
            {

            }
            column(BalanceDueLabel; BalanceDueLabel)
            {

            }
            column(BalanceDueLabel_AR; BalanceDueLabel_AR)
            {

            }

            column(CodeLabel; CodeLabel)
            {

            }
            column(CustomerNameLabel; CustomerNameLabel)
            {

            }
            column(VATNumberLabel; VATNumberLabel)
            {

            }
            column(AddressCustLabel; AddressCustLabel)
            {

            }
            column(CurrencyCustLabel; CurrencyCustLabel)
            {

            }
            column(CodeLabel_AR; CodeLabel_AR)
            {

            }
            column(CustomerNameLabel_AR; CustomerNameLabel_AR)
            {

            }
            column(VATNumberLabel_AR; VATNumberLabel_AR)
            {

            }
            column(AddressCustLabel_AR; AddressCustLabel_AR)
            {

            }
            column(CurrencyCustLabel_AR; CurrencyCustLabel_AR)
            {

            }
            #endregion
            #region //LeftValues
            column(BillToCustomer; "Sales Invoice Header"."Bill-to Customer No.")
            {

            }
            column(Bill_to_Name; "Bill-to Name")
            {

            }
            column(CustVATNumber; "VAT Registration No.")
            {

            }
            column(Bill_to_Address; "Bill-to Address")
            {

            }
            column(Bill_to_City; "Bill-to City")
            {

            }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code")
            {

            }
            column(G_Invoice_Currency; G_Invoice_Currency)
            {

            }
            column(Advance_Payment; "Sales Invoice Header"."Amount Including VAT" - GlobalBalanceDue)
            {

            }
            column(GlobalBalanceDue; GlobalBalanceDue)
            {

            }

            #endregion
            #region //RightLabels
            column(ProjectLabelAr; ProjectLabelAr)
            {

            }
            column(ProjectLabelEn; ProjectLabelEn)
            {

            }
            column(Cust_Project; "Sales Invoice Header"."Cust Project")
            {

            }
            column(ShipToCustomerLabel; ShipToCustomerLabel)
            {

            }
            column(CountryAndCityLabel; CountryAndCityLabel)
            {

            }
            column(PostalCodeLabel; PostalCodeLabel)
            {

            }
            column(SOLabel; SOLabel)
            {

            }
            column(PhoneLabel; PhoneLabel)
            {

            }
            column(InvoiceNoLabel; InvoiceNoLabel)
            {

            }
            column(InvoiceDateLabel; InvoiceDateLabel)
            {

            }
            column(PoNoLabel; PoNoLabel)
            {

            }
            column(DueDateLabel; DueDateLabel)
            {

            }
            column(DueDateLabel_AR; DueDateLabel_AR)
            {

            }
            column(CountryAndCityLabel_AR; CountryAndCityLabel_AR)
            {

            }
            column(PostalCodeLabel_AR; PostalCodeLabel_AR)
            {

            }
            column(SOLabel_AR; SOLabel_AR)
            {

            }
            column(PhoneLabel_AR; PhoneLabel_AR)
            {

            }
            column(InvoiceNoLabel_AR; InvoiceNoLabel_AR)
            {

            }
            column(InvoiceDateLabel_AR; InvoiceDateLabel_AR)
            {

            }
            #endregion
            #region //RightValues
            column(ShipTo_Phone; GlobalShipToCustomer."Phone No.")
            {

            }
            column(ShipTo_ReceiverName; GlobalContact.Name)
            {

            }
            column(ShipTo_ReceiverContact; GlobalContact."Phone No.")
            {

            }
            column(ShipTo_ShippingMode; GlobalShipmentMethod.Description)
            {

            }
            column(ShipTo_Carrier; "Sales Invoice Header"."Shipping Agent Code")
            {

            }
            column(ShipToCustomer; "Sales Invoice Header"."Ship-to Name")
            {

            }
            column(G_ShipToCountryCity; G_ShipToCountryCity)
            {

            }
            column(ShipToPostalCode; "Sales Invoice Header"."Ship-to Post Code")
            {

            }
            column(SalesOrderNo; "Sales Invoice Header"."Order No.")
            {

            }
            column(ShipToPhoneNo; G_ShipToPhoneNo)
            {

            }
            column(InvoiceNo; "No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(External_Document_No_; "External Document No.")
            {

            }
            column(Due_Date; "Due Date")
            {

            }
            column(BillTo_PurchOrderRef; "Sales Invoice Header"."External Document No.")
            {

            }
            column(BillTo_PayTerms; GlobalPayTermsDescription)
            {

            }

            #endregion
            #endregion
            #region //Body Table
            column(GourpingLabel; GroupingLabel)
            {

            }
            column(ItemCodeLabel; ItemCodeLabel)
            {

            }
            column(DescriptionLabel; DescriptionLabel)
            {

            }
            column(HSCodeLabel; HSCodeLabel)
            {

            }
            column(HSCodeLabel_AR; HSCodeLabel_AR)
            {

            }
            column(SizeLabel; SizeLabel)
            {

            }
            column(SizeLabel_AR; SizeLabel_AR)
            {

            }
            column(QuantityLabel; QuantityLabel)
            {

            }
            column(UnitPriceLabel; UnitPriceLabel)
            {

            }
            column(DiscountLabel; DiscountLabel)
            {

            }
            column(UnitPriceExclVATLabel; UnitPriceExclVATLabel)
            {

            }
            column(TaxRateLabel; TaxRateLabel)
            {

            }
            column(TaxAmountLabel; TaxAmountLabel)
            {

            }
            column(TotalPriceIncldVATLabel; TotalPriceIncldVATLabel)
            {

            }
            column(GourpingLabel_AR; GroupingLabel_AR)
            {

            }
            column(ItemCodeLabel_AR; ItemCodeLabel_AR)
            {

            }
            column(DescriptionLabel_AR; DescriptionLabel_AR)
            {

            }
            column(QuantityLabel_AR; QuantityLabel_AR)
            {

            }
            column(UnitPriceLabel_AR; UnitPriceLabel_AR)
            {

            }

            column(DiscountLabel_AR; DiscountLabel_AR)
            {

            }
            column(UnitPriceExclVATLabel_AR; UnitPriceExclVATLabel_AR)
            {

            }
            column(UnitPriceInlcVATLabel_AR1; UnitPriceInlcVATLabel_AR1)
            {

            }
            column(UnitPriceInlcVATLabel_AR2; UnitPriceInlcVATLabel_AR2)
            {

            }
            column(TaxRateLabel_AR; TaxRateLabel_AR)
            {

            }
            column(TaxAmountLabel_AR; TaxAmountLabel_AR)
            {

            }
            column(TotalPriceIncldVATLabel_AR; TotalPriceIncldVATLabel_AR)
            {

            }
            #endregion
            #region //Body Below Table
            column(TotalExlVATLabel; TotalExlVATLabel)
            {

            }
            column(TotalVATLabel; TotalVATLabel)
            {

            }
            column(TotalTaxable; TotalTaxable)
            {

            }
            column(TotalLabel; TotalLabel)
            {

            }
            column(TotalLabel_AR; TotalLabel_AR)
            {

            }
            column(TotalExlVATLabel_AR; TotalExlVATLabel_AR)
            {

            }
            column(TotalVATLabel_AR; TotalVATLabel_AR)
            {

            }
            column(TotalTaxable_AR; TotalTaxable_AR)
            {

            }
            column(InvoiceAmount; Amount)
            {

            }
            column(Invoice_Discount_Amount; "Invoice Discount Amount")
            {

            }
            column(Invoice_Amount_Including_VAT; "Amount Including VAT")
            {

            }
            column(AmountinWords; AmountinWords)
            {

            }
            column(YouOweUsLabel; YouOweUsLabel)
            {

            }
            column(OnlyLabel; OnlyLabel)
            {

            }
            column(ShipToAddress; ShipToAddress)
            {

            }
            column(GlAmount; GlAmount)
            {

            }



            #endregion
            #endregion
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Line No.");
                #region //Sale Lines
                column(No_; "No.")
                {

                }
                column(HS_Code; HSCode)
                {

                }
                column(Size; Size)
                {

                }
                column(description; "Description")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(G_LineAmountDiscountExVat; "Line Amount")
                {

                }
                column(G_UnitPriceDiscountInclVat; G_UnitPriceDiscountInclVat)
                {

                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {

                }
                column(VAT_Rate; "VAT %")
                {

                }
                column(VAT_Amount; G_VAT_Amount)
                {

                }
                column(Amount_Including_VAT; "Amount Including VAT")
                {

                }
                column(R_LineDiscount; R_LineDiscount)
                {
                }
                column(R_AdvancedPayment; R_AdvancedPayment)
                {
                }
                column(R_TotalTaxable; R_TotalTaxable)
                {
                }
                column(R_TotalVat; R_TotalVat)
                {
                }
                column(R_Discount; R_Discount)
                {

                }
                column(R_BalanceDue; R_BalanceDue)
                {

                }
                column(R_TotalExcVat; R_TotalExcVat)
                {
                }
                #endregion
                trigger onaftergetrecord()
                begin
                    if ("No." <> '') and (Type = Type::Item) then begin
                        GlobalItem.Get("No.");
                        HSCode := GlobalItem."HS Code";
                    end else
                        Clear(HSCode);

                    G_UnitPriceDiscountInclVat := "Unit Price" + ("Unit Price" * ("VAT %" / 100)) - ("Unit Price" * "Line Discount %" / 100);
                    G_LineAmountInclVat := G_UnitPriceDiscountInclVat * Quantity;
                    G_VAT_Amount := "Amount Including VAT" - "Line Amount";

                    R_LineDiscount := R_LineDiscount + "Line Discount Amount";
                    if "Prepayment Line" then
                        R_AdvancedPayment := R_AdvancedPayment + "Amount Including VAT"
                    else begin
                        R_TotalTaxable := R_TotalTaxable + "Amount Including VAT";
                        R_TotalVat := R_TotalVat + ("Amount Including VAT" - Amount);
                    end;
                end;

                trigger OnPostDataItem()
                begin

                end;
            }

            trigger OnAfterGetRecord()
            var
                CustomerLoc: Record Customer;
                CustLedgerEntry: Record "Cust. Ledger Entry";
                PaymentTerms: Record "Payment Terms";
            begin
                CalcFields(Amount);
                G_RecGnrlLedgSetup.Get();
                if "Sales Invoice Header"."Currency Code" = '' then
                    G_Invoice_Currency := G_RecGnrlLedgSetup."LCY Code"
                else
                    G_Invoice_Currency := "Sales Invoice Header"."Currency Code";
                AmountInWordsFunction("Sales Invoice Header"."Amount Including VAT", G_Invoice_Currency);

                if GlobalShipToCustomer.Get("Sales Invoice Header"."Sell-to Customer No.") then
                    //Get Ship Address
                    ShipToAddress := "Sales Invoice Header"."Sell-to Country/Region Code" + ',' + "Sales Invoice Header"."Ship-to Address" + ',' + "Sales Invoice Header"."Ship-to Address 2";

                Clear(GlobalBalanceDue);
                CustLedgerEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                if CustLedgerEntry.FindFirst() then begin
                    CustLedgerEntry.CalcFields("Remaining Amount");
                    GlobalBalanceDue := CustLedgerEntry."Remaining Amount";
                end;

                Clear(GlobalContact);
                if GlobalContact.get("Sales Invoice Header"."Sell-to Contact No.") then;

                Clear(GlobalShipmentMethod);
                if GlobalShipmentMethod.Get("Sales Invoice Header"."Shipment Method Code") then;

                //Barcode text
                Clear(BarcodeText);
                BarcodeText := "Sales Invoice Header"."Bill-to Customer No." + '+' + "Sales Invoice Header"."No.";

                //Invoice Type
                Clear(GlobalInvoiceType);
                GlobalInvoiceType := GetOptionValue(Database::"Sales Invoice Header", 70101, "Sales Invoice Header"."ZATCA Invoice Type");
                Clear(G_ShipToPhoneNo);
                G_RecCustomer.reset();
                if "Sales Invoice Header"."Ship-to Code" = '' then begin
                    if G_RecCustomer.get("Sales Invoice Header"."Sell-to Customer No.") then
                        G_ShipToPhoneNo := G_RecCustomer."Phone No.";
                end
                else begin
                    G_RecShipToAdd.reset();
                    if G_RecShipToAdd.get("Sales Invoice Header"."Sell-to Customer No.", "Sales Invoice Header"."Ship-to Code") then
                        G_ShipToPhoneNo := G_RecShipToAdd."Phone No.";
                end;
                Clear(PaymentTerms);
                Clear(GlobalPayTermsDescription);
                if PaymentTerms.Get("Payment Terms Code") then
                    GlobalPayTermsDescription := PaymentTerms.Description;

                R_Discount := "Sales Invoice Header"."Invoice Discount Amount";
                R_TotalExcVat := R_TotalTaxable - R_TotalVat;

            end;

            trigger OnPreDataItem()
            begin
                if "Sales Invoice Header".GetFilter("No.") = '' then
                    Error('Please select a Sales Invoice.');
            end;
        }
    }

    trigger OnPreReport()
    begin
        G_ShipToCountryCity := "Sales Invoice Header"."Ship-to City" + ' ' + "Sales Invoice Header"."Ship-to Country/Region Code";
        G_RecGnrlLedgSetup.Get();
        G_RecCompanyInformation.Get();
        CompanyAddress := G_RecCompanyInformation.Address + ' ' + G_RecCompanyInformation."Country/Region Code";
        CompanyVat := G_RecGnrlLedgSetup."Default VAT %";
        G_RecCompanyInformation.CalcFields(Picture);
    end;

    // requestpage
    // {
    //     layout
    //     {
    //         area(content)
    //         {
    //             group(GroupName)
    //             {
    //             }
    //         }
    //     }
    //     actions
    //     {
    //         area(processing)
    //         {
    //         }
    //     }
    // }
    #region //Amount in Word
    procedure AmountInWordsFunction(Amount: Decimal; CurrencyCode: Code[10])//To get amount in words
    var
        NoText: array[2] of Text[200];
    begin
        InitTextVariable();
        FormatNoText(NoText, Amount, CurrencyCode);
        AmountinWords := NoText[1];
    end;

    procedure InitTextVariable()//Taken from Cheque Report
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;

    procedure FormatNoText(var NoText: array[2] of Text[200]; No: Decimal; CurrencyCode: Code[10])//Taken from Cheque Report
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';
        G_RecGnrlLedgSetup.Get();

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        else
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        DecimalPosition := GetAmtDecimalPosition();
        AddToNoText(NoText, NoTextIndex, PrintExponent, (Format(No * DecimalPosition) + '/' + Format(DecimalPosition)));

        if CurrencyCode <> '' then
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);

        OnAfterFormatNoText(NoText, No, CurrencyCode);
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[200]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])//Taken from Cheque Report
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(Text029, AddText);
        end;

        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    local procedure GetAmtDecimalPosition(): Decimal//Taken from Cheque Report
    var
        Currency: Record Currency;
    begin
        if "Sales Invoice Header"."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get("Sales Invoice Header"."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;
        exit(1 / Currency."Amount Rounding Precision");
    end;

    local procedure OnAfterFormatNoText(var NoText: array[2] of Text[200]; No: Decimal; CurrencyCode: Code[10])//Taken from Cheque Report
    begin
    end;

    procedure GetOptionValue(Table: Integer; Field: Integer; Value: Integer): Text
    var
        RecordRef: RecordRef;
        FieldRef: FieldRef;
        TempString: Text;
    begin
        RecordRef.OPEN(Table);
        FieldRef := RecordRef.FIELD(Field);
        TempString := FieldRef.OptionMembers;
        RecordRef.CLOSE;
        EXIT(SELECTSTR(Value + 1, TempString));
    end;
    #endregion
    var
        //Records
        G_RecCompanyInformation: Record "Company Information";
        G_RecGnrlLedgSetup: Record "General Ledger Setup";
        G_RecCustomer: Record Customer;
        G_RecShipToAdd: Record "Ship-to Address";
        //Variables
        GlobalInvoiceType: Text[150];
        //Header
        CityAndZip: Text[250];
        CompanyAddress: Text[250];

        GlobalPayTermsDescription: Text[100];
        CompanyVat: Integer;
        //Body
        G_CustVATNumber: Text[250];
        G_Invoice_Currency: Text[250];
        G_ShipToCountryCity: Text[250];
        G_ShipToPhoneNo: Text[250];
        BarcodeText: Text[150];
        G_VAT_Amount: Decimal;
        G_TotalExclVAT: Decimal;
        G_UnitPriceDiscountInclVat: Decimal;
        G_LineAmountInclVat: Decimal;
        HSCode: Code[50];
        ShipToAddress: Text[250];
        GlobalShipToCustomer: Record Customer;
        GlobalItem: Record item;
        GlobalBalanceDue: Decimal;
        GlobalContact: Record Contact;
        GlobalShipmentMethod: Record "Shipment Method";
        GlAmount: Decimal;

        R_Discount: Decimal;
        R_BalanceDue: Decimal;
        R_TotalExcVat: Decimal;
        R_LineDiscount: Decimal;
        R_AdvancedPayment: Decimal;
        R_TotalTaxable: Decimal;
        R_TotalVat: Decimal;

        //Labels
        #region //Header
        SalesInvoiceHeader: Label 'Tax Invoice';
        Capital_Label: Label 'Capital';
        VendorNoLabel: Label 'Vendor No.';
        AddressLabel: Label 'Address';
        TLabel: Label 'T:';
        ELabel: Label 'E:';
        VATCodeLabel: Label 'VAT';
        FullyPaidLabel: Label 'Fully Paid';
        PurchaseOrderRefLabel: Label 'Purchase Order Ref.';
        PurchaseOrderRefLabel_AR: Label 'رقم المرجع';
        PaymentTermsLabel: Label 'Payment Terms';
        PaymentTermsLabel_AR: Label 'شروط الدفع';
        DueDateLabel: Label 'Due Date';
        DueDateLabel_AR: Label 'تاریخ الاستحقاق';
        Err0001: Label 'Please Select a Sales Invoice.';
        #endregion
        #region //Shipping Info
        ShippingAddressLabel: Label 'Shipping Address';
        ShippingAddressLabel_AR: Label 'عنوان التسليم';
        ReceiverNameLabel: Label 'Receiver Name';
        ReceiverNameLabel_AR: Label 'اسم المستلم';
        ReceiverContactLabel: Label 'Receiver Contact';
        ReceiverContactLabel_AR: Label 'رقم المستلم';
        ShippingModeLabel: Label 'Shipping Mode';
        ShippingModeLabel_AR: Label 'طريقة الشحن';
        ShippingTermsLabel: Label 'Shipping Terms';
        ShippingTermsLabel_AR: Label 'شروط الشحن';
        CarrierLabel: Label 'Carrier';
        CarrierLabel_AR: Label 'مرجع الشحن';
        BillRefNoLabel: Label 'Bill Ref. No.';
        BillRefNoLabel_AR: Label 'رقم فاتورة الشحن';
        AdvancedPaymentLabel: Label 'Advanced Payment';
        AdvancedPaymentLabel_AR: Label 'دفعة مسبقة';
        BalanceDueLabel: Label 'Balance Due';
        BalanceDueLabel_AR: Label 'الرصيد المستحق';
        #endregion
        #region //Footer
        FormNoLabel: Label 'FORM #';
        IssueDateLabel: Label 'Issue Date';
        RevisionDateLabel: Label 'Revision Date/#';
        FormNo: Label 'ER\KSA\TCC\S-SI\100';
        IssueDate: Label 'Jan 23';
        #endregion
        #region //BodyInformation
        ProjectLabelEn: Label 'Project';
        ProjectLabelAr: Label 'المشروع';
        BillToCustomerLabel: Label 'Billing Info';
        CodeLabel: Label 'Acc#';
        CustomerNameLabel: Label 'Customer Name';
        VATNumberLabel: Label 'VAT Number';
        AddressCustLabel: Label 'Billing Address';
        CurrencyCustLabel: Label 'Currency';
        codeLabel_AR: Label 'رمز العمیل';
        CustomerNameLabel_AR: Label 'اسم العمیل';
        VATNumberLabel_AR: Label 'رقم تسجیل القیمة المضافة';
        AddressCustLabel_AR: Label 'عنوان الفاتورة';
        CurrencyCustLabel_AR: Label 'العملة';
        ShipToCustomerLabel: Label 'Shipping Info';
        CountryAndCityLabel: Label 'Country & City';
        PostalCodeLabel: Label 'Postal Code';
        SOLabel: Label 'SO#';
        PhoneLabel: Label 'Phone';
        InvoiceNoLabel: Label 'Invoice No.';
        InvoiceDateLabel: Label 'Invoice Date';
        PoNoLabel: Label 'Po No.';
        CountryAndCityLabel_AR: Label 'البلد والمدينة';
        PostalCodeLabel_AR: Label 'الرمز البريدي';
        SOLabel_AR: Label 'رقم الطلبیة';
        PhoneLabel_AR: Label 'الهاتف';
        InvoiceNoLabel_AR: Label 'رقم الفاتورة';
        InvoiceDateLabel_AR: Label 'تاریخ إصدار الفاتورة';
        #endregion
        #region //BodyTable
        GroupingLabel: Label 'Grouping';
        ItemCodeLabel: Label 'Item Code';
        HSCodeLabel: Label 'HS Code';
        HSCodeLabel_AR: Label 'بند التعرفة';
        DescriptionLabel: Label 'Description';
        SizeLabel: Label 'Size';
        SizeLabel_AR: Label 'مقاس';
        QuantityLabel: Label 'Qty';
        UnitPriceLabel: Label 'Unit Price';
        DiscountLabel: Label 'Discount';
        UnitPriceExclVATLabel: Label 'Amount Excl. VAT';
        TaxRateLabel: Label 'VAT Rate';
        TaxAmountLabel: Label 'VAT Amount';
        TotalPriceIncldVATLabel: Label 'Total Price Including VAT';
        GroupingLabel_AR: Label 'المجموعة';
        ItemCodeLabel_AR: Label 'المنتج';
        DescriptionLabel_AR: Label 'الوصف';
        QuantityLabel_AR: Label 'الكمية';
        UnitPriceLabel_AR: Label 'السعر الإفرادي';
        DiscountLabel_AR: Label 'الحسم';
        UnitPriceExclVATLabel_AR: Label 'السعر الاجمالي قبل القيمة المضافة';
        UnitPriceInlcVATLabel_AR1: Label 'السعر الإفرادي ';
        UnitPriceInlcVATLabel_AR2: Label 'شامل القیمة المضافة';
        TaxRateLabel_AR: Label 'نسبة الضریبة';
        TaxAmountLabel_AR: Label 'مبلغ الضریبة';
        TotalPriceIncldVATLabel_AR: Label 'السعر شامل ضریبة القیمة المضافة';
        #endregion
        #region //BodyBelowTable
        TotalExlVATLabel: Label 'Total Excluding VAT';
        TotalVATLabel: Label 'Total VAT';
        TotalTaxable: Label 'Total Taxable';
        TotalLabel: Label 'Total';
        TotalLabel_AR: Label 'المجموع';
        TotalExlVATLabel_AR: Label 'الإجمالي غیر شامل القیمة المضافة';
        TotalVATLabel_AR: Label 'مجموع ضریبة القیمة المضافة';
        TotalTaxable_AR: Label 'الاجمالي شامل القيمة المضافة';
        #endregion
        #region //BodyAmountInWords
        WhoOwesWhom: Text[250];
        AmountinWords: Text[250];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        WeOweYouLabel: Label 'We owe you';
        YouOweUsLabel: Label 'You owe us';
        OnlyLabel: Label 'only.';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
    #endregion
}
