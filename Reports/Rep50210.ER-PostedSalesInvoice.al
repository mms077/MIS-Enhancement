report 50210 "ER - Posted Sales Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-PostedSalesInvoice.rdlc';
    Caption = 'Sales - Invoice';
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
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
            column(ShowLocalVAT; ShowLocalVAT)
            {

            }
            #endregion

            #region //Invoice Header
            column(Sales_Invoice_No; "Sales Invoice Header"."No.")
            {

            }
            column(Sales_Invoice_Posting_Date; "Sales Invoice Header"."Posting Date")
            {

            }
            column(TotalAmount; "Sales Invoice Header".Amount)
            {

            }
            column(InvoiceDiscount; "Sales Invoice Header"."Invoice Discount Amount")
            {

            }
            column(VAT_Amount; "Sales Invoice Header"."Amount Including VAT" - "Sales Invoice Header".Amount)
            {

            }
            column(Local_VAT_Amount; LocalVATAmount)
            {

            }
            column(Gross_Total; "Sales Invoice Header"."Amount Including VAT")
            {

            }
            column(Advance_Payment; "Sales Invoice Header"."Amount Including VAT" - GlobalBalanceDue)
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
            column(BillTo_PurchOrderRef; "Sales Invoice Header"."External Document No.")
            {

            }
            column(BillTo_PayTerms; GlobalPayTermsDescription)
            {

            }
            /*column(ColumnName; )
            {

            }*/ //Shipping Terms

            column(BillTo_DueDate; "Sales Invoice Header"."Due Date")
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
            column(ShipTo_Carrier; "Sales Invoice Header"."Shipping Agent Code")
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
            column(SalesInvoiceLabel; SalesInvoiceLabel)
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
            column(LocalVATLabel; LocalVATLabel)
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
            column(VAT_Percentage;VAT_Percentage)
            {

            }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                #region //Sales Invoice Lines Columns
                column(Line_Type; "Sales Invoice Line".Type)
                {

                }
                column(Line_HS_Ccode; GlobalItem."Hs Code")
                {

                }
                column(Line_Item_No; "Sales Invoice Line"."No.")
                {

                }
                column(Line_Item_Description; CeeAntCodeUnit.GetSalesInvoiceLineLanguageDescription("Sales Invoice Line"."Document No.", "Sales Invoice Line"."Line No.", SelectedLanguage))
                {

                }
                column(Line_Size; CeeAntCodeUnit.GetSizeValue("Sales Invoice Line".Size, SelectedLanguage))
                {

                }
                column(Line_Qty; "Sales Invoice Line".Quantity)
                {

                }
                column(Line_Unit_Price; "Sales Invoice Line"."Unit Price")
                {

                }
                column(Line_Amount; "Sales Invoice Line"."Line Amount")
                {

                }
                /////
                column(ItemsLinesAmounts;LinesTotalAmount)
                {

                }
                ////
                column(DepartmentName; DepartmentName)
                {

                }
                column(PositionName; PositionName)
                {

                }
                column(GlAmount; GlAmount)
                {

                }
                column(GL_Line;GL_Line)
                {

                }
                #endregion
                trigger OnAfterGetRecord()
                begin
                    Clear(GlobalItem);
                    GL_Line:=false;
                    if GlobalItem.Get("Sales Invoice Line"."No.") then;
                    //Hide not invoiced lines
                    if ("Sales Invoice Line".Type = "Sales Invoice Line".Type::Item) and ("Sales Invoice Line".Quantity = 0) then
                        CurrReport.Skip();

                    //Calculate Total Line Discount
                    TotalLineDiscountAmt := TotalLineDiscountAmt + "Sales Invoice Line"."Line Discount Amount" + "Sales Invoice Line"."Inv. Discount Amount";

                    //Get Allocation Name
                    GetAllocationName("Sales Invoice Header", "Sales Invoice Line");

                    //Get The Total Line Amount
                    if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then
                        LinesTotalAmount:=LinesTotalAmount+"Sales Invoice Line"."Line Amount";

                    //Calculate G/L Amount
                    if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" then begin
                        GL_Line:=true;
                        GlAmount := GlAmount + "Sales Invoice Line"."Line Amount";
                    end;

                end;
            }
            trigger OnPreDataItem()
            begin
                if "Sales Invoice Header".GetFilter("No.") = '' then
                    Error('Please select a Sales Invoice.');
            end;

            //Sales Invoice Header Triggers
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
                if GlobalShipToCustomer.Get("Sales Invoice Header"."Sell-to Customer No.") then
                    //Get Ship Address
                    ShipToAddress := "Sales Invoice Header"."Sell-to Country/Region Code" + ',' + "Sales Invoice Header"."Ship-to Address" + ',' + "Sales Invoice Header"."Ship-to Address 2";
                if GlobalBillToCustomer.Get("Sales Invoice Header"."Bill-to Customer No.") then begin
                    //Get Fiscal Code
                    Clear(GlobalFiscalCode);
                    if GlobalBillToCustomer."VAT Registration No." <> '' then
                        GlobalFiscalCode := GlobalBillToCustomer."VAT Registration No."
                    else
                        GlobalFiscalCode := GlobalBillToCustomer."CR No.";
                    //Get Bill Address
                    Clear(BillToAddress);
                    BillToAddress := "Sales Invoice Header"."Bill-to Country/Region Code" + ',' + "Sales Invoice Header"."Bill-to Address" + ',' + "Sales Invoice Header"."Bill-to Address 2"
                end;

                //Calculate Balance Due
                Clear(CustLedgerEntry);
                Clear(GlobalBalanceDue);
                CustLedgerEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                if CustLedgerEntry.FindFirst() then begin
                    CustLedgerEntry.CalcFields("Remaining Amount");
                    GlobalBalanceDue := CustLedgerEntry."Remaining Amount";
                end;
                //Get Shipment Method
                Clear(GlobalShipmentMethod);
                if GlobalShipmentMethod.Get("Sales Invoice Header"."Shipment Method Code") then;

                //Get Currency Code
                Clear(GlobalCurrencyCode);
                if "Sales Invoice Header"."Currency Code" = '' then
                    GlobalCurrencyCode := GeneralLedgerSetup."LCY Code"
                else
                    GlobalCurrencyCode := "Sales Invoice Header"."Currency Code";

                //Get Payment Terms
                Clear(PaymentTerms);
                Clear(GlobalPayTermsDescription);
                if PaymentTerms.Get("Payment Terms Code") then
                    GlobalPayTermsDescription := PaymentTerms.Description;

                

                //Barcode text
                Clear(BarcodeText);
                BarcodeText := "Sales Invoice Header"."Bill-to Customer No." + '+' + "Sales Invoice Header"."No.";

                //Contact
                Clear(GlobalContact);
                if GlobalContact.get("Sales Invoice Header"."Sell-to Contact No.") then;

                //Project
                Clear(GlobalProject);
                if "Sales Invoice Header"."Cust Project" = '' then
                    GlobalProject := "Sales Invoice Header"."IC Customer Project Code"
                else
                    GlobalProject := "Sales Invoice Header"."Cust Project";


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

                //Amount in Words
                AmountInWordsFunction("Sales Invoice Header"."Amount Including VAT", GlobalCurrencyCode);

                
                //Calculate Local VAT Amount
                LocalVatAmount := 0;
                "Sales Invoice Header".CalcFields("Amount Including VAT", Amount);
                //Currency is Local
                if "Currency Code" = '' then
                    LocalVatAmount := "Sales Invoice Header"."Amount Including VAT" - "Sales Invoice Header".Amount
                else
                    //Currency <> Local and currency factor <> 0
                    if "Currency Factor" <> 0 then
                        LocalVatAmount := ("Sales Invoice Header"."Amount Including VAT" - "Sales Invoice Header".Amount) / "Sales Invoice Header"."Currency Factor";
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
                    field(ShowLocalVAT; ShowLocalVAT)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Local VAT';
                    }
                }
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

    trigger OnPreReport()
    begin
        GeneralLedgerSetup.Get();
        CompanyInformation.Get();
        CompanyAddress := CompanyInformation.Address + ' ' + CompanyInformation."Address 2";
        CompanyInformation.CalcFields(Picture);
        VAT_Percentage := GeneralLedgerSetup."Default VAT %";
    end;
    trigger OnInitReport()
    begin
        Clear(SelectedLanguage);
        SelectedLanguage := G_CULanguage.GetLanguageCode(GlobalLanguage);
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

    procedure GetAllocationName(SalesInvHeader: Record "Sales Invoice Header"; SalesInvLine: Record "Sales Invoice Line")
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
            GetICAllocationName("Sales Invoice Header", "Sales Invoice Line", SalesInvHeader."IC Company Name", SalesInvHeader."IC Source No.", SalesInvHeader."IC Customer SO No.")
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

    procedure GetICAllocationName(SalesInvHeader: Record "Sales Invoice Header"; SalesInvLine: Record "Sales Invoice Line"; ICCompany: Code[20]; ICCustomerNo: Code[20]; ICCustomerSONo: Code[20])
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
        CompanyInformation: Record "Company Information";
        CeeAntCodeUnit: Codeunit CeeAnt;
        G_CULanguage: Codeunit Language;


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
        LinesTotalAmount: Decimal;
        FrenchReport: Boolean;
        ShowStamp: Boolean;
        ShowNotice: Boolean;
        TotalLineDiscountAmt: Decimal;
        GlobalBalanceDue: Decimal;
        GlAmount: Decimal;
        GL_Line:Boolean;
        ShowLocalVAT: Boolean;
        LocalVatAmount: Decimal;
        VAT_Percentage: Decimal;
        SelectedLanguage: Code[10];
        SalesInvoiceLabel: Label 'Sales Invoice';
        InvoiceDateLabel: Label 'Invoice Date';
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
        LocalVATLabel: Label 'VAT in LCY';
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