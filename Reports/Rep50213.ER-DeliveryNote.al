report 50213 "ER - Delivery Note"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-DeliveryNote.rdlc';
    Caption = 'ER - Delivery Note';
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(selectedInvoice; "No.")
            {

            }
            column(InvoiceLabel; InvoiceLabel)
            {

            }
            column(FrenchReport; FrenchReport)
            {

            }
            column(OfLabel; OfLabel)
            {

            }
            column(ShowNotice; ShowNotice)
            {

            }
            column(ShowStamp; ShowStamp)
            {

            }
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
            column(Company_City; CompanyInformation.City)
            {

            }
            column(Company_RIB; CompanyInformation.RIB)
            {

            }
            column(Company_Bank; CompanyInformation."Bank Name")
            {

            }
            column(Company_BankBranch; CompanyInformation."Bank Branch No.")
            {

            }
            column(LCY_Code; GeneralLedgerSetup."LCY Code")
            {

            }
            column(MOFReceipt; GeneralLedgerSetup."MOF Receipt")
            {

            }

            #endregion
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                DataItemTableView = sorting("No.");
                //DataItemLink = "No." = FIELD("Shipment No.");
                column(PSHNB; PSHNB)
                {

                }
                column(InvoiceNb; "Sales Invoice Header"."No.")
                {

                }
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
                column(BillTo_PurchOrderRef; "Sales Shipment Header"."External Document No.")
                {

                }
                column(BillTo_PayTerms; GlobalPayTermsDescription)
                {

                }
                //Shipping Terms

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
                column(ShipTo_ShippingMode; GlobalShipmentMethod.Description)
                {

                }
                column(ShipTo_Carrier; "Sales Shipment Header"."Shipping Agent Code")
                {

                }
                column(ShipTo_Project; "Sales Shipment Header"."Shortcut Dimension 1 Code")
                {

                }
                #endregion

                #region //Labels
                column(SalesShipmentLabel; SalesShipmentLabel)
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
                column(ProductLabel; ProductLabel)
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
                column(FormLabel; FormLabel)
                {

                }
                column(FormNumber; FormNumber)
                {

                }
                column(IssueDateLabel; "IssueDateLabel")
                {

                }
                column(IssueDateValue; IssueDateValue)
                {

                }
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
                #endregion

                #region Terms and Conditions
                column(TermsAndConditionsLabel; TermsandCondLabel)
                {

                }
                column(ImportantNoticeLabel; ImportantNoticeLabel)
                {

                }
                column(TermsAndCondText; TermsAndCondText)
                {

                }
                column(TermsAndCondText_1; TermsAndCondText_1)
                {

                }
                column(TermsAndCondText_2; TermsAndCondText_2)
                {

                }
                column(TermsAndCondText_3; TermsAndCondText_3)
                {

                }
                column(TermsAndCondText_4; TermsAndCondText_4)
                {

                }
                column(TermsAndCondText_5; TermsAndCondText_5)
                {

                }
                column(TermsAndCondText_6; TermsAndCondText_6)
                {

                }
                column(TermsAndCondText_7; TermsAndCondText_7)
                {

                }
                column(TermsAndCondText_7_Infos; TermsAndCondText_7_Infos)
                {

                }
                column(TermsAndCondText_8; TermsAndCondText_8)
                {

                }
                column(TermsAndCondText_9; TermsAndCondText_9)
                {

                }
                column(TermsAndCondText_10; TermsAndCondText_10)
                {

                }
                column(TermsAndCondText_11; TermsAndCondText_11)
                {

                }
                column(TermsAndCondText_12; TermsAndCondText_12)
                {

                }
                column(TermsAndCondText_13; TermsAndCondText_13)
                {

                }
                column(TermsAndCondText_14; TermsAndCondText_14)
                {

                }
                column(TermsAndCondText_15; TermsAndCondText_15)
                {

                }
                column(TermsAndCondText_16; TermsAndCondText_16)
                {

                }
                column(TermsAndCondText_17; TermsAndCondText_17)
                {

                }
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
                    column(Line_Size; "Sales Shipment Line".Size)
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
                    end;
                }

                trigger OnPreDataItem()
                begin
                    "Sales Shipment Header".setrange("No.", PSH_List.Get(PSH_No));
                    PSHNB := PSH_List.Get(PSH_No);
                    if PSH_No < PSH_List.count() then
                        PSH_No := PSH_No + 1;
                end;

                //Sales Shipment Header Triggers
                trigger OnAfterGetRecord()
                var
                    PaymentTerms: Record "Payment Terms";
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                    CustomerProjects: Record "Customer Projects";
                begin
                    Clear(TotalLineDiscountAmt);
                    Clear(GlobalShipToCustomer);
                    Clear(GlobalBillToCustomer);
                    Clear(BillToAddress);
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
                        Clear(BillToAddress);
                        BillToAddress := "Sales Shipment Header"."Bill-to Country/Region Code" + ',' + "Sales Shipment Header"."Bill-to Address" + ',' + "Sales Shipment Header"."Bill-to Address 2"
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
                    Clear(GlobalProject);
                    Clear(CustomerProjects);
                    if CustomerProjects.Get("Sales Shipment Header"."Shortcut Dimension 1 Code", "Sales Shipment Header"."Sell-to Customer No.") then
                        GlobalProject := CustomerProjects."Project Name";
                end;
            }
            trigger OnAfterGetRecord()
            begin
                GlobalSLI.Reset();
                GlobalSLI.SetRange("Document No.", "Sales Invoice Header"."No.");
                if GlobalSLI.FindFirst() then begin
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
                group("Report Settings")
                {
                    Caption = 'Report Settings';
                    field(ShowNotice; ShowNotice)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Notice';
                    }
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
        trigger OnOpenPage()
        begin
            ShowNotice := True;
        end;
    }
    trigger OnPreReport()
    begin
        GeneralLedgerSetup.Get();
        CompanyInformation.Get();
        CompanyAddress := CompanyInformation.Address + ' ' + CompanyInformation."Address 2";
        CompanyInformation.CalcFields(Picture);
        PSH_No := 1;

        if G_CULanguage.GetLanguageId(SelectedLanguage) = 1036 then begin
            CurrReport.Language := 1036;
            FrenchReport := true;
            //GlobalBankAccount := CompanyInformation."Bank Name" + ' ' + CompanyInformation."Bank Branch No."
        end
        else begin
            CurrReport.Language := G_CULanguage.GetLanguageID('ENG');
            FrenchReport := false;
            //GlobalBankAccount := CompanyInformation."Bank Name";
        end;
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
        GlobalSLI: Record "Sales Invoice Line";
        GlobalItem: Record Item;
        GlobalContact: Record Contact;

        #region Language
        G_CULanguage: Codeunit Language;
        SelectedLanguage: Code[10];
        ShowNotice: Boolean;
        ShowStamp: Boolean;
        FrenchReport: Boolean;
        #endregion
        GlobalFiscalCode: Text[30];
        PSH_No: Integer;
        AmountinWords: Text[250];
        GlobalCurrencyCode: Code[10];
        GlobalPayTermsDescription: Text[100];
        CompanyAddress: Text[250];
        BarcodeText: Text[150];
        DepartmentName: Text[150];
        PositionName: Text[150];
        StaffName: Text[150];
        BillToAddress: Text[250];
        ShipToAddress: Text[250];
        GlobalProject: Text;
        PSH_List: List of [Code[20]];
        PSHNB: Code[20];
        TotalLineDiscountAmt: Decimal;
        GlobalBalanceDue: Decimal;
        //PostingDesc: Text;
        ErrorMessage1: label 'Please Select a Sales Invoice that contains Posted Sales Shipment in the Sales Lines';
        OfLabel: Label 'of ';
        SalesShipmentLabel: Label 'Delivery Note Of ';
        InvoiceDateLabel: Label 'Invoice Date';
        InvoiceLabel: Label 'Invoice No. ';
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
        ProductLabel: Label 'Product';
        SizeLabel: Label 'Size';
        QtyLabel: Label 'Quantity';
        UnitPriceLabel: Label 'Unit Price';
        TotalPriceLabel: Label 'Total Price';
        TotalLabel: Label 'Total';
        DiscountLabel: Label 'Discount';
        VATLabel: Label 'VAT';
        GrossTotalLabel: Label 'Gross Total';
        AdvancePaymentLabel: Label 'Advance Payment';
        DueBalanceLabel: Label 'Due Balance';
        IssuedateLabel: Label 'Issue Date: ';
        IssueDateValue: Label 'Jan 23';
        RevisionDateLabel: Label 'Revision Date';
        MOFReceiptLabel: Label 'Duty Stamp is paid in cash, MOF Receipt- ';
        RefLabel: label 'Ref.';
        ProjectLabel: label 'Project';
        FormLabel: label 'Form #:';
        FormNumber: label 'ER\LB\AVER\S-DN\100';
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