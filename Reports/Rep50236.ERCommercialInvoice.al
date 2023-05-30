report 50236 "ER - Commercial Invoice"
{
    ApplicationArea = All;
    Caption = 'ER - Commercial Invoice';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-CommercialInvoice.rdlc';
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
            #region //CompanyInformation
            column(Company_Picture; CompanyInformation.Picture)
            {

            }
            column(Company_Capital; CompanyInformation.Capital)
            {

            }
            column(Company_City; CompanyInformation.City)
            {

            }
            column(Company_CRNo; CompanyInformation."CR No.")
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

            column(Company_SWIFT; CompanyInformation."SWIFT Code")
            {

            }
            column(Company_IBAN; CompanyInformation.IBAN)
            {

            }
            column(BankBranch; CompanyInformation."Bank Branch No.")
            {

            }
            column(RIBValue; CompanyInformation.RIB)
            {

            }
            column(LCY_Code; GeneralLedgerSetup."LCY Code")
            {

            }
            column(MOFReceipt; GeneralLedgerSetup."MOF Receipt")
            {

            }
            column(ShowStamp; ShowStamp)
            {

            }
            column(ShowNotice; ShowNotice)
            {

            }
            #endregion

            #region //Order Header
            column(Sales_Order_No; "Sales Header"."No.")
            {

            }
            column(Sales_Order_Posting_Date; "Sales Header"."Posting Date")
            {

            }
            column(TotalAmount; "Sales Header".Amount)
            {

            }
            column(InvoiceDiscount; "Sales Header"."Invoice Discount Amount")
            {

            }
            column(VAT_Amount; "Amount Including VAT" - Amount)
            {

            }
            column(Gross_Total; "Amount Including VAT")
            {

            }
            column(Advance_Payment; "Amount Including VAT" - GlobalBalanceDue)
            {

            }
            column(Due_Balance; GlobalBalanceDue)
            {

            }

            column(AmountinWords; AmountinWords)
            {

            }
            column(MOF_Recipt_No; GeneralLedgerSetup."MOF Receipt")
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
            column(BillTo_PurchOrderRef; "External Document No.")
            {

            }
            column(BillTo_PayTerms; GlobalPayTermsDescription)
            {

            }
            /*column(ColumnName; )
            {

            }*/ //Shipping Terms

            column(BillTo_DueDate; "Due Date")
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
            column(ShipTo_Carrier; "Shipping Agent Code")
            {

            }
            column(ShipTo_Project; GlobalProject)
            {

            }
            /*column()
            {

            }*/ //Bill Ref. Number

            #endregion 

            #region //Labels
            column(RIBLabel; RIBLabel) { }
            column(SalesOrderLabel; SalesOrderLabel)
            {

            }
            column(InvoiceDateLabel; OrderDateLabel)
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
            column(HSCodeLabel; HSCodeLabel)
            {

            }
            column(ItemCodeLabel; ItemCodeLabel)
            {

            }
            column(GLCodeLabel; GLCodeLabel)
            {

            }
            column(TotalGlAccountLabel; TotalGlAccountLabel)
            {

            }
            column(ProductLabel; ProductLabel)
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
            column(IssueDateLabel; "IssueDateLabel")
            {

            }
            column(IssueDateValue; "IssueDateValue")
            {

            }
            column(RevisionDateLabel; "RevisionDateLabel")
            {

            }
            column(FormNoLabel; FormNoLabel)
            {

            }
            column(FormNoValue; FormNoValue)
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
            column(PageLabel; PageLabel) { }
            column(PageOfLabel; PageOfLabel) { }
            #endregion

            #region Customer Language
            column(FrenchReport; FrenchReport)
            {

            }
            #endregion

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                #region //Sales Invoice Lines Columns
                column(Line_Type; "Sales Line".Type)
                {

                }
                column(Line_HS_Ccode; GlobalItem."Hs Code")
                {

                }
                column(Line_Item_No; "Sales Line"."No.")
                {

                }
                column(Line_Item_Description; "Sales Line"."Description")
                {

                }
                column(Line_Size; Size)
                {

                }
                column(Line_Qty; "Sales Line".Quantity)
                {

                }
                column(Line_Unit_Price; "Sales Line"."Unit Price")
                {

                }
                column(Line_Amount; "Sales Line"."Line Amount")
                {

                }
                column(DepartmentName; DepartmentName)
                {

                }
                column(PositionName; PositionName)
                {

                }
                column(GlAmount; GlAmount)
                {

                }
                #endregion
                trigger OnAfterGetRecord()
                begin
                    Clear(GlobalItem);
                    if GlobalItem.Get("Sales Line"."No.") then;
                    //Hide not invoiced lines
                    if ("Sales Line".Type = "Sales Line".Type::Item) and ("Sales Line".Quantity = 0) then
                        CurrReport.Skip();

                    //Calculate Total Line Discount
                    TotalLineDiscountAmt := TotalLineDiscountAmt + "Sales Line"."Line Discount Amount" + "Sales Line"."Inv. Discount Amount";

                    //Get Allocation Name
                    GetAllocationName("Sales Header", "Sales Line");

                    //Calculate G/L Amount
                    if "Sales Line".Type = "Sales Line".Type::"G/L Account" then
                        GlAmount := GlAmount + "Sales Line"."Line Amount";

                end;
            }
            trigger OnPreDataItem()
            begin
                if "Sales Header".GetFilter("No.") = '' then
                    Error('Please select a Sales Invoice.');
            end;

            //Sales Order Header Triggers
            trigger OnAfterGetRecord()
            var
                PaymentTerms: Record "Payment Terms";
                CustLedgerEntry: Record "Cust. Ledger Entry";
            begin
                GlAmount := 0;
                Clear(TotalLineDiscountAmt);
                Clear(GlobalShipToCustomer);
                Clear(GlobalBillToCustomer);
                Clear(BillToAddress);
                if GlobalShipToCustomer.Get("Sales Header"."Sell-to Customer No.") then
                    //Get Ship Address
                    ShipToAddress := "Sales Header"."Sell-to Country/Region Code" + ',' + "Sales Header"."Ship-to Address" + ',' + "Sales Header"."Ship-to Address 2";
                if GlobalBillToCustomer.Get("Sales Header"."Bill-to Customer No.") then begin
                    //Get Fiscal Code
                    Clear(GlobalFiscalCode);
                    if GlobalBillToCustomer."VAT Registration No." <> '' then
                        GlobalFiscalCode := GlobalBillToCustomer."VAT Registration No."
                    else
                        GlobalFiscalCode := GlobalBillToCustomer."CR No.";
                    //Get Bill Address
                    Clear(BillToAddress);
                    BillToAddress := "Sales Header"."Bill-to Country/Region Code" + ',' + "Sales Header"."Bill-to Address" + ',' + "Sales Header"."Bill-to Address 2"
                end;

                //Calculate Balance Due
                Clear(CustLedgerEntry);
                Clear(GlobalBalanceDue);
                CustLedgerEntry.SetRange("Document No.", "Sales Header"."No.");
                if CustLedgerEntry.FindFirst() then begin
                    CustLedgerEntry.CalcFields("Remaining Amount");
                    GlobalBalanceDue := CustLedgerEntry."Remaining Amount";
                end;
                //Get Shipment Method
                Clear(GlobalShipmentMethod);
                if GlobalShipmentMethod.Get("Sales Header"."Shipment Method Code") then;

                //Get Currency Code
                Clear(GlobalCurrencyCode);
                if "Sales Header"."Currency Code" = '' then
                    GlobalCurrencyCode := GeneralLedgerSetup."LCY Code"
                else
                    GlobalCurrencyCode := "Sales Header"."Currency Code";

                //Get Payment Terms
                Clear(PaymentTerms);
                Clear(GlobalPayTermsDescription);
                if PaymentTerms.Get("Payment Terms Code") then
                    GlobalPayTermsDescription := PaymentTerms.Description;

                //Amount in Words
                AmountInWordsFunction("Sales Header"."Amount Including VAT", GlobalCurrencyCode);

                //Barcode text
                Clear(BarcodeText);
                BarcodeText := "Sales Header"."Bill-to Customer No." + '+' + "Sales Header"."No.";

                //Contact
                Clear(GlobalContact);
                if GlobalContact.get("Sales Header"."Sell-to Contact No.") then;

                //Project
                Clear(GlobalProject);
                if "Sales Header"."Cust Project" = '' then
                    GlobalProject := "Sales Header"."IC Customer Project Code"
                else
                    GlobalProject := "Sales Header"."Cust Project";


                // if G_CULanguage.GetLanguageId(SelectedLanguage) = 1036 then begin
                //     CurrReport.Language := 1036;
                //     FrenchReport := true;
                //     GlobalBankAccount := CompanyInformation."Bank Name" + ' ' + CompanyInformation."Bank Branch No."

                // end
                // else begin
                //     CurrReport.Language := G_CULanguage.GetLanguageID('ENG');
                //     FrenchReport := false;
                //     GlobalBankAccount := CompanyInformation."Bank Name";
                // end;

            end;
        }
    }

    requestpage
    {
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
                    field(ShowNotice; ShowNotice)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Notice';
                    }
                }
                // group(LanguageSelection)
                // {
                //     Caption = 'Language Selection';
                //     field(SelectedLanguage; SelectedLanguage)
                //     {
                //         ApplicationArea = All;
                //         TableRelation = "Language";
                //         Lookup = true;
                //         Caption = 'Language';
                //         ToolTip = 'Select the language to be used in the report.';
                //     }

                // }
            }
        }
        // trigger OnOpenPage()
        // var
        // begin
        //     Clear(SelectedLanguage);
        //     SelectedLanguage := G_CULanguage.GetLanguageCode(GlobalLanguage);
        // end;
    }

    trigger OnPreReport()
    begin
        GeneralLedgerSetup.Get();
        CompanyInformation.Get();
        CompanyAddress := CompanyInformation.Address + ' ' + CompanyInformation."Address 2";
        CompanyInformation.CalcFields(Picture);
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

    procedure GetAllocationName(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line")
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
        if SalesHeader."IC Source No." <> '' then
            GetICAllocationName("Sales Header", "Sales Line", SalesHeader."IC Company Name", SalesHeader."IC Source No.", SalesHeader."IC Customer SO No.")
        else begin
            //if SalesLine.get(SalesLine."Document Type"::Order, Rec."Source No.", Rec."Source Line No.") then begin
            case SalesLine."Allocation Type" of
                SalesLine."Allocation Type"::" ":
                    exit;
                SalesLine."Allocation Type"::Department:
                    begin
                        if CustomerDepartment.Get(SalesLine."Sell-to Customer No.", SalesLine."Allocation Code") then begin
                            if Department.Get(CustomerDepartment."Department Code") then
                                DepartmentName := Department.Name;
                        end;
                    end;
                SalesLine."Allocation Type"::Position:
                    begin
                        if ParameterHeader.Get(SalesLine."Parameters Header ID") then begin
                            CustomerPosition.SetRange("Position Code", SalesLine."Allocation Code");
                            CustomerPosition.SetRange("Customer No.", SalesLine."Sell-to Customer No.");
                            CustomerPosition.SetRange("Department Code", ParameterHeader."Department Code");
                            if CustomerPosition.FindFirst() then begin
                                if Position.Get(CustomerPosition."Position Code") then
                                    PositionName := Position.Name;
                                if Department.Get(ParameterHeader."Department Code") then
                                    DepartmentName := Department.Name;
                            end;
                        end;
                    end;
                SalesLine."Allocation Type"::Staff:
                    begin
                        if ParameterHeader.Get(SalesLine."Parameters Header ID") then begin
                            CustomerStaff.SetRange(Code, SalesLine."Allocation Code");
                            CustomerStaff.SetRange("Customer No.", SalesLine."Sell-to Customer No.");
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

    procedure GetICAllocationName(SalesInvHeader: Record "Sales Header"; SalesInvLine: Record "Sales Line"; ICCompany: Code[20]; ICCustomerNo: Code[20]; ICCustomerSONo: Code[20])
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
        if ICSalesHeader.get(ICSalesHeader."Document Type"::Invoice, ICCustomerSONo) then begin
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
        CompanyInformation: Record "Company Information";
        CeeAntCodeUnit: Codeunit CeeAnt;
        //G_CULanguage: Codeunit Language;


        GeneralLedgerSetup: Record "General Ledger Setup";
        GlobalShipToCustomer: Record Customer;
        GlobalBillToCustomer: Record Customer;
        GlobalCustomer: Record Customer;
        GlobalShipmentMethod: Record "Shipment Method";
        GlobalItem: Record Item;
        GlobalContact: Record Contact;
        GlobalFiscalCode: Text[30];
        AmountinWords: Text[250];
        GlobalCurrencyCode: Code[10];
        //UnitPriceVar: Text[50];
        GlobalPayTermsDescription: Text[100];
        CompanyAddress: Text[250];
        BarcodeText: Text[150];
        DepartmentName: Text[150];
        PositionName: Text[150];
        StaffName: Text[150];
        BillToAddress: Text[250];
        ShipToAddress: Text[250];
        GlobalProject: Code[50];
        GlobalBankAccount: Text[50];
        FrenchReport: Boolean;
        ShowStamp: Boolean;
        ShowNotice: Boolean;
        TotalLineDiscountAmt: Decimal;
        GlobalBalanceDue: Decimal;
        GlAmount: Decimal;
        //SelectedLanguage: Code[10];
        SalesOrderLabel: Label 'Commercial Invoice';
        OrderDateLabel: Label 'Invoice Date';
        BillingInfoLabel: Label 'Billing Info';
        ShippingInfoLabel: Label 'Shiping Info';
        CustomerNameLabel: Label 'Customer Name';
        CodeLabel: Label 'Code';
        BillingAddressLabel: Label 'Billing Address';
        PhoneLabel: Label 'Phone';
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
        GlCodeLabel: Label 'G/L Account No.';
        TotalGlAccountLabel: Label 'Total G/L Account';
        ProductLabel: Label 'Product';
        DescriptionLabel: Label 'Description';
        SizeLabel: Label 'Size';
        QtyLabel: Label 'QTY';
        UnitPriceLabel: Label 'U.P.';
        TotalPriceLabel: Label 'T.P.';
        TotalLabel: Label 'Total';
        DiscountLabel: Label 'Discount';
        VATLabel: Label 'VAT';
        GrossTotalLabel: Label 'Gross Total';
        AdvancePaymentLabel: Label 'Advance Payment';
        DueBalanceLabel: Label 'Due Balance';

        MOFReceiptLabel: Label 'Duty Stamp is paid in cash, MOF Receipt- ';
        RefLabel: label 'Ref.';
        ProjectLabel: label 'Project';
        IssuedateLabel: Label 'Issue Date:';
        IssueDateValue: Label 'Jan 23';
        RevisionDateLabel: Label 'Revision Date';
        FormNoLabel: label 'Form #:';
        FormNoValue: label 'ER\LB\AVER\S-SI\100';
        PageLabel: label 'Page';
        PageOfLabel: label 'of';
        RIBLabel: label 'RIB:';
}
