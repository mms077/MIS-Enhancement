report 50224 "ER - Vendor Trial Balance"
{
    ApplicationArea = All;
    Caption = 'ER - Vendor Trial Balance';
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-VendorTrialBalance.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "Date Filter";

            // Company Info
            column(Company_Picture; compInfoRec.Picture)
            {

            }
            column(Company_Capital; compInfoRec.Capital)
            {

            }
            column(Company_Vat; compInfoRec."VAT Registration No.")
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
            column(LCY; GLS."LCY Code")
            {
            }
            // Vendor Info

            column(CustNoLbl; CustNoLbl)
            { }
            column(Customer_No_; "No.")
            { }
            column(CustNamelbl; CustNamelbl)
            { }
            column(Customer_Name; Name)
            { }
            column(CurrencyLbl; CurrencyLbl)
            { }
            column(BeginBalOrigLbl; BeginBalOrigLbl)
            { }
            column(Net_Change_Orig_Lbl; NetOrigLbl)
            { }
            column(Date_Range; format(FromDate) + '..' + format(ToDate))
            { }
            column(FromDate; Format(FromDate))
            { }
            column(Debit_Orig_Lbl; DebitOrigLbl)
            { }
            column(Credit_Orig_Lbl; CreditOrigLbl)
            { }
            column(End_Bal_Orig_Lbl; EndBalOrigLbl)
            { }
            column(ToDate; Format(ToDate))
            { }
            column(AccountLbl; AccountLbl)
            { }
            column(HideCust; HideCust)
            { }

            // Title
            column(TitleLbl; TitleLbl)
            { }
            column(BeginBalLbl; BeginBalLbl + ' ' + GLS."LCY Code")
            { }
            column(NetChangeLbl; NetChangeLbl + ' ' + GLS."LCY Code")
            { }
            column(EndingBalLbl; EndingBalLbl + ' ' + GLS."LCY Code")
            { }
            column(DebitLbl; DebitLbl + ' ' + GLS."LCY Code")
            { }
            column(Creditlbl; Creditlbl + ' ' + GLS."LCY Code")
            { }
            column(ShowOpening; ShowOpening)
            { }

            dataitem(TempCurrencyTotal; "AC Currency Total")
            {
                column(CurrencyCode; CurrencyCode)
                { }

                column(Line_Currency; TempCurrency)
                { }
                column(Begin_Bal_Orig; BeginBalOrig)
                { }
                column(Debit_Orig; DebiOrig)
                { }
                column(Credit_Orig; CreditOrig)
                { }
                column(End_Bal_Orig; EndBalOrig)
                { }
                column(BeginBalLCY; BeginBalLCY)
                { }
                column(DebitLCY; DebitLCY)
                { }
                column(CreditLCY; CreditLCY)
                { }
                column(EndBalLCY; EndBalLCY)
                { }
                column(TotalCurrLbl; TotalCurrLbl + ' ' + TempCurrency)
                {

                }
                column(EndTotalLCY; EndTotalLCY)
                { }

                trigger OnAfterGetRecord()
                var
                    Vend: Record Vendor;
                    GLS: Record "General Ledger Setup";
                begin

                    GLS.Get();
                    BeginBalOrig := 0;
                    DebiOrig := 0;
                    CreditOrig := 0;
                    EndBalOrig := 0;
                    BeginBalLCY := 0;
                    CreditLCY := 0;
                    DebitLCY := 0;
                    EndBalLCY := 0;


                    // Opening Orig/LCY

                    Vend.Reset();
                    Vend.SetFilter("No.", Vendor."No.");
                    Vend.SetFilter("Currency Filter", TempCurrencyTotal.CurrencyCode);
                    Vend.SetFilter("Date Filter", '<' + format(FromDate));

                    if Vend.FindFirst() then begin
                        Vend.CalcFields("Net Change", "Net Change (LCY)");
                        BeginBalOrig := Vend."Net Change";
                        BeginBalLCY := Vend."Net Change (LCY)";
                    end;

                    // Movement Orig/LCY

                    Vend.Reset();
                    Vend.SetFilter("No.", Vendor."No.");
                    Vend.SetFilter("Currency Filter", TempCurrencyTotal.CurrencyCode);
                    Vend.SetFilter("Date Filter", format(FromDate) + '..' + format(ToDate));

                    if Vend.FindFirst() then begin
                        Vend.CalcFields("Net Change", "Net Change (LCY)", "Credit Amount", "Credit Amount (LCY)", "Debit Amount", "Debit Amount (LCY)");

                        DebiOrig := Vend."Credit Amount";
                        DebitLCY := Vend."Credit Amount (LCY)";
                        CreditOrig := Vend."Debit Amount";
                        CreditLCY := Vend."Debit Amount (LCY)";

                    end;

                    // Ending Orig/LCY              

                    EndBalOrig := BeginBalOrig + DebiOrig - CreditOrig;
                    EndBalLCY := BeginBalLCY + DebitLCY - CreditLCY;

                    EndTotalLCY += EndBalLCY;

                    // If no balance in currency skip currency

                    if (BeginBalOrig = 0) and (DebiOrig = 0) and (CreditOrig = 0) and (EndBalOrig = 0) then begin
                        CurrReport.Skip();
                    end;

                    // Currency

                    if TempCurrencyTotal.CurrencyCode = '''''' then begin
                        TempCurrency := GLS."LCY Code";
                    end
                    else
                        TempCurrency := TempCurrencyTotal.CurrencyCode;


                end;
            }

            trigger OnAfterGetRecord()
            begin

                Vendor.CalcFields(Balance);
                if (Vendor.Balance = 0) and (HideCust) then
                    CurrReport.Skip();

            end;

        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(HideCust; HideCust)
                    {
                        ApplicationArea = all;
                        Caption = 'Hide Vendors With no Balance';
                    }
                    field("Show opening balance"; ShowOpening)
                    {
                        ApplicationArea = all;
                        Caption = 'Show Opening Balance';
                    }
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

    trigger OnPreReport()
    var
        Text001: label 'From Date can not be greater than To Date.';
        text002: Label 'Please fill From Date and To Date';
        currencies: Record Currency;
    begin

        GLS.Get();
        CompanyAddress := compInfoRec.Address + ' ' + compInfoRec."Address 2";

        if Vendor.GetFilter("No.") <> '' then
            AccountLbl := 'Account : ';

        if FromDate > ToDate then Error(Text001);
        if (format(FromDate) = '') or (format(ToDate) = '') then Error(text002);


        if currencies.FindFirst() then
            repeat
                TempCurrencyTotal.Init();
                TempCurrencyTotal.CurrencyCode := currencies.Code;
                if TempCurrencyTotal.Insert() then;
            until currencies.Next() = 0;

        TempCurrencyTotal.Init();
        TempCurrencyTotal.CurrencyCode := '''''';
        if TempCurrencyTotal.Insert() then;

    end;

    trigger OnInitReport()
    var

    begin

        compInfoRec.Get();
        compInfoRec.CalcFields(Picture);

    end;


    var
        ShowOpening: Boolean;
        GLS: Record "General Ledger Setup";
        compInfoRec: Record "Company Information";
        CurrencyCounter: Integer;
        TempCurrency: Code[10];
        FromDate: Date;
        ToDate: Date;
        CustomerEmpty: Boolean;
        TitleLbl: Label 'Vendor-Trial Balance';
        BeginBalOrigLbl: Label 'Begining Balance Original';
        NetOrigLbl: Label 'Net Change Original';
        EndBalOrigLbl: Label 'Ending Balance Original';
        BeginBalLbl: Label 'Begining Balance';
        NetChangeLbl: Label 'Net Change';
        EndingBalLbl: Label 'Ending Balance';
        DebitOrigLbl: Label 'Debit Original';
        CreditOrigLbl: Label 'Credit Original';
        DebitLbl: Label 'Debit';
        Creditlbl: Label 'Credit';
        CurrencyLbl: Label 'Curr';
        TotalLbl: Label 'Total';
        CustNoLbl: Label 'No.';
        CustNamelbl: Label 'Name';
        TotalCurrLbl: Label 'Total';
        CapitalLabel: Label 'Capital';
        VATCodeLabel: Label 'VAT Code';
        AddressLabel: Label 'Address';
        BankAccountLabel: Label 'Bank Account';
        SWIFTLabel: Label 'SWIFT';
        BeginBalOrig: Decimal;
        DebiOrig: Decimal;
        CreditOrig: Decimal;
        EndBalOrig: Decimal;
        BeginBalLCY: Decimal;
        DebitLCY: Decimal;
        CreditLCY: Decimal;
        EndBalLCY: Decimal;
        EndTotalLCY: Decimal;
        HideCust: Boolean;
        CompanyAddress: Text[250];
        AccountLbl: Text[250];
}
