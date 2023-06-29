report 50235 "ER - Sales Quote With Visuals"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'ER - Sales Quote With Visuals';
    RDLCLayout = 'Reports Layouts/ER-SalesQuoteWithVisuals.rdlc';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "No.";
            #region //Sales Header
            column(No_; "No.") { }
            column(Document_Date; "Document Date") { }
            column(Currency_Code; GlobalCurrencyCode) { }
            column(CustomerNo; "Sell-to Customer No.") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(CustomerArabicName; Customer."Name (Arabic)") { }
            column(CustomerFrenchName; Customer."Name 2") { }
            column(ProjectName; "Cust Project") { }
            column(Sell_to_Address; "Sell-to Address") { }
            column(Sell_to_Country; "Sell-to Country/Region Code") { }
            column(Sell_to_Contact; SellToContact.Name) { }
            column(TotalAmount; Amount) { }
            column(VAT_Amount; "Amount Including VAT" - Amount) { }
            column(Gross_Total; "Amount Including VAT") { }
            column(AmountinWords; AmountinWords) { }
            column(TotalLineDiscountAmt; TotalLineDiscountAmt) { }
            column(BarcodeText; BarcodeText) { }
            column(PaymentTerms_Description; GlobalPaymentTerms.Description) { }
            column(ShowColor; ShowColor)
            {

            }
            column(ShowSize; ShowSize)
            {

            }
            column(TotalStaff; TotalStaff)
            {

            }
            column(TotalWeeks; TotalWeeks)
            {

            }
            column(Incoterms; GlobalShipmentMethod.Description)
            {

            }
            #endregion //Sales Header

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
            column(LCY_Code; GeneralLedgerSetup."LCY Code")
            {

            }
            column(MOF_Recipt_No; GeneralLedgerSetup."MOF Receipt")
            {

            }
            #endregion

            #region Labels
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
            column(ProjectLabel; ProjectLabel)
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

            column(CustomerNoLabel; CustomerNoLabel)
            {
            }

            column(CustomerNameLabel; CustomerNameLabel)
            {
            }

            column(CountryLabel; CountryLabel)
            {
            }

            column(ContactPersonLabel; ContactPersonLabel)
            {
            }

            column(CurrencyLabel; CurrencyLabel)
            {
            }

            column(DocumentDateLabel; DocumentDateLabel)
            {
            }

            column(NbLabel; NbLabel)
            {
            }

            column(DesignRefLabel; DesignRefLabel)
            {
            }
            column(ItemRefLabel; ItemRefLabel)
            {
            }

            column(StaffingDisciplineLabel; StaffingDisciplineLabel)
            {
            }

            column(TotalStaffingLabel; TotalStaffingLabel)
            {
            }

            column(ParLevelLabel; ParLevelLabel)
            {
            }

            column(TotalSupplyQtyLabel; TotalSupplyQtyLabel)
            {
            }

            column(UnitPriceLabel; UnitPriceLabel)
            {
            }
            column(UnitCostLabel; UnitCostLabel)
            {
            }

            column(TotalPriceLabel; TotalPriceLabel)
            {
            }

            column(TotalStaffLabel; TotalStaffLabel)
            {
            }

            column(TotalLabel; TotalLabel)
            {
            }

            column(DiscountLabel; DiscountLabel)
            {
            }

            column(VATAmountLabel; VATAmountLabel)
            {
            }

            column(AmountIncVATLabel; AmountIncVATLabel)
            {
            }

            column(GrandTotalLabel; GrandTotalLabel)
            {
            }

            column(OrderTermsLabel; OrderTermsLabel)
            {
            }

            column(DeliveryLabel; DeliveryLabel)
            {
            }

            column(SizesLabel; SizesLabel)
            {
            }
            column(PackagingLabel; PackagingLabel)
            {
            }
            column(ValidityLabel; ValidityLabel)
            {
            }
            column(IncotermsLabel; IncotermsLabel)
            {
            }
            column(PagesLabel; PagesLabel)
            {
            }
            column(ApprovalLabel; ApprovalLabel)
            {
            }
            column(SalesTermsConditionsLabel; SalesTermsConditionsLabel)
            {
            }
            column(TotalsLabel; TotalsLabel)
            {

            }
            column(TermsLabel; TermsLabel)
            {

            }
            column(IncotermsTermsLabel; IncotermsTermsLabel)
            {

            }
            column(ImportantNoticeLabel; ImportantNoticeLabel)
            {

            }
            column(ArabicNameLabel; ArabicNameLabel)
            {

            }
            column(SizesValueLabel; SizesValueLabel)
            {

            }
            column(PackagingValueLabel; PackagingValueLabel)
            {

            }
            column(ValidityValueLabel; ValidityValueLabel)
            {

            }
            column(IncotermsValueTermsLabel; IncotermsValueTermsLabel)
            {

            }
            column(MadeOfValueLabel; MadeOfValueLabel)
            {

            }
            column(NameTitleValueLabel; NameTitleValueLabel)
            {

            }
            column(SignatureValueLabel; SignatureValueLabel)
            {

            }
            column(DeliveryValueLabel; DeliveryValueLabel)
            {

            }
            column(FormLabel; FormLabel)
            {

            }
            column(August21Label; August21Label)
            {

            }
            column(ColorLabel; ColorLabel)
            {

            }
            column(SizeLabel; SizeLabel)
            {

            }
            column(HsCodeLabel; HsCodeLabel)
            {

            }
            #endregion
            #region Sales Terms And Conditions
            column(PageLabeFR; PageLabeFR) { }
            column(PageLabelValueFR; PageLabelValueFR) { }
            column(TermsAndCondLabel_0; TermsAndCondLabel_0) { }
            column(TermsAndCondLabel_1; TermsAndCondLabel_1) { }
            column(TermsAndCondLabel_2; TermsAndCondLabel_2) { }
            column(TermsAndCondLabel_3; TermsAndCondLabel_3) { }
            column(TermsAndCondLabel_4; TermsAndCondLabel_4) { }
            column(TermsAndCondLabel_5; TermsAndCondLabel_5) { }
            column(TermsAndCondLabel_6; TermsAndCondLabel_6) { }
            column(TermsAndCondLabel_7; TermsAndCondLabel_7) { }
            column(TermsAndCondLabel_8; TermsAndCondLabel_8) { }
            column(TermsAndCondLabel_9; TermsAndCondLabel_9) { }
            column(TermsAndCondLabel_10; TermsAndCondLabel_10) { }
            column(TermsAndCondLabel_11; TermsAndCondLabel_11) { }
            column(TermsAndCondLabel_12; TermsAndCondLabel_12) { }
            column(TermsAndCondLabel_13; TermsAndCondLabel_13) { }
            column(TermsAndCondLabel_14; TermsAndCondLabel_14) { }
            column(FrenchReport; FrenchReport) { }
            column(OfLabel; OfLabel) { }
            column(SalesQuoteLabel; SalesQuoteLabel) { }

            #endregion
            column(VAT_Percentage; VAT_Percentage) { }
            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Department Code", "Position Code", "Staff Code");
                #region Sales Line Columns
                column(ItemNo; "No.") { }
                column(ItemDesign; ItemDesign.Code) { }
                column(Hs_Code; Item."Hs Code") { }
                column(Line_No_; "Line No.") { }
                column(VariantCode; "Variant Code") { }
                column(Document_No_; "Document No.") { }
                column(Description; G_Description) { }
                column(Quantity; Quantity) { }
                column(Line_Amount; "Line Amount") { }
                column(Amount; Amount) { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
                column(Line_Discount_Amount; "Line Discount Amount") { }
                column(Unit_Price; "Unit Price") { }
                column(ItemDesignGender; ItemDesign.Gender) { }
                column(DeptName; DeptName) { }
                column(PositionName; PositionName) { }
                column(PositionSorting; PositionSorting) { }
                column(MediaPicture; G_MediaPicture) { }
                column(VariantPicture; G_RecItemVariant.Picture) { }
                column(ItemPicture; G_RecItem.Picture) { }
                column(NoPicture; G_RecSalesAndReciept.Picture) { }
                column(StaffName; StaffName) { }
                column(NumReference; NumReference) { }
                column(ParLevel; "Par Level") { }
                column(ColorName; colorName)
                {
                }
                column(SizeName; SizeName)
                {
                }
                column(TotalStaffing; TotalStaffing)
                {
                }
                #endregion
                trigger OnPreDataItem()
                begin
                    Number := 0;
                    SalesLine.SetCurrentKey("Department Code", "Staff Code", "Position Sorting");
                    SalesLine.SetAscending("Position Sorting", true);
                end;

                trigger OnAfterGetRecord()//Sales Line Data Item
                var

                begin
                    //Get Size
                    clear(SizeRec);
                    if SizeRec.Get(SalesLine.Size) then
                        SizeName := SizeRec.Name;

                    //Check if the report is french to change the language of the color name
                    //Color
                    Clear(GlobalColor);
                    if GlobalColor.Get(SalesLine.Color) then;
                    if FrenchReport then
                        ColorName := GlobalColor."French Description"
                    else
                        ColorName := GlobalColor.Name;

                    //if the report is french then change the language of the item description
                    Item.Reset();
                    Item.get(SalesLine."No.");
                    if FrenchReport then
                        G_Description := Item."Description 2"
                    else
                        G_Description := Item.Description;


                    //Calculate Total Line Discount
                    TotalLineDiscountAmt := TotalLineDiscountAmt + "Line Discount Amount" + "Inv. Discount Amount";

                    //Get Gender from Item Design +
                    ItemDesign.Reset();
                    Item.Reset();
                    If Item.Get(SalesLine."No.") then;
                    If ItemDesign.Get(Item."Design Code") then;
                    //Get Gender from Item Design -

                    Position := SalesLine."Position Code";
                    Department := SalesLine."Department Code";
                    Gender := Format(ItemDesign.Gender);

                    if (Position = xPosition) and (Department = xDepartment) and (Gender = xGender) then
                        NumReference := Number
                    else begin
                        xPosition := Position;
                        xDepartment := Department;
                        xGender := Gender;
                        Position := SalesLine."Position Code";
                        Department := SalesLine."Department Code";
                        Gender := Format(ItemDesign.Gender);
                        Number += 1;
                        NumReference := Number;
                    end;

                    Clear(ParameterHeader);
                    Clear(DepartmentRec);
                    Clear(PositionRec);
                    Clear(StaffRec);
                    DeptName := '';
                    PositionName := '';
                    StaffName := '';
                    PositionSorting := 0;
                    //Get Department
                    if DepartmentRec.Get(SalesLine."Department Code") then
                        DeptName := DepartmentRec.Name;
                    //Get Department
                    if PositionRec.Get(SalesLine."Position Code") then begin
                        PositionName := PositionRec.Name;
                        PositionSorting := PositionRec."Sorting Number";
                    end;
                    //Get Staff
                    StaffRec.SetRange(Code, SalesLine."Staff Code");
                    StaffRec.SetRange("Customer No.", SalesLine."Sell-to Customer No.");
                    StaffRec.SetRange("Department Code", SalesLine."Department Code");
                    StaffRec.SetRange("Position Code", SalesLine."Position Code");

                    if StaffRec.Get("Staff Code", "Position Code", "Sell-to Customer No.", "Department Code") then
                        StaffName := StaffRec.Name;



                    //TotalStaffing Column
                    TotalStaffing := 0;
                    if "Par Level" = 0 then
                        TotalStaffing := 0
                    else
                        TotalStaffing := Quantity / "Par Level";


                    //Getting Image
                    Clear(G_RecItem);
                    clear(G_RecItemVariant);
                    clear(G_MediaPicture);
                    //0 nopic, 1 variant, 2 item
                    if "Variant Code" <> '' then begin
                        G_RecItemVariant.SetRange(Code, SalesLine."Variant Code");
                        G_RecItemVariant.SetRange("Item No.", SalesLine."No.");
                        if G_RecItemVariant.get("No.", "Variant Code") then begin
                            if G_RecItemVariant.Picture.Count <> 0 then
                                G_MediaPicture := 1
                            else
                                if G_RecItem.Get(SalesLine."No.") then begin
                                    if G_RecItem.Picture.Count <> 0 then
                                        G_MediaPicture := 2
                                    else
                                        G_MediaPicture := 0;
                                end;
                        end;
                    end
                    else
                        if G_RecItem.Get("No.") then begin
                            if G_RecItem.Picture.Count <> 0 then
                                G_MediaPicture := 2
                            else
                                G_MediaPicture := 0;
                        end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                SalesLineLoc: Record "Sales Line";
                PrviousStaff: Code[50];
            begin
                if G_CULanguage.GetLanguageId(SelectedLanguage) = 1036 then begin
                    CurrReport.Language := 1036;
                    FrenchReport := true;

                end
                else begin
                    CurrReport.Language := G_CULanguage.GetLanguageID('ENG');
                    FrenchReport := false;
                end;


                Clear(TotalLineDiscountAmt);
                Customer.Get("Sell-to Customer No.");
                GeneralLedgerSetup.Get();
                NumReference := 0;
                //Get Currency Code
                Clear(GlobalCurrencyCode);
                if "Currency Code" = '' then
                    GlobalCurrencyCode := GeneralLedgerSetup."LCY Code"
                else
                    GlobalCurrencyCode := "Currency Code";
                //Amount in Words
                AmountInWordsFunction("Amount Including VAT", GlobalCurrencyCode);

                //Barcode text
                Clear(BarcodeText);
                BarcodeText := "Bill-to Customer No." + '+' + "No.";

                //Payment Terms
                Clear(GlobalPaymentTerms);
                if GlobalPaymentTerms.Get("Payment Terms Code") then;

                //Sell To Contact
                Clear(SellToContact);
                if SellToContact.Get("Sell-to Contact No.") then;

                //Calculate Total Staff
                TotalStaff := 0;
                Clear(SalesLineLoc);
                SalesLineLoc.SetCurrentKey("Staff Code");
                SalesLineLoc.SetRange("Document Type", SalesHeader."Document Type");
                SalesLineLoc.SetRange("Document No.", SalesHeader."No.");
                SalesLineLoc.Setfilter("Staff Code", '<>%1', '');
                if SalesLineLoc.FindSet() then begin
                    PrviousStaff := '';
                    repeat
                        if SalesLineLoc."Staff Code" <> PrviousStaff then
                            TotalStaff := TotalStaff + 1;
                        PrviousStaff := SalesLineLoc."Staff Code";
                    until SalesLineLoc.Next() = 0;
                end;

                //Calculate Total Weeks 
                TotalWeeks := 0;
                if "Requested Delivery Date" <> 0D then
                    TotalWeeks := ("Requested Delivery Date" - Today) / 7;

                //Incoterms
                Clear(GlobalShipmentMethod);
                if GlobalShipmentMethod.Get("Shipment Method Code") then;
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
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
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

                    field(ShowColor; ShowColor)
                    {
                        ApplicationArea = all;
                        Caption = 'Show Item Color';
                        trigger OnValidate()
                        begin
                            if ShowColor then
                                ShowSize := false;
                        end;
                    }
                    field(ShowSize; ShowSize)
                    {
                        ApplicationArea = all;
                        Caption = 'Show Item Size';
                        trigger OnValidate()
                        begin
                            if ShowSize then
                                ShowColor := false;
                        end;
                    }
                }
            }

        }


    }
    trigger OnPreReport()
    begin
        CompanyInformation.get();
        GeneralLedgerSetup.Get();
        G_RecSalesAndReciept.Get();//To get no image picture
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

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        CompanyInformation: Record "Company Information";
        Customer: Record customer;
        SizeRec: Record Size;
        G_CULanguage: Codeunit Language;
        DeptName: text[100];
        PositionName: text[100];
        StaffName: text[100];
        Number: Integer;
        Position: Text;
        Department: Text;
        Gender: Text;
        xPosition: Text;
        xDepartment: Text;
        xGender: Text;
        GlobalCurrencyCode: Code[10];
        CompanyAddress: Text[250];
        AmountinWords: Text[250];
        BarcodeText: Text[150];
        SelectedLanguage: Code[10];
        NumReference: Integer;
        FrenchReport: Boolean;
        TotalLineDiscountAmt: Decimal;
        ItemDesign: Record Design;
        ParameterHeader: Record "Parameter Header";
        Item: Record Item;
        DepartmentRec: Record Department;
        PositionRec: Record Position;
        StaffRec: Record Staff;
        GlobalPaymentTerms: Record "Payment Terms";
        SellToContact: Record Contact;
        GlobalColor: Record Color;
        GlobalShipmentMethod: Record "Shipment Method";
        ShowColor: Boolean;
        ShowSize: Boolean;
        TotalStaffing: Decimal;
        TotalStaff: Integer;
        TotalWeeks: Decimal;
        PositionSorting: Integer;
        VAT_Percentage: Decimal;
        SizeName: Text[100];
        //Item Picture
        G_RecItem: Record Item;
        G_RecItemVariant: Record "Item Variant";
        G_RecSalesAndReciept: Record "Sales & Receivables Setup";
        G_MediaPicture: Integer;
        ColorName: Text[100];
        G_Description: Text[100];
        CapitalLabel: Label 'Capital';
        VATCodeLabel: Label 'VAT Code';
        AddressLabel: Label 'Address';
        BankAccountLabel: Label 'Bank Account';
        SWIFTLabel: Label 'SWIFT';
        PrintedOnLabel: Label 'Printed On';
        IssuedateLabel: Label 'Issue Date';
        RevisionDateLabel: Label 'Revision Date/#';
        SalesQuoteLabel: Label 'Sales Quote';
        ProjectLabel: Label 'Project';
        ArabicNameLabel: Label 'Arabic Name';
        TotalAmountLabel: Label 'Total Amount';
        DescriptionLabel: Label 'Description';
        AmountLabel: Label 'Amount';
        CurrencyCodeLabel: Label 'Currency Code';
        VATLabel: Label 'VAT';
        NetTotalLabel: Label 'Net Total';
        MOFReceiptLabel: Label 'Duty Stamp is paid in cash, MOF Receipt- ';
        CustomerNoLabel: Label 'Customer No.';
        CustomerNameLabel: Label 'Customer Name';
        CountryLabel: Label 'Country';
        ContactPersonLabel: Label 'Contact Person';
        CurrencyLabel: Label 'Currency';
        DocumentDateLabel: Label 'Document Date';
        NbLabel: Label 'Nb.';
        DesignRefLabel: Label 'Design Ref';
        ItemRefLabel: Label 'Item Ref';
        HsCodeLabel: Label 'HS Code';
        StaffingDisciplineLabel: Label 'Staffing Discipline';
        TotalStaffingLabel: Label 'Total Staffing';
        ParLevelLabel: Label 'Par Level';
        TotalSupplyQtyLabel: Label 'Total Supply Qty';
        UnitPriceLabel: Label 'Unit Price';
        UnitCostLabel: Label 'Unit Cost';
        TotalPriceLabel: Label 'Total Price';
        TotalStaffLabel: Label 'Total Staff';
        TotalLabel: Label 'Totals';
        TotalsLabel: Label 'Totals';
        DiscountLabel: Label 'Discount';
        VATAmountLabel: Label 'VAT Amount';
        AmountIncVATLabel: Label 'Amount Inc. VAT';
        GrandTotalLabel: Label 'Grand Total';
        OrderTermsLabel: Label 'Order Terms & Conditions';
        DeliveryLabel: Label 'Delivery';
        TermsLabel: Label 'Terms';
        SizesLabel: Label 'Sizes';
        PackagingLabel: Label 'Packaging';
        ValidityLabel: Label 'Validity';
        IncotermsLabel: Label 'Incoterms';
        PagesLabel: Label 'pages';
        ApprovalLabel: Label 'Approval';
        SalesTermsConditionsLabel: Label 'Sales Terms and Conditions';
        IncotermsTermsLabel: Label 'Incoterms';
        ImportantNoticeLabel: Label '- Important Notice -';
        SizesValueLabel: Label 'STANDARD EUROPEAN SIZES';
        PackagingValueLabel: label 'PLASTIC BAGS IN STRONG EXPORT CARTONS';
        ValidityValueLabel: label 'THIS QUOTATION IS VALID FOR 1 MONTH';
        IncotermsValueTermsLabel: label 'EX Works – Mkalles, LB';
        MadeOfValueLabel: label 'This quotation is made up of';
        NameTitleValueLabel: label 'Name & Title';
        SignatureValueLabel: label 'Signature, Stamp and Date';
        DeliveryValueLabel: Label 'weeks – From Sizes Confirmation Date.';
        FormLabel: Label 'Form #: ER\LB\AVER\BS-SQ\100';
        August21Label: Label 'August 21';
        ColorLabel: Label 'Color';
        SizeLabel: Label 'Size';
        OfLabel: Label 'of';
        PageLabeFR: Label '7- PAGES |';
        PageLabelValueFR: Label 'CE DEVIS EST COMPOSÉ DE 2 PAGES, CONDITIONS GÉNÉRALES DE VENTE INCLUSES.';
        TermsAndCondLabel_0: label 'When ordering from Emile Rassam or any affiliate company (referred to hereafter as "ER"), you, as “client”, are agreeing, on your behalf and onbehalf of your organization, that the “General Terms & Conditions” shall apply from the time the order is placed and confirmed unlessotherwise agreed in writing by an authorized officer of Emile Rassam';
        //TermsAndCondLabel_1_title:label '1. Delivery:';
        TermsAndCondLabel_1: label '1. Delivery: ER takes dates very seriously and will make every reasonable effort to deliver the “Order” on the agreed dates, but these schedulesare not binding and do not form any part of the contract. Emile Rassam is not liable for any damages or loss caused by delays despite itsnature.';
        //TermsAndCondLabel_2_title:label '2. Samples:';
        TermsAndCondLabel_2: label '2. Samples: When the client or any team member in his organization in charge approves samples submitted by ER, he then approves thequality, fit, construction and any material that constitute these samples. The client is herein expected to run the relevant test washes asdescribed on the washing instruction label attached to the inside garment. By approving the samples it is considered that the client is fullyaware and approves the results of the washing';
        //TermsAndCondLabel_3_title:label '3. Bank charges:';
        TermsAndCondLabel_3: label '3. Bank charges: In the case of payment though bank transfers, charges are to be borne by the remitter.';
        //TermsAndCondLabel_4_title:label '4. Sizes:';
        TermsAndCondLabel_4: label '4. Sizes: All sizes must be confirmed together with your order to enable production to be launched';
        //TermsAndCondLabel_5_title:label '5. Tailors assistance:';
        TermsAndCondLabel_5: label '5. Tailors assistance: Unless otherwise agreed in writing, orders do not include tailors visits for measurements taking or fitting sessions. Suchservices are quoted separately depending on the geographic location of the client"s project, its size and manning required. When ER agrees toextend such services, the client agrees to take charge of the accomodation & meals of the ER team who will be responsible for thisassignement - such teams are usually made of 2 to 4 members maximum. In order for these missions to serve its purpose the client shouldhave at least 4 industrial machines available: 1- 2 x regular sewing machine - 2- 1x overlock, - 4 -1 x blind stitch machine';
        //TermsAndCondLabel_6_title:label '6. Personalization:';
        TermsAndCondLabel_6: label '6. Personalization: Artwork must be submitted together with your confirmation (in .eps format) together with the purchase order. Any delayin submission might and could impact the delivery schedules';
        //TermsAndCondLabel_7_title:label '7. Currency';
        TermsAndCondLabel_7: label '7. Currency: ER accepts only the currency stated on their quotations. In case payments are made in a different currency, conversion chargesinto US Dollars will be charged to your account';
        //TermsAndCondLabel_8_title:label '8. Returns & exchanges:';
        TermsAndCondLabel_8: label '8. Returns & exchanges: No returns or exchanges can be given on items manufactured to your specifications, unless there is a manufacturingdefect or the goods are not conform to the order. Items to return must be announced in writing within a period of 14 days from the deliverydate and shall remain unused in its original packing. When the client requests a return or an exchange it remains subject to approval by ERofficial representative.';
        //TermsAndCondLabel_9_title:label '9.Missing items:';
        TermsAndCondLabel_9: label '9.Missing items: Please ensure you check all items against the delivery note. In the event that items are missing, claims need to becommunicated to ER in writing within seven calendar days after delivery';
        //TermsAndCondLabel_10_title:label '10. Cancellations:';
        TermsAndCondLabel_10: label '10. Cancellations: Please note order cancellations will only be accepted prior to production being launched. In the case of cancellationsregistered while your order is in production, the full value of the cancelled items will be charged. Deposits will be refunded only if productionhas not been launched to the value of 80%, the retained 20% will be deductible against any other order and must be utilized within 3 monthsfrom the cancellation date.';
        //TermsAndCondLabel_11_title:label '11. Transportation:';
        TermsAndCondLabel_11: label '11. Transportation: ER or his affiliate companies can only recommend shipping companies to use for the transportation of goods however isnot responsible for delays or complications generated by the latter The client has the right to accept any shipper he trusts to ship his order';
        //TermsAndCondLabel_12_title:label '12. Social media:';
        TermsAndCondLabel_12: label '12. Social media: ER reserves the right to mention their clients names or visuals in social media marketing and or newsletters whetherelectronic or hard publications.';
        //TermsAndCondLabel_13_title:label '13. Force Majeure:';
        TermsAndCondLabel_13: label '13. Force Majeure: ER is not liable for any delay or failure to deliver as a result to Acts of Nature (including fire, floods, earthquake, storms,hurricanes or other natural disasters), war, invasion, insurrection, military or usurped power of confiscation, terrorist activities, nationalization,government sanction, blockage, embargo, labour dispute, strike, lockout or interruption or failure of power sources';
        //TermsAndCondLabel_14_title:label '14. Arbitrage:';
        TermsAndCondLabel_14: label '14. Arbitrage: In case of disputes, the laws and courts of the country of the client shall govern.';
}