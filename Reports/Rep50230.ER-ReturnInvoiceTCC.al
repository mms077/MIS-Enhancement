report 50230 "ER - Return Invoice TCC"
{
    ApplicationArea = All;
    Caption = 'ER - Return Invoice TCC';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-ReturnInvoiceTCC.rdlc';
    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            RequestFilterFields = "No.";
            #region Company Information
            column(Company_Picture; G_RecCompanyInformation.Picture)
            {

            }
            column(Company_City; G_RecCompanyInformation.City)
            {

            }
            column(Company_Vat; G_RecCompanyInformation."VAT Registration No.")
            {

            }
            column(Company_CR; G_RecCompanyInformation."CR No.")
            {

            }
            column(Company_Phone; G_RecCompanyInformation."Phone No.")
            {

            }
            column(Company_Fax; G_RecCompanyInformation."Fax No.")
            {

            }
            column(Company_Email; G_RecCompanyInformation."E-Mail")
            {

            }
            column(Company_Address; G_TxtCompanyAddress)
            {

            }
            #endregion
            #region Header Information
            column(Invoice_No; "Sales Cr.Memo Header"."No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            #endregion
            #region Bill To Customer
            column(Bill_to_Customer_No_; "Bill-to Customer No.")
            {

            }
            column(Bill_to_Customer_Name; G_TxtCustomerArabicName)
            {

            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {

            }
            column(Bill_to_Customer_Address; "Bill-to Address")
            {

            }
            column(Bill_to_City; "Bill-to City")
            {

            }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code")
            {

            }
            column(Currency_Code; G_CodeInvoiceCurr)//LCY is taken from General Posting Setup
            {

            }
            #endregion
            #region Ship To Customer
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Project_Code; "Shortcut Dimension 1 Code")
            {

            }
            column(Ship_to_Country_and_City; "G_TextCountryAndCity")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(Sales_Order_No; G_TxtSalesOrderNo)
            {

            }
            column(Ship_to_Phone; G_RecShipToCustomer."Phone No.")
            {

            }
            column(External_Document_No_; "External Document No.")
            {

            }
            column(Due_Date; "Due Date")
            {

            }
            #endregion

            #region Total Amounts
            column(Invoice_Discount_Amount; "Invoice Discount Amount")
            {

            }
            column(Invoice_Amount; Amount)
            {

            }
            column(Invoice_Amount_Including_VAT; "Amount Including VAT")
            {

            }
            column(Text_Barcode; G_TxtBarcode)
            {

            }
            column(AmountinWords; AmountinWords)
            {

            }
            #endregion

            #region Labels
            column(PageLabel; PageLabel)
            {

            }
            column(OfLabel; OfLabel)
            {

            }
            column(VATLabel; VATLabel)
            {

            }
            column(TLabel; TLabel)
            {

            }
            column(ELabel; ELabel)
            {

            }
            column(AddressLabel; AddressLabel)
            {

            }
            column(InvoiceDateLabel; InvoiceDateLabel)
            {

            }
            column(ReturnInvoiceLabel; ReturnInvoiceLabel)
            {

            }
            column(BillToCustomerLabel; BillToCustomerLabel)
            {

            }
            column(AccountNoLabel; AccountNoLabel)
            {

            }
            column(AccountNoArLabel; AccountNoArLabel)
            {

            }
            column(CustomerNameLabel; CustomerNameLabel)
            {

            }
            column(CustomerNameArLabel; CustomerNameArLabel)
            {

            }
            column(VATNumberLabel; VATNumberLabel)
            {

            }
            column(VATNumberArLabel; VATNumberArLabel)
            {

            }
            column(AddressBodyLabel; AddressBodyLabel)
            {

            }
            column(AddressBodyArLabel; AddressBodyArLabel)
            {

            }
            column(CurrencyLabel; CurrencyLabel)
            {

            }
            column(CurrencyArLabel; CurrencyArLabel)
            {

            }
            column(ShipToCustomerLabel; ShipToCustomerLabel)
            {

            }
            column(ProjectLabel; ProjectLabel)
            {

            }
            column(ProjectArLabel; ProjectArLabel)
            {

            }
            column(CountryAndCityLabel; CountryAndCityLabel)
            {

            }
            column(CountryAndCityArLabel; CountryAndCityArLabel)
            {

            }
            column(PostalCodeLabel; PostalCodeLabel)
            {

            }
            column(PostalCodeArLabel; PostalCodeArLabel)
            {

            }
            column(SONoLabel; SONoLabel)
            {

            }
            column(SONoArLabel; SONoArLabel)
            {

            }
            column(PhoneLabel; PhoneLabel)
            {

            }
            column(PhoneArLabel; PhoneArLabel)
            {

            }
            column(PoNoLabel; PoNoLabel)
            {

            }
            column(DueDateLabel; DueDateLabel)
            {

            }
            column(GroupingLabel; GroupingLabel)
            {

            }
            column(GroupingArLabel; GroupingArLabel)
            {

            }
            column(ItemCodeLabel; ItemCodeLabel)
            {

            }
            column(ItemCodeArLabel; ItemCodeArLabel)
            {

            }
            column(DescriptionLabel; DescriptionLabel)
            {

            }
            column(DescriptionArLabel; DescriptionArLabel)
            {

            }
            column(QtyLabel; QtyLabel)
            {

            }
            column(QtyArLabel; QtyArLabel)
            {

            }
            column(UnitPriceLabel; UnitPriceLabel)
            {

            }
            column(UnitPriceArLabel; UnitPriceArLabel)
            {

            }
            column(DiscountLabel; DiscountLabel)
            {

            }
            column(DiscountArLabel; DiscountArLabel)
            {

            }
            column(LineAmountExclVatLabel; LineAmountExclVatLabel)
            {

            }
            column(LineAmountExclVatArLabel; LineAmountExclVatArLabel)
            {

            }
            column(UnitPriceDiscountInclVatLabel; UnitPriceDiscountInclVatLabel)
            {

            }
            column(UnitPriceDiscountInclVat1Label; UnitPriceDiscountInclVat1Label)
            {

            }
            column(UnitPriceDiscountInclVat2Label; UnitPriceDiscountInclVat2Label)
            {

            }
            column(TaxRateLabel; TaxRateLabel)
            {

            }
            column(TaxRateArLabel; TaxRateArLabel)
            {

            }
            column(TaxAmountLabel; TaxAmountLabel)
            {

            }
            column(TaxAmountArLabel; TaxAmountArLabel)
            {

            }
            column(TotalPriceIncludingTax; TotalPriceIncludingTax)
            {

            }
            column(TotalPriceIncludingTaxAr; TotalPriceIncludingTaxAr)
            {

            }
            column(TotalExcludingVATLabel; TotalExcludingVATLabel)
            {

            }
            column(TotalExcludingVATArLabel; TotalExcludingVATArLabel)
            {

            }
            column(TotalVATLabel; TotalVATLabel)
            {

            }
            column(TotalVATArLabel; TotalVATArLabel)
            {

            }
            column(TotalTaxableLabel; TotalTaxableLabel)
            {

            }
            column(TotalTaxableArLabel; TotalTaxableArLabel)
            {

            }
            column(YouOweUsLabel; YouOweUsLabel)
            {

            }
            column(OnlyLabel; OnlyLabel)
            {

            }
            column(FormNoLabel; FormNoLabel)
            {

            }
            column(FormNoValue; FormNoValue)
            {

            }
            column(IssueDateLabel; IssueDateLabel)
            {

            }
            column(IssueDateValue; IssueDateValue)
            {

            }
            column(RevisionDateLabel; RevisionDateLabel)
            {

            }

            #endregion
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(Line_Type; Type)
                {

                }
                column(Item_No; "No.")
                {

                }
                column(Line_Description; Description)
                {

                }
                // column(Grouping;)
                // {

                // }
                column(Line_HS_Code; G_RecItem."Hs Code")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                column(Unit_Price_Discount_InclVat; G_DecUnitPriceDiscountInclVat)
                {

                }
                column(VAT_Percentage; "VAT %")
                {

                }
                column(Vat_Amount; G_DecVATAmount)
                {

                }
                column(Line_Amount_InclVat; G_DecLineAmountInclVat)
                {

                }

                trigger OnAfterGetRecord()//line
                begin
                    // Calculate the unit price including VAT and discounts
                    Clear(G_RecItem);
                    // Get the item record
                    if G_RecItem.Get("Sales Cr.Memo Line"."No.") then;
                    // Calculate the unit price including VAT and discounts
                    //clear(G_DecUnitPriceDiscountInclVat);
                    G_DecUnitPriceDiscountInclVat := "Unit Price" + ("Unit Price" * ("VAT %" / 100)) - ("Unit Price" * "Line Discount %" / 100);//93.5
                    // Calculate the line amount including VAT and discounts
                    G_DecLineAmountInclVat := G_DecUnitPriceDiscountInclVat * Quantity;
                    // Calculate the VAT amount
                    G_DecVATAmount := G_DecLineAmountInclVat - "Line Amount";

                end;
            }
            trigger OnPreDataItem()
            begin
                if "Sales Cr.Memo Header".GetFilter("No.") = '' then
                    Error('Please select a Return Invoice.');
            end;

            trigger OnAfterGetRecord()//Header
            begin
                CalcFields(Amount);
                CalcFields("Amount Including VAT");
                //Taking LCY from General Ledger Setup if chosen
                if "Currency Code" = '' then
                    G_CodeInvoiceCurr := G_RecGeneralLedgerSetup."LCY Code"
                else
                    G_CodeInvoiceCurr := "Currency Code";

                //Combining Country and City
                G_TextCountryAndCity := "Ship-to Country/Region Code" + ', ' + "Ship-to City";

                //Taking Customer Arabic Name
                Clear(G_RecCustomer);
                if G_RecCustomer.Get("Bill-to Customer No.") then;
                G_TxtCustomerArabicName := G_recCustomer."Name (Arabic)";
                if G_TxtCustomerArabicName = '' then
                    G_TxtCustomerArabicName := G_recCustomer."Name";

                //Barcode text
                Clear(G_TxtBarcode);
                G_TxtBarcode := "Sales Cr.Memo Header"."Bill-to Customer No." + '+' + "Sales Cr.Memo Header"."No.";

                //Getting Customer Info for shipping
                Clear(G_RecShipToCustomer);
                if G_RecShipToCustomer.Get("Sales Cr.Memo Header"."Sell-to Customer No.") then;

                //Getting Amount in Words
                AmountInWordsFunction("Sales Cr.Memo Header"."Amount Including VAT", G_CodeInvoiceCurr);

                //Getting Sales order no.
                Clear(G_RecCustLedgEntry);
                G_RecCustLedgEntry.SetRange("Document No.", "No.");
                if G_RecCustLedgEntry.FindSet() then begin
                    G_IntMemoLedgerEntryNo := G_RecCustLedgEntry."Entry No.";
                    clear(G_RecCustLedgEntry);
                    G_RecCustLedgEntry.SetRange("Closed by Entry No.", G_IntMemoLedgerEntryNo);
                    if G_RecCustLedgEntry.FindFirst() then begin
                        clear(G_RecPostedSalesInv);
                        if G_RecPostedSalesInv.Get(G_RecCustLedgEntry."Document No.") then begin
                            G_TxtSalesOrderNo := G_RecPostedSalesInv."Order No.";
                        end;
                    end;
                end;
            end;
        }
    }

    trigger OnPreReport()
    begin
        G_RecGeneralLedgerSetup.Get();
        G_RecCompanyInformation.Get();
        Clear(G_TxtCompanyAddress);
        G_TxtCompanyAddress := G_RecCompanyInformation.Address + ' ' + G_RecCompanyInformation."Country/Region Code";
        G_RecCompanyInformation.CalcFields(Picture);
        //G_TxtCompanyCR := G_RecCompanyInformation.City + ' ' + G_RecCompanyInformation."CR No.";
    end;


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
        G_RecGeneralLedgerSetup.Get();

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
        if "Sales Cr.Memo Header"."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get("Sales Cr.Memo Header"."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;
        exit(1 / Currency."Amount Rounding Precision");
    end;

    local procedure OnAfterFormatNoText(var NoText: array[2] of Text[200]; No: Decimal; CurrencyCode: Code[10])//Taken from Cheque Report
    begin
    end;
    #endregion
    var
        G_RecGeneralLedgerSetup: Record "General Ledger Setup";
        #region Comapny Information
        G_RecCompanyInformation: Record "Company Information";

        //G_TxtCompanyCR: Text[250];
        G_TxtCompanyAddress: Text[250];
        #endregion
        #region Body Header
        G_CodeInvoiceCurr: Code[10];
        G_RecCustomer: Record Customer;
        G_RecShipToCustomer: Record Customer;
        G_RecPostedSalesInv: Record "Sales Invoice Header";// used to retrieve sales order no
        G_RecCustLedgEntry: Record "Cust. Ledger Entry";
        G_IntMemoLedgerEntryNo: Integer;
        G_TxtSalesOrderNo: Code[20];
        G_TxtCustomerArabicName: Text[100];
        G_TextCountryAndCity: Text[250];
        SalesOrderNO: Code[25];
        #endregion
        #region Body Table
        G_RecItem: Record Item;
        G_DecUnitPriceDiscountInclVat: Decimal;
        G_DecLineAmountInclVat: Decimal;
        G_DecVATAmount: Decimal;
        G_TxtBarcode: Text[250];
        #endregion

        #region Labels
        //Header
        PageLabel: Label 'Page ';
        OfLabel: Label 'of ';
        VATLabel: Label 'VAT: ';
        TLabel: Label 'T: ';
        ELabel: Label 'E: ';
        AddressLabel: Label 'Address: ';
        InvoiceDateLabel: Label 'Invoice Date: ';
        ReturnInvoiceLabel: Label 'Return Invoice ';
        //Body Header
        //BillTo
        BillToCustomerLabel: Label 'Bill To Customer';
        AccountNoLabel: Label 'Acc#';
        AccountNoArLabel: Label 'رمز العميل';
        CustomerNameLabel: Label 'Customer Name';
        CustomerNameArLabel: Label 'اسم العميل';
        VATNumberLabel: Label 'VAT Number';
        VATNumberArLabel: Label 'رقم تسجيل القيمة المضافة';
        AddressBodyLabel: Label 'Address';
        AddressBodyArLabel: Label 'العنوان';
        CurrencyLabel: Label 'Currency';
        CurrencyArLabel: Label 'العملة';
        //ShipTo
        ShipToCustomerLabel: Label 'Ship To Customer';
        ProjectLabel: Label 'Project';
        ProjectArLabel: Label 'المشروع';
        CountryAndCityLabel: Label 'Country & City';
        CountryAndCityArLabel: Label 'البلد والمدينة';
        PostalCodeLabel: Label 'Postal Code';
        PostalCodeArLabel: Label 'الرمز البريدي';
        SONoLabel: Label 'SO#';
        SONoArLabel: Label 'رقم الطلبية';
        PhoneLabel: Label 'Phone';
        PhoneArLabel: Label 'الهاتف';
        PoNoLabel: Label 'Po No.';
        DueDateLabel: Label 'Due Date';
        //Body
        //Table Header
        GroupingLabel: Label 'Grouping';
        GroupingArLabel: Label 'المجموعة';
        ItemCodeLabel: Label 'Item Code';
        ItemCodeArLabel: Label 'المنتج';
        DescriptionLabel: Label 'Description';
        DescriptionArLabel: Label 'الوصف';
        QtyLabel: Label 'Qty';
        QtyArLabel: Label 'الكمية';
        UnitPriceLabel: Label 'Unit Price';
        UnitPriceArLabel: Label 'السعر الإفرادي';

        DiscountLabel: Label 'Discount';
        DiscountArLabel: Label 'قيمة الحسم';
        LineAmountExclVatLabel: Label 'Line Amount Excl. VAT';
        LineAmountExclVatArLabel: Label 'السعر الاجمالي قبل القيمة المضافة';
        UnitPriceDiscountInclVatLabel: Label 'Unit Price Discount Incl. VAT';
        UnitPriceDiscountInclVat1Label: Label 'السعر الإفرادي';
        UnitPriceDiscountInclVat2Label: Label ' شامل القيمة المضافة';
        TaxRateLabel: Label 'Tax Rate';
        TaxRateArLabel: Label 'نسبة الضريبة';
        TaxAmountLabel: Label 'Tax Amount';
        TaxAmountArLabel: Label 'مبلغ الضريبة';
        TotalPriceIncludingTax: Label 'Total Price Including Tax';
        TotalPriceIncludingTaxAr: Label 'السعر شامل ضريبة القيمة المضافة';
        //Totals
        TotalExcludingVATLabel: Label 'Total Excluding VAT';
        TotalExcludingVATArLabel: Label 'الاجمالي غير شامل القيمة المضافة';
        TotalVATLabel: Label 'Total VAT';
        TotalVATArLabel: Label 'مجموع ضريبة القيمة المضافة';
        TotalTaxableLabel: Label 'Total Taxable';
        TotalTaxableArLabel: Label 'الاجمالي شامل القيمة المضافة';

        //You owe us
        YouOweUsLabel: Label 'You owe us';
        OnlyLabel: Label 'Only';
        //Footer
        FormNoLabel: Label 'FORM #:';
        FormNoValue: Label 'ER\KSA\TCC\ACCT-RI\100';
        IssueDateLabel: Label 'Issue Date: ';
        IssueDateValue: Label 'Jan 23';
        RevisionDateLabel: Label 'Revision Date/#: ';
        #endregion

        #region //BodyAmountInWords
        WhoOwesWhom: Text[250];
        AmountinWords: Text[250];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        WeOweYouLabel: Label 'We owe you';
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
    //EOF
}