report 50221 "ER - Vendor - Summary Aging"
{
    ApplicationArea = All;
    Caption = 'ER - Vendor - Summary Aging';
    UsageCategory = ReportsAndAnalysis;

    DefaultLayout = RDLC;
    RDLCLayout = './Reports Layouts/ER-VendorSummaryAging.rdlc';
    dataset
    {
        dataitem(G_TmpRecCurr; "AC Currency Total")
        {
            //PrintOnlyIfDetail = true;
            DataItemTableView = sorting(CurrencyCode);
            #region Columns of Currency
            column(CurrencyCode; CurrencyCode) { }
            // Column(Total; Total) { }
            column(ForeignCurrency_1; ForeignPerCurrency[1]) { }
            column(ForeignCurrency_2; ForeignPerCurrency[2]) { }
            column(ForeignCurrency_3; ForeignPerCurrency[3]) { }
            column(ForeignCurrency_4; ForeignPerCurrency[4]) { }
            column(ForeignCurrency_5; ForeignPerCurrency[5]) { }
            column(ForeignCurrency_6; ForeignPerCurrency[6]) { }
            column(PeriodStartDate_2; Format(PeriodStartDate[2])) { }
            column(PeriodStartDate_3; Format(PeriodStartDate[3])) { }
            column(PeriodStartDate_4; Format(PeriodStartDate[4])) { }
            column(PeriodStartDate_5; Format(PeriodStartDate[5])) { }
            column(PeriodEndDate_2; Format(PeriodStartDate[3] - 1)) { }
            column(PeriodEndDate_3; Format(PeriodStartDate[4] - 1)) { }
            column(PeriodEndDate_4; Format(PeriodStartDate[5] - 1)) { }
            column(PeriodEndDate_5; Format(PeriodStartDate[6] - 1)) { }
            column(PrintLine; PrintLine) { }
            //Labels
            Column(CityAndZip; CityAndZip) { }
            Column(CompanyAddress; CompanyAddress) { }
            Column(CustomerSummaryAgingLabel; VendorSummaryAgingLabel) { }
            Column(Capital_Label; Capital_Label) { }
            Column(AddressLabel; AddressLabel) { }
            Column(TLabel; TLabel) { }
            Column(ELabel; ELabel) { }
            Column(VATCodeLabel; VATCodeLabel) { }
            Column(BalanceDueLabel; BalanceDueLabel) { }
            Column(CurrencyLabel; CurrencyLabel) { }
            Column(GenBusPostGrpLabel; GenBusPostGrpLabel) { }
            Column(BeforeLabel; BeforeLabel) { }
            Column(AfterLabel; AfterLabel) { }
            Column(BalanceLabel; BalanceLabel) { }
            Column(VendorNoLabel; VendorNoLabel) { }
            Column(NameLabel; NameLabel) { }
            Column(Name2Label; Name2Label) { }
            Column(FormNoLabel; FormNoLabel) { }
            Column(IssueDateLabel; IssueDateLabel) { }
            Column(RevisionDateLabel; RevisionDateLabel) { }
            Column(FormNo; FormNo) { }
            column(IssueDate; IssueDate) { }
            Column(TotalLCYLabel; TotalLCYLabel) { }
            Column(TotalLabel; TotalLabel) { }
            column(Company_Picture; CompanyInformation.Picture) { }
            column(Company_Capital; CompanyInformation.Capital) { }
            column(Company_Vat; CompanyInformation."VAT Registration No.") { }
            column(Comapny_Phone; CompanyInformation."Phone No.") { }
            column(Company_Email; CompanyInformation."E-Mail") { }
            column(Company_Address; CompanyInformation.Address) { }
            column(Company_Address2; CompanyInformation."Address 2") { }
            column(Company_Bank_Account; CompanyInformation."Bank Name") { }
            column(Company_SWIFT; CompanyInformation."SWIFT Code") { }
            column(Company_IBAN; CompanyInformation.IBAN) { }
            column(Company_CityAndZip; CityAndZip) { }
            column(FullyPaidLabel; FullyPaidLabel) { }
            column(LCY_Code; G_GnrlLedgSetup."LCY Code") { }
            //Filters
            column(StartDateLabel; StartDateLabel) { }
            column(PeriodLengthLabel; PeriodLengthLabel) { }
            column(PrintAmountsInLCYLabel; PrintAmountsInLCYLabel) { }
            column(PeriodStartDate; PeriodStartDate[2]) { }
            column(PeriodLength; PeriodLength) { }
            column(PrintAmountsInLCY; PrintAmountsInLCY) { }
            column(AllFilters; AllFilters) { }
            column(G_SelectedGenBusPostingGrp; G_SelectedGenBusPostingGrp) { }
            column(G_OuterCurr; G_OuterCurr) { }

            #endregion
            dataitem(Vendor; Vendor)
            {
                RequestFilterFields = "No.", "Gen. Bus. Posting Group";
                #region Colums of Vendor
                column(VendorNo; "No.") { }
                column(Name; Name) { }
                column(Name2; "Name 2") { }
                column(GenBusPostingGroup; "Gen. Bus. Posting Group") { }
                column(G_CurrentCurr; G_CurrentCurr) { }
                column(G_LineBalance; G_LineBalance) { }
                column(G_LineBalanceLCY; G_LineBalanceLCY) { }
                column(CustBalanceDue_1; CustBalanceDue[1]) { }
                column(CustBalanceDue_2; CustBalanceDue[2]) { }
                column(CustBalanceDue_3; CustBalanceDue[3]) { }
                column(CustBalanceDue_4; CustBalanceDue[4]) { }
                column(CustBalanceDue_5; CustBalanceDue[5]) { }
                column(CustBalanceDue_6; CustBalanceDue[6]) { }
                column(CustBalanceDueLCY_1; CustBalanceDueLCY[1]) { }
                column(CustBalanceDueLCY_2; CustBalanceDueLCY[2]) { }
                column(CustBalanceDueLCY_3; CustBalanceDueLCY[3]) { }
                column(CustBalanceDueLCY_4; CustBalanceDueLCY[4]) { }
                column(CustBalanceDueLCY_5; CustBalanceDueLCY[5]) { }
                column(CustBalanceDueLCY_6; CustBalanceDueLCY[6]) { }
                column(TotalPerPeriod_1; TotalPerPeriod[1]) { }
                column(TotalPerPeriod_2; TotalPerPeriod[2]) { }
                column(TotalPerPeriod_3; TotalPerPeriod[3]) { }
                column(TotalPerPeriod_4; TotalPerPeriod[4]) { }
                column(TotalPerPeriod_5; TotalPerPeriod[5]) { }
                column(TotalPerPeriod_6; TotalPerPeriod[6]) { }
                #endregion
                trigger OnAfterGetRecord()//after get vendor
                begin
                    //Getting LCY code
                    if PrintAmountsInLCY = true then
                        G_CurrentCurr := G_GnrlLedgSetup."LCY Code"
                    else begin
                        if G_TmpRecCurr.CurrencyCode = '''''' then
                            g_currentcurr := G_GnrlLedgSetup."LCY Code"
                        else
                            g_currentcurr := G_TmpRecCurr.CurrencyCode;
                    end;
                    G_DtldVendorLedgEntry.Reset();
                    G_DtldVendorLedgEntry.SetRange("Currency Code", G_TmpRecCurr.CurrencyCode);
                    G_DtldVendorLedgEntry.SetRange("Vendor No.", "No.");
                    if not G_DtldVendorLedgEntry.FindSet() then//if there is no entry for the vendor then skip the vendor
                        CurrReport.Skip();
                    PrintLine := true;
                    //calculate each line
                    G_LineBalance := 0;
                    G_LineBalanceLCY := 0;
                    for i := 1 to 6 do begin//looping through the periods
                        G_DtldVendorLedgEntry.Reset();
                        G_DtldVendorLedgEntry.SetCurrentKey("Vendor No.", "Initial Entry Due Date");
                        G_DtldVendorLedgEntry.SetRange("Vendor No.", vendor."No.");
                        G_DtldVendorLedgEntry.SetRange("Currency Code", G_TmpRecCurr.CurrencyCode);
                        G_DtldVendorLedgEntry.SetRange("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                        G_DtldVendorLedgEntry.CalcSums("Amount");
                        G_DtldVendorLedgEntry.CalcSums("Amount (LCY)");
                        CustBalanceDue[i] := G_DtldVendorLedgEntry."Amount";
                        CustBalanceDueLCY[i] := G_DtldVendorLedgEntry."Amount (LCY)";
                        G_LineBalance := G_LineBalance + CustBalanceDue[i];
                        G_LineBalanceLCY := G_LineBalanceLCY + CustBalanceDueLCY[i];
                    end;
                    if G_LineBalanceLCY = 0 then//if the line balance is zero then skip the line in report builder
                        PrintLine := false
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if G_TmpRecCurr.CurrencyCode = '''''' then
                    G_OuterCurr := G_GnrlLedgSetup."LCY Code"
                else
                    G_OuterCurr := G_TmpRecCurr.CurrencyCode;
                G_DtldVendorLedgEntry.Reset();
                G_DtldVendorLedgEntry.SetRange("Currency Code", CurrencyCode);
                if g_DtldVendorLedgEntry.IsEmpty() then//if there is no entry for the vendor then skip the vendor
                    CurrReport.Skip();
                Clear(ForeignPerCurrency);
                for i := 1 to 6 do begin//looping through the periods
                    G_DtldVendorLedgEntry.Reset();
                    G_DtldVendorLedgEntry.SetCurrentKey("Vendor No.", "Currency Code", "Initial Entry Due Date");
                    if vendor.GetFilter("No.") <> '' then
                        G_DtldVendorLedgEntry.SetRange("Vendor No.", vendor.GetFilter("No."));

                    //!! Problem HERE !!
                    // if vendor.GetFilter("Gen. Bus. Posting Group") <> '' then
                    //     G_DtldVendorLedgEntry.SetRange("Gen. Bus. Posting Group", vendor.GetFilter("Gen. Bus. Posting Group"));
                    //!! Problem HERE !!

                    G_DtldVendorLedgEntry.SetRange("Currency Code", CurrencyCode);
                    G_DtldVendorLedgEntry.SetRange("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                    G_DtldVendorLedgEntry.CalcSums("Amount");
                    ForeignPerCurrency[i] := ForeignPerCurrency[i] + G_DtldVendorLedgEntry."Amount";
                end;

            end;

        }

    }

    requestpage
    {
        SaveValues = TRUE;
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    Caption = 'Filters';
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
                        ToolTip = 'Specifies that you want amounts in the report to be displayed in LCY. Leave this field unchecked if you want to see amounts in foreign currencies.';
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

        trigger OnClosePage()
        begin
            AllFilters := Vendor.GetFilter("No.");
            G_SelectedGenBusPostingGrp := Vendor.GetFilter("Gen. Bus. Posting Group");
        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean//Check if the user has selected a starting date and period length before running the report
        begin
            if CloseAction <> Action::Cancel then begin
                if PeriodStartDate[2] = 0D then
                    Error(Text001)
                else
                    if Format(PeriodLength) = '' then
                        Error(Text002);
                exit(true);
            end;
        end;
    }

    trigger OnPreReport()
    begin
        //Fill temporary table with currencies
        G_GnrlLedgSetup.get();
        CompanyInformation.Get();
        CityAndZip := companyInformation.City + ' ' + CompanyInformation."Post Code";
        CompanyInformation.CalcFields(Picture);

        G_TmpRecCurr.Init();
        G_TmpRecCurr.CurrencyCode := '''''';
        if G_TmpRecCurr.Insert() then;
        if G_RecCurr.FindFirst() then
            repeat
                G_TmpRecCurr.Init();
                G_TmpRecCurr.CurrencyCode := G_RecCurr.Code;
                if G_TmpRecCurr.Insert() then;
            until G_RecCurr.Next() = 0;
        //Fill period start dates
        for i := 3 to 6 do
            PeriodStartDate[i] := CalcDate(PeriodLength, PeriodStartDate[i - 1]);
        PeriodStartDate[7] := DMY2Date(31, 12, 9999);

    end;

    var
        G_RecCurr: Record Currency;
        G_GnrlLedgSetup: Record "General Ledger Setup";
        G_DtldVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        CompanyInformation: Record "Company Information";
        PeriodStartDate: array[7] of Date;
        CustBalanceDue: array[6] of Decimal;
        CustBalanceDueLCY: array[6] of Decimal;
        TotalPerPeriod: array[6] of Decimal;
        ForeignPerCurrency: array[6] of Decimal;
        G_CurrentCurr: code[10];
        G_OuterCurr: code[10];

        G_DictCurr: Dictionary of [code[10], List of [Decimal]];
        G_LineBalance: Decimal;
        G_LineBalanceLCY: Decimal;
        PeriodLength: DateFormula;
        PrintAmountsInLCY: Boolean;
        i: Integer;
        PrintLine: Boolean;//to check wether to skip the line or not
        #region Labels
        //Header
        CityAndZip: Text[250];
        CompanyAddress: Text[250];
        VendorSummaryAgingLabel: Label 'Vendor-Summary Aging';
        Capital_Label: Label 'Capital';
        VendorNoLabel: Label 'Vendor No';
        AddressLabel: Label 'Address';
        TLabel: Label 'T:';
        ELabel: Label 'E:';
        VATCodeLabel: Label 'VAT Code';
        BalanceDueLabel: Label 'Balance Due';
        FullyPaidLabel: Label 'Fully Paid';
        StartDateLabel: Label 'Start Date: ';
        PeriodLengthLabel: Label 'Period Length: ';
        PrintAmountsInLCYLabel: Label 'Print Amounts in LCY: ';
        AllFilters: Text[250];
        G_SelectedGenBusPostingGrp: Code[20];
        //Body
        GenBusPostGrpLabel: Label 'Gen. Bus. Post. Grp';
        CurrencyLabel: Label 'Curr.';
        BeforeLabel: Label '...Before';
        AfterLabel: Label 'After...';
        BalanceLabel: Label 'Balance';
        NameLabel: Label 'Name';
        Name2Label: Label 'Name 2';
        TotalLCYLabel: Label 'Total of all currencies in (LCY)';
        TotalLabel: label 'TOTAL';
        //Footer
        FormNoLabel: Label 'Form #';
        IssueDateLabel: Label 'Issue Date';
        RevisionDateLabel: Label 'Revision Date/#';
        FormNo: Label 'ER\LB\AVER\ACCT-V.SA\100';
        IssueDate: Label 'Jan 2023';
        // EOF Labels
        Text001: Label 'Please Select Starting Date.';
        Text002: Label 'Please Insert Period Length.';
    #endregion
}
