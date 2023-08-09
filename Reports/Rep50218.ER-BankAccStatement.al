report 50218 "ER - Bank Acc. Statement"
{
    ApplicationArea = All;
    Caption = 'Bank Acc. Statement';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-BankAccStatement.rdl';
    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            RequestFilterFields = "No.";

            dataitem(BankAccountLedgerEntry; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No.");
                DataItemLinkReference = "Bank Account";

                RequestFilterFields = "Bank Account No.", "Currency Code";

                column(Company_Picture; compInfoRec.Picture)
                {

                }
                column(PageLabel; PageLabel) { }
                column(OfLabel; OfLabel) { }
                column(Company_Capital; compInfoRec.Capital)
                {

                }
                column(Company_Vat; compInfoRec."VAT Registration No.")
                {

                }
                column(PrintedOnLabel; PrintedOnLabel)
                {

                }
                column(TimeNow; TimeNow)
                {

                }
                column(Comapny_Phone; compInfoRec."Phone No.")
                {

                }
                column(Company_Email; compInfoRec."E-Mail")
                {

                }
                column(Company_Address; CompanyAddress)
                {

                }
                column(Company_Bank_Account; compInfoRec."Bank Name")
                {

                }
                column(Company_SWIFT; compInfoRec."SWIFT Code")
                {

                }
                column(Company_IBAN; compInfoRec.IBAN)
                {

                }
                column("Company_CR_No"; compInfoRec."CR No.")
                { }
                column(Company_City; compInfoRec.City)
                { }
                column(CapitalLabel; CapitalLabel)
                {
                }
                column(VATCodeLabel; VATCodeLabel)
                {
                }
                column(AddressLabel; AddressLabel)
                {
                }
                column(BankAccountLabel; BankAccountLabel)
                {
                }
                column(SWIFTLabel; SWIFTLabel)
                {
                }
                column(LCY_Code; GLS."LCY Code")
                {
                }
                column(Bank_Account_No_; "Bank Account No.")
                {
                }

                column(BankAccName; BankAccRec.Name)
                {
                }
                column(bankAccAdd1; BankAccRec.Address)
                {
                }
                column(BankAccAdd2; BankAccRec."Address 2")
                {
                }
                column(BankAccPhone; BankAccRec."Phone No.")
                {
                }
                column(PostingDate_BankAccountLedgerEntry; "Posting Date")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry; "Document No.")
                {
                }
                column(DocumentType_BankAccountLedgerEntry; "Document Type")
                {
                }
                column(Description_BankAccountLedgerEntry; Description)
                {
                }
                column(Amount_BankAccountLedgerEntry; Amount)
                {
                }
                column(Currency_Code; "Currency Code")
                {
                }
                column(TempCurrencyCode2; TempCurrencyCode2)
                {
                }
                column(TempAccumalated; TempAccumalated)
                {
                }
                column(CreditAmount; CreditAmount)
                {
                }
                column(DebitAmount; DebitAmount)
                {
                }
                column(OpeningBalance; OpeningBalance)
                {
                }
                column(FromDate; FromDate)
                {
                }
                column(ToDate; ToDate)
                {
                }
                column(Today_; Today_)
                {
                }
                column(AmountinWords; AmountinWords)
                {
                }
                column(BeforeAmtInWords; BeforeAmtInWords)
                { }


                trigger OnPreDataItem()
                begin
                    SetCurrentKey("Bank Account No.", "Currency Code", "Posting Date");
                    if FromDate <> 0D then
                        tempfromDate := CalcDate('-<1D>', FromDate)
                    else
                        tempfromDate := 0D;
                    if (FromDate <> 0D) and (ToDate <> 0D) then SetRange("Posting Date", FromDate, ToDate);

                    Clear(TempCurrencyCode3);
                end;

                trigger OnAfterGetRecord()
                var
                    L_Bank: Record "Bank Account";
                begin
                    Clear(L_Bank);
                    Clear(TempCurrencyCode);
                    Clear(DebitAmount);
                    Clear(CreditAmount);
                    GenLedgerSetupRec.Get();

                    if BankAccountLedgerEntry."Currency Code" = '' then
                        TempCurrencyCode := GenLedgerSetupRec."LCY Code"
                    else
                        TempCurrencyCode := BankAccountLedgerEntry."Currency Code";

                    if tempBankNo <> BankAccountLedgerEntry."Bank Account No." then begin
                        tempBankNo := BankAccountLedgerEntry."Bank Account No.";
                        Clear(OpeningBalance);
                        Clear(TempAccumalated);
                        Clear(TempCurrencyCode3);
                        Clear(counter);
                        if not BankAccRec.get(BankAccountLedgerEntry."Bank Account No.") then
                            Clear(BankAccRec);
                        counter := 1;
                    end;

                    if TempCurrencyCode3 <> TempCurrencyCode then begin
                        TempCurrencyCode3 := TempCurrencyCode;
                        Clear(OpeningBalance);
                        Clear(TempAccumalated);
                        Clear(counter);
                        BankAccLedgerEntryRec.Reset();
                        BankAccLedgerEntryRec.SetCurrentKey("Bank Account No.", "Currency Code");
                        BankAccLedgerEntryRec.SetRange("Bank Account No.", BankAccountLedgerEntry."Bank Account No.");
                        BankAccLedgerEntryRec.SetRange("Currency Code", BankAccountLedgerEntry."Currency Code");
                        if tempfromDate <> 0D then
                            BankAccLedgerEntryRec.SetFilter("Posting Date", '..%1', tempfromDate)
                        else
                            BankAccLedgerEntryRec.SetRange("Posting Date");
                        if BankAccLedgerEntryRec.FindFirst() then begin
                            repeat
                                OpeningBalance += BankAccLedgerEntryRec.Amount;
                            until BankAccLedgerEntryRec.Next() = 0;
                        end;
                        counter := 1;
                        if (FromDate = 0D) and (ToDate = 0D) then
                            OpeningBalance := 0;
                    end;

                    if BankAccountLedgerEntry.Amount > 0 then
                        DebitAmount := BankAccountLedgerEntry.Amount
                    else
                        "Debit Amount" := 0;
                    if BankAccountLedgerEntry.Amount < 0 then
                        CreditAmount := BankAccountLedgerEntry.Amount
                    else
                        CreditAmount := 0;

                    if counter = 1 then begin
                        TempAccumalated := OpeningBalance + BankAccountLedgerEntry.Amount;
                        TotalInWords := 0;
                    end
                    else
                        TempAccumalated += BankAccountLedgerEntry.Amount;

                    counter += 1;

                    TotalInWords += Amount;

                    if "Currency Code" = '' then
                        CurrencyInWords := TempCurrencyCode2
                    else
                        CurrencyInWords := "Currency Code";

                    L_Bank.SetFilter("No.", BankAccountLedgerEntry."Bank Account No.");
                    L_Bank.SetFilter("Date Filter", Format(FromDate) + '..' + Format(ToDate));

                    if CurrencyInWords = GLS."LCY Code" then
                        L_Bank.SetFilter("Currency Code", '')
                    else
                        L_Bank.SetFilter("Currency Code", CurrencyInWords);

                    if L_Bank.FindFirst() then
                        L_Bank.CalcFields("Balance at Date");

                    if L_Bank."Balance at Date" < 0 then begin
                        AmountInWordsFunction((-L_Bank."Balance at Date"), CurrencyInWords);
                        BeforeAmtInWords := 'We owe you ';
                    end
                    else begin
                        AmountInWordsFunction(L_Bank."Balance at Date", CurrencyInWords);

                        BeforeAmtInWords := 'You owe us ';
                    end;

                end;
            }
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    Caption = 'Options';

                    field(FromDate; FromDate)
                    {
                        ApplicationArea = all;
                        Caption = 'From Date';
                    }
                    field(ToDate; ToDate)
                    {
                        ApplicationArea = all;
                        Caption = 'To Date';
                    }
                    // field(ShowDueDate; ShowDueDate)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Show Due Date';
                    // }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        compInfoRec.Get();
        compInfoRec.CalcFields(Picture);
        GenLedgerSetupRec2.Get();
        Clear(TempCurrencyCode2);
        TempCurrencyCode2 := GenLedgerSetupRec2."LCY Code";
    end;

    trigger OnPreReport()
    var
        Text001: Label 'From Date can not be greater than to date.';
    begin
        GLS.Get();
        CompanyAddress := compInfoRec.Address + ' ' + compInfoRec."Address 2";
        if FromDate > ToDate then Error(Text001);
        Clear(Today_);
        Today_ := Today;
        TimeNow := Format(System.CurrentDateTime());

    end;

    procedure AmountInWordsFunction(Amount: Decimal; CurrencyCode: Code[10])
    var
        ReportCheck: Report Check;
        NoText: array[2] of Text[80];
    begin
        ReportCheck.InitTextVariable();
        ReportCheck.FormatNoText(NoText, Amount, CurrencyCode);
        AmountinWords := NoText[1];
    end;

    var
        GLS: Record "General Ledger Setup";
        CompanyAddress: Text[250];
        CurrencyInWords: Code[10];
        TotalInWords: Decimal;
        AmountinWords: Text[250];
        BankAccLedgerEntryRec: Record "Bank Account Ledger Entry";
        BankAccRec: Record "Bank Account";
        compInfoRec: Record "Company Information";
        countryRegionRec: Record "Country/Region";
        countryRegionRec2: Record "Country/Region";
        GenLedgerSetupRec: Record "General Ledger Setup";
        GenLedgerSetupRec2: Record "General Ledger Setup";
        formatAdd: Codeunit "Format Address";
        OpeningBalance: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
        TempAccumalated: Decimal;
        tempBankNo: Code[20];
        TempCurrencyCode: Code[20];
        TempCurrencyCode2: Code[20];
        TempCurrencyCode3: Code[20];
        FromDate: Date;
        ToDate: Date;
        tempfromDate: Date;
        counter: Integer;
        CompanyDetails: array[8] of Text;
        ShowDueDate: Boolean;
        Today_: Date;
        CapitalLabel: Label 'Capital';
        VATCodeLabel: Label 'VAT Code';
        AddressLabel: Label 'Address';
        BankAccountLabel: Label 'Bank Account';
        SWIFTLabel: Label 'SWIFT';
        BeforeAmtInWords: text;


        TimeNow: Text[25];
        PrintedOnLabel: Label 'Printed On:';
        PageLabel: Label 'Page';
        OfLabel: Label 'of';
}
