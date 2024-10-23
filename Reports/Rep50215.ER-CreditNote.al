report 50215 "ER-Credit Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-CreditNote.rdl';
    EnableHyperlinks = true;
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Credit Note';
    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = sorting("No.");
            #region //CompanyInformation
            column(FrenchReport; FrenchReport) { }
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
            column(Company_Address; CompanyAddress)
            {

            }
            column(Company_Bank_Account; GlobalBankAccount)
            {

            }
            column(Company_Rib; CompanyInformation.RIB)
            {

            }
            column(RibLabel; RibLabel) { }
            column(Company_SWIFT; CompanyInformation."SWIFT Code")
            {

            }
            column(Company_IBAN; CompanyInformation.IBAN)
            {

            }
            column(LCY_Code; GeneralLedgerSetup."LCY Code")
            {

            }
            column(MOFReceipt; GeneralLedgerSetup."MOF Receipt")
            {

            }
            #endregion

            #region //Invoice Header
            column(Sales_Invoice_No; "Sales Cr.Memo Header"."No.")
            {

            }
            column(Sales_Invoice_Posting_Date; "Sales Cr.Memo Header"."Posting Date")
            {

            }
            column(TotalAmount; "Sales Cr.Memo Header".Amount)
            {

            }
            column(InvoiceDiscount; "Sales Cr.Memo Header"."Invoice Discount Amount")
            {

            }
            column(VAT_Amount; "Sales Cr.Memo Header"."Amount Including VAT" - "Sales Cr.Memo Header".Amount)
            {

            }
            column(Gross_Total; "Sales Cr.Memo Header"."Amount Including VAT")
            {

            }
            column(Advance_Payment; "Sales Cr.Memo Header"."Amount Including VAT" - GlobalBalanceDue)
            {

            }
            column(Due_Balance; GlobalBalanceDue)
            {

            }

            column(AmountinWords; AmountinWords)
            {

            }
            column(MOF_Recipt_No; G_Cust."VAT Registration No.")
            {

            }
            column(TotalLineDiscountAmt; TotalLineDiscountAmt)
            {

            }
            column(BarcodeText; BarcodeText)
            {

            }
            #endregion
            #region Billing Info
            column(BillTo_Name; GlobalBillToCustomer.Name)
            {

            }
            column(BillTo_No; GlobalBillToCustomer."No.")
            {

            }
            column(BillTo_Address; BillToAddress)
            {

            }
            column(BillTo_Phone; GlobalBillToCustomer."Phone No.")
            {

            }
            column(BillTo_FiscalCode; GlobalFiscalCode)
            {

            }
            column(BillTo_Currency; GlobalCurrencyCode)
            {

            }
            column(BillTo_PurchOrderRef; "Sales Cr.Memo Header"."External Document No.")
            {

            }
            column(BillTo_PayTerms; GlobalPayTermsDescription)
            {

            }
            //Shipping Terms

            column(BillTo_DueDate; "Sales Cr.Memo Header"."Due Date")
            {

            }
            #endregion

            #region Shipping Info
            column(ShipTo_Name; GlobalShipToCustomer.Name)
            {

            }
            column(ShipTo_Address; ShipToAddress)
            {

            }
            column(ShipTo_Phone; GlobalShipToCustomer."Phone No.")
            {

            }
            column(ShipTo_ReceiverName; GlobalContact.Name)
            {

            } //Receiver Name

            column(ShipTo_ReceiverContact; GlobalContact."Phone No.")
            {

            }//Receiver Contact
            column(ShipTo_ShippingMode; GlobalShipmentMethod.Description)
            {

            }
            column(ShipTo_Carrier; "Sales Cr.Memo Header"."Shipping Agent Code")
            {

            }
            column(ShipTo_Project; GlobalProject)
            {

            }

            #endregion 

            #region //Labels
            column(SalesInvoiceLabel; TitleText)
            {

            }
            column(InvoiceDateLabel; InvoiceDateLabel)
            {

            }
            column(BillingInfoLabel; BillingInfoLabel)
            {

            }
            column(ShippingInfoLabel; ShippingInfoLabel)
            {

            }
            column(CustomerNameLabel; CustomerNameLabel)
            {

            }
            column(CodeLabel; CodeLabel)
            {

            }
            column(BillingAddressLabel; BillingAddressLabel)
            {

            }
            column(PhoneLabel; PhoneLabel)
            {

            }
            column(FiscalCodeLabel; FiscalCodeLabel)
            {

            }
            column(CurrencyLabel; CurrencyLabel)
            {

            }
            column(PurchOrderRefLabel; PurchOrderRefLabel)
            {

            }
            column(PaymentTermsLabel; PaymentTermsLabel)
            {

            }
            column(ShippingTermsLabel; ShippingTermsLabel)
            {

            }
            column(DueDateLabel; DueDateLabel)
            {

            }
            column(ShippingAddressLabel; ShippingAddressLabel)
            {

            }
            column(ReceiverNameLabel; ReceiverNameLabel)
            {

            }
            column(ReceiverContactLabel; ReceiverContactLabel)
            {

            }
            column(ShippingModeLabel; ShippingModeLabel)
            {

            }
            column(CarrierLabel; CarrierLabel)
            {

            }
            column(BillRefNumberLabel; BillRefNumberLabel)
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
            column(PrintedOnLabel; PrintedOnLabel)
            {

            }
            column(PageLabel; PageLabel) { }
            column(OfLabel; OfLabel) { }
            column(HSCodeLabel; HSCodeLabel)
            {

            }
            column(ItemCodeLabel; ItemCodeLabel)
            {

            }
            column(DescriptionLabel; DescriptionLabel)
            {

            }
            column(SizeLabel; SizeLabel)
            {

            }
            column(QtyLabel; QtyLabel)
            {

            }
            column(UnitPriceLabel; UnitPriceLabel)
            {

            }
            column(TotalPriceLabel; TotalPriceLabel)
            {

            }
            column(TotalLabel; TotalLabel)
            {

            }
            column(TotalLabelWithoutVAT; TotalLabelWithoutVAT)
            {

            }
            column(DiscountLabel; DiscountLabel)
            {

            }
            column(VATLabel; VATLabel)
            {

            }
            column(GrossTotalLabel; GrossTotalLabel)
            {

            }
            column(AdvancePaymentLabel; AdvancePaymentLabel)
            {

            }
            column(DueBalanceLabel; DueBalanceLabel)
            {

            }
            column(FormNoLabel; FormNoLabel) { }
            column(FormNoVal; FormNoVal) { }
            column(IssueDateLabel; "IssueDateLabel")
            {

            }
            column(IssueDateVal; IssueDateVal) { }
            column(RevisionDateLabel; "RevisionDateLabel")
            {

            }
            column(MOFReceiptLabel; MOFReceiptLabel)
            {

            }
            column(RefLabel; RefLabel)
            {

            }
            column(ProjectLabel; ProjectLabel)
            {

            }
            column(PhoneNumberLbl; PhoneNumberLbl)
            { }
            #endregion
            column(VAT_Percentage; VAT_Percentage) { }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Cr.Memo Header";
                #region //Sales Invoice Lines Columns
                column(Line_Type; "Sales Cr.Memo Line".Type)
                {

                }
                column(Line_HS_Ccode; GlobalItem."Hs Code")
                {

                }
                column(Line_Item_No; "Sales Cr.Memo Line"."No.")
                {

                }
                column(Line_Item_Description; CeeAntCodeUnit.GetCreditLineLanguageDescription("Document No.", "Line No.", SelectedLanguage))
                {

                }
                column(Line_Size; "Sales Cr.Memo Line".Size)
                {

                }
                column(Line_Qty; "Sales Cr.Memo Line".Quantity)
                {

                }
                column(Line_Unit_Price; "Sales Cr.Memo Line"."Unit Price")
                {

                }
                column(Line_Amount; "Sales Cr.Memo Line"."Line Amount")
                {

                }
                column(DepartmentName; DepartmentName)
                {

                }
                column(PositionName; PositionName)
                {

                }
                column(MOFLabel; MOFLabel)
                {

                }
                #endregion
                trigger OnAfterGetRecord()
                begin
                    Clear(GlobalItem);
                    if GlobalItem.Get("Sales Cr.Memo Line"."No.") then;
                    //Hide not invoiced lines
                    if ("Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::Item) and ("Sales Cr.Memo Line".Quantity = 0) then
                        CurrReport.Skip();

                    //Calculate Total Line Discount
                    TotalLineDiscountAmt := TotalLineDiscountAmt + "Sales Cr.Memo Line"."Line Discount Amount" + "Sales Cr.Memo Line"."Inv. Discount Amount";

                    //Get Allocation Name
                    GetAllocationName("Sales Cr.Memo Header", "Sales Cr.Memo Line");
                end;
            }

            //Sales Invoice Header Triggers
            trigger OnAfterGetRecord()
            var
                PaymentTerms: Record "Payment Terms";
                CustLedgerEntry: Record "Cust. Ledger Entry";

            begin

                Clear(G_Cust);
                G_Cust.get("Sales Cr.Memo Header"."Bill-to Customer No.");


                if G_CULanguage.GetLanguageId(SelectedLanguage) = 1036 then begin
                    CurrReport.Language := 1036;
                    FrenchReport := true;
                    GlobalBankAccount := CompanyInformation."Bank Name" + ' ' + CompanyInformation."Bank Branch No."
                end
                else begin
                    CurrReport.Language := G_CULanguage.GetLanguageID('ENG');
                    FrenchReport := false;
                    GlobalBankAccount := CompanyInformation."Bank Name";
                end;

                Clear(TotalLineDiscountAmt);
                Clear(GlobalShipToCustomer);
                Clear(GlobalBillToCustomer);
                Clear(BillToAddress);
                if GlobalShipToCustomer.Get("Sales Cr.Memo Header"."Sell-to Customer No.") then
                    //Get Ship Address
                    ShipToAddress := "Sales Cr.Memo Header"."Sell-to Country/Region Code" + ',' + "Sales Cr.Memo Header"."Ship-to Address" + ',' + "Sales Cr.Memo Header"."Ship-to Address 2";
                if GlobalBillToCustomer.Get("Sales Cr.Memo Header"."Bill-to Customer No.") then begin
                    //Get Fiscal Code
                    Clear(GlobalFiscalCode);
                    if GlobalBillToCustomer."VAT Registration No." <> '' then
                        GlobalFiscalCode := GlobalBillToCustomer."VAT Registration No."
                    else
                        GlobalFiscalCode := GlobalBillToCustomer."CR No.";
                    //Get Bill Address
                    Clear(BillToAddress);
                    BillToAddress := "Sales Cr.Memo Header"."Bill-to Country/Region Code" + ',' + "Sales Cr.Memo Header"."Bill-to Address" + ',' + "Sales Cr.Memo Header"."Bill-to Address 2"
                end;

                //Calculate Balance Due
                Clear(CustLedgerEntry);
                Clear(GlobalBalanceDue);
                CustLedgerEntry.SetRange("Document No.", "Sales Cr.Memo Header"."No.");
                if CustLedgerEntry.FindFirst() then begin
                    CustLedgerEntry.CalcFields("Remaining Amount");
                    GlobalBalanceDue := CustLedgerEntry."Remaining Amount";
                end;
                //Get Shipment Method
                Clear(GlobalShipmentMethod);
                if GlobalShipmentMethod.Get("Sales Cr.Memo Header"."Shipment Method Code") then;

                //Get Currency Code
                Clear(GlobalCurrencyCode);
                if "Sales Cr.Memo Header"."Currency Code" = '' then
                    GlobalCurrencyCode := GeneralLedgerSetup."LCY Code"
                else
                    GlobalCurrencyCode := "Sales Cr.Memo Header"."Currency Code";

                //Get Payment Terms
                Clear(PaymentTerms);
                Clear(GlobalPayTermsDescription);
                if PaymentTerms.Get("Payment Terms Code") then
                    GlobalPayTermsDescription := PaymentTerms.Description;

                //Amount in Words
                AmountInWordsFunction("Sales Cr.Memo Header"."Amount Including VAT", GlobalCurrencyCode);

                //Barcode text
                Clear(BarcodeText);
                BarcodeText := "Sales Cr.Memo Header"."Bill-to Customer No." + '+' + "Sales Cr.Memo Header"."No.";

                //Contact
                Clear(GlobalContact);
                if GlobalContact.get("Sales Cr.Memo Header"."Sell-to Contact No.") then;

                //Project
                Clear(GlobalProject);
                if "Sales Cr.Memo Header"."IC Customer Project Code" = '' then begin
                    GlobalProject := "Sales Cr.Memo Header"."Shortcut Dimension 1 Code"
                end
                else
                    GlobalProject := "Sales Cr.Memo Header"."IC Customer Project Code";
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(LanguageSelection)
                {
                    Caption = 'Language Selection';
                    field(SelectedLanguage; SelectedLanguage)
                    {
                        ApplicationArea = All;
                        TableRelation = "Language";
                        Lookup = true;
                        Caption = 'Language';
                        ToolTip = 'Select the language to be used in the report.';
                    }

                }
            }
        }

    }

    trigger OnInitReport()
    begin
        Clear(SelectedLanguage);
        SelectedLanguage := G_CULanguage.GetLanguageCode(GlobalLanguage);
    end;

    trigger OnPreReport()
    begin
        GeneralLedgerSetup.Get();
        CompanyInformation.Get();
        CompanyAddress := CompanyInformation.Address + ' ' + CompanyInformation."Address 2";
        CompanyInformation.CalcFields(Picture);
        VAT_Percentage := GeneralLedgerSetup."Default VAT %";
        if GeneralLedgerSetup."Sub Tax Invoice Title" then
            TitleText := TaxCreditNote
        else
            TitleText := CreditNoteLabel;
    end;

    procedure AmountInWordsFunction(Amount: Decimal; CurrencyCode: Code[10])
    var
        NoText: array[2] of Text[80];
        ReportCheck: Report Check;
    begin
        ReportCheck.InitTextVariable();
        ReportCheck.FormatNoText(NoText, Amount, CurrencyCode);
        AmountinWords := NoText[1];
    end;


    procedure GetAllocationName(SalesInvHeader: Record "Sales Cr.Memo Header"; SalesInvLine: Record "Sales Cr.Memo Line")
    var
        CustomerDepartment: Record "Customer Departments";
        CustomerPosition: Record "Department Positions";
        CustomerStaff: Record Staff;
        Department: Record Department;
        Position: Record Position;
        ParameterHeader: Record "Parameter Header";
    begin
        Clear(CustomerDepartment);
        Clear(CustomerPosition);
        Clear(CustomerStaff);
        Clear(DepartmentName);
        Clear(PositionName);
        Clear(StaffName);
        Clear(Department);
        Clear(Position);
        Clear(ParameterHeader);
        if SalesInvHeader."IC Source No." <> '' then
            GetICAllocationName("Sales Cr.Memo Header", "Sales Cr.Memo Line", SalesInvHeader."IC Company Name", SalesInvHeader."IC Source No.", SalesInvHeader."IC Customer SO No.")
        else begin
            //if SalesLine.get(SalesLine."Document Type"::Order, Rec."Source No.", Rec."Source Line No.") then begin
            case SalesInvLine."Allocation Type" of
                SalesInvLine."Allocation Type"::" ":
                    exit;
                SalesInvLine."Allocation Type"::Department:
                    begin
                        if CustomerDepartment.Get(SalesInvLine."Sell-to Customer No.", SalesInvLine."Allocation Code") then begin
                            if Department.Get(CustomerDepartment."Department Code") then
                                DepartmentName := Department.Name;
                        end;
                    end;
                SalesInvLine."Allocation Type"::Position:
                    begin
                        if ParameterHeader.Get(SalesInvLine."Parameters Header ID") then begin
                            CustomerPosition.SetRange("Position Code", SalesInvLine."Allocation Code");
                            CustomerPosition.SetRange("Customer No.", SalesInvLine."Sell-to Customer No.");
                            CustomerPosition.SetRange("Department Code", ParameterHeader."Department Code");
                            if CustomerPosition.FindFirst() then begin
                                if Position.Get(CustomerPosition."Position Code") then
                                    PositionName := Position.Name;
                                if Department.Get(ParameterHeader."Department Code") then
                                    DepartmentName := Department.Name;
                            end;
                        end;
                    end;
                SalesInvLine."Allocation Type"::Staff:
                    begin
                        if ParameterHeader.Get(SalesInvLine."Parameters Header ID") then begin
                            CustomerStaff.SetRange(Code, SalesInvLine."Allocation Code");
                            CustomerStaff.SetRange("Customer No.", SalesInvLine."Sell-to Customer No.");
                            CustomerStaff.SetRange("Department Code", ParameterHeader."Department Code");
                            CustomerStaff.SetRange("Position Code", ParameterHeader."Position Code");
                            if CustomerStaff.FindFirst() then begin
                                StaffName := CustomerStaff.Name;
                                if Department.Get(ParameterHeader."Department Code") then
                                    DepartmentName := Department.Name;
                                if Position.Get(ParameterHeader."Position Code") then
                                    PositionName := Position.Name;
                            end;
                        end;
                    end;
            end;
        end;
    end;

    procedure GetICAllocationName(SalesInvHeader: Record "Sales Cr.Memo Header"; SalesInvLine: Record "Sales Cr.Memo Line"; ICCompany: Code[20]; ICCustomerNo: Code[20]; ICCustomerSONo: Code[20])
    var
        ICSalesHeader: Record "Sales Header";
        ICSalesLine: Record "Sales Line";
        CustomerDepartment: Record "Customer Departments";
        CustomerPosition: Record "Department Positions";
        CustomerStaff: Record Staff;
        Department: Record Department;
        Position: Record Position;
        ParameterHeader: Record "Parameter Header";
    begin
        Clear(CustomerDepartment);
        Clear(CustomerPosition);
        Clear(CustomerStaff);
        Clear(DepartmentName);
        Clear(PositionName);
        Clear(StaffName);
        Clear(Department);
        Clear(Position);
        Clear(ParameterHeader);
        //if SalesLine.get(SalesLine."Document Type"::Order, Rec."Source No.", Rec."Source Line No.") then;
        CustomerDepartment.ChangeCompany(ICCompany);
        CustomerPosition.ChangeCompany(ICCompany);
        CustomerStaff.ChangeCompany(ICCompany);
        Department.ChangeCompany(ICCompany);
        Position.ChangeCompany(ICCompany);
        ParameterHeader.ChangeCompany(ICCompany);
        ICSalesHeader.ChangeCompany(ICCompany);
        if ICSalesHeader.get(ICSalesHeader."Document Type"::Order, ICCustomerSONo) then begin
            ICSalesLine.ChangeCompany(ICCompany);
            ICSalesLine.SetRange("Document No.", ICSalesHeader."No.");
            ICSalesLine.SetRange("Allocation Type", SalesInvLine."Allocation Type");
            icSalesLine.SetRange("Allocation Code", SalesInvLine."Allocation Code");
            if ICSalesLine.FindFirst() then begin
                case ICSalesLine."Allocation Type" of
                    ICSalesLine."Allocation Type"::" ":
                        exit;
                    ICSalesLine."Allocation Type"::Department:
                        begin
                            if CustomerDepartment.Get(ICSalesLine."Sell-to Customer No.", ICSalesLine."Allocation Code") then begin
                                if Department.Get(CustomerDepartment."Department Code") then
                                    DepartmentName := Department.Name;
                            end;
                        end;
                    ICSalesLine."Allocation Type"::Position:
                        begin
                            if ParameterHeader.Get(ICSalesLine."Parameters Header ID") then begin
                                CustomerPosition.SetRange("Position Code", ICSalesLine."Allocation Code");
                                CustomerPosition.SetRange("Customer No.", ICSalesLine."Sell-to Customer No.");
                                CustomerPosition.SetRange("Department Code", ParameterHeader."Department Code");
                                if CustomerPosition.FindFirst() then begin
                                    if Position.Get(CustomerPosition."Position Code") then
                                        PositionName := Position.Name;
                                    if Department.Get(ParameterHeader."Department Code") then
                                        DepartmentName := Department.Name;
                                end;
                            end;
                        end;
                    ICSalesLine."Allocation Type"::Staff:
                        begin
                            if ParameterHeader.Get(ICSalesLine."Parameters Header ID") then begin
                                CustomerStaff.SetRange(Code, ICSalesLine."Allocation Code");
                                CustomerStaff.SetRange("Customer No.", ICSalesLine."Sell-to Customer No.");
                                CustomerStaff.SetRange("Department Code", ParameterHeader."Department Code");
                                CustomerStaff.SetRange("Position Code", ParameterHeader."Position Code");
                                if CustomerStaff.FindFirst() then begin
                                    StaffName := CustomerStaff.Name;
                                    if Department.Get(ParameterHeader."Department Code") then
                                        DepartmentName := Department.Name;
                                    if Position.Get(ParameterHeader."Position Code") then
                                        PositionName := Position.Name;
                                end;
                            end;
                        end;
                end;
            end;
        end;
    end;

    var
        G_Cust: Record Customer;
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GlobalShipToCustomer: Record Customer;
        GlobalBillToCustomer: Record Customer;
        CeeAntCodeUnit: Codeunit CeeAnt;
        GlobalShipmentMethod: Record "Shipment Method";
        G_CULanguage: Codeunit Language;
        GlobalItem: Record Item;
        GlobalContact: Record Contact;
        GlobalFiscalCode: Text[30];
        AmountinWords: Text[250];
        FrenchReport: Boolean;
        VAT_Percentage: Decimal;
        GlobalBankAccount: Text[50];
        GlobalCurrencyCode: Code[10];
        GlobalPayTermsDescription: Text[100];
        CompanyAddress: Text[250];
        BarcodeText: Text[150];
        DepartmentName: Text[150];
        PositionName: Text[150];
        SelectedLanguage: Code[10];
        StaffName: Text[150];
        BillToAddress: Text[250];
        ShipToAddress: Text[250];
        GlobalProject: Code[50];
        TotalLineDiscountAmt: Decimal;
        GlobalBalanceDue: Decimal;
        TitleText: Text[50];
        CreditNoteLabel: Label 'Credit Note';
        TaxCreditNote: Label 'Tax Credit Note';
        InvoiceDateLabel: Label 'Date of Issue:';
        BillingInfoLabel: Label 'Billing Info';
        ShippingInfoLabel: Label 'Shiping Info';
        CustomerNameLabel: Label 'Pay to:';
        CodeLabel: Label 'Code';
        BillingAddressLabel: Label 'Billing Address:';
        PhoneLabel: Label 'Bill Number:';
        PhoneNumberLbl: Label 'Phone Number :';
        FiscalCodeLabel: Label 'Fiscal Code';
        CurrencyLabel: Label 'Currency';
        PurchOrderRefLabel: Label 'Purchase Order Ref.';
        PaymentTermsLabel: Label 'Payment Terms';
        ShippingTermsLabel: Label 'Shipping Terms';
        DueDateLabel: Label 'Due Date';
        ShippingAddressLabel: Label 'Shiping Address';
        ReceiverNameLabel: Label 'Receiver Name';
        ReceiverContactLabel: Label 'Receiver Contact';
        ShippingModeLabel: Label 'Shiping Mode';
        CarrierLabel: Label 'Carrier';
        BillRefNumberLabel: Label 'Bill Ref. Number';
        CapitalLabel: Label 'Capital';
        VATCodeLabel: Label 'VAT Code';
        AddressLabel: Label 'Address';
        BankAccountLabel: Label 'Bank Account';
        SWIFTLabel: Label 'SWIFT';
        PrintedOnLabel: Label 'Printed On';
        HSCodeLabel: Label 'HS Code';
        ItemCodeLabel: Label 'Item Code';
        DescriptionLabel: Label 'Description';
        SizeLabel: Label 'Size';
        QtyLabel: Label 'Quantity';
        UnitPriceLabel: Label 'Unit Price';
        TotalPriceLabel: Label 'Total Amount';
        TotalLabel: Label 'Net Total';
        DiscountLabel: Label 'Discount';
        VATLabel: Label 'VAT';
        GrossTotalLabel: Label 'Gross Total';
        AdvancePaymentLabel: Label 'Advance Payment';
        DueBalanceLabel: Label 'Due Balance';
        IssuedateLabel: Label 'Issue Date';
        RevisionDateLabel: Label 'Revision Date';
        MOFReceiptLabel: Label 'Duty Stamp is paid in cash, MOF Receipt- ';
        MOFLabel: Label 'MOF';
        RefLabel: label 'Ref.';
        ProjectLabel: label 'Project';
        RibLabel: label 'RIB';
        FormNoLabel: Label 'Form #: ';
        FormNoVal: Label ' ER\LB\AVER\ACCT-CR\100';
        PageLabel: label 'Page ';
        OfLabel: label ' of ';
        TotalLabelWithoutVAT: label 'Total';
        IssueDateVal: label 'Jan 23';
}
