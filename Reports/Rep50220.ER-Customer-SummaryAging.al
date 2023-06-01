report 50220 "ER - Customer - Summary Aging"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports Layouts/ER-CustomerSummaryAging.rdl';
    ApplicationArea = All;
    Caption = 'ER - Customer - Summary Aging';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(TempCurrency; "AC Currency Total")
        {
            DataItemTableView = SORTING(CurrencyCode);

            #region Customer


            column(CustNoLabel; CustNoLabel) { }
            column(CustomerNoFilter; CustomerNoFilter) { }
            column(CurrLabel; CurrLabel) { }
            column(NoLabel; NoLabel) { }
            column(NameLabel; NameLabel) { }
            column(Name2Label; Name2Label) { }
            column(SLPLabel; SLPLabel) { }
            column(today; TestDateTime) { }
            column(CustSumAgingLabel; CustSumAgingLabel) { }
            column(GenBusPostGrpFilterLabel; GenBusPostGrpFilterLabel) { }
            column(GenBusPostGrpLabel; GenBusPostGrpLabel) { }

            column(CityPostal; CityPostal) { }
            column(CapitalLabel; CapitalLabel) { }
            column(VatCodeLabel; VatCodeLabel) { }
            column(TelLabel; TelLabel) { }
            column(EmailLabel; EmailLabel) { }
            column(fullypaidLabel; fullypaidLabel) { }
            column(Company_Email; CompanyInformation."E-Mail") { }
            column(LCY; GenLedgerSetup."LCY Code") { }

            column(Company_Address; CompanyAddress) { }
            column(Company_Address_2; CompanyInformation."Address 2") { }
            column(Company_Bank_Account; CompanyInformation."Bank Name") { }
            column(Company_SWIFT; CompanyInformation."SWIFT Code") { }
            column(Company_IBAN; CompanyInformation.IBAN) { }
            column(AddressLabel; AddressLabel) { }
            column(Company_Picture; CompanyInformation.Picture) { }
            column(Company_Capital; CompanyInformation.Capital) { }
            column(Company_Vat; CompanyInformation."VAT Registration No.") { }
            column(Comapny_Phone; CompanyInformation."Phone No.") { }

            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY) { }

            column(PeriodStartDate_2_; Format(PeriodStartDate[2]))
            {
            }
            column(PeriodStartDate_3_; Format(PeriodStartDate[3]))
            {
            }
            column(PeriodStartDate_4_; Format(PeriodStartDate[4]))
            {
            }
            column(PeriodStartDate_5_; Format(PeriodStartDate[5]))
            {
            }
            column(PeriodStartDate_3_1; Format(PeriodStartDate[3] - 1))
            {
            }
            column(PeriodStartDate_4_1; Format(PeriodStartDate[4] - 1))
            {
            }
            column(PeriodStartDate_5_1; Format(PeriodStartDate[5] - 1))
            {
            }
            column(PeriodStartDate_6_1; Format(PeriodStartDate[6] - 1))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Balance_DueCaption; Balance_DueCaptionLbl)
            {
            }

            column(CustBalanceDue_1_Caption; CustBalanceDue_1_CaptionLbl)
            {
            }

            column(CustBalanceDue_6_Caption; CustBalanceDue_6_CaptionLbl)
            {
            }
            column(LineTotalCustBalanceCaption; LineTotalCustBalanceCaptionLbl)
            {
            }
            column(Total_LCY_Caption; Total_LCY_CaptionLbl)
            {
            }
            column(PrintLine; PrintLine)
            {
            }

            column(CurrencyCodeVar; CurrencyCodeVar) { }
            //Footer
            column(FormNumberLabel; FormNumberLabel) { }
            column(FormNumberValueLabel; FormNumberValueLabel) { }
            column(IssueDateLabel; IssueDateLabel) { }
            column(IssueDateValueLabel; IssueDateValueLabel) { }
            column(RevisionDateLabel; RevisionDateLabel) { }




            column(PeriodStartDateFilter; PeriodStartDate[2]) { }
            column(PeriodLengthFilter; PeriodLength) { }
            column(PrintAmountsInLCYFilter; PrintAmountsInLCY) { }
            column(StartingDateLabel; StartingDateLabel) { }
            column(PeriodLengthLabel; PeriodLengthLabel) { }
            column(PrintAmountinLCYLabel; PrintAmountinLCYLabel) { }
            column(BalanceDueLabel; BalanceDueLabel) { }
            column(AmountLabel; AmountLabel) { }
            column(AmountLCYLabel; AmountLCYLabel) { }
            column(totalLabel; totalLabel) { }
            #endregion

            dataitem(Customer; Customer)
            {
                RequestFilterFields = "No.", "Gen. Bus. Posting Group";

                column(CustomerPostingGroupFilter; CustomerPostingGroupFilter)
                {
                }


                column(Customer_Name; Name)
                {
                }
                column(Customer_No_; "No.")
                {
                }
                column(Name_2; "Name 2") { }
                column(Customer_Name_Control74; Name)
                {
                }
                column(SLP_Name; SLP_Name) { }
                column(Customer_No_Control75; "No.")
                {
                }
                //column(CustomertotLCY; CustomertotLCY) { }

                column(LineTotalCustBalance; LineTotalCustBalance)
                {
                    AutoFormatExpression = TempCurrency.CurrencyCode;
                    AutoFormatType = 1;
                }
                column(LineTotalCustBalanceLCY; LineTotalCustBalanceLCY)
                {
                    AutoFormatExpression = TempCurrency.CurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_6; CustBalanceDue[6])
                {
                    AutoFormatExpression = TempCurrency.CurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_5; CustBalanceDue[5])
                {
                    AutoFormatExpression = TempCurrency.CurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_4; CustBalanceDue[4])
                {
                    AutoFormatExpression = TempCurrency.CurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_3; CustBalanceDue[3])
                {
                    AutoFormatExpression = TempCurrency.CurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_2; CustBalanceDue[2])
                {
                    AutoFormatExpression = TempCurrency.CurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_1; CustBalanceDue[1])
                {
                    AutoFormatExpression = TempCurrency.CurrencyCode;
                    AutoFormatType = 1;
                }
                column(PostingGRP; "Gen. Bus. Posting Group") { }

                column(CustBalanceDueLCY_1; CustBalanceDueLCY[1]) { }
                column(CustBalanceDueLCY_2; CustBalanceDueLCY[2]) { }
                column(CustBalanceDueLCY_3; CustBalanceDueLCY[3]) { }
                column(CustBalanceDueLCY_4; CustBalanceDueLCY[4]) { }
                column(CustBalanceDueLCY_5; CustBalanceDueLCY[5]) { }
                column(CustBalanceDueLCY_6; CustBalanceDueLCY[6]) { }

                trigger OnAfterGetRecord()//Do calculation based on Customer ans currency code
                var
                begin
                    if PrintAmountsInLCY then begin
                        CurrencyCodeVar := GenLedgerSetup."LCY Code";
                    end
                    else
                        if TempCurrency.CurrencyCode = '''''' then
                            CurrencyCodeVar := GenLedgerSetup."LCY Code"
                        else
                            CurrencyCodeVar := TempCurrency.CurrencyCode;
                    PrintLine := false;
                    LineTotalCustBalance := 0;
                    LineTotalCustBalanceLCY := 0;
                    DtldCustLedgEntry.Reset();
                    DtldCustLedgEntry.SetRange("Customer No.", Customer."No.");
                    //DtldCustLedgEntry.SetRange("Initial Entry Due Date", PeriodStartDate[1], PeriodStartDate[7] - 1);
                    DTldCustLedgEntry.SetRange("Currency Code", TempCurrency.CurrencyCode);
                    if DtldCustLedgEntry.IsEmpty() then
                        CurrReport.Skip();


                    for i := 1 to 6 do begin
                        DtldCustLedgEntry.Reset();
                        DtldCustLedgEntry.SetCurrentKey("Customer No.", "Initial Entry Due Date");//"Currency Code"
                        DtldCustLedgEntry.SetRange("Customer No.", Customer."No.");
                        DtldCustLedgEntry.SetRange("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                        DTldCustLedgEntry.SetRange("Currency Code", TempCurrency.CurrencyCode);
                        DtldCustLedgEntry.CalcSums(Amount);
                        DtldCustLedgEntry.CalcSums("Amount (LCY)");

                        CustBalanceDue[i] := DtldCustLedgEntry."Amount";
                        CustBalanceDueLCY[i] := DtldCustLedgEntry."Amount (LCY)";

                        //CustomertotLCY := CustomertotLCY + CustBalanceDue[i];
                        if CustBalanceDueLCY[i] <> 0 then
                            PrintLine := true;
                        LineTotalCustBalance := LineTotalCustBalance + DtldCustLedgEntry."Amount";
                        LineTotalCustBalanceLCY := LineTotalCustBalanceLCY + DtldCustLedgEntry."Amount (LCY)";
                    end;
                    if Customer."Salesperson Code" <> '' then begin
                        SLP.get(Customer."Salesperson Code");
                        if SLP.Name <> '' then
                            SLP_Name := SLP.Name
                        else
                            SLP_Name := ' ';
                    end
                    else
                        SLP_Name := ' ';

                    if not PrintLine then
                        CurrReport.Skip();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //clear(TotalLineALLCurrency);
                //clear(CustBalanceDue);

                DtldCustLedgEntry.Reset();
                if Customer.GetFilter("No.") <> '' then begin
                    CustomerNoFilter := Customer.GetFilter("No.");
                    DtldCustLedgEntry.SetRange("Customer No.", Customer.GetFilter("No."))
                end
                else
                    CustomerNoFilter := '';
                    

                if Customer.getFilter("Gen. Bus. Posting Group") <> '' then begin
                    CustomerPostingGroupFilter := Customer.getFilter("Gen. Bus. Posting Group")
                end
                else
                    CustomerPostingGroupFilter := '';
                DtldCustLedgEntry.SetRange("Currency Code", tempcurrency.currencycode);
                if DtldCustLedgEntry.IsEmpty() then
                    CurrReport.Skip();
                
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
                group(Options)
                {
                    Caption = 'Options';
                    field(StartingDate; PeriodStartDate[2])
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the date for the beginning of the period covered by the report.';

                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period Length';
                        ToolTip = 'Specifies the length of each of the four periods. For example, enter "1M" for one month.';
                    }
                    field(ShowAmountsInLCY; PrintAmountsInLCY)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Amounts in LCY';
                        ToolTip = 'Specifies that you want amounts in the report to be displayed in LCY. Leave this field blank if you want to see amounts in foreign currencies.';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if PeriodStartDate[2] = 0D then
                PeriodStartDate[2] := WorkDate();
            if Format(PeriodLength) = '' then
                Evaluate(PeriodLength, '<1M>');
        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if CloseAction = Action::Cancel then begin
                exit(true);
            end
            else begin
                if PeriodStartDate[2] = 0D then begin
                    Error(Text002);
                end;
                if Format(PeriodLength) = '' then
                    Error(Text003)

            end;
            exit(true);
        end;

    }

    trigger OnInitReport()
    begin
        TestDateTime := CurrentDateTime;
    end;

    procedure PopulateACCurrency()//Used to populate the temp table with the currency codes grom the Currencies Table
    begin
        G_RecCurrency.Reset();
        if G_RecCurrency.FindFirst() then
            repeat
                TempCurrency.Reset();
                TempCurrency.CurrencyCode := G_RecCurrency.Code;
                if TempCurrency.Insert() then;
            until G_RecCurrency.Next() = 0;
        TempCurrency.Init();
        TempCurrency.CurrencyCode := '''''';
        if TempCurrency.Insert() then;
    end;


    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin
        CompanyInformation.Get();
        CompanyAddress := CompanyInformation.Address;
        CityPostal := CompanyInformation.City + ' ' + CompanyInformation."Post Code";
        CompanyInformation.CalcFields(Picture);
        GenLedgerSetup.get();
        for i := 3 to 6 do
            PeriodStartDate[i] := CalcDate(PeriodLength, PeriodStartDate[i - 1]);
        PeriodStartDate[7] := DMY2Date(31, 12, 9999);
        PopulateACCurrency();
    end;


    var
        CompanyInformation: Record "Company Information";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        SLP: Record "Salesperson/Purchaser";
        SLP_Name: Text[50];
        PeriodLength: DateFormula;
        G_RecCurrency: Record Currency;
        GenLedgerSetup: Record "General Ledger Setup";
        CompanyAddress: Text;
        CityPostal: Text;
        CustFilter: Text;
        TestDateTime: DateTime;
        AddressLabel: Label 'Address:';
        CapitalLabel: Label 'Capital';
        VatCodeLabel: Label 'VAT Code: ';
        TelLabel: Label 'T:';
        EmailLabel: Label 'E:';
        CurrencyCodeVar: Code[10];
        PrintAmountsInLCY: Boolean;
        PeriodStartDate: array[7] of Date;
        CustBalanceDue: array[6] of Decimal;
        CustBalanceDueLCY: array[6] of Decimal;
        LineTotalCustBalance: Decimal;
        LineTotalCustBalanceLCY: Decimal;
        stackFilter: Array[5] of text;
        PrintLine: Boolean;
        //CustomertotLCY: Decimal;
        i: Integer;
        Customer_Summary_AgingCaptionLbl: Label 'Customer - Summary Aging';
        BalanceDueLabel: Label 'Balance Due';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Balance_DueCaptionLbl: Label 'Balance Due';
        CustBalanceDue_1_CaptionLbl: Label '...Before';
        CustBalanceDue_6_CaptionLbl: Label 'After...';
        LineTotalCustBalanceCaptionLbl: Label 'Balance';
        Total_LCY_CaptionLbl: Label 'Total (LCY)';
        CurrLabel: Label 'Cur';
        NoLabel: Label 'No.';
        NameLabel: Label 'Name';
        Name2Label: Label 'Name 2';
        SLPLabel: label 'Sales Person Name';

        CustSumAgingLabel: Label 'Customer-Summary Aging';

        //Footer
        FormNumberLabel: label 'Form #: ';
        FormNumberValueLabel: Label 'ER\LB\AVER\ACCT-C.SA\100';
        IssueDateLabel: Label 'Issue Date: ';
        IssueDateValueLabel: Label 'Jan 2023';
        RevisionDateLabel: label 'Revision Date/#:';


        // Request page filters
        CustomerNoFilter: Text;
        CustomerPostingGroupFilter: Text;
        //// Labels


        //CustomerFilters:Text;
        StartingDateLabel: Label 'Start Date: ';
        PeriodLengthLabel: Label 'Period Length: ';
        PrintAmountinLCYLabel: Label 'Print Amounts in LCY: ';
        GenBusPostGrpFilterLabel: Label 'Gen. Bus. Post. Grp: ';
        GenBusPostGrpLabel: Label 'Gen. Bus. Post. Grp';


        Text002: Label 'Please Select a Starting Date.';
        Text003: Label 'Please Insert Period Length';
        fullypaidLabel: Label 'Fully Paid';



        //Currency table in RDLC
        AmountLabel: Label 'Amount';
        AmountLCYLabel: Label 'Amount LCY';
        totalLabel: Label 'TOTAL ';
        CustNoLabel: Label 'No.: ';
}


