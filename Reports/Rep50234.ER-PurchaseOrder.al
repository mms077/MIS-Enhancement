report 50234 "Standard Purchase"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/ER-PurchaseOrder.rdlc';
    Caption = 'ER - Purchase Order';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            column(PurchaseNo_; "No.") { }
            #region Company Information
            column(PrintedOnLabel; PrintedOnLabel) { }
            column(LCY_Code; GeneralLedgerSetup."LCY Code")
            {

            }
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
            column(VATCodeLabel; VATCodeLabel) { }
            column(CapitalLabel; CapitalLabel) { }
            //column(AddressLabel;AddressLabel){}
            column(BankAccountLabel; BankAccountLabel) { }
            column(SWIFTLabel; SWIFTLabel) { }
            column(IBANLabel; Company_IBAN) { }
            column(PageLabel; PageLabel) { }
            column(OfLabel; OfLabel) { }



            # endregion

            #region Labels
            column(CostCenterLabel;CostCenterLabel){}
            column(AccountManagerLabel;AccountManagerLabel){}
            column(ShippingMethodLabel;ShippingMethodLabel){}
            column(RequestedByLabel;RequestedByLabel){}
            column(FinancialControllerLabel;FinancialControllerLabel){}
            column(ManigingDirectorLabel;ManigingDirectorLabel){}
            column(DateLabel; DateLabel) { }
            column(OrderNoLabel; OrderNoLabel) { }
            column(PurchaseOrderLabel; PurchaseOrderLabel) { }
            column(IssueDateLabel; IssueDateLabel) { }
            column(VendorLabel; VendorLabel) { }
            column(AddressLabel; AddressLabel) { }
            column(PhoneLabel; PhoneLabel) { }
            column(EmailLabel; EmailLabel) { }
            column(ContactLabel; ContactLabel) { }
            column(VendorRefLabel; VendorRefLabel) { }
            column(PaymentTermsLabel; PaymentTermsLabel) { }
            column(DeliveryDateLabel; DeliveryDateLabel) { }
            column(TermsLabel; TermsLabel) { }
            column(BillToLabel; BillToLabel) { }
            column(FinancialNoLabel; FinancialNoLabel) { }
            column(ShipToLabel; ShipToLabel) { }
            column(ShipToPhoneLabel; ShipToPhoneLabel) { }
            column(ShipToEmailLabel; ShipToEmailLabel) { }
            column(ShipToContactLabel; ShipToContactLabel) { }
            column(TotalLabel; TotalLabel) { }
            column(DiscountLabel; DiscountLabel) { }
            column(VATLabel; VATLabel) { }
            column(GrossTotalLabel; GrossTotalLabel) { }
            column(SupplyTheFollowingGoodsLabel; SupplyTheFollowingGoodsLabel) { }
            column(ThankYouForYourPromptLabel; ThankYouForYourPromptLabel) { }
            column(NoLabel; NoLabel) { }
            column(DescriptionLabel; DescriptionLabel) { }
            column(UnitOfMeasureLabel; UnitOfMeasureLabel) { }
            column(QuantityLabel; QuantityLabel) { }
            column(DirectUnitCostLabel; DirectUnitCostLabel) { }
            column(DiscountPercentLabel; DiscountPercentLabel) { }
            column(AmountLabel; AmountLabel) { }
            column(FormNoLabel; FormNoLabel) { }
            column(FormNoValueLabel; FormNoValueLabel) { }
            column(IssueDateFooterLabel; IssueDateFooterLabel) { }
            column(IssueDateValueLabel; IssueDateValueLabel) { }
            column(RevisionDateLabel; RevisionDateLabel) { }

            #endregion
            #region Terms And Conditions
            column(TermsAndCondLabel; TermsAndCondLabel) { }
            column(TermsAndCondHeaderLabel; TermsAndCondHeaderLabel) { }
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
            column(TermsAndCondLabel_15; TermsAndCondLabel_15) { }
            column(TermsAndCondLabel_16_1; TermsAndCondLabel_16_1) { }
            column(TermsAndCondLabel_16_2; TermsAndCondLabel_16_2) { }
            column(TermsAndCondLabel_16_3; TermsAndCondLabel_16_3) { }
            column(TermsAndCondLabel_16_4; TermsAndCondLabel_16_4) { }
            column(TermsAndCondLabel_16_4_I; TermsAndCondLabel_16_4_I) { }
            column(TermsAndCondLabel_16_5; TermsAndCondLabel_16_5) { }
            column(TermsAndCondLabel_16_6; TermsAndCondLabel_16_6) { }
            column(TermsAndCondLabel_17; TermsAndCondLabel_17) { }
            column(TermsAndCondLabel_18; TermsAndCondLabel_18) { }
            column(TermsAndCondLabel_19; TermsAndCondLabel_19) { }
            column(TermsAndCondLabel_20; TermsAndCondLabel_20) { }
            column(TermsAndCondLabel_21; TermsAndCondLabel_21) { }
            column(TermsAndCondLabel_22; TermsAndCondLabel_22) { }
            column(TermsAndCondLabel_23; TermsAndCondLabel_23) { }
            column(TermsAndCondLabel_24; TermsAndCondLabel_24) { }
            column(TermsAndCondLabel_25; TermsAndCondLabel_25) { }
            column(TermsAndCondLabel_26; TermsAndCondLabel_26) { }
            #endregion
            column(CompanyEmail_Lbl; EmailIDCaptionLbl)
            {
            }

            #region HeaderInformation
            column(OrderNo; "No.") { }
            column(IssueDate; "Posting Date") { }
            column(VendorName; VendorName) { }
            column(VendorAddress; VendorAddress) { }
            column(VendorPhone; VendorPhone) { }
            column(vendorEmail; vendorEmail) { }
            column(VendorContact; VendorContact) { }
            column(VendorRef; "Vendor Invoice No.") { }
            column(PayToVendorName; PayToVendorName) { }
            column(PayToVendorAddress; PayToVendorAddress) { }
            column(PayToVendorPhone; PayToVendorPhone) { }
            column(PayToVendorEmail; PayToVendorEmail) { }
            column(PayToVendorContact; PayToVendorContact) { }
            column(PaymentTerms; PaymetTermsDesc) { }
            column(Order_Date; "Order Date") { }
            column(ShipToName; "Ship-to Name") { }
            column(shiptoAdress; "Ship-to Address") { }
            column(ShiptoContact; "Ship-to Contact") { }
            column(DeliveryDate; "Expected Receipt Date") { }
            column(ShipToPhone; ShiptoPhone) { }
            column(ShipToEmail; ShiptoEmail) { }


            #endregion

            column(VAT_Amount; VAT_Amount) { }

            column(GrossTotal; "Purchase Header"."Amount Including VAT") { }
            column(billInCurrency; "Currency Code") { }

            column(TotalDiscountAmount; TotalDiscountAmount) { }

            column(BarcodeText; BarcodeText) { }
            column(AmountinWords; AmountinWords) { }
            column(VAT_Percentage;VAT_Percentage) { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(No_; "No.") { }
                column(Description; "Description") { }
                column(UnitOfMeasure; "Unit of Measure") { }
                column(Quantity; "Quantity") { }
                column(DirectUnitCost; "Direct Unit Cost") { }
                column(DiscountPercent; "Line Discount %") { }
                column(Amount; "Line Amount") { }
                column(TotalAmountExcludingVAT; TotalAmountExcludingVAT) { }
                //column(TotalDiscountAmount; TotalDiscountAmount) { }

                trigger OnAfterGetRecord()
                begin
                    TotalDiscountAmount := TotalDiscountAmount + "Line Discount Amount";
                    VAT_Amount := VAT_Amount + "Amount Including VAT" - Amount;
                    TotalAmountExcludingVAT := TotalAmountExcludingVAT + Amount;

                end;
            }

            trigger onAfterGetRecord()
            begin
                clear(TotalDiscountAmount);
                clear(TotalAmountExcludingVAT);
                Clear(TotalDiscountAmount);
                clear(VAT_Amount);

                //Buy From Vendor
                G_Vendor.Reset();
                G_Vendor.GET("Buy-from Vendor No.");
                VendorName := G_Vendor.Name;
                VendorAddress := G_Vendor.Address + ' ' + G_Vendor."Address 2";
                VendorPhone := G_Vendor."Phone No.";
                vendorEmail := G_Vendor."E-Mail";
                VendorContact := G_Vendor.Contact;

                //Pay to Vendor
                G_Vendor.Reset();
                G_Vendor.GET("Pay-to Vendor No.");
                PayToVendorName := G_Vendor.Name;
                PayToVendorAddress := G_Vendor.Address + ' ' + G_Vendor."Address 2";
                PayToVendorPhone := G_Vendor."Phone No.";
                PayToVendorEmail := G_Vendor."E-Mail";
                PayToVendorContact := G_Vendor.Contact;

                //Amount in Words
                AmountInWordsFunction("Purchase Header"."Amount Including VAT", "Purchase Header"."Currency Code");



                //Barcode
                Clear(BarcodeText);
                BarcodeText := "Purchase Header"."Pay-to Vendor No." + '+' + "Purchase Header"."No.";


                //Payment Terms
                if PaymentTerms.GET("Payment Terms Code") then
                    PaymetTermsDesc := PaymentTerms."Description"
                else
                    PaymetTermsDesc := '';


                //Ship to Infos
                if "Purchase Header"."Sell-to Customer No." <> '' then begin
                    G_Customer.Reset();
                    ShiptoPhone := G_Customer."Phone No.";
                    ShiptoEmail := G_Customer."E-Mail";
                end
                else begin
                    if "Ship-to Name" <> '' then begin
                        ShiptoPhone := CompanyInformation."Phone No.";
                        ShiptoEmail := CompanyInformation."E-Mail";
                    end
                    else begin
                        ShiptoPhone := '';
                        ShiptoEmail := '';
                    end;
                end;


            end;
        }

    }

    requestpage
    {
        layout
        {

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
        NoText: array[2] of Text[80];
        ReportCheck: Report Check;
    begin
        ReportCheck.InitTextVariable();
        ReportCheck.FormatNoText(NoText, Amount, CurrencyCode);
        AmountinWords := NoText[1];
    end;


    procedure GetDimenstion5(var DimSetID:Integer)
    var
        DimSet: Record "Dimension Set Entry" temporary;
    begin
        DimensionManagment_CU.GetDimensionSet(DimSet,DimSetID);
        DimSet.
    end;    



    var
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        G_Customer: Record Customer;
        G_Vendor: Record Vendor;
        PaymentTerms: Record "Payment Terms";
        DimensionManagment_CU:codeunit DimensionManagement;

        TotalDiscountAmount: Decimal;
        TotalAmountExcludingVAT: Decimal;
        PaymetTermsDesc: Text[100];


        AmountinWords: Text[250];
        VendorName: Text[100];
        VendorAddress: Text[100];
        VendorPhone: Text[30];
        ShiptoPhone: Text[30];
        vendorEmail: Text[80];
        ShiptoEmail: Text[80];
        VendorContact: Text[100];
        VendorRefNo: Text[20];
        VAT_Amount: Decimal;

        PayToVendorName: Text[100];
        PayToVendorAddress: Text[100];
        PayToVendorPhone: Text[30];
        PayTovendorEmail: Text[80];
        PayToVendorContact: Text[100];
        BarcodeText: Text[150];
        VAT_Percentage: Decimal;

        CompanyAddress: Text[250];

        PurchaseOrderLabel: Label 'Purchase Order';
        NoLabel: Label 'No.';
        DescriptionLabel: Label 'Description';
        UnitOfMeasureLabel: Label 'Unit of Measure';
        QuantityLabel: Label 'Quantity';
        DirectUnitCostLabel: Label 'Direct Unit Cost';
        DiscountPercentLabel: Label 'Discount %';
        AmountLabel: Label 'Amount';
        PrintedOnLabel: Label 'Printed On';
        PageLabel: label 'Page ';
        OfLabel: label 'of ';
        BankAccountLabel: Label 'Bank Account';
        VATCodeLabel: Label 'VAT Code';
        CapitalLabel: Label 'Capital';
        SWIFTLabel: Label 'SWIFT';
        Company_IBAN: Label 'IBAN';
        TotalLabel: Label 'Total';
        DiscountLabel: Label 'Discount';
        VATLabel: Label 'VAT';
        GrossTotalLabel: Label 'Gross Total';
        OrderNoLabel: Label 'Order No.';
        IssueDateLabel: Label 'Issue Date';
        VendorLabel: label 'Vendor';
        AddressLabel: Label 'Address';
        PhoneLabel: Label 'Phone';
        EmailLabel: Label 'Email';
        ContactLabel: Label 'Contact';
        VendorRefLabel: Label 'Vendor Ref';
        PaymentTermsLabel: Label 'Payment Terms';
        DeliveryDateLabel: Label 'Delivery Date';
        TermsLabel: Label 'Terms';
        BillToLabel: Label 'Bill To';
        FinancialNoLabel: Label 'Financial No.';
        ShipToLabel: Label 'Ship To';
        ShipToPhoneLabel: Label 'Phone';
        ShipToEmailLabel: Label 'Email';
        ShipToContactLabel: Label 'Contact';
        CostCenterLabel: Label 'Cost Center';
        DateLabel: Label 'Date: ';
        EmailIDCaptionLbl: Label 'Email';
        FormNoLabel: Label 'Form #:';
        FormNoValueLabel: label 'ER\LB\AVER\BS-PO\100';
        IssueDateFooterLabel: Label 'Issue Date:';
        IssueDateValueLabel: Label 'Jan 23';
        RevisionDateLabel: Label 'Revision Date:';
        AccountManagerLabel: Label 'Account Manager';
        ShippingMethodLabel: Label 'Shipping Method';
        RequestedByLabel: Label 'Requested By';
        FinancialControllerLabel: Label 'Financial Controller';
        ManigingDirectorLabel: Label 'Managing Director';
        SupplyTheFollowingGoodsLabel: label 'Please supply the following Goods and/or Services';
        ThankYouForYourPromptLabel: label 'Thank you for your prompt handling of this order, please acknowledge receipt and acceptance.';
        TermsAndCondLabel: label 'Terms and Conditions';
        TermsAndCondHeaderLabel: Label 'UNLESS A SEPARATE AGREEMENT IS SIGNED BY THE PARTIES HERETO, THIS PURCHASE ORDER IS SUBJECT TO THE TERMS AND CONDITIONS ATTACHED HERETO. NO AMENDMENTS TO SUCH TERMS AND CONDITIONS SHALL BE EFFECTIVE UNLESS IT IS IN WRITING, IDENTIFIED AS AN AMENDMENT TO SUCH TERMS AND CONDITIONS AND SIGNED BY AN AUTHORIZED REPRESENTATIVE OF BOTH PARTIES HERETO.';
        TermsAndCondLabel_1: Label '1.	Please notify us if you are unable to comply with the order as specified.';
        TermsAndCondLabel_2: Label '2.	In case goods, material or services which are similar to those which are the subject of this Purchase Order (referred to as P.O) are being supplied by you to a similar activity business as ours and should be a conflict of interest in your acceptance of this P.O, you will notify us immediately. Upon receiving your notification, we may, at our sole and absolute discretion, cancel the P.O without any liability devolving on us.';
        TermsAndCondLabel_3: Label '3.	Our purchase order number must be clearly printed on your invoice and a copy of our P.O must accompany your invoice. This P.O will be deemed accepted by the Vendor upon the first of the following to occur: (a) the Vendor making, signing, or delivering to the Customer any letter, form, or other writing or instrument acknowledging his acceptance; (b) any performance by the Vendor under the P.O; or (c) the passage of ten (10) days after the Vendor’s receipt of the P.O without sending any written notice to the Customer declining such P.O';
        TermsAndCondLabel_4: Label '4.	Where applicable, an original proof of delivery or shipping must accompany your invoice.';
        TermsAndCondLabel_5: Label '5.	Payments will only be made against official tax invoices - not proforma invoices nor quotations.';
        TermsAndCondLabel_6: Label '6.	All original invoices to be mailed or hand delivered to our Receiving Office. In situations where you claim payment/reimbursement from us for third party invoices, then provided that usage of such 3rd parties has been pre-approved by us, payment/reimbursement of the said third party invoices will be made by us subject to and conditional upon receipt of the substantiating documents from you.';
        TermsAndCondLabel_7: Label '7.	Where progressive payments have been made, the invoice should clearly identify the previous amounts invoiced and paid.';
        TermsAndCondLabel_8: Label '8.	Payment of an invoice will be effected by us within 90 (Ninety) days from the date of an invoice unless otherwise agreed in writing with an official company signatory. In the event that we might need a supplementary period of time to effect the payment, we will send a notice to the Vendor of such time extension.';
        TermsAndCondLabel_9: Label '9.	In case advance payment is made by us prior to our receiving the goods/services ordered, and if such goods/services are subsequently not received by us as per the specificationsstipulated in the P.O, within the given time frame, you will effect full refund of the advance payment to us immediately upon receiving a written notice from us. The refund needs to be made back to the same bank account where the advance payment has been issued from initially. Failure on your part in making such refund will entitle us to take the necessary legal steps against you.';
        TermsAndCondLabel_10: Label '10.	The price is inclusive of all overheads and disbursements. All taxes and levies relating to the payment are your responsibility. We will not reimburse any expenses which are not authorized by us beforehand. The Vendor warrants that the prices for the goods/material sold and/or services performed hereunder are not less favorable than those currently extended toany other customer for the same or similar products in similar quantities and/or services. In the event the Vendor reduces its prices for such goods/material and/or services prior to accepting the Customer’s P.O or during the term of performance of any P.O for services, the Vendor agrees to reduce the prices hereof accordingly. The Vendor warrants that the prices shown in the P.O shall be complete and no additional charges shall be added. If a decrease in the price for any goods and/or services becomes effective after the Vendor accepts a P.O for the goods/material and/or services, but before the Vendor has shipped the goods or performed the services, the price the Customer will pay will be the price in effect when the Vendor ships the goods to the Customer or performs the services. In the event of a price decrease, the Vendor will grant to the Customer a credit with respect to goods then in the Customer’s inventory or the services performed. The price protection credit will be equal to the difference between the price originally paid by the Customer and the new adjusted price of the goods/material and/or services less any previously issued credits. If an increase in the price for any goods/material and/or services becomes effective after the Vendor accepts a P.O for the goods/material and/or services but before the Vendor has shipped the goods or performed the services, the price the Customer will pay will be the price in effect when the Vendor accepted the P.O from the Customer.';
        TermsAndCondLabel_11: Label '11.	Timely provision of the services/supply of the goods is of the very essence to us. You undertake to discharge your obligations in this regard in a timely manner.';
        TermsAndCondLabel_12: Label '12.	Intellectual property: Ownership in all intellectual property such as documents, data, drawings, maps, specifications, calculations, technical information. We retain the right to use all such intellectual property for any project, at our will, without any further payment without any further payment having to be effected to you.';
        TermsAndCondLabel_13: Label '13.	Confidentiality: You will treat the content of this Purchase Order, and the information exchanged as private and confidential. It goes without saying that any material produced for us cannot be shared, disclosed or sold by you to another client.';
        TermsAndCondLabel_14: Label '14.	The services shall be provided in line with the best practices and international standards accepted in your discipline.';
        TermsAndCondLabel_15: Label '15.	You will use reasonable skill, care and diligence in undertaking the services to be provided.';
        TermsAndCondLabel_16_1: Label '16.1    In case the subject of this P.O involves supply and/or usage of goods/material, then you will be responsible for ensuring that the goods/material are of a high and merchantable quality and are fit for the purpose intended, and shall be free of defects in materials, workmanship and design.';
        TermsAndCondLabel_16_2: Label '16.2    Vendor hereby represents and warrants that (i) it is authorized to sell the goods/material and/or performance the services set out in the P.O; (ii) all goods/material provided and/or services performed will comply with the descriptions and specifications as set out in the P.O; (iii) all goods provided are of genuine and authentic manufacture, new and unused, and will throughout the Warranty Period be free from defects in design, materials, workmanship and manufacture, be of satisfactory quality and fit for the purposes communicated by the Customer or if not communicated by the Customer fit for the purposes as can be reasonably deemed; and (iv) all services will be performed in a workmanlike and professional manner by employees or subcontractors of the Vendor having a level of skill commensurate with the requirements of the agreed upon scope of work and that its performance of services do not and will not infringe any patent, copyright, trademark, trade secret or other proprietary right of any third party. The Vendor hereby agrees that it will make spare partsavailable to the Customer for a period of one (1) year from the date of final acceptance by the Customer at the Vendor’s then current price less applicable discounts.';
        TermsAndCondLabel_16_3: Label '16.3    The foregoing warranties are in addition to all other warranties, express or implied, and shall survive the delivery, performance, inspection, acceptance or payment by the Customer. The Customer’s inspection, test, approval, acceptance or use of any goods/material will not relieve the Vendor of any warranties specified herein or otherwise applicable.';
        TermsAndCondLabel_16_4: Label '16.4    If the Customer identifies a warranty problem during the Warranty Period (for the purposes of this P.O Warranty Period shall be for a period of 12 months from the date of delivery of the goods/material (“Warranty Period”)), the Customer will notify Vendor and may, at its sole option, and at the Vendor’s expense:';
        TermsAndCondLabel_16_4_I: Label '(i) require the Vendor to correct any defect or nonconformance; (ii) return deficient or nonconforming goods/material to the Vendor for a full refund of amounts paid for those deficient or nonconforming goods/materi¬al; (iii) correct the deficient or nonconforming goods/material itself, or (iv) re-perform the services or any part thereof which fails to conform to the Customer’s specifications. Replacement or repaired goods/material shall be warranted for a period of 12 months from the date such repairs or replacements were completed.';
        TermsAndCondLabel_16_5: Label '16.5 The Vendor shall be liable for any damage, loss or destruction of any goods/material or property resulting from improper packaging or handling.';
        TermsAndCondLabel_16_6: Label '16.6 Acceptance of deliveries not in conformance with this P.O shall not be deemed a waiver of the Customer’s right to hold the Vendor liable for any loss or damage to the Customer or modify the Vendor’s obligation to make future deliveries in conformance with the terms herein. The Customer reserves the right to inspect the goods/material on or after the delivery date. The latter at its sole option, may reject all or any P.Ortion of the goods/material if it determines the goods/material are defective or nonconforming. The Customer may require replacement of the goods/material; the Vendor shall promptly replace the nonconforming goods/material. If the Vendor fails to timely deliver replacement goods/material, the Customer may replace them with goods/material from a third party and charge the Vendor with the cost thereof and terminate this P.O. Any inspection or other action by the Customer under this section shall not affect the Vendor s obligations under the P.O, and the Customer shall have the right to further inspection after the Vendor takes remedial action.';
        TermsAndCondLabel_17: Label '17.    At all times during the term of the P.O, you will maintain a valid trade license/commercial registration and any other relevant governmental permit and/or approved necessary for operating your business in a lawful manner in the country where you are incorporated and/or in the country/jurisdiction where the goods/services will be delivered.';
        TermsAndCondLabel_18: Label '18.	We reserve the right to cancel this purchase order at our discretion without any requirement to serve an advance notice and without any liability devolving on us. We will pay you for the services rendered/goods supplied until the date of our cancellation notice.';
        TermsAndCondLabel_19: Label '19.	This purchase order will be governed by the laws of the country where we are incorporated.';
        TermsAndCondLabel_20: Label '20.	Neither party shall be liable as a result of any delay or failure to perform its obligations under the Contract if and to the extent such delay or failure is caused by an event or circumstances which is beyond the reasonable control of that party which by its nature could not have been foreseen by such a party or if it could have been foreseen, was unavoidable. If such event or circumstance prevents Vendor from supplying the goods and/or services for more than two (2) weeks, customer shall have the right, without limiting its other rights or remedies, to terminate the contract with immediate effect by giving written notice to Vendor.';
        TermsAndCondLabel_21: Label '21.	Vendor shall not assign, transfer, charge, subcontract or deal in any other manner with all or any of its rights or obligations under the contract without the prior written consent of the customer. Customer may at any time assign, transfer, charge, subcontract, or deal in any other manner with all or any of its rights under the contract and may subcontract or delegate in any manner or all of its obligations under the contract to any third party or agent.';
        TermsAndCondLabel_22: Label '22.	A waiver of any right under the contract is only effective if it is in writing and shall not be deemed to be a waiver of any subsequent breach or default. No failure or delay by a party in exercising any right or remedy under the contract or by law shall constitute a waiver of that or any other right or remedy, nor preclude or restrict its further exercise. No single or partial exercise of such right or remedy shall preclude or restrict the further exercise of that or any other right or remedy. Unless specifically provided otherwise, rights arising under the contract are cumulative and do not exclude rights provided by law.';
        TermsAndCondLabel_23: Label '23.	If a court or any other competent authority finds that any provision (or part thereof) of the contract is invalid, illegal or unenforceable, that provision or part-provision shall, to the extent required, be deemed deleted, and the validity and enforceability of the other provisions of the contract shall not be affected. If any invalid, unenforceable or illegal provision of the contract would be valid, enforceable and legal if some part of it were deleted, the provision shall apply with the minimum modification necessary to make it legal, valid and enforceable.';
        TermsAndCondLabel_24: Label '24.	Any variation, including any additional terms and conditions, to the contract shall only be binding when agreed in writing and signed by customer.';
        TermsAndCondLabel_25: Label '25.	If the Supplier fails to make delivery; fails to perform within the time specified in the PO; delivers non-conforming Goods or material; fails to make progress so as to endanger performance of the PO; then Customer may cancel the PO or part thereof and the Supplier shall be liable for all costs incurred by the Customer in purchasing similar Goods/material elsewhere.';
        TermsAndCondLabel_26: Label '26.	The termination of any P.O shall not affect any obligation of the Parties incurred before the termination date. Notwithstanding the termination or expiration of the P.O, the terms of this P.O which by their context, intent and meaning are intended to survive the termination or expiration of the P.O shall survive any termination or expiration of the P.O.';


}



