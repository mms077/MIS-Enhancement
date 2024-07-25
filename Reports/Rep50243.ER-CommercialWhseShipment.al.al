report 50243 "ER - Commercial Whse Shipment"
{
    ApplicationArea = All;
    Caption = 'ER - Commercial Invoice';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-CommercialWhseShipment.rdlc';
    dataset
    {
        dataitem(Header; "Warehouse Shipment Header")
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
            column(Sales_Order_No; Header."Sales Invoice No.")
            {

            }
            column(Sales_Order_Posting_Date; Header."Posting Date")
            {

            }
            column(TotalAmount; TotalAmount)
            {

            }
            column(InvoiceDiscount; SalesHeader."Invoice Discount Amount")
            {

            }
            column(VAT_Amount; TotalVat)
            {

            }
            column(Gross_Total; TotalAmountIncludingVat)
            {

            }
            column(Advance_Payment; SalesHeader."Amount Including VAT" - GlobalBalanceDue)
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

            column(BillTo_DueDate; SalesHeader."Due Date")
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

            dataitem("Line"; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                column(Line_Type; SalesLine.Type)
                {

                }
                column(Line_HS_Ccode; GlobalItem."Hs Code")
                {

                }
                column(Line_Item_No; line."Item No.")
                {

                }
                column(Line_Item_Description; Line."Description")
                {

                }
                column(Line_Size; Size)
                {

                }
                column(Line_Qty; Line.Quantity)
                {

                }
                column(Line_Unit_Price; SalesLine."Unit Price")
                {

                }
                column(Line_Amount; SalesLine."Line Amount")
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

                trigger OnAfterGetRecord()
                var

                begin

                    Clear(SalesLine);
                    if SalesLine.get(SalesLine."Document Type"::Order, line."Source No.", Line."Source Line No.") then begin
                        // LineAmount := Round(SalesLine.Amount * SalesLine."Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");
                        Clear(Customer);
                        if Customer.get(SalesLine."Sell-to Customer No.") then;
                        //Get Currency Code
                        Clear(GlobalCurrencyCode);
                        if SalesLine."Currency Code" = '' then
                            GlobalCurrencyCode := GeneralLedgerSetup."LCY Code"
                        else
                            GlobalCurrencyCode := SalesLine."Currency Code";
                    end;
                    Clear(GlobalItem);
                    if GlobalItem.Get(Line."Item No.") then;
                    //Hide not invoiced lines
                    /*if (Line.Type = Line.Type::Item) and (Line.Quantity = 0) then
                        CurrReport.Skip();*/

                    //Calculate Total Line Discount
                    TotalLineDiscountAmt := TotalLineDiscountAmt + SalesLine."Line Discount Amount" + SalesLine."Inv. Discount Amount";

                    //Get Allocation Name
                    GetAllocationName(SalesHeader, SalesLine);

                    //Calculate G/L Amount
                    if SalesLine.Type = SalesLine.Type::"G/L Account" then
                        GlAmount := GlAmount + SalesLine."Line Amount";

                end;
            }
            trigger OnPreDataItem()
            begin
                if Header.GetFilter("No.") = '' then
                    Error('Please select a Sales Invoice.');
            end;


            //Sales Order Header Triggers
            trigger OnAfterGetRecord()
            var
                PaymentTerms: Record "Payment Terms";
                CustLedgerEntry: Record "Cust. Ledger Entry";
                //  SalesLine: Record "Sales Line";
                UniqueSales: Dictionary of [Code[20], Decimal];
                DocNo: Code[20];
                WhseShipLine: Record "Warehouse Shipment Line";
            begin
                //Get Total Amount
                WhseShipLine.SetFilter("No.", Header."No.");
                if WhseShipLine.FindSet() then
                    repeat
                        SalesHeaderTotal.SetRange("No.", WhseShipLine."Source No.");
                        if SalesHeaderTotal.FindSet() then
                            repeat
                                SalesHeaderTotal.CalcFields(Amount, "Amount Including VAT");
                                if not UniqueSales.ContainsKey(SalesHeaderTotal."No.") then begin
                                    TotalAmount := TotalAmount + SalesHeaderTotal.Amount;
                                    TotalVat := TotalVat + SalesHeaderTotal."Amount Including VAT" - SalesHeaderTotal.Amount;
                                    TotalAMountIncludingVat := TotalAmountIncludingVat + SalesHeaderTotal."Amount Including VAT";
                                    //Amount in Words
                                    AmountInWordsFunction(SalesHeaderTotal."Amount Including VAT", GlobalCurrencyCode);
                                    UniqueSales.Add(SalesHeaderTotal."No.", SalesHeaderTotal.Amount);
                                end;
                            until SalesHeaderTotal.Next() = 0;
                    until WhseShipLine.Next() = 0;

                GlAmount := 0;
                Clear(TotalLineDiscountAmt);
                Clear(GlobalShipToCustomer);
                Clear(GlobalBillToCustomer);
                Clear(BillToAddress);
                SalesHeader.get(SalesHeader."Document Type"::Invoice, Header."Sales Invoice No.");
                SalesHeader.CalcFields(Amount);
                SalesHeader.CalcFields("Amount Including VAT");
                if GlobalShipToCustomer.Get(SalesHeader."Sell-to Customer No.") then
                    //Get Ship Address
                    ShipToAddress := SalesHeader."Sell-to Country/Region Code" + ',' + SalesHeader."Ship-to Address" + ',' + SalesHeader."Ship-to Address 2";
                if GlobalBillToCustomer.Get(SalesHeader."Bill-to Customer No.") then begin
                    //Get Fiscal Code
                    Clear(GlobalFiscalCode);
                    if GlobalBillToCustomer."VAT Registration No." <> '' then
                        GlobalFiscalCode := GlobalBillToCustomer."VAT Registration No."
                    else
                        GlobalFiscalCode := GlobalBillToCustomer."CR No.";
                    //Get Bill Address
                    Clear(BillToAddress);
                    BillToAddress := SalesHeader."Bill-to Country/Region Code" + ',' + SalesHeader."Bill-to Address" + ',' + SalesHeader."Bill-to Address 2"
                end;

                //Calculate Balance Due
                Clear(CustLedgerEntry);
                Clear(GlobalBalanceDue);
                CustLedgerEntry.SetRange("Document No.", Header."No.");
                if CustLedgerEntry.FindFirst() then begin
                    CustLedgerEntry.CalcFields("Remaining Amount");
                    GlobalBalanceDue := CustLedgerEntry."Remaining Amount";
                end;
                //Get Shipment Method
                Clear(GlobalShipmentMethod);
                if GlobalShipmentMethod.Get(Header."Shipment Method Code") then;



                //Get Payment Terms
                Clear(PaymentTerms);
                Clear(GlobalPayTermsDescription);
                if PaymentTerms.Get(SalesHeader."Payment Terms Code") then
                    GlobalPayTermsDescription := PaymentTerms.Description;



                //Barcode text
                Clear(BarcodeText);
                BarcodeText := SalesHeader."Bill-to Customer No." + '+' + Header."No.";

                //Contact
                Clear(GlobalContact);
                if GlobalContact.get(SalesHeader."Sell-to Contact No.") then;

                //Project
                Clear(GlobalProject);
                if SalesHeader."Cust Project" = '' then
                    GlobalProject := SalesHeader."IC Customer Project Code"
                else
                    GlobalProject := SalesHeader."Cust Project";


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
                    field(LockWhseDoc; LockWhseDoc)
                    {
                        ApplicationArea = All;
                        Caption = 'Lock Warehouse Shipment';
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
    trigger OnPostReport()
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
    begin
        if LockWhseDoc then begin
            WarehouseShipmentHeader.SetFilter("No.", Header."No.");
            if WarehouseShipmentHeader.FindFirst() then begin
                WarehouseShipmentHeader.Printed := true;
                WarehouseShipmentHeader.Modify();
            end;
        end;
    end;

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
            GetICAllocationName(SalesHeader, SalesLine, SalesHeader."IC Company Name", SalesHeader."IC Source No.", SalesHeader."IC Customer SO No.")
        else begin
            //if SalesLine.get(SalesLine."Document Type"::Order, Rec."Source No.", Rec."Source Line No.") then begin
            case SalesLine."Allocation Type" of
                SalesLine."Allocation Type"::" ":
                    exit;
                SalesLine."Allocation Type"::Department:
                    begin
                        if CustomerDepartment.Get(SalesLine."Sell-to Customer No.", line."Allocation Code") then begin
                            if Department.Get(CustomerDepartment."Department Code") then
                                DepartmentName := Department.Name;
                        end;
                    end;
                SalesLine."Allocation Type"::Position:
                    begin
                        if ParameterHeader.Get(SalesLine."Parameters Header ID") then begin
                            CustomerPosition.SetRange("Position Code", line."Allocation Code");
                            CustomerPosition.SetRange("Customer No.", SalesHeader."Sell-to Customer No.");
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
                            CustomerStaff.SetRange(Code, Line."Allocation Code");
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
        TotalAmount: Decimal;
        TotalVat: Decimal;
        TotalAmountIncludingVat: Decimal;
        FrenchReport: Boolean;
        ShowStamp: Boolean;
        ShowNotice: Boolean;
        LockWhseDoc: Boolean;
        TotalLineDiscountAmt: Decimal;
        GlobalBalanceDue: Decimal;
        Customer: Record Customer;
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
        SalesLine: Record "Sales Line";
        SalesHeaderTotal: Record "Sales header";
        SalesHeader: Record "Sales header";
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
