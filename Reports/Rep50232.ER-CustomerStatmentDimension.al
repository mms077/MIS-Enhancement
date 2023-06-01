report 50232 "ER - Customer Statement(Dim)"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-CustomerStatmentDimension.rdl';
    Caption = 'ER - Customer Statement(Dimension)';

    dataset
    {
        dataitem("Currency Table"; "AC Currency Total")
        {
            DataItemTableView = sorting(CurrencyCode);
            PrintOnlyIfDetail = false;
            column(CurrencyCode; CurrencyCode) { }
            //column(Total; Total) { }
            column(Curr; G_CurrencyCode) { }
            column(AmountinWords; AmountinWords) { }
            column(CityPostal; CityPostal) { }
            column(Company_Address; CompanyAddress) { }
            column(FullyPaidLabel; FullyPaidLabel) { }
            column(Company_Address_2; CompanyInformation."Address 2") { }
            column(Company_Bank_Account; CompanyInformation."Bank Name") { }
            column(Company_SWIFT; CompanyInformation."SWIFT Code") { }
            column(Company_IBAN; CompanyInformation.IBAN) { }
            column(today; TestDateTime) { }
            column(fromDate; fromDate) { }
            column(toDate; toDate) { }
            //Labels
            column(CapitalLabel; CapitalLabel) { }
            column(VatCodeLabel; VatCodeLabel) { }
            column(TelLabel; TelLabel) { }
            column(EmailLabel; EmailLabel) { }
            column(AddressLabel; AddressLabel) { }
            column(ReportTitle; ReportTitle) { }
            column(CustomerLabel; CustomerLabel) { }
            column(SalepersonLabel; SalepersonLabel) { }
            column(CustAddLabel; CustAddLabel) { }
            column(VatRegNoLabel; VatRegNoLabel) { }
            column(CustProjLabel; CustProjLabel) { }
            column(CustAccountLabel; CustAccountLabel) { }
            column(VATNumLabel; VATNumLabel) { }
            column(PhoneNumLabel; PhoneNumLabel) { }
            column(DocNoLabel; DocNoLabel) { }
            column(PostingDateLabel; PostingDateLabel) { }
            column(DueDateLabel; DueDateLabel) { }
            column(CurrencyCodeLabel; CurrencyCodeLabel) { }
            column(DescriptionLabel; DescriptionLabel) { }
            column(DebitAmountLabel; DebitAmountLabel) { }
            column(CreditAmountLabel; CreditAmountLabel) { }
            column(RemainingAmountLabel; RemainingAmountLabel) { }
            column(BalanceLabel; BalanceLabel) { }
            column(TotalLabel; TotalLabel) { }
            column(FormNumberLabel; FormNumberLabel) { }
            column(FormNoValueLabel; FormNoValueLabel) { }
            column(IssueDateLabel; IssueDateLabel) { }
            column(IssueDateValueLabel; IssueDateValueLabel) { }
            column(RevisionDateLabel; RevisionDateLabel) { }
            column(FromDateLabel; FromDateLabel) { }
            column(ToDateLabel; ToDateLabel) { }
            Column(OweUsLabel; OweUsLabel) { }
            column(OnlyLabel; OnlyLabel) { }
            column(EntriesLabel; EntriesLabel) { }

            column(Customer_No; CustomerInformation."No.") { }
            column(Customer_Name; CustomerInformation."Name") { }
            column(Cust_Address; CustomerInformation.Address) { }
            column(Vat_Reg_No; CustomerInformation."VAT Registration No.") { }
            column(Cust_Phone; CustomerInformation."Phone No.") { }
            column(CustSalesperson; SalesPersonNaneVar) { }

            column(Company_Picture; CompanyInformation.Picture) { }
            column(Company_Capital; CompanyInformation.Capital) { }
            column(Company_Vat; CompanyInformation."VAT Registration No.") { }
            column(Comapny_Phone; CompanyInformation."Phone No.") { }
            column(Company_Email; CompanyInformation."E-Mail") { }
            column(TotalBefore; TotalBefore) { }
            column(dim_1; SelectedDimensions[1]) { }
            column(dim_2; SelectedDimensions[2]) { }
            column(x; x) { }
            column(TotalAMT; TotalAMT) { }


            dataitem(CustLedEntry; "Cust. Ledger Entry")
            {
                PrintOnlyIfDetail = false;

                //DataItemLink = "Currency Code" = field(CurrencyCode);
                DataItemTableView = sorting("Entry No.");
                column(Doc_No; "Document No.") { }
                column(PDate; "Posting Date") { }
                column(Due_Date; "Due Date") { }
                column(Description; Description) { }
                column(Debit_Amount; "Debit Amount") { }
                column(Credit_Amount; "Credit Amount") { }
                column(Remaining_Amount; "Remaining Amount") { }
                column(LCY; GeneralLedgerSetup."LCY Code") { }
                column(Amount; "Amount") { }
                column(Dim1Value; Dim1Value) { }
                column(Dim2Value; Dim2Value) { }

                column(tot; tot) { }

                trigger OnAfterGetRecord()
                var
                    MyFieldRef: FieldRef;
                    CustLedEntRecref: RecordRef;
                    RecID: RecordID;
                begin
                    CustLedEntRecref.OPEN(21);
                    RecID := CustLedEntry.RecordId;
                    CustLedEntRecref.Get(RecID);
                    MyFieldRef := CustLedEntRecref.FIELD(Dim1ID);
                    if Dim1ID > 24 then
                        MyFieldRef.CALCFIELD;
                    Dim1Value := MyFieldRef.Value;


                    MyFieldRef := CustLedEntRecref.FIELD(Dim2ID);
                    if Dim2ID > 24 then
                        MyFieldRef.CALCFIELD;
                    Dim2Value := MyFieldRef.Value;
                end;


                trigger OnPreDataItem()//Show the Records for the specified Customer where the Posting Date is between fromDate and toDate specified by the user on the request Page
                begin
                    CustLedEntry.SetCurrentKey("Posting Date");
                    SetRange("Posting Date", FromDate, ToDate);
                    SetRange("Customer No.", G_CustNo);
                    SetRange("Currency Code","Currency Table".CurrencyCode);
                    case SelectedDimensionsNB[1] of
                        1:
                            begin
                                Dim1ID := 23;
                            end;
                        2:
                            begin
                                Dim1ID := 24;
                            end;
                        3:
                            begin
                                Dim1ID := 481;
                            end;
                        4:
                            begin
                                Dim1ID := 482;
                            end;
                        5:
                            begin
                                Dim1ID := 483;
                            end;
                        6:
                            begin
                                Dim1ID := 484;
                            end;
                        7:
                            begin
                                Dim1ID := 485;
                            end;
                        8:
                            begin
                                Dim1ID := 486;
                            end;
                    end;

                    case SelectedDimensionsNB[2] of
                        1:
                            begin
                                Dim2ID := 23;
                            end;
                        2:
                            begin
                                Dim2ID := 24;
                            end;
                        3:
                            begin
                                Dim2ID := 481;
                            end;
                        4:
                            begin
                                Dim2ID := 482;
                            end;
                        5:
                            begin
                                Dim2ID := 483;
                            end;
                        6:
                            begin
                                Dim2ID := 484;
                            end;
                        7:
                            begin
                                Dim2ID := 485;
                            end;
                        8:
                            begin
                                Dim2ID := 486;
                            end;
                    end;

                end;
            }

            trigger OnPreDataItem()//Setting the G_CurrencyCode Varaible and the SalesPersonNameVar
            begin
                G_CurrencyCode := "Currency Table".CurrencyCode;
                if CustomerInformation."Salesperson Code" = '' then begin
                    SalesPersonNaneVar := '';
                end
                else begin
                    SalesPerson.GET(CustomerInformation."Salesperson Code");
                    SalesPersonNaneVar := SalesPerson.Name;
                end;

                // //Currency Filter
                // "Currency Table".SetFilter(CurrencyCode, RequestedCurrency);
                // if "Currency Table".FindSet() then;

            end;


            trigger OnAfterGetRecord()// Checking if the total transaction during the specefic period AND the BBF are positive or negative(For setting OweUsLabel)
                                      // If the currencyCode field inside the temperory Cirrencytable empty then the total ammount that it is Calculated is for the LCY
                                      // getTotalBefore is used for calculating the total before thw Date that is specified by the user on the request Page
            var
                L_CustomerLedgerEntry: Record "Cust. Ledger Entry";
            begin
                clear(tot);
                tot := 0;//"Currency Table".Total;

                if "Currency Table".CurrencyCode = '''''' then begin
                    G_CurrencyCode := GeneralLedgerSetup."LCY Code";
                end
                else begin
                    G_CurrencyCode := "Currency Table".CurrencyCode;
                end;
                getTotalBefore("Currency Table".CurrencyCode);
               
                

                TotalAMT := TotalBefore;
                L_CustomerLedgerEntry.Reset();
                L_CustomerLedgerEntry.SetRange("Customer No.", G_CustNo);
                L_CustomerLedgerEntry.SetRange("Currency Code", "Currency Table".CurrencyCode);
                L_CustomerLedgerEntry.SetRange("Posting Date", fromDate, toDate);
                if L_CustomerLedgerEntry.Findfirst() then begin // Check if during those specifed date there is a transaction in each currency
                    repeat
                        L_CustomerLedgerEntry.CalcFields("Amount");
                        TotalAMT += L_CustomerLedgerEntry."Amount";
                    until L_CustomerLedgerEntry.Next() = 0;
                end;

                tot:=TotalAMT;
                if tot < 0 then begin
                    OweUsLabel := 'We owe you';
                    tot := tot * -1;
                end
                else begin
                    OweUsLabel := 'You owe us';
                end;

                AmountInWordsFunction(TotalAMT, G_CurrencyCode);

            end;

            trigger OnPostDataItem()
            begin
                PopulateTempCurrenciesTotal();
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group("Date  And Customer Filtering")
                {
                    field("From Date"; fromDate)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if (fromDate > toDate) and (toDate <> 0D) then begin
                                Error(Text000, fromDate, fromDate);
                                exit;
                            end;
                        end;
                    }

                    field("To Date"; toDate)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if fromDate > toDate then begin
                                Error(DateErrorLabel);
                                exit;
                            end;
                        end;

                    }
                    field("Customer No."; G_CustNo)
                    {
                        ApplicationArea = All;
                        TableRelation = Customer."No.";
                        trigger OnValidate()
                        begin
                            if G_CustNo = '' then begin
                                Error(SselectCustLabel);
                                exit;
                            end;
                        end;
                    }

                }
                group("Currency Filtering")
                {
                    field(RequestCurrency; RequestedCurrency)
                    {
                        AssistEdit = true;
                        TableRelation = "AC Currency Total".CurrencyCode;
                        LookupPageId = Currencies;
                        ApplicationArea = All;
                        caption = 'Requested Currency Code';
                        Lookup = false;

                        trigger OnValidate()
                        begin
                            if RequestedCurrency = '' then begin
                                "Currency Table".Reset();
                            end;
                        end;


                        trigger OnAssistEdit()

                        begin
                            GeneralLedgerSetup.get();

                            Clear(G_MyCurrPage);
                            G_MyCurrPage.LookupMode := true;
                            if G_MyCurrPage.RunModal() = ACTION::LookupOK then begin
                                Clear(RequestedCurrency);
                                G_MyCurrPage.SetSelectionFilter("Currency Table");
                                if "Currency Table".FindFirst() then
                                    repeat
                                            RequestedCurrency := RequestedCurrency + "Currency Table".CurrencyCode + '|';
                                    until "Currency Table".Next() = 0;
                                RequestedCurrency := DelChr(RequestedCurrency, '>', '|');
                            end;
                        end;
                    }
                }
                group("Groupping by Dimensions")
                {
                    field(Dimension1; DimensionsArray[1])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,1,1';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension2; DimensionsArray[2])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,1,2';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension3; DimensionsArray[3])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,2,3';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension4; DimensionsArray[4])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,2,4';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension5; DimensionsArray[5])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,2,5';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension6; DimensionsArray[6])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,2,6';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension7; DimensionsArray[7])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,2,7';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension8; DimensionsArray[8])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,2,8';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                }
            }

        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if CloseAction = Action::Cancel then begin
                exit(true);
            end
            else begin
                if fromDate > toDate then begin
                    Error(DateErrorLabel);
                end;
                if fromDate = 0D then begin
                    Error(Text002);
                end;
                if toDate = 0D then begin
                    Error(Text003);
                end;
                if G_CustNo = '' then begin
                    Error(SselectCustLabel);
                end
            end;
            exit(true);
        end;


        trigger OnOpenPage()
        begin
            PopulateTempCurrenciesTotal();
        end;
    }


    trigger OnPreReport()
    var
        LCYTotal: Decimal;
        i: Integer;
        L_RecDimensions: Record Dimension;
    begin
        GeneralLedgerSetup.Get();
        CompanyInformation.Get();
        CustomerInformation.Get(G_CustNo);
        CompanyAddress := CompanyInformation.Address;
        CityPostal := CompanyInformation.City + ' ' + CompanyInformation."Post Code";
        CompanyInformation.CalcFields(Picture);
        x := 1;

        for i := 1 to 8 do begin
            if DimensionsArray[i] = true then begin
                if i = 1 then begin
                    L_RecDimensions.get(GeneralLedgerSetup."Global Dimension 1 Code");
                    SelectedDimensions[x] := L_RecDimensions.Name;
                    SelectedDimensionsNB[x] := 1;
                    x := x + 1;
                end else begin
                    if i = 2 then begin
                        L_RecDimensions.get(GeneralLedgerSetup."Global Dimension 2 Code");
                        SelectedDimensions[x] := L_RecDimensions.Name;
                        SelectedDimensionsNB[x] := 2;
                        x := x + 1;

                    end else begin
                        if i = 3 then begin
                            L_RecDimensions.get(GeneralLedgerSetup."Shortcut Dimension 3 Code");
                            SelectedDimensions[x] := L_RecDimensions.Name;
                            SelectedDimensionsNB[x] := 3;
                            x := x + 1;

                        end else begin
                            if i = 4 then begin
                                L_RecDimensions.get(GeneralLedgerSetup."Shortcut Dimension 4 Code");
                                SelectedDimensions[x] := L_RecDimensions.Name;
                                SelectedDimensionsNB[x] := 4;
                                x := x + 1;

                            end else begin
                                if i = 5 then begin
                                    L_RecDimensions.get(GeneralLedgerSetup."Shortcut Dimension 5 Code");
                                    SelectedDimensions[x] := L_RecDimensions.Name;
                                    SelectedDimensionsNB[x] := 5;
                                    x := x + 1;

                                end else begin
                                    if i = 6 then begin
                                        L_RecDimensions.get(GeneralLedgerSetup."Shortcut Dimension 6 Code");
                                        SelectedDimensions[x] := L_RecDimensions.Name;
                                        SelectedDimensionsNB[x] := 6;
                                        x := x + 1;

                                    end else begin
                                        if i = 7 then begin
                                            L_RecDimensions.get(GeneralLedgerSetup."Shortcut Dimension 7 Code");
                                            SelectedDimensions[x] := L_RecDimensions.Name;
                                            SelectedDimensionsNB[x] := 7;
                                            x := x + 1;

                                        end else begin
                                            if i = 8 then begin
                                                L_RecDimensions.get(GeneralLedgerSetup."Shortcut Dimension 8 Code");
                                                SelectedDimensions[x] := L_RecDimensions.Name;
                                                SelectedDimensionsNB[x] := 8;
                                                x := x + 1;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;


    end;

    trigger OnInitReport()
    begin
        TestDateTime := CurrentDateTime;
    end;



    procedure PopulateTempCurrenciesTotal()//Used to populate the temp table with the currency codes from the Currencies Table
    begin
        if G_RecCurrency.FindFirst() then
            repeat
                "Currency Table".Init();
                "Currency Table".CurrencyCode := G_RecCurrency.Code;
                if "Currency Table".Insert() then;
            until G_RecCurrency.Next() = 0;
        //Add the empty currency code for LCY
        "Currency Table".Init();
        "Currency Table".CurrencyCode := '''''';//GeneralLedgerSetup."LCY Code";
        if "Currency Table".Insert() then;
    end;


    procedure getTotalBefore(Ccode: Code[20])//Used to getTotal of each currency before the time that is specified by the user to output the balance before the TODATE
    var
        L_CustomerLedgerEntry: Record "Cust. Ledger Entry";
    begin

        if Ccode = GeneralLedgerSetup."LCY Code" then
            Ccode := '';
        L_CustomerLedgerEntry.Reset();
        L_CustomerLedgerEntry.SetRange("Customer No.", G_CustNo);
        L_CustomerLedgerEntry.SetRange("Currency Code", Ccode);
        L_CustomerLedgerEntry.SetRange("Posting Date", 0D, fromDate - 1);

        clear(TotalBefore);

        if L_CustomerLedgerEntry.FindFirst() then
            repeat
                L_CustomerLedgerEntry.CalcFields("Amount");
                TotalBefore += L_CustomerLedgerEntry."Amount";
            until L_CustomerLedgerEntry.Next() = 0;
    end;




    procedure AmountInWordsFunction(Amount: Decimal; CurrencyCode: Code[10])
    var
        NoText: array[2] of Text[200];
    begin
        Clear(AmountinWords);
        InitTextVariable();
        FormatNoText(NoText, Amount, CurrencyCode);
        AmountinWords := NoText[1];
    end;


    procedure GetTrue(): Integer
    var
        i: Integer;
        Counter: Integer;
    begin
        Counter := 0;
        for i := 1 to 8 do begin
            if DimensionsArray[i] = true then begin
                Counter := Counter + 1;
            end;
        end;
        exit(Counter)
    end;


    //Because the length of the Amount in Words was only 80Characters i coppy and past the cide that generate amount in word and i increased the length to become 200
    procedure FormatNoText(var NoText: array[2] of Text[200]; No: Decimal; CurrencyCode: Code[10])
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
        GeneralLedgerSetup.Get();

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

    end;

    local procedure AddToNoText(var NoText: array[2] of Text[200]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(Text029, AddText);
        end;

        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    local procedure GetAmtDecimalPosition(): Decimal
    var
        Currency: Record Currency;
        GenJnlLine: Record "Gen. Journal Line";
    begin
        if GenJnlLine."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(GenJnlLine."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;
        exit(1 / Currency."Amount Rounding Precision");
    end;

    procedure InitTextVariable()
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


    var
        CompanyInformation: Record "Company Information";
        GlobalCLE: Record "Cust. Ledger Entry";
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        CustomerInformation: Record Customer;
        GeneralLedgerSetup: RECORD "General Ledger Setup";
        G_RecCurrency: Record Currency;
        G_PageCurrency: Page Currencies;
        G_MyCurrPage: Page AC_CurrencyTotal;
        G_MyCurrencyTable: Record "AC Currency Total";
        CustLedgerEntriesRecref: RecordRef;
        TestDateTime: DateTime;
        CompanyAddress: Text;
        CityPostal: Text;
        DimensionsArray: array[8] of Boolean;
        SelectedDimensions: array[2] of Text;
        SelectedDimensionsNB: array[2] of Integer;
        x: Integer;
        Dim1ID: Integer;
        Dim2ID: Integer;
        Dim1Value: Text;
        Dim2Value: Text;
        FilteringCurrency:Code[10];
        TotalAMT: Decimal;

        G_CurrencyCode: Code[10];
        G_CustNo: Code[20];
        fromDate: Date;
        ShowOnlyLCY: Boolean;
        toDate: Date;
        SalesPerson: Record "Salesperson/Purchaser";
        SalesPersonNaneVar: Text[50];
        TotalBefore: Decimal;
        RequestedCurrency: Text;

        //Labels
        //Header
        CapitalLabel: Label 'Capital';
        FullyPaidLabel: Label 'Fully Paid';
        VatCodeLabel: Label 'VAT Code';
        TelLabel: Label 'T:';
        EmailLabel: Label 'E:';
        AddressLabel: Label 'Address:';
        ReportTitle: Label 'Customer Statment';
        CustomerLabel: Label 'Customer';
        SalepersonLabel: Label 'Salesperson';
        CustAddLabel: Label 'Address';
        VatRegNoLabel: Label 'VAT Reg. No.';

        //Body
        CustProjLabel: Label 'Customer Project';
        CustAccountLabel: Label 'Account';
        VATNumLabel: Label 'VAT Number';
        PhoneNumLabel: Label 'Phone Number';
        DocNoLabel: Label 'Doc. No.';
        PostingDateLabel: Label 'Date';
        DueDateLabel: Label 'Due Date';
        CurrencyCodeLabel: Label 'Curr.';
        DescriptionLabel: Label 'Transaction Desc.';
        DebitAmountLabel: Label 'Debit Amt.';
        CreditAmountLabel: Label 'Credit Amt.';
        RemainingAmountLabel: Label 'Rem Amt.';
        BalanceLabel: Label 'Balance';
        TotalLabel: Label 'Total';
        EntriesLabel: Label 'Entries';
        SselectCustLabel: Label 'Please select a customer';
        DateErrorLabel: label 'From Date cannot be greater than To Date';
        Text000: Label 'The field %1 cannot be greater than the field %2.';

        Text002: Label 'Please Select a From Date.';
        Text003: Label 'Please Select a To Date.';

        //Footer
        FormNumberLabel: label 'Form #: ';
        FormNoValueLabel: Label 'ER\LB\AVER\ACCT-C.SOA\100';
        IssueDateLabel: Label 'Issue Date:';
        IssueDateValueLabel: Label 'Jan 2023';
        RevisionDateLabel: label 'Revision Date';
        FromDateLabel: Label 'From Date';
        ToDateLabel: Label 'To Date';
        OweUsLabel: Text[50];
        OnlyLabel: Label 'only';

        AmountinWords: Text[250];
        tot: Decimal;

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
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
}





















