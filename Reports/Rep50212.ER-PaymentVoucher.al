report 50212 "ER - Payment Voucher"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-PaymentVoucher.rdlc';
    Caption = 'Payment Voucher';
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Document No.";
            #region //CompanyInformation
            column(Company_Picture; CompanyInformation.Picture)
            {

            }
            column(Company_Capital; CompanyInformation.Capital)
            {

            }
            column(Company_Vat; CompanyInformation."VAT Registration No.")
            {

            }
            column(CompanyInformation_City; CompanyInformation.City)
            {

            }
            column(CompanyInformation_CR; CompanyInformation."CR No.")
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
            /*column(ColumnName; SourceFieldName)
            {

            }
            column(ColumnName; SourceFieldName)
            {

            }*/
            column(AmountinWords; AmountinWords)
            {

            }
            column(NetTotal; NetTotal)
            {

            }
            column(NetTotalLCY; NetTotalLCY)
            {

            }
            column(VL_CurrencyCode; GlobalCurrencyCode)
            {

            }
            column(TotalVATAmount; VATAmount)
            {

            }
            column(VL_PayTo; GlobalVendor.Name)
            {

            }
            column(VL_BillingAddress; BillingAddress)
            {

            }
            column(VL_MOF; MOF)
            {

            }
            column(VL_DateOfIssue; "Vendor Ledger Entry"."Posting Date")
            {

            }
            column(VL_Project; "Vendor Ledger Entry"."Global Dimension 1 Code")
            {

            }
            /*column(ColumnName; SourceFieldName)
            {

            }*/ //Bill Number
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
            column(FormNoLabel; FormNoLabel)
            {

            }
            column(FormNoValue; FormNoValue)
            {

            }
            column(IssuedateLabel; IssuedateLabel)
            {

            }

            column(RevisionDateLabel; RevisionDateLabel)
            {

            }

            column(PaymentVoucherLabel; PaymentVoucherLabel)
            {

            }

            column(PayToLabel; PayToLabel)
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
            #endregion
            column(VAT_Percentage;VAT_Percentage){}
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Entry No." = FIELD("Entry No.");
                #region //Vendor Ledger Entries

                column(VL_Description; "Vendor Ledger Entry".Description)
                {

                }
                column(VL_Amount; "Vendor Ledger Entry".Amount)
                {

                }
                #endregion
                //Vendor Ledger Entry Trigger
                trigger OnAfterGetRecord()
                var
                    GeneralLedgerSetup: Record "General Ledger Setup";
                begin
                    Clear(GeneralLedgerSetup);
                    GeneralLedgerSetup.Get();
                    Clear(GlobalVendor);
                    Clear(BillingAddress);
                    if GlobalVendor.Get("Vendor Ledger Entry"."Vendor No.") then begin
                        BillingAddress := GlobalVendor.Address + '' + GlobalVendor."Address 2";
                        if GlobalVendor."VAT Registration No." <> '' then
                            MOF := GlobalVendor."VAT Registration No."
                    end;

                    Clear(BarCodeText);
                    BarCodeText := "Vendor Ledger Entry"."Vendor No." + '+' + "Vendor Ledger Entry"."Document No.";

                    "Vendor Ledger Entry".CalcFields(Amount, "Amount (LCY)");
                    NetTotal := NetTotal + ("Vendor Ledger Entry".Amount);
                    NetTotalLCY := NetTotalLCY + ("Vendor Ledger Entry"."Amount (LCY)");
                    Clear(GlobalCurrencyCode);
                    if "Vendor Ledger Entry"."Currency Code" = '' then
                        GlobalCurrencyCode := GeneralLedgerSetup."LCY Code"
                    else
                        GlobalCurrencyCode := "Vendor Ledger Entry"."Currency Code";

                    //Amount in Words
                    AmountInWordsFunction(NetTotal, "Currency Code");
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
        GlobalVendor: Record Vendor;
        AmountinWords: Text[250];
        GlobalCurrencyCode: Code[10];
        BankCurrencyCode: Code[10];
        CompanyAddress: Text[250];
        BillingAddress: Text[250];
        MOF: Text[100];
        VATPercentage: Decimal;
        BarCodeText: Text[100];
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
        PaymentVoucherLabel: Label 'Payment Voucher';
        PayToLabel: Label 'Pay to';
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

        FormNoLabel: Label 'Form#';
        FormNoValue: Label 'ER\LB\AVER\ACCT-P\100';

}