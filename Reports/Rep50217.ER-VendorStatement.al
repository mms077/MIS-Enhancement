report 50217 "ER - Vendor Statement"
{
    ApplicationArea = All;
    Caption = 'ER - Vendor Statement';
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = true;
    EnableHyperlinks = true;
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-VendorStatement.rdlc';

    dataset
    {
        dataitem(G_TempCurrencyTotal; "AC Currency Total")
        {
            //UseTemporary = true;
            DataItemTableView = sorting(CurrencyCode);
            #region TempCurrencyTotal columns
            column(CurrencyCode; CurrencyCode)
            {
            }
            // column(Total; Total)
            // {
            // }
            column(Company_Picture; CompanyInformation.Picture)
            {

            }
            column(Company_Capital; CompanyInformation.Capital)
            {

            }
            column(Company_Vat; CompanyInformation."VAT Registration No.")
            {

            }
            column(Comapny_Phone; CompanyInformation."Phone No.")
            {

            }
            column(Company_Email; CompanyInformation."E-Mail")
            {

            }
            column(Company_Address; CompanyInformation.Address)
            {
            }
            column(Company_Address2; CompanyInformation."Address 2")
            {

            }
            column(Company_Bank_Account; CompanyInformation."Bank Name")
            {

            }
            column(Company_SWIFT; CompanyInformation."SWIFT Code")
            {

            }
            column(Company_IBAN; CompanyInformation.IBAN)
            {

            }
            column(Company_CityAndZip; CityAndZip)
            {

            }
            column(LCY_Code; GeneralLedgerSetup."LCY Code")
            {

            }
            column(AccountNumberLabel; AccountNumberLabel)
            {

            }
            column(FromDateLabel; FromDateLabel)
            {

            }
            column(ToDateLabel; ToDateLabel)
            {

            }
            column(Capital_Label; Capital_Label)
            {

            }
            column(VendorStatementLabel; VendorStatementLabel)
            {

            }
            column(VendorLabel; VendorLabel)
            {

            }
            column(AddressLabel; AddressLabel)
            {

            }
            column(PhoneLabel; PhoneLabel)
            {

            }
            column(VATCodeLabel; VATCodeLabel)
            {

            }
            column(VatRegNoLabel; VatRegNoLabel)
            {

            }
            column(DocumentNoLabel; DocumentNoLabel)
            {

            }
            column(dateLabel; dateLabel)
            {

            }
            column(dueDateLabel; dueDateLabel)
            {

            }
            column(CurrencyLabel; CurrencyLabel)
            {

            }
            column(TransactionDescLabel; TransactionDescLabel)
            {

            }
            column(DebitLabel; DebitLabel)
            {

            }
            column(CreditLabel; CreditLabel)
            {

            }
            column(RemAmtLabel; RemAmtLabel)
            {

            }
            column(BalanceLabel; BalanceLabel)
            {

            }
            column(FullyPaidLabel; FullyPaidLabel)
            {
            }
            column(TotalLabel; TotalLabel)
            {
            }
            column(WeOweYouLabel; WeOweYouLabel)
            {
            }
            column(OnlyLabel; OnlyLabel)
            {
            }
            column(FromDate; "From Date")
            {
            }
            column(FormNo; FormNo)
            {
            }
            column(IssueDate; IssueDate)
            {
            }
            column(ToDate; "To Date")
            {
            }
            column(SelectedVendorNo; SelectedVendorNo)
            {

            }
            column(VendorNoLabel; VendorNoLabel)
            {

            }
            column(VendorNo; G_RecVendor."No.")
            {
            }
            column(VendorName; G_RecVendor.Name)
            {
            }

            column(G_CurrentCurrency; G_CurrentCurrency)
            {
            }
            column(G_TempTotal; G_TempTotal)
            {
            }
            column(G_BeforeTotal; G_BeforeTotal)
            {
            }
            column(AmountinWords; AmountinWords)
            {
            }
            column(WhoOwesWhom; WhoOwesWhom)
            {
            }

            column(VendorAddress; G_RecVendor.Address)
            {
            }
            column(VendordVatRegNo; G_RecVendor."VAT Registration No.")
            {
            }
            column(VendorPhoneNo; G_RecVendor."Phone No.")
            {
            }
            //Footer
            column(RevisionDateLabel; RevisionDateLabel)
            {

            }
            column(FormNoLabel; FormNoLabel)
            {

            }
            column(IssueDateLabel; IssueDateLabel)
            {

            }
            #endregion
            dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
            {
                // RequestFilterFields = "Vendor No.";
                //DataItemLink = "Currency Code" = field(CurrencyCode);
                DataItemTableView = sorting("Entry No.");
                #region VendorLedgerEntry
                column(External_Document_No; "External Document No.")
                {

                }
                column(Document_Type; "Document Type")
                {

                }
                column(Currency_Code; "Currency Code")
                {
                }
                column(Description; Description)
                {
                }
                column(DebitAmount; "Debit Amount")
                {
                }
                column(CreditAmount; "Credit Amount")
                {
                }

                column(RemainingAmount; "Remaining Amount")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Document_No_; "Document No.")
                {
                }
                column(PostingDate; "Posting Date")
                {
                }
                column(DueDate; "Due Date")
                {
                }
                column(TotalPerCurrency; TotalPerCurrency)
                {

                }
                #endregion
                //Triggers
                trigger OnPreDataItem()
                begin
                    //Filtering the Date
                    VendorLedgerEntry.SetRange("Posting Date", "From Date", "To Date");
                    VendorLedgerEntry.SetRange("Vendor No.", SelectedVendorNo);
                    VendorLedgerEntry.SetRange("Currency Code", G_TempCurrencyTotal.CurrencyCode);
                end;
            }
            // Triggers
            trigger OnAfterGetRecord()
            begin
                // if G_TempCurrencyTotal.CurrencyCode='''''' then begin
                //     G_filteringCurrency:='''''';
                // end
                // else begin
                //     G_filteringCurrency:=G_TempCurrencyTotal.CurrencyCode;
                // end; 
                CalculateBeforeTotal(G_TempCurrencyTotal.CurrencyCode);//calculating the before total
                CalculateCurrenciesTotals(G_TempCurrencyTotal.CurrencyCode);//calculating the total per currency + before total

                // Convert empty currency to LCY
                clear(G_CurrentCurrency);
                if CurrencyCode = '''''' then
                    G_CurrentCurrency := GeneralLedgerSetup."LCY Code"
                else
                    G_CurrentCurrency := CurrencyCode;

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
                group(Filters)
                {
                    Caption = 'Date & Vendor Filters';
                    field("From Date"; "From Date")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the starting date for the report.';

                        trigger onValidate()
                        begin
                            if ("From Date" > "To Date") and ("To Date" <> 0D) then
                                Error(Text000, "From Date", "To Date");

                        end;
                    }
                    field("To Date"; "To Date")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the ending date for the report.';
                        trigger onValidate()
                        begin
                            if "From Date" > "To Date" then
                                Error(Text000, "From Date", "To Date");
                        end;
                    }
                    field(SelectedVendorNo; SelectedVendorNo)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the Vendor No.';
                        TableRelation = Vendor."No.";
                        Caption = 'Vendor No.';
                        Lookup = true;
                        trigger OnValidate()//check if empty
                        begin
                            if SelectedVendorNo = '' then
                                Error(Text001);
                        end;
                    }
                    field(SelectedCurrencies; SelectedCurrencies)
                    {
                        TableRelation = "AC Currency Total".CurrencyCode;
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the Currency Code.';
                        Caption = 'Filter By Currency Codes.';
                        Lookup = false;

                        trigger OnValidate()//check if empty
                        begin
                            if SelectedCurrencies = '' then
                                G_TempCurrencyTotal.Reset();
                        end;

                        trigger OnAssistEdit()
                        begin
                            GeneralLedgerSetup.Get();
                            //G_RecCurrency.Reset();
                            Clear(G_PageCurrList);
                            G_PageCurrList.LookupMode := true;
                            if G_PageCurrList.RunModal() = ACTION::LookupOK then begin
                                Clear(SelectedCurrencies);
                                G_PageCurrList.SetSelectionFilter(G_TempCurrencyTotal);
                                if G_TempCurrencyTotal.FindFirst() then
                                    repeat
                                            SelectedCurrencies := SelectedCurrencies + G_TempCurrencyTotal.CurrencyCode + '|';
                                    until G_TempCurrencyTotal.Next() = 0;
                                SelectedCurrencies := DelChr(SelectedCurrencies, '>', '|');
                            end;
                        end;

                    }
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean//Check if the user has selected a vendor before running the report
        begin//check if vendor is empty
            if CloseAction <> Action::Cancel then begin
                if SelectedVendorNo = '' then
                    Error(Text001)
                else
                    if "From Date" = 0D then
                        Error(Text002)
                    else
                        if "To Date" = 0D then
                            Error(Text003);
                exit(true);
            end;
        end;
    }



    trigger OnPreReport()
    begin
        GeneralLedgerSetup.Get();
        CompanyInformation.Get();
        G_TempCurrencyTotal.Reset();
        CityAndZip := companyInformation.City + ' ' + companyInformation."Post Code";
        CompanyInformation.CalcFields(Picture);
        G_RecVendor.Get(SelectedVendorNo);
    end;

    procedure CalculateBeforeTotal(SelectedCurrency: Code[10])//Calculate the total before the Selected Time Period
    var
    begin
        G_RecVendLedgEntry.Reset();
        G_RecVendLedgEntry.SetRange("Currency Code", SelectedCurrency);
        G_RecVendLedgEntry.SetRange("Posting Date", 0D, "From Date" - 1);
        G_RecVendLedgEntry.SetRange("Vendor No.", SelectedVendorNo);
        G_BeforeTotal := 0;
        if G_RecVendLedgEntry.Findfirst() then begin
            repeat
                G_RecVendLedgEntry.CalcFields("Amount");
                G_BeforeTotal := G_BeforeTotal + G_RecVendLedgEntry."Amount";
            until G_RecVendLedgEntry.Next() = 0;
        end;
    end;

    procedure CalculateCurrenciesTotals(RecievedCurrency: Code[10]) //Calculate the total for each currency
    begin
        TotalPerCurrency := G_BeforeTotal;
        G_RecVendLedgEntry.Reset();
        G_RecVendLedgEntry.SetRange("Currency Code", RecievedCurrency);
        G_RecVendLedgEntry.SetRange("Posting Date", "From Date", "To Date");//22/2
        G_RecVendLedgEntry.SetRange("Vendor No.", SelectedVendorNo);
        if G_RecVendLedgEntry.Findfirst() then
            repeat
                G_RecVendLedgEntry.CalcFields("Amount");
                TotalPerCurrency := TotalPerCurrency + G_RecVendLedgEntry.Amount;
            until G_RecVendLedgEntry.Next() = 0;
        PrintAmountInWords(RecievedCurrency, TotalPerCurrency);
    end;


    #region "Amount in Words"
    procedure PrintAmountInWords(CurrencyCodeChosen: Code[10]; TotalGained: Decimal)//Choose the correct lable to print alongside converting negative values to positive values
    var
        L_AmountCalculated: Decimal;
    begin//Slight Optimize needed
        G_TempCurrencyTotal.get(CurrencyCodeChosen);
        L_AmountCalculated := TotalGained;
        if L_AmountCalculated < 0 then begin
            L_AmountCalculated := L_AmountCalculated * -1;
            AmountInWordsFunction(L_AmountCalculated, G_CurrentCurrency);
            WhoOwesWhom := WeOweYouLabel;
        end else begin
            AmountInWordsFunction(L_AmountCalculated, G_CurrentCurrency);
            WhoOwesWhom := YouOweUsLabel;
        end
    end;

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
        if VendorLedgerEntry."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(VendorLedgerEntry."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;
        exit(1 / Currency."Amount Rounding Precision");
    end;

    local procedure OnAfterFormatNoText(var NoText: array[2] of Text[200]; No: Decimal; CurrencyCode: Code[10])//Taken from Cheque Report
    begin
    end;
    #endregion
    var
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        //To get currencies
        G_RecCurrency: Record Currency;
        //EOF
        G_RecVendLedgEntry: Record "Vendor Ledger Entry";
        G_RecVendor: Record Vendor;
        G_PageCurrList: page AC_CurrencyTotal;
        TotalPerCurrency: Decimal;
        SelectedCurrencies: text[50];
        G_CurrentCurrency: code[10];//To get current currency and replace empty with lcy
        AmountinWords: Text[250];
        G_BeforeTotal: Decimal;
        G_TempTotal: Decimal;
        "From Date": Date;//For Filtering
        "To Date": Date;//For Filtering
        SelectedVendorNo: Code[20];//For Filtering
        CityAndZip: Text[250];
        CompanyAddress: Text[250];
       //G_filteringCurrency: Code[10];
        AccountNumberLabel: Label 'Account';
        WhoOwesWhom: Text[250];
        FromDateLabel: Label 'From Date';
        ToDateLabel: Label 'To Date';
        PrintedOnLabel: Label 'Printed On';
        VendorStatementLabel: Label 'Vendor Statement';
        Capital_Label: Label 'Capital';
        VendorLabel: Label 'Vendor';
        VendorNoLabel: Label 'Vendor No.';
        AddressLabel: Label 'Address';
        Phonelabel: Label 'Phone Number';
        VATCodeLabel: Label 'VAT Code';
        VATRegNoLabel: Label 'VAT Reg. No.';
        DocumentNoLabel: Label 'Doc. No.';
        dateLabel: Label 'Date';
        dueDateLabel: Label 'Due Date';
        CurrencyLabel: Label 'Curr.';
        TransactionDescLabel: Label 'Transaction Desc.';
        DebitLabel: Label 'Debit Amt.';
        CreditLabel: Label 'Credit Amt.';
        RemAmtLabel: Label 'Rem. Amt.';
        BalanceLabel: Label 'Balance';
        FullyPaidLabel: Label 'Fully Paid';
        TotalLabel: Label 'Total';
        WeOweYouLabel: Label 'We owe you';
        YouOweUsLabel: Label 'You owe us';
        OnlyLabel: Label 'only.';
        //Footer
        FormNoLabel: Label 'Form #: ';
        IssueDateLabel: Label 'Issue Date: ';
        RevisionDateLabel: Label 'Revision Date/#: ';

        FormNo: Label 'ER\LB\AVER\ACCT-V.SOA\100';
        IssueDate: Label 'Jan 2023';

        #region //Beginning of Taken from Cheque Report
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        Text000: Label 'The field %1 cannot be greater than the field %2.';
        Text001: Label 'Please Select a Vendor.';
        Text002: Label 'Please Select a From Date.';
        Text003: Label 'Please Select a To Date.';
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