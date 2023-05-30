report 50229 "ER - Delivery Note AR"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-DeliveryNote_AR.rdlc';
    Caption = 'Delivery Note Arabic';
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(invoiceNo_Value; "Sales Invoice Header"."No."){}
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                DataItemTableView = sorting("No.");
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
                column(Comapny_Phone; CompanyInformation."Phone No.")
                {

                }
                column(Company_Fax; CompanyInformation."Fax No.")
                {

                }
                column(Company_Email; CompanyInformation."E-Mail")
                {

                }
                column(Company_Address; CompanyAddress)
                {

                }
                column(Company_City; CompanyInformation."City")
                {

                }
                column(LCY_Code; GeneralLedgerSetup."LCY Code")
                {

                }
                column(MOFReceipt; GeneralLedgerSetup."MOF Receipt")
                {

                }
                column(CRValue; CompanyInformation."CR No.")
                {

                }
                #endregion

                #region //Shipment Header
                column(Sales_Shipment_No; "Sales Shipment Header"."No.")
                {

                }
                column(Sales_Shipment_Posting_Date; "Sales Shipment Header"."Posting Date")
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
                column(ShipToCity; "Ship-to City")
                {

                }
                column(ShipToCountry; "Ship-to Country/Region Code")
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
                column(Sell_to_Address; "Sell-to Address")
                {

                }
                column(Sell_to_City; "Sell-to City")
                {

                }
                column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
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
                column(BillTo_PurchOrderRef; "Sales Shipment Header"."External Document No.")
                {

                }
                column(BillTo_PayTerms; GlobalPayTermsDescription)
                {

                }
                /*column(ColumnName; )
                {

                }*/ //Shipping Terms

                column(BillTo_DueDate; "Sales Shipment Header"."Due Date")
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
                column(SalesOrderNo; "Order No.")
                {

                }

                column(ShipToPostalCode; "Ship-to Post Code")
                {

                }

                #endregion

                #region //Labels
                column(FormNoValueLabel;FormNoValueLabel){}
                column(FormNoLabel;FormNoLabel){}
                column(SalesShipmentLabel; SalesShipmentLabel)
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
                column(CustomerNameLabelArabic; CustomerNameLabelArabic) { }
                column(CodeLabel; CodeLabel)
                {

                }
                column(CodeLabelArabic; CodeLabelArabic) { }
                column(BillingAddressLabel; BillingAddressLabel)
                {

                }
                column(PhoneLabel; PhoneLabel)
                {

                }
                column(PhoneLabelArabic; PhoneLabelArabic) { }
                column(FiscalCodeLabel; FiscalCodeLabel)
                {

                }
                column(CurrencyLabel; CurrencyLabel)
                {

                }
                column(CurrencyLabelArabic; CurrencyLabelArabic) { }
                column(PurchOrderRefLabel; PurchOrderRefLabel)
                {

                }

                column(PaymentTermsLabel; PaymentTermsLabel)
                {

                }
                column(paymentTermsLabelArabic; paymentTermsLabelArabic) { }
                column(ShippingTermsLabel; ShippingTermsLabel)
                {

                }
                column(ShippingTermsLabelArabic; ShippingTermsLabelArabic) { }
                column(DueDateLabel; DueDateLabel)
                {

                }
                column(ShippingAddressLabel; ShippingAddressLabel) { }
                column(ShippingAddressLabelArabic; ShippingAddressLabelArabic) { }
                column(ReceiverNameLabel; ReceiverNameLabel)
                {

                }
                column(ReceiverNameLabelArabic; ReceiverNameLabelArabic) { }
                column(ReceiverContactLabel; ReceiverContactLabel)
                {

                }
                column(ReceiverContactLabelArabic; ReceiverContactLabelArabic) { }
                column(ShippingModeLabel; ShippingModeLabel)
                {

                }
                column(ShippingModeLabelArabic; ShippingModeLabelArabic) { }
                column(CarrierLabel; CarrierLabel)
                {

                }
                column(CarrierLabelArabic; CarrierLabelArabic) { }
                column(BillRefNumberLabel; BillRefNumberLabel)
                {

                }
                column(BillRefNumberLabelArabic; BillRefNumberLabelArabic) { }
                column(CapitalLabel; CapitalLabel)
                {

                }
                column(VATCodeLabel; VATCodeLabel)
                {

                }
                column(CRLabel; CRLabel) { }
                column(VATCodeLabelArabic; VATCodeLabelArabic) { }
                column(AddressLabel; AddressLabel)
                {

                }
                column(AddressLabelArabic; AddressLabelArabic) { }
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
                column(ProductDescriptionLabel; ProductDescriptionLabel)
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
                column(IssueDateLabel; IssueDateLabel)
                {

                }
                column(IssueDateValueLabel;IssueDateValueLabel){}

                column(RevisionDateLabel; "RevisionDateLabel")
                {

                }
                column(MOFReceiptLabel; MOFReceiptLabel)
                {

                }
                column(ClientDepLabel; ClientDepLabel)
                {

                }
                column(CountryCityLabel; CountryCityLabel) { }
                column(CountryCityLabelArabic; CountryCityLabelArabic) { }
                column(PostalCodeLabel; PostalCodeLabel) { }
                column(PostalCodeLabelArabic; PostalCodeLabelArabic) { }
                column(SalesOrderNbLabel; SalesOrderNbLabel) { }
                column(SalesOrderNbLabelArabic; SalesOrderNbLabelArabic) { }
                column(InvoiceDateLabel; InvoiceDateLabel) { }
                column(InvoiceDateLabelArabic; InvoiceDateLabelArabic) { }
                column(InvoiceNbLabel; InvoiceNoLabel) { }
                column(InvoiceNo; "No.")
                {
                }
                column(InvoiceNbLabelArabic; InvoiceNoLabelArabic) { }
                column(Posting_Date; "Posting Date")
                {

                }
                column(G_ShipToCountryCity; G_ShipToCountryCity) { }

                #endregion

                #region Terms and Conditions
                column(TermsAndConditionsLabel; TermsandCondLabel)
                {

                }
                column(ImportantNoticeLabel; ImportantNoticeLabel) { }
                column(TermsAndCondText; TermsAndCondText) { }
                column(TermsAndCondText_1; TermsAndCondText_1) { }
                column(TermsAndCondText_2; TermsAndCondText_2) { }
                column(TermsAndCondText_3; TermsAndCondText_3) { }
                column(TermsAndCondText_4; TermsAndCondText_4) { }
                column(TermsAndCondText_5; TermsAndCondText_5) { }
                column(TermsAndCondText_6; TermsAndCondText_6) { }
                column(TermsAndCondText_7; TermsAndCondText_7) { }
                column(TermsAndCondText_7_Infos; TermsAndCondText_7_Infos) { }
                column(TermsAndCondText_8; TermsAndCondText_8) { }
                column(TermsAndCondText_9; TermsAndCondText_9) { }
                column(TermsAndCondText_10; TermsAndCondText_10) { }
                column(TermsAndCondText_11; TermsAndCondText_11) { }
                column(TermsAndCondText_12; TermsAndCondText_12) { }
                column(TermsAndCondText_13; TermsAndCondText_13) { }
                column(TermsAndCondText_14; TermsAndCondText_14) { }
                column(TermsAndCondText_15; TermsAndCondText_15) { }
                column(TermsAndCondText_16; TermsAndCondText_16) { }
                column(TermsAndCondText_17; TermsAndCondText_17) { }
                #endregion

                dataitem("Sales Shipment Line"; "Sales Shipment Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = sorting("Document No.");
                    #region //Sales Shipment Lines Columns
                    column(Line_Type; "Sales Shipment Line".Type)
                    {

                    }
                    column(Line_HS_Ccode; GlobalItem."Hs Code")
                    {

                    }
                    column(Line_Item_No; "Sales Shipment Line"."No.")
                    {

                    }
                    column(Line_Item_Description; "Sales Shipment Line".Description)
                    {

                    }
                    column(Line_Size; SizeName)
                    {

                    }
                    column(Line_Qty; "Sales Shipment Line".Quantity)
                    {

                    }
                    column(Line_Unit_Price; "Sales Shipment Line"."Unit Price")
                    {

                    }
                    column(DepartmentName; DepartmentName)
                    {

                    }
                    column(PositionName; PositionName)
                    {

                    }
                    #endregion
                    trigger OnAfterGetRecord()
                    begin
                        Clear(GlobalItem);
                        if GlobalItem.Get("Sales Shipment Line"."No.") then;
                        //Hide not 0 Qty lines
                        if ("Sales Shipment Line".Type = "Sales Shipment Line".Type::Item) and ("Sales Shipment Line".Quantity = 0) then
                            CurrReport.Skip();

                        //Get Allocation Name
                        GetAllocationName("Sales Shipment Header", "Sales Shipment Line");
                        G_Size.SetRange(Code, "Sales Shipment Line".Size);
                        if G_Size.FindFirst then
                            SizeName := G_Size.INTL;

                    end;
                }

                //Sales Shipment Header Triggers
                trigger OnPreDataItem()
                begin
                    "Sales Shipment Header".setrange("No.", PSH_List.Get(PSH_No));
                    PSHNB:=PSH_List.Get(PSH_No);
                    if PSH_No < PSH_List.count() then
                        PSH_No := PSH_No + 1;
                end;
                
                
                
                
                trigger OnAfterGetRecord()
                var
                    PaymentTerms: Record "Payment Terms";
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                begin
                    Clear(TotalLineDiscountAmt);
                    Clear(GlobalShipToCustomer);
                    Clear(GlobalBillToCustomer);

                    "Sales Shipment Header".Reset();
                    "Sales Shipment Header".SetRange("No.", PSH_List.Get(PSH_No));
                    PSHNB := PSH_List.Get(PSH_No);
                    if PSH_No < PSH_List.count() then
                        PSH_No := PSH_No + 1;

                    if GlobalShipToCustomer.Get("Sales Shipment Header"."Sell-to Customer No.") then
                        //Get Ship Address
                        ShipToAddress := "Sales Shipment Header"."Sell-to Country/Region Code" + ',' + "Sales Shipment Header"."Ship-to Address" + ',' + "Sales Shipment Header"."Ship-to Address 2";
                    if GlobalBillToCustomer.Get("Sales Shipment Header"."Bill-to Customer No.") then begin
                        //Get Fiscal Code
                        Clear(GlobalFiscalCode);
                        if GlobalBillToCustomer."VAT Registration No." <> '' then
                            GlobalFiscalCode := GlobalBillToCustomer."VAT Registration No."
                        else
                            GlobalFiscalCode := GlobalBillToCustomer."CR No.";
                        //Get Bill Address
                    end;

                    //Get Shipment Method
                    Clear(GlobalShipmentMethod);
                    if GlobalShipmentMethod.Get("Sales Shipment Header"."Shipment Method Code") then;

                    //Get Currency Code
                    Clear(GlobalCurrencyCode);
                    if "Sales Shipment Header"."Currency Code" = '' then
                        GlobalCurrencyCode := GeneralLedgerSetup."LCY Code"
                    else
                        GlobalCurrencyCode := "Sales Shipment Header"."Currency Code";

                    //Get Payment Terms
                    Clear(PaymentTerms);
                    Clear(GlobalPayTermsDescription);
                    if PaymentTerms.Get("Payment Terms Code") then
                        GlobalPayTermsDescription := PaymentTerms.Description;

                    //Barcode text
                    Clear(BarcodeText);
                    BarcodeText := "Sales Shipment Header"."Bill-to Customer No." + '+' + "Sales Shipment Header"."No.";

                    //Contact
                    Clear(GlobalContact);
                    if GlobalContact.get("Sales Shipment Header"."Sell-to Contact No.") then;

                    //Project
                    /*Clear(GlobalProject);
                    if "Sales Shipment Header"."Cust Project" = '' then
                        GlobalProject := "Sales Shipment Header"."IC Client Project Code"
                    else
                        GlobalProject := "Sales Shipment Header"."Cust Project";*/
                end;

            }
            trigger OnAfterGetRecord()
            begin
                GlobalSLI.Reset();
                GlobalSLI.SetRange("Document No.", "Sales Invoice Header"."No.");
                if GlobalSLI.FindFirst() then begin//I filled the list with all the shipment no. of the invoice Lines
                    repeat
                        if not PSH_List.Contains(GlobalSLI."Shipment No.") then
                            if GlobalSLI."Shipment No." <> '' then
                                PSH_List.Add(GlobalSLI."Shipment No.");
                    until GlobalSLI.Next() = 0;
                end;
                if PSH_List.Count() = 0 then begin
                    Error(ErrorMessage1);
                    CurrReport.skip();
                end;
                    
            end;

        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    /*field(Name; SourceExpression)
                    {
                        ApplicationArea = All;

                    }*/
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        GeneralLedgerSetup.Get();
        CompanyInformation.Get();
        // G_ShipToCountryCity := "Sales Shipment Header"."Ship-to City" + ' ' + "Sales Shipment Header"."Ship-to Country/Region Code";
        CompanyAddress := CompanyInformation.Address + ' ' + CompanyInformation."Country/Region Code";
        CompanyInformation.CalcFields(Picture);
        PSH_No:=1;
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

    procedure GetAllocationName(SalesShipmentHeader: Record "Sales Shipment Header"; SalesShipmentLine: Record "Sales Shipment Line")
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
        if SalesShipmentHeader."IC Source No." <> '' then
            GetICAllocationName("Sales Shipment Header", "Sales Shipment Line", SalesShipmentHeader."IC Company Name", SalesShipmentHeader."IC Source No.", SalesShipmentHeader."IC Customer SO No.")
        else begin
            //if SalesLine.get(SalesLine."Document Type"::Order, Rec."Source No.", Rec."Source Line No.") then begin
            case SalesShipmentLine."Allocation Type" of
                SalesShipmentLine."Allocation Type"::" ":
                    exit;
                SalesShipmentLine."Allocation Type"::Department:
                    begin
                        if CustomerDepartment.Get(SalesShipmentLine."Sell-to Customer No.", SalesShipmentLine."Allocation Code") then begin
                            if Department.Get(CustomerDepartment."Department Code") then
                                DepartmentName := Department.Name;
                        end;
                    end;
                SalesShipmentLine."Allocation Type"::Position:
                    begin
                        if ParameterHeader.Get(SalesShipmentLine."Parameters Header ID") then begin
                            CustomerPosition.SetRange("Position Code", SalesShipmentLine."Allocation Code");
                            CustomerPosition.SetRange("Customer No.", SalesShipmentLine."Sell-to Customer No.");
                            CustomerPosition.SetRange("Department Code", ParameterHeader."Department Code");
                            if CustomerPosition.FindFirst() then begin
                                if Position.Get(CustomerPosition."Position Code") then
                                    PositionName := Position.Name;
                                if Department.Get(ParameterHeader."Department Code") then
                                    DepartmentName := Department.Name;
                            end;
                        end;
                    end;
                SalesShipmentLine."Allocation Type"::Staff:
                    begin
                        if ParameterHeader.Get(SalesShipmentLine."Parameters Header ID") then begin
                            CustomerStaff.SetRange(Code, SalesShipmentLine."Allocation Code");
                            CustomerStaff.SetRange("Customer No.", SalesShipmentLine."Sell-to Customer No.");
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

    procedure GetICAllocationName(SalesShipHeader: Record "Sales Shipment Header"; SalesShipLine: Record "Sales Shipment Line"; ICCompany: Code[20]; ICCustomerNo: Code[20]; ICCustomerSONo: Code[20])
    var
        ICSalesHeader: Record "Sales Header";
        ICSalesInvHeader: Record "Sales Invoice Header";
        ICSalesLine: Record "Sales Line";
        ICSalesInvLine: Record "Sales Invoice Line";
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
        ICSalesInvHeader.ChangeCompany(ICCompany);
        if ICSalesHeader.get(ICSalesHeader."Document Type"::Order, ICCustomerSONo) then begin
            ICSalesLine.ChangeCompany(ICCompany);
            ICSalesLine.SetRange("Document No.", ICSalesHeader."No.");
            ICSalesLine.SetRange("Allocation Type", SalesShipLine."Allocation Type");
            iCSalesLine.SetRange("Allocation Code", SalesShipLine."Allocation Code");
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
            //If the sales order is fully invoiced and archived   
        end else begin
            ICSalesInvHeader.SetRange("Order No.", ICCustomerSONo);
            if ICSalesInvHeader.FindFirst() then begin
                ICSalesInvLine.ChangeCompany(ICCompany);
                ICSalesInvLine.SetRange("Document No.", ICSalesInvHeader."No.");
                ICSalesInvLine.SetRange("Allocation Type", SalesShipLine."Allocation Type");
                ICSalesInvLine.SetRange("Allocation Code", SalesShipLine."Allocation Code");
                if ICSalesInvLine.FindFirst() then begin
                    case ICSalesInvLine."Allocation Type" of
                        ICSalesInvLine."Allocation Type"::" ":
                            exit;
                        ICSalesInvLine."Allocation Type"::Department:
                            begin
                                if CustomerDepartment.Get(ICSalesInvLine."Sell-to Customer No.", ICSalesInvLine."Allocation Code") then begin
                                    if Department.Get(CustomerDepartment."Department Code") then
                                        DepartmentName := Department.Name;
                                end;
                            end;
                        ICSalesInvLine."Allocation Type"::Position:
                            begin
                                if ParameterHeader.Get(ICSalesInvLine."Parameters Header ID") then begin
                                    CustomerPosition.SetRange("Position Code", ICSalesInvLine."Allocation Code");
                                    CustomerPosition.SetRange("Customer No.", ICSalesInvLine."Sell-to Customer No.");
                                    CustomerPosition.SetRange("Department Code", ParameterHeader."Department Code");
                                    if CustomerPosition.FindFirst() then begin
                                        if Position.Get(CustomerPosition."Position Code") then
                                            PositionName := Position.Name;
                                        if Department.Get(ParameterHeader."Department Code") then
                                            DepartmentName := Department.Name;
                                    end;
                                end;
                            end;
                        ICSalesInvLine."Allocation Type"::Staff:
                            begin
                                if ParameterHeader.Get(ICSalesInvLine."Parameters Header ID") then begin
                                    CustomerStaff.SetRange(Code, ICSalesInvLine."Allocation Code");
                                    CustomerStaff.SetRange("Customer No.", ICSalesInvLine."Sell-to Customer No.");
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
    end;

    var
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GlobalShipToCustomer: Record Customer;
        GlobalBillToCustomer: Record Customer;
        GlobalShipmentMethod: Record "Shipment Method";
        GlobalSLI:Record "Sales Invoice Line";
        GlobalItem: Record Item;
        G_Size: Record Size;
        GlobalContact: Record Contact;
        GlobalFiscalCode: Text[30];
        AmountinWords: Text[250];
        GlobalCurrencyCode: Code[10];
        GlobalPayTermsDescription: Text[100];
        CompanyAddress: Text[250];
        G_ShipToCountryCity: Text[250];

        BarcodeText: Text[150];
        DepartmentName: Text[150];
        PositionName: Text[150];
        StaffName: Text[150];
        ShipToAddress: Text[250];
        GlobalProject: Code[50];
        TotalLineDiscountAmt: Decimal;
        GlobalBalanceDue: Decimal;
        SizeName: Code[20];
        PSHNB: Code[20];
        PSH_List: List of [Code[20]];
        PSH_No: Integer;
        ErrorMessage1:label 'Please Selecte a Sales Invoice that contains Posted Sales Shipment in the Sales Lines';
        SalesShipmentLabel: Label 'Delivery Note Of ';
        BillingInfoLabel: Label 'Bill To Customer';
        ShippingInfoLabel: Label 'Ship To Customer';
        CustomerNameLabel: Label 'Customer Name';
        CustomerNameLabelArabic: Label 'اسم العميل';
        CodeLabel: Label 'Code';
        CodeLabelArabic: label 'رمز العميل';
        BillingAddressLabel: Label 'Billing Address';
        PhoneLabel: Label 'Phone';
        PhoneLabelArabic: Label 'الهاتف';
        FiscalCodeLabel: Label 'VAT Number';
        CurrencyLabel: Label 'Currency';
        CurrencyLabelArabic: Label 'العملة';
        PurchOrderRefLabel: Label 'Po No.';
        PaymentTermsLabel: Label 'Payment Terms';
        paymentTermsLabelArabic: Label 'شروط الدفع';
        ShippingTermsLabel: Label 'Shipping Terms';
        ShippingTermsLabelArabic: Label 'شروط الشحن';
        DueDateLabel: Label 'Due Date';
        ShippingAddressLabel: Label 'Shiping Address';
        ShippingAddressLabelArabic: Label 'عنوان الشحن';
        ReceiverNameLabel: Label 'Receiver Name';
        ReceiverNameLabelArabic: Label 'اسم المستلم';
        ReceiverContactLabel: Label 'Receiver Contact';
        ReceiverContactLabelArabic: Label 'جهة اتصال المستلم';
        ShippingModeLabel: Label 'Shiping Mode';
        ShippingModeLabelArabic: Label 'طريقة الشحن';
        CarrierLabel: Label 'Carrier';
        CarrierLabelArabic: Label 'شركة الشحن';
        BillRefNumberLabel: Label 'Bill Ref. Number';
        BillRefNumberLabelArabic: Label 'رقم الفاتورة';
        CapitalLabel: Label 'Capital';
        VATCodeLabel: Label 'VAT';
        CRLabel: Label 'CR';
        VATCodeLabelArabic: Label 'رقم تسجيل القيمة المضافة';
        AddressLabel: Label 'Address';
        AddressLabelArabic: Label 'العنوان';
        BankAccountLabel: Label 'Bank Account';
        SWIFTLabel: Label 'SWIFT';
        PrintedOnLabel: Label 'Printed On';
        HSCodeLabel: Label 'HS Code';
        ItemCodeLabel: Label 'Item No.';
        ProductDescriptionLabel: Label 'Description';
        SizeLabel: Label 'Size';
        QtyLabel: Label 'Qty';
        UnitPriceLabel: Label 'Unit Price';
        TotalPriceLabel: Label 'Total Price';
        TotalLabel: Label 'Total';
        DiscountLabel: Label 'Discount';
        VATLabel: Label 'VAT';
        GrossTotalLabel: Label 'Gross Total';
        AdvancePaymentLabel: Label 'Advance Payment';
        DueBalanceLabel: Label 'Due Balance';
        IssuedateLabel: Label 'Issue Date:';
        IssueDateValueLabel: Label 'Jan 23';
        RevisionDateLabel: Label 'Revision Date';
        MOFReceiptLabel: Label 'Duty Stamp is paid in cash, MOF Receipt- ';
        ClientDepLabel: label 'Client Dep.';
        ProjectLabel: label 'Project';
        ProjectLabelArabic: label 'مشروع';
        CountryCityLabel: label 'Country & City';
        CountryCityLabelArabic: label 'البلد والمدينة';
        PostalCodeLabel: label 'Postal Code';
        PostalCodeLabelArabic: label 'الرمز البريدي';
        SalesOrderNbLabel: label 'SO#';
        SalesOrderNbLabelArabic: label 'رقم الطلبية';
        InvoiceNoLabel: label 'Invoice No. ';
        FormNoLabel: label 'Form #:';
        FormNoValueLabel:label 'ER\KSA\TCC\S-DN\100';
        InvoiceNoLabelArabic: label 'رقم الفاتورة';
        InvoiceDateLabel: label 'Invoice Date';
        InvoiceDateLabelArabic: label 'تاريخ الفاتورة';
        TermsAndCondLabel: label 'Terms and Conditions';
        ImportantNoticeLabel: label '- Important Notice -';
        TermsAndCondText: label 'When ordering from Emile Rassam or any affiliate company (referred to hereafter as "ER"), you, as "client", are agreeing, on your behalf and on behalf of your organization, that the "General Terms & Conditions" shall apply from the time the order is placed and confirmed unless otherwise agreed in writing by an authorized officer of Emile Rassam.';
        TermsAndCondText_1: label '1.Preamble: This Preamble consitutes an integral part of the sales transaction.';
        TermsAndCondText_2: label '2. Representation: The Client and whoever from his organization placing the order with us are all considered as one. The Purchase order supercedes any verbal conversation or discussion. Any special request or changes to any order has to be made in writing prior to any initiation. of production.';
        TermsAndCondText_3: label '3. Delivery: ER takes dates very seriously and will make every reasonable effort to deliver the "Order" on the agreed dates, but these schedules are not binding and do not form any part of the contract. Emile Rassam is not liable for any damages or loss caused by delays despite its nature.';
        TermsAndCondText_4: label '4. Samples: When the client or any team member in his organization in charge approves samples submitted by ER, he then approves the quality, fit, construction and any material that constitute these samples. The client is herein expected to run the relevant test washes as described on the washing instruction label attached to the inside garment. By approving the samples it is considered that the client is fully aware and approves the results of the washing.';
        TermsAndCondText_5: label '5. Bank charges: In the case of payment by bank transfers, charges are to be borne by the remitter. charges are to be borne by the remitter.';
        TermsAndCondText_6: label '6. Sizes: All sizes will be standard European sizes.';
        TermsAndCondText_7: label '7. Tailors assistance: Unless otherwise agreed in writing, orders do not include tailors visits for measurements taking or fitting sessions. Such services are quoted separately depending on the geographic location of the clients project, its size and manning required. When ER agrees to extend such services, the client agrees to take charge of the accomodation & meals of the ER team who will be responsible for this assignement - such teams are usually made of 2 to 4 members maximum. In order for these missions to serve its purpose the client should have at least 4 industrial machines available:';
        TermsAndCondText_7_Infos: label '1- 2 x regular sewing machine - 2- Ix overlock, - 4-1 x blind stitch machine.';
        TermsAndCondText_8: label '8. Personalization: Artwork must be submitted together with your confirmation (in .eps format) together with the purchase order. Any delay in submission might and could impact the delivery schedules.';
        TermsAndCondText_9: label '9. Currency: ER accepts only the currency stated on their quotations. In case payments are made in a different currency, conversion charges will be charged to your account.our account.';
        TermsAndCondText_10: label '10. Returns & exchanges: No returns or exchanges can be given on items manufactured to your specifications, unless there is a manufacturing defect or the goods are not conform to the order. Items to return must be announced in writing within a period of 14 days from the delivery date and shall remain unused in its original packing. When the client requests a return or an exchange it remains subject to approval by ER official representative.';
        TermsAndCondText_11: label '11. Missing items: Please ensure you check all items against the delivery note. In the event that items are missing, claims need to be communicated to ER in writing within seven calendar days after delivery.';
        TermsAndCondText_12: label '12. Cancellations: Please note order cancellations will only be accepted prior to production being launched. In the case of cancellations registered while your order is in production, the full value of the cancelled items will be charged. Deposits will be refunded only if production has not been launched to the value of 80%, the retained 20% will be deductible against any other order and must be utilized within 3 months from the cancellation date.';
        TermsAndCondText_13: label '13. Transportation: ER or his affiliate companies can only recommend shipping companies to use for the transportation of goods however is not responsible for delays or complications generated by the latter The client has the right to accept any shipper he trusts to ship his order.';
        TermsAndCondText_14: label '14. Social media: ER reserves the right to mention their clients names or visuals in social media marketing and or newsletters whether electronic or hard publications.';
        TermsAndCondText_15: label '15. Validity & Expiry: ER reserves the right to mention their clients names or project subject to this quotation in social media and or newsletters or press releases whether electronic or hard publications.';
        TermsAndCondText_16: label '16. Force Majeure: ER is not liable for any delay or failure to deliver as a result to Acts of Nature (including fire, floods, earthquake, storms, hurricanes or other natural disasters), war, invasion, insurrection, military or usurped power of confiscation, terrorist activities, nationalization, government sanction, blockage, embargo, labour dispute, strike, lockout or interruption or failure of power sources.';
        TermsAndCondText_17: label '17. Arbitrage: In case of disputes, the laws and courts of the country of the client shall govern.';


}