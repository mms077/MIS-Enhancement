report 50211 "ER - Receipt Voucher"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-ReceiptVoucher.rdlc';
    Caption = 'Receipt Voucher';
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            //RequestFilterFields = "Document No.";
            RequestFilterFields = "Document No.";
            #region //CompanyInformation
            column(Company_Picture; CompanyInformation.Picture)
            {

            }
            column(Company_Capital; CompanyInformation.Capital)
            {

            }
            column(City_CR; City_CR)
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
            column(LCY_Code; GeneralLedgerSetup."LCY Code")
            {

            }
            column(MOF_Recipt_No; GeneralLedgerSetup."MOF Receipt")
            {

            }
            #endregion

            #region //G/L Entry
            column(GL_DocumentNo; "G/L Entry"."Document No.")
            {

            }
            column(GL_Description; "G/L Entry"."Description")
            {

            }

            column(AmountinWords; AmountinWords)
            {

            }
            column(NetTotal; NetTotal)
            {

            }
            column(NetTotalLCY; NetTotalLCY)
            {

            }
            column(CL_CurrencyCode; GlobalCurrencyCode)
            {

            }
            column(TotalVATAmount; VATAmount)
            {

            }
            column(CL_ReceivedFrom; GlobalCustomer.Name)
            {

            }
            column(CL_BillingAddress; BillingAddress)
            {

            }
            column(CL_MOF; MOF)
            {

            }
            column(CL_DateOfIssue; "Cust. Ledger Entry"."Posting Date")
            {

            }
            column(CL_Project; "Cust. Ledger Entry"."Global Dimension 1 Code")
            {

            }

            column(BillNumber; BillNumber)
            {

            }
            column(BarCodeText; BarCodeText)
            {

            }
            column(VATPercentage; VATPercentage)
            {

            }
            column(ShowStamp; ShowStamp)
            {

            }
            #endregion

            #region //Labels
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

            column(PrintedOnLabel; PrintedOnLabel)
            {

            }

            column(IssuedateLabel; IssuedateLabel)
            {

            }

            column(RevisionDateLabel; RevisionDateLabel)
            {

            }

            column(ReceiptLabel; ReceiptLabel)
            {

            }

            column(ReceivedFromLabel; ReceivedFromLabel)
            {

            }

            column(BillingAddressLabel; BillingAddressLabel)
            {

            }

            column(MOFLabel; MOFLabel)
            {

            }

            column(DateOfIssueLabel; DateOfIssueLabel)
            {

            }

            column(ProjectLabel; ProjectLabel)
            {

            }

            column(BillNumberLabel; BillNumberLabel)
            {

            }

            column(TotalAmountLabel; TotalAmountLabel)
            {

            }

            column(DescriptionLabel; DescriptionLabel)
            {

            }

            column(AmountLabel; AmountLabel)
            {

            }

            column(CurrencyCodeLabel; CurrencyCodeLabel)
            {

            }

            column(VATLabel; VATLabel)
            {

            }

            column(NetTotalLabel; NetTotalLabel)
            {

            }
            column(MOFReceiptLabel; MOFReceiptLabel)
            {

            }
            column(IncludedLabel; IncludedLabel) { }
            #endregion
            column(VAT_Percentage;VAT_Percentage)
            {

            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Entry No." = FIELD("Entry No.");
                #region //Customer Ledger Entries

                column(CL_Description; "Cust. Ledger Entry".Description)
                {

                }
                column(CL_Amount; "Cust. Ledger Entry".Amount)
                {

                }
                #endregion
                //Customer Ledger Entry Trigger
                trigger OnAfterGetRecord()
                var
                    GeneralLedgerSetup: Record "General Ledger Setup";
                begin
                    Clear(GeneralLedgerSetup);
                    GeneralLedgerSetup.Get();
                    Clear(GlobalCustomer);
                    Clear(BillingAddress);
                    if GlobalCustomer.Get("Cust. Ledger Entry"."Customer No.") then begin
                        BillingAddress := GlobalCustomer.Address + '' + GlobalCustomer."Address 2";
                        if GlobalCustomer."VAT Registration No." <> '' then
                            MOF := GlobalCustomer."VAT Registration No."
                        else
                            MOF := GlobalCustomer."CR No.";
                    end;

                    Clear(BarCodeText);
                    BarCodeText := "Cust. Ledger Entry"."Customer No." + '+' + "Cust. Ledger Entry"."Document No.";

                    "Cust. Ledger Entry".CalcFields(Amount, "Amount (LCY)");
                    NetTotal := NetTotal + ("Cust. Ledger Entry".Amount);
                    NetTotalLCY := NetTotalLCY + ("Cust. Ledger Entry"."Amount (LCY)");
                    Clear(GlobalCurrencyCode);
                    if "Cust. Ledger Entry"."Currency Code" = '' then
                        GlobalCurrencyCode := GeneralLedgerSetup."LCY Code"
                    else
                        GlobalCurrencyCode := "Cust. Ledger Entry"."Currency Code";

                    //Amount in Words
                    AmountInWordsFunction(NetTotal * -1, "Currency Code");
                end;
            }
            dataitem("VAT Entry"; "VAT Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                #region //VAT Entry
                column(VATEntry_Amount; "VAT Entry".Amount)
                {

                }
                #endregion
                trigger OnAfterGetRecord()
                var
                    VatPostingSetup: Record "VAT Posting Setup";
                begin
                    //To return only one VAT Entry
                    if "G/L Entry".Amount <> "VAT Entry".Amount then
                        CurrReport.Skip();
                    if "VAT Entry".Amount > 0 then
                        VATAmount := VatAmount + "VAT Entry".Amount;
                    //Get Vat %
                    Clear(VatPostingSetup);
                    Clear(VATPercentage);
                    If VatPostingSetup.Get("VAT Entry"."VAT Bus. Posting Group", "VAT Entry"."VAT Prod. Posting Group") then
                        VATPercentage := VatPostingSetup."VAT %";
                end;
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Entry No." = FIELD("Entry No.");
                column(BL_Description; "Bank Account Ledger Entry".Description)
                {

                }
                column(BL_Amount; "Bank Account Ledger Entry".Amount)
                {

                }
                column(BL_CurrencyCode; BankCurrencyCode)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    Clear(BankCurrencyCode);
                    GeneralLedgerSetup.Get();
                    if "Bank Account Ledger Entry"."Currency Code" = '' then
                        BankCurrencyCode := GeneralLedgerSetup."LCY Code"
                    else
                        BankCurrencyCode := "Bank Account Ledger Entry"."Currency Code";
                end;
            }

            //G/L Entry Triggers
            trigger OnAfterGetRecord()
            begin
                //Get Applied Invoice
                if BillNumber = '' then begin
                    Clear(DetCustLedgerEntry);
                    DetCustLedgerEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                    DetCustLedgerEntry.SetRange("Entry Type", DetCustLedgerEntry."Entry Type"::Application);
                    DetCustLedgerEntry.SetFilter("Cust. Ledger Entry No.", '<>%1', "G/L Entry"."Entry No.");
                    if DetCustLedgerEntry.FindFirst() then
                        if CustLedgerEntry.Get(DetCustLedgerEntry."Cust. Ledger Entry No.") then
                            BillNumber := CustLedgerEntry."Document No.";
                end;
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
                group(General)
                {
                    field(ShowStamp; ShowStamp)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Stamp';
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        GeneralLedgerSetup.Get();
        CompanyInformation.Get();
        CompanyAddress := CompanyInformation.Address + ' ' + CompanyInformation."Address 2";
        City_CR := CompanyInformation."City" + ', ' + CompanyInformation."CR No.";
        CompanyInformation.CalcFields(Picture);
        VAT_Percentage := GeneralLedgerSetup."Default VAT %";
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
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GlobalCustomer: Record Customer;
        DetCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        BillNumber: Text;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        AmountinWords: Text[250];
        GlobalCurrencyCode: Code[10];
        BankCurrencyCode: Code[10];
        CompanyAddress: Text[250];
        BillingAddress: Text[250];
        MOF: Text[100];
        VATPercentage: Decimal;
        BarCodeText: Text[100];
        City_CR: Text[100];
        VATAmount: Decimal;
        NetTotal: Decimal;
        NetTotalLCY: Decimal;
        IsVATEntry: Boolean;
        ShowStamp: Boolean;
        VAT_Percentage: Decimal;
        CapitalLabel: Label 'Capital';
        VATCodeLabel: Label 'VAT Code';
        AddressLabel: Label 'Address';
        BankAccountLabel: Label 'Bank Account';
        SWIFTLabel: Label 'SWIFT';
        PrintedOnLabel: Label 'Printed On';
        IssuedateLabel: Label 'Issue Date';
        RevisionDateLabel: Label 'Revision Date';
        ReceiptLabel: Label 'Receipt';
        ReceivedFromLabel: Label 'Received From';
        BillingAddressLabel: Label 'Billing Address';
        MOFLabel: Label 'MOF';
        DateOfIssueLabel: Label 'Date Of Issue';
        ProjectLabel: Label 'Project';
        BillNumberLabel: Label 'Bill Number';
        TotalAmountLabel: Label 'Total Amount';
        DescriptionLabel: Label 'Description';
        AmountLabel: Label 'Amount';
        CurrencyCodeLabel: Label 'Currency Code';
        VATLabel: Label 'VAT';
        NetTotalLabel: Label 'Net Total';
        MOFReceiptLabel: Label 'Duty Stamp is paid in cash, MOF Receipt- ';
        IncludedLabel: Label 'Included';
}