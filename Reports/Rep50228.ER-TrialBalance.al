report 50228 "ER - Trial Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-TrialBalance.rdl';
    AdditionalSearchTerms = 'year closing,close accounting period,close fiscal year';
    ApplicationArea = Basic, Suite;
    Caption = 'ER - Trial Balance';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(Company_Picture; CompanyInformation.Picture)
            {

            }
            column(PageLabel; PageLabel) { }
            column(OfLabel; OfLabel) { }
            column(TimeNow; TimeNow)
            {

            }
            column(PrintedOnLabel; PrintedOnLabel)
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
            column(Company_Address; CompanyAddress)
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
            column("Company_CR_No"; CompanyInformation."CR No.")
            { }
            column(Company_City; CompanyInformation.City)
            { }
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FieldCaption("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
            {
            }
            column(EndingBalanceCaption; EndingBalanceCaption)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(FromDate; FromDate)
            {
            }
            column(FromDateLbl; FromDateLbl)
            {
            }
            column(ToDate; ToDate)
            {
            }
            column(ToDateLbl; ToDateLbl)
            {
            }
            column(AmountsInText; AmountsInText)
            {
            }
            column(LCY_Code; GLS."LCY Code")
            {
            }
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
            column(TotalCaption; TotalCaption)
            { }
            column(TotalEndingBalance; TotalEndingBalance)
            { }
            column(TotalMovementBalance; TotalMovementBalance)
            { }
            column(TotalOpeningBalance; TotalOpeningBalance)
            { }
            column(ShowOpening; ShowOpening)
            { }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change_; BeginningBalanceDebit)
                {
                }
                column(G_L_Account___Net_Change__Control22; BeginningBalanceCredit)
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date_; MovementDebit)
                {
                }
                column(G_L_Account___Balance_at_Date__Control24; MovementCredit)
                {
                    AutoFormatType = 1;
                }
                column(G_L_Ending_Balance; EndingBalanceDebit)
                {
                }
                column(G_L_Ending_Balance_Control24; EndingBalanceCredit)
                {
                }
                column(EndingBalanceTotalCredit; EndingBalanceTotalCredit)
                {
                }
                column(EndingBalanceTotalDebit; EndingBalanceTotalDebit)
                {
                }
                column(G_L_Account___Account_Type_; Format("G/L Account"."Account Type", 0, 2))
                {
                }
                column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
                column(BeginBalanceTotalCredit; BeginBalanceTotalCredit)
                { }
                column(BeginBalanceTotalDebit; BeginBalanceTotalDebit)
                { }
                column(MovementTotalCredit; MovementTotalCredit)
                { }
                column(MovementTotalDebit; MovementTotalDebit)
                { }
                dataitem(BlankLineRepeater; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(BlankLineNo; BlankLineNo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if BlankLineNo = 0 then
                            CurrReport.Break();

                        BlankLineNo -= 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    BlankLineNo := "G/L Account"."No. of Blank Lines" + 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                L_GL_Acc: Record "G/L Account";
                DateFilter: Text;
                OpeningDate: Text;
                EndingDate: Text;
            begin

                MovementDebit := 0;
                MovementCredit := 0;
                BeginningBalanceCredit := 0;
                BeginningBalanceDebit := 0;
                BeginBalanceTot := 0;
                EndingBalance := 0;
                DateFilter := "G/L Account".GetFilter("Date Filter");

                // Amounts in LCY

                if not ShowinACY then begin

                    // Mouvement Amount

                    Clear(L_GL_Acc);
                    L_GL_Acc.SetFilter("No.", "G/L Account"."No.");
                    L_GL_Acc.SetFilter("Date Filter", DateFilter);
                    if L_GL_Acc.FindFirst() then begin
                        L_GL_Acc.CalcFields("Debit Amount", "Credit Amount");
                        //MovementBalance := L_GL_Acc."Net Change";
                        MovementDebit := L_GL_Acc."Debit Amount";
                        //MovementTotalDebit := MovementTotalDebit + MovementDebit;
                        MovementCredit := L_GL_Acc."Credit Amount";
                        if "G/L Account"."Account Type" = AccountTypeEnum::Posting then begin
                            MovementTotalCredit := MovementTotalCredit + MovementCredit;
                            MovementTotalDebit := MovementTotalDebit + MovementDebit;
                        end;
                        TotalMovementBalance := TotalMovementBalance + MovementDebit + MovementCredit;
                    end;

                    // Opening Amount

                    Clear(L_GL_Acc);
                    L_GL_Acc.SetFilter("No.", "G/L Account"."No.");
                    L_GL_Acc.SetFilter("Date Filter", '<' + CopyStr(DateFilter, 1, 8));
                    if L_GL_Acc.FindFirst() then begin
                        L_GL_Acc.CalcFields("Debit Amount", "Credit Amount");
                        // BeginningBalance := L_GL_Acc."Net Change";
                        BeginningBalanceDebit := L_GL_Acc."Debit Amount";
                        BeginningBalanceCredit := L_GL_Acc."Credit Amount";
                        BeginBalanceTot := BeginningBalanceDebit - BeginningBalanceCredit;

                        TotalOpeningBalance := TotalOpeningBalance + BeginningBalanceDebit + BeginningBalanceCredit;
                    end;

                    // Ending Amount

                    Clear(L_GL_Acc);
                    L_GL_Acc.SetFilter("No.", "G/L Account"."No.");
                    L_GL_Acc.SetFilter("Date Filter", CopyStr(DateFilter, 11, 18));
                    if L_GL_Acc.FindFirst() then begin
                        L_GL_Acc.CalcFields("Debit Amount", "Credit Amount");
                        if ShowOpening then
                            EndingBalance := -BeginningBalanceCredit + BeginningBalanceDebit + MovementDebit - MovementCredit
                        else
                            EndingBalance := MovementDebit - MovementCredit;
                        TotalEndingBalance += EndingBalance;
                    end;
                end

                // Amounts in ACY

                else begin

                    // Mouvement Amount

                    Clear(L_GL_Acc);
                    L_GL_Acc.SetFilter("No.", "G/L Account"."No.");
                    L_GL_Acc.SetFilter("Date Filter", DateFilter);
                    if L_GL_Acc.FindFirst() then begin
                        //L_GL_Acc.CalcFields("Additional-Currency Net Change");
                        L_GL_Acc.CalcFields("Add.-Currency Debit Amount", "Add.-Currency Credit Amount");
                        MovementDebit := L_GL_Acc."Add.-Currency Debit Amount";
                        MovementCredit := L_GL_Acc."Add.-Currency Credit Amount";
                        if "G/L Account"."Account Type" = AccountTypeEnum::Posting then begin
                            MovementTotalCredit := MovementTotalCredit + MovementCredit;
                            MovementTotalDebit := MovementTotalDebit + MovementDebit;
                        end;
                        TotalMovementBalance := MovementDebit + MovementCredit;
                    end;

                    // Opening Amount

                    Clear(L_GL_Acc);
                    L_GL_Acc.SetFilter("No.", "G/L Account"."No.");
                    L_GL_Acc.SetFilter("Date Filter", '<' + CopyStr(DateFilter, 1, 8));
                    if L_GL_Acc.FindFirst() then begin
                        L_GL_Acc.CalcFields("Add.-Currency Credit Amount", "Add.-Currency Debit Amount");
                        //BeginningBalance := L_GL_Acc."Additional-Currency Net Change";
                        BeginningBalanceCredit := L_GL_Acc."Add.-Currency Credit Amount";
                        BeginningBalanceDebit := L_GL_Acc."Add.-Currency Debit Amount";
                        TotalOpeningBalance := TotalOpeningBalance + BeginningBalanceCredit + BeginningBalanceDebit;
                        BeginBalanceTot := BeginningBalanceDebit - BeginningBalanceCredit;
                    end;

                    // Ending Amount

                    Clear(L_GL_Acc);
                    L_GL_Acc.SetFilter("No.", "G/L Account"."No.");
                    L_GL_Acc.SetFilter("Date Filter", CopyStr(DateFilter, 11, 18));
                    if L_GL_Acc.FindFirst() then begin
                        L_GL_Acc.CalcFields("Add.-Currency Debit Amount", "Add.-Currency Credit Amount");
                        if ShowOpening then
                            EndingBalance := -BeginningBalanceCredit + BeginningBalanceDebit + MovementDebit - MovementCredit
                        else
                            EndingBalance := MovementDebit - MovementCredit;
                        TotalEndingBalance += EndingBalance;
                    end;

                end;

                if BeginBalanceTot < 0 then begin
                    BeginningBalanceDebit := 0;
                    BeginningBalanceCredit := -BeginBalanceTot;
                    if "G/L Account"."Account Type" = AccountTypeEnum::Posting then
                        BeginBalanceTotalCredit := BeginBalanceTotalCredit - BeginBalanceTot
                end
                else begin
                    BeginningBalanceDebit := BeginBalanceTot;
                    BeginningBalanceCredit := 0;
                    if "G/L Account"."Account Type" = AccountTypeEnum::Posting then
                        BeginBalanceTotalDebit := BeginBalanceTotalDebit + BeginBalanceTot
                end;




                if EndingBalance > 0 then begin
                    EndingBalanceDebit := EndingBalance;
                    EndingBalanceCredit := 0;
                    if "G/L Account"."Account Type" = AccountTypeEnum::Posting then
                        EndingBalanceTotalDebit := EndingBalanceTotalDebit + EndingBalance
                end
                else begin
                    EndingBalanceCredit := -EndingBalance;
                    EndingBalanceDebit := 0;
                    if "G/L Account"."Account Type" = AccountTypeEnum::Posting then
                        EndingBalanceTotalCredit := EndingBalanceTotalCredit - EndingBalance
                end;





                if HideNull then begin
                    if (MovementDebit = 0) and (MovementCredit = 0) and (BeginningBalanceCredit = 0) and (BeginningBalanceDebit = 0) and (EndingBalance = 0) then
                        CurrReport.Skip()
                    else begin
                        if ShowOpening = false then begin
                            if (MovementDebit = 0) and (MovementCredit = 0) and (EndingBalance = 0) then
                                CurrReport.Skip()
                        end;
                    end;
                end;


                if ChangeGroupNo then begin
                    PageGroupNo += 1;
                    ChangeGroupNo := false;
                end;

                ChangeGroupNo := "New Page";
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 0;
                ChangeGroupNo := false;
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
                group(Options)
                {
                    field(HideNull; HideNull)
                    {
                        ApplicationArea = all;
                        Caption = 'Hide Empty Lines';
                    }
                    field(ShowinACY; ShowinACY)
                    {
                        ApplicationArea = all;
                        Caption = 'Show Amounts in ACY';
                    }
                    field("Show opening balance"; ShowOpening)
                    {
                        ApplicationArea = all;
                        Caption = 'With Opening Balance';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin

        GLS.Get();
        CompanyInformation.Get();
        CompanyAddress := CompanyInformation.Address + ' ' + CompanyInformation."Address 2";
        CompanyInformation.CalcFields(Picture);

        TotalOpeningBalance := 0;
        TotalMovementBalance := 0;
        TotalEndingBalance := 0;

        "G/L Account".SecurityFiltering(SecurityFilter::Filtered);
        GLFilter := "G/L Account".GetFilters();
        PeriodText := "G/L Account".GetFilter("Date Filter");

        if StrLen("G/L Account".GetFilter("Date Filter")) < 17 then
            Error('Date filter must be filled');

        FromDate := CopyStr("G/L Account".GetFilter("Date Filter"), 1, 8);
        ToDate := CopyStr("G/L Account".GetFilter("Date Filter"), 11, 18);

        if not ShowinACY then
            AmountsInText := 'Amounts are in ' + GLS."LCY Code"
        else
            AmountsInText := 'Amounts are in ' + GLS."Additional Reporting Currency";
        TimeNow := Format(System.CurrentDateTime());
    end;

    var
        AccountTypeEnum: Enum "G/L Account Type";
        ShowOpening: Boolean;
        TotalOpeningBalance: Decimal;
        TotalMovementBalance: Decimal;
        TotalEndingBalance: Decimal;
        ShowinACY: Boolean;
        MovementDebit: Decimal;
        BeginBalanceTot: Decimal;
        MovementCredit: Decimal;
        EndingBalanceCredit: Decimal;
        PrintedOnLabel: Label 'Printed On:';
        EndingBalanceDebit: Decimal;
        BeginningBalanceDebit: Decimal;
        BeginningBalanceCredit: Decimal;
        HideNull: Boolean;
        TotalCaption: Label 'Total';
        CapitalLabel: Label 'Capital';
        VATCodeLabel: Label 'VAT Code';
        AddressLabel: Label 'Address';
        BankAccountLabel: Label 'Bank Account';
        SWIFTLabel: Label 'SWIFT';
        CompanyAddress: Text[250];
        CompanyInformation: Record "Company Information";
        Text000: Label 'Period: %1';
        PeriodText: Text[30];
        FromDateLbl: Label 'From Date : ';
        ToDateLbl: Label 'To Date : ';
        Trial_BalanceCaptionLbl: Label 'Trial Balance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Net_ChangeCaptionLbl: Label 'Begining Balance';
        BalanceCaptionLbl: Label 'Movement';
        EndingBalanceCaption: Label 'Ending Balance';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: Label 'Name';
        G_L_Account___Net_Change_CaptionLbl: Label 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: Label 'Credit';
        G_L_Account___Balance_at_Date_CaptionLbl: Label 'Debit';
        G_L_Account___Balance_at_Date__Control24CaptionLbl: Label 'Credit';
        PageGroupNo: Integer;
        ChangeGroupNo: Boolean;
        BlankLineNo: Integer;
        //BeginningBalance: Decimal;
        //MovementBalance: Decimal;
        BeginBalanceTotalDebit: Decimal;
        BeginBalanceTotalCredit: Decimal;
        EndingBalanceTotalDebit: Decimal;
        EndingBalanceTotalCredit: Decimal;
        MovementTotalDebit: Decimal;
        MovementTotalCredit: Decimal;
        EndingBalance: Decimal;
        FromDate: Text;
        PageLabel: Label 'Page';
        OfLabel: Label 'of';
        ToDate: Text;
        GLS: Record "General Ledger Setup";
        AmountsInText: Text;
        TimeNow: Text[25];

    protected var
        GLFilter: Text;
}
