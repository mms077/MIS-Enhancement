// report 50209 "Posted Sales Shipment"
// {
//     DefaultLayout = RDLC;
//     //RDLCLayout = 'Layouts/PostedShipment.rdlc';
//     RDLCLayout = 'Reports Layouts/PostedShipmentK.rdlc';
//     Caption = 'Sales - Shipment';
//     EnableHyperlinks = true;
//     Permissions = TableData "Sales Shipment Buffer" = rimd;
//     PreviewMode = PrintLayout;

//     dataset
//     {
//         dataitem("Sales Shipment Header";
//         "Sales Shipment Header")
//         {
//             DataItemTableView = SORTING("No.");
//             RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
//             RequestFilterHeading = 'Sales Invoice';

//             column(No_SalesHeader;
//             "No.")
//             {
//             }
//             //   column(Terms;Terms)
//             // {}
//             column(SalesLineVATIdentifierCaption;
//             SalesLineVATIdentifierCaptionLbl)
//             {
//             }
//             column(PaymentTermsDescriptionCaption;
//             PaymentTermsDescriptionCaptionLbl)
//             {
//             }
//             column(ShipmentMethodDescriptionCaption;
//             ShipmentMethodDescriptionCaptionLbl)
//             {
//             }
//             column(CompanyInfoHomePageCaption;
//             CompanyInfoHomePageCaptionLbl)
//             {
//             }
//             column(CompanyInfoEmailCaption;
//             CompanyInfoEmailCaptionLbl)
//             {
//             }
//             column(DocumentDateCaption;
//             DocumentDateCaptionLbl)
//             {
//             }
//             column(SalesLineAllowInvoiceDiscCaption;
//             SalesLineAllowInvoiceDiscCaptionLbl)
//             {
//             }
//             column(Ship_to_County;
//             "Ship-to County")
//             {
//             }
//             column(Bill_to_Address;
//             "Bill-to Address" + ' - ' + "Bill-to Address 2")
//             {
//             }
//             // column(CompanyInfoCapital;
//             // CompanyInfo.Capital)
//             // {
//             // }
//             column(GLSetupLCYCode;
//             GLSetup."LCY Code")
//             {
//             }
//             column(External_Document_No_;
//             "External Document No.")
//             {
//             }
//             dataitem(CopyLoop;
//             "Integer")
//             {
//                 DataItemTableView = SORTING(Number);

//                 dataitem(PageLoop;
//                 "Integer")
//                 {
//                     DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

//                     column(CompanyInfo2Picture;
//                     CompanyInfo2.Picture)
//                     {
//                     }
//                     column(PaymentTermsDescription;
//                     PaymentTerms.Code)
//                     {
//                     }
//                     column(ShipmentMethodDescription;
//                     ShipmentMethod.Code)
//                     {
//                     }
//                     column(CompanyInfo3Picture;
//                     CompanyInfo3.Picture)
//                     {
//                     }
//                     // column(CompanyInfo3SubPic;
//                     // CompanyInfo3."Sub Picture") //karim
//                     // {
//                     // }
//                     column(CompanyInfo1Picture;
//                     CompanyInfo1.Picture)
//                     {
//                     }
//                     column(CompanyInfoCountryRegionCode;
//                     CompanyInfo."Country/Region Code")
//                     {
//                     }
//                     column(SalesCopyText;
//                     StrSubstNo(Text004, CopyText))
//                     {
//                     }
//                     column(CustAddr1;
//                     CustAddr[1])
//                     {
//                     }
//                     column(CompanyAddr1;
//                     CompanyAddr[1])
//                     {
//                     }
//                     column(CustAddr2;
//                     CustAddr[2])
//                     {
//                     }
//                     column(CompanyAddr2;
//                     CompanyAddr[2])
//                     {
//                     }
//                     column(CustAddr3;
//                     CustAddr[3])
//                     {
//                     }
//                     column(CompanyAddr3;
//                     CompanyAddr[3])
//                     {
//                     }
//                     column(CustAddr4;
//                     CustAddr[4])
//                     {
//                     }
//                     column(CompanyAddr4;
//                     CompanyAddr[4])
//                     {
//                     }
//                     column(CustAddr5;
//                     CustAddr[5])
//                     {
//                     }
//                     column(CompanyInfoEmail;
//                     CompanyInfo."E-Mail")
//                     {
//                     }
//                     column(CompanyInfoHomePage;
//                     CompanyInfo."Home Page")
//                     {
//                     }
//                     column(CompanyInfoPhoneNo;
//                     CompanyInfo."Phone No.")
//                     {
//                     }
//                     column(CompanyInfoFaxNo;
//                     CompanyInfo."Fax No.")
//                     {
//                     }
//                     column(CustAddr6;
//                     CustAddr[6])
//                     {
//                     }
//                     column(CompanyInfoVATRegNo;
//                     CompanyInfo."VAT Registration No.")
//                     {
//                     }
//                     column(CompanyInfoGiroNo;
//                     CompanyInfo."Giro No.")
//                     {
//                     }
//                     column(CompanyInfoBankName;
//                     CompanyInfo."Bank Name")
//                     {
//                     }
//                     column(CompanyInfoBankAccountNo;
//                     CompanyInfo."Bank Account No.")
//                     {
//                     }
//                     column(CompPostCode;
//                     CompanyInfo.City + ' ' + CompanyInfo."Post Code")
//                     {
//                     }
//                     column(BilltoCustNo_SalesHeader;
//                     "Sales Shipment Header"."Bill-to Customer No.")
//                     {
//                     }
//                     column(DocDate_SalesHeader;
//                     Format("Sales Shipment Header"."Document Date", 0, 4))
//                     {
//                     }
//                     column(VATNoText;
//                     VATNoText)
//                     {
//                     }
//                     column(VATRegNo_SalesHeader;
//                     "Sales Shipment Header"."VAT Registration No.")
//                     {
//                     }
//                     column(ShipmentDate_SalesHeader;
//                     Format("Sales Shipment Header"."Shipment Date"))
//                     {
//                     }
//                     column(SalesPersonText;
//                     SalesPersonText)
//                     {
//                     }
//                     column(SalesPurchPersonName;
//                     SalesPurchPerson.Name)
//                     {
//                     }
//                     column(No1_SalesHeader;
//                     "Sales Shipment Header"."No.")
//                     {
//                     }
//                     column(ReferenceText;
//                     ReferenceText)
//                     {
//                     }
//                     column(YourReference_SalesHeader;
//                     "Sales Shipment Header"."Your Reference")
//                     {
//                     }
//                     column(CustAddr7;
//                     CustAddr[7])
//                     {
//                     }
//                     column(CustAddr8;
//                     CustAddr[8])
//                     {
//                     }
//                     column(CompanyAddr5;
//                     CompanyAddr[5])
//                     {
//                     }
//                     column(CompanyAddr6;
//                     CompanyAddr[6])
//                     {
//                     }
//                     column(PricesIncludingVAT_SalesHdr;
//                     "Sales Shipment Header"."Prices Including VAT")
//                     {
//                     }
//                     column(PricesInclVAT_SalesInvHdr;
//                     "Sales Shipment Header"."Prices Including VAT")
//                     {
//                     }
//                     column(PageCaption;
//                     StrSubstNo(Text005, ''))
//                     {
//                     }
//                     column(OutputNo;
//                     OutputNo)
//                     {
//                     }
//                     column(PricesInclVATYesNo_SalesInvHdr;
//                     Format("Sales Shipment Header"."Prices Including VAT"))
//                     {
//                     }
//                     column(PricesInclVATYesNo_SalesHdr;
//                     Format("Sales Shipment Header"."Prices Including VAT"))
//                     {
//                     }
//                     column(CompanyInfoPhoneNoCaption;
//                     CompanyInfoPhoneNoCaptionLbl)
//                     {
//                     }
//                     column(CompanyInfoVATRegNoCaption;
//                     CompanyInfoVATRegNoCaptionLbl)
//                     {
//                     }
//                     column(CompanyInfoGiroNoCaption;
//                     CompanyInfoGiroNoCaptionLbl)
//                     {
//                     }
//                     column(CompanyInfoBankNameCaption;
//                     CompanyInfoBankNameCaptionLbl)
//                     {
//                     }
//                     column(CompanyInfoBankAccountNoCaption;
//                     CompanyInfoBankAccountNoCaptionLbl)
//                     {
//                     }
//                     column(SalesHeaderShipmentDateCaption;
//                     SalesHeaderShipmentDateCaptionLbl)
//                     {
//                     }
//                     column(SalesHeaderNoCaption;
//                     SalesHeaderNoCaptionLbl)
//                     {
//                     }
//                     column(BilltoCustNo_SalesHeaderCaption;
//                     "Sales Shipment Header".FieldCaption("Bill-to Customer No."))
//                     {
//                     }
//                     column(InvDiscountAmtCaption;
//                     InvDiscountAmtCaptionLbl)
//                     {
//                     }
//                     column(PricesIncludingVAT_SalesHdrCaption;
//                     "Sales Shipment Header".FieldCaption("Prices Including VAT"))
//                     {
//                     }
//                     column(PricesInclVAT_SalesInvHdrCaption;
//                     "Sales Shipment Header".FieldCaption("Prices Including VAT"))
//                     {
//                     }
//                     column(BilltoCustName_SalesHeader;
//                     "Sales Shipment Header"."Bill-to Name")
//                     {
//                     }
//                     column(ShiptoCustName_SalesHeader;
//                     ShiptoCustName_SalesHeader)
//                     {
//                     }
//                     column(shipToAddress;
//                     shipToAddress)
//                     {
//                     }
//                     column(shipToAddress2;
//                     "Sales Shipment Header"."Ship-to Address 2")
//                     {
//                     }
//                     column(ShipToCountry;
//                     "Sales Shipment Header"."Ship-to City")
//                     {
//                     }
//                     column(shiptoPhone;
//                     ShipToCustomer."Phone No.")
//                     {
//                     }
//                     column(CustPhone;
//                     "Sales Shipment Header"."Sell-to Phone No.")
//                     {
//                     }
//                     column(selltoCountry;
//                     "Sales Shipment Header"."Sell-to Country/Region Code")
//                     {
//                     }
//                     column(DueDate;
//                     Format("Sales Shipment Header"."Due Date", 0, 4))
//                     {
//                     }
//                     column(CurrencyCode;
//                     "Sales Shipment Header"."Currency Code")
//                     {
//                     }
//                     /*   column(CustOrder;
//                       "Sales Shipment Header"."Customer Order ID")
//                       {
//                       } */
//                     column(ShowAmounttxt;
//                     UpperCase(ShowAmounttxt[1]))
//                     {
//                     }
//                     column(VATLCY;
//                     VATLCY)
//                     {
//                     }
//                     column(PrintTerms;
//                     PrintTerms)
//                     {
//                     }
//                     column(CompPostFax;
//                     CompanyInfo."Fax No.")
//                     {
//                     }
//                     column(CompEmail;
//                     CompanyInfo."E-Mail")
//                     {
//                     }
//                     column(CompPostPhone;
//                     CompanyInfo."Phone No.")
//                     {
//                     }
//                     column(CompPosAddress;
//                     CompanyInfo.Address)
//                     {
//                     }
//                     column(CompPosAddress2;
//                     CompanyInfo."Address 2")
//                     {
//                     }
//                     dataitem(DimensionLoop1;
//                     "Integer")
//                     {
//                         DataItemLinkReference = "Sales Shipment Header";
//                         DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

//                         column(DimText;
//                         DimText)
//                         {
//                         }
//                         column(DimensionLoop1Number;
//                         Number)
//                         {
//                         }
//                         column(HeaderDimensionsCaption;
//                         HeaderDimensionsCaptionLbl)
//                         {
//                         }
//                         trigger OnAfterGetRecord()
//                         begin
//                             if Number = 1 then begin
//                                 if not DimSetEntry1.FindSet then CurrReport.Break;
//                             end
//                             else
//                                 if not Continue then CurrReport.Break;
//                             Clear(DimText);
//                             Continue := false;
//                             repeat
//                                 OldDimText := DimText;
//                                 if DimText = '' then
//                                     DimText := StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
//                                 else
//                                     DimText := StrSubstNo('%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
//                                 if StrLen(DimText) > MaxStrLen(OldDimText) then begin
//                                     DimText := OldDimText;
//                                     Continue := true;
//                                     exit;
//                                 end;
//                             until DimSetEntry1.Next = 0;
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             if not ShowInternalInfo then CurrReport.Break;
//                         end;
//                     }
//                     dataitem("Sales Shipment Line";
//                     "Sales Shipment Line")
//                     {
//                         DataItemLink = "Document No." = FIELD("No.");
//                         DataItemLinkReference = "Sales Shipment Header";
//                         DataItemTableView = SORTING("Document No.", "Line No.");

//                         // column(LineAmt_SalesInvLine; 0)
//                         // {
//                         //     AutoFormatExpression = GetCurrencyCode;
//                         //     AutoFormatType = 1;
//                         // }
//                         // column(LineAmt_SalesLine; "Sales Shipment Line"."Line Amount")
//                         // {
//                         //     // AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                         //     AutoFormatType = 1;
//                         // }
//                         column(No_SalesLine;
//                         "Sales Shipment Line"."No.")
//                         {
//                         }
//                         column(HSCode;
//                         HSCode)
//                         {
//                         }
//                         column(MainLineDesc;
//                         MainLineDesc)
//                         {
//                         }
//                         column(HasSize;
//                         HasSize)
//                         {
//                         }
//                         column(Desc_SalesLine;
//                         "Sales Shipment Line".Description)
//                         {
//                         }
//                         column(Quantity_SalesLine;
//                         "Sales Shipment Line".Quantity)
//                         {
//                         }
//                         column(UnitofMeasure_SalesLine;
//                         "Sales Shipment Line"."Unit of Measure")
//                         {
//                         }
//                         // column(LineAmt1_SalesLine; "Sales Shipment Line"."Line Amount")
//                         // {
//                         //     AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                         //     AutoFormatType = 1;
//                         // }
//                         column(UnitPrice_SalesLine;
//                         "Sales Shipment Line"."Unit Price")
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 2;
//                         }
//                         column(LineDiscount_SalesLine;
//                         "Sales Shipment Line"."Line Discount %")
//                         {
//                         }
//                         column(AllowInvoiceDisc_SalesLine;
//                         "Sales Shipment Line"."Allow Invoice Disc.")
//                         {
//                             IncludeCaption = false;
//                         }
//                         // column(VATIdentifier_SalesLine; "Sales Shipment Line"."VAT Identifier")
//                         // {
//                         // }
//                         column(Type_SalesLine;
//                         Format("Sales Shipment Line".Type))
//                         {
//                         }
//                         column(No1_SalesLine;
//                         "Sales Shipment Line"."Line No.")
//                         {
//                         }
//                         column(AllowInvoiceDisYesNo;
//                         Format("Sales Shipment Line"."Allow Invoice Disc."))
//                         {
//                         }
//                         /*                     column(InvDiscountAmount_SalesLine; -SalesLine."Inv. Discount Amount")
//                                                                    {
//                                                                        AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                                                                        AutoFormatType = 1;
//                                                                    }

//                                                                    column(DiscountAmt_SalesLine; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount")
//                                                                    {
//                                                                        AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                                                                        AutoFormatType = 1;
//                                                                    }*/
//                         column(VATAmtLineVATAmtTxt;
//                         VATAmountLine.VATAmountText)
//                         {
//                         }
//                         column(VATAmount;
//                         VATAmount)
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATDiscountAmount;
//                         -VATDiscountAmount)
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATBaseAmount;
//                         VATBaseAmount)
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         /*  column(InvDiscLineAmt_SalesInvLine; -"Inv. Discount Amount")
//                                                 {
//                                                     AutoFormatExpression = GetCurrencyCode;
//                                                     AutoFormatType = 1;
//                                                 }*/
//                         column(TotalSubTotal;
//                         TotalSubTotal)
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(TotalInvDiscAmount;
//                         TotalInvDiscAmount)
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(TotalText;
//                         TotalText)
//                         {
//                         }
//                         /*    column(Amount_SalesInvLine; Amount)
//                                                   {
//                                                       AutoFormatExpression = GetCurrencyCode;
//                                                       AutoFormatType = 1;
//                                                   }*/
//                         column(TotalAmount;
//                         TotalAmount)
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         /*   column(Amount_AmtInclVAT; "Amount Including VAT" - Amount)
//                                                  {
//                                                      AutoFormatExpression = GetCurrencyCode;
//                                                      AutoFormatType = 1;
//                                                  }
//                                                  column(AmtInclVAT_SalesInvLine; "Amount Including VAT")
//                                                  {
//                                                      AutoFormatExpression = GetCurrencyCode;
//                                                      AutoFormatType = 1;
//                                                  }*/
//                         column(VATAmtLineVATAmtText;
//                         VATAmountLine.VATAmountText)
//                         {
//                         }
//                         column(TotalExclVATText;
//                         TotalExclVATText)
//                         {
//                         }
//                         column(TotalInclVATText;
//                         TotalInclVATText)
//                         {
//                         }
//                         column(TotalAmountInclVAT;
//                         TotalAmountInclVAT)
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(TotalAmountVAT;
//                         TotalAmountVAT)
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         /*      column(LineAmtAfterInvDiscAmt; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
//                                                     {
//                                                         AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                                                         AutoFormatType = 1;
//                                                     }*/
//                         column(VATBaseDisc_SalesInvHdr;
//                         "Sales Shipment Header"."VAT Base Discount %")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(TotalPaymentDiscOnVAT;
//                         TotalPaymentDiscOnVAT)
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(TotalInclVATText_SalesInvLine;
//                         TotalInclVATText)
//                         {
//                         }
//                         column(VATAmtText_SalesInvLine;
//                         VATAmountLine.VATAmountText)
//                         {
//                         }
//                         column(UnitPriceCaption;
//                         UnitPriceCaptionLbl)
//                         {
//                         }
//                         column(SalesLineLineDiscCaption;
//                         SalesLineLineDiscCaptionLbl)
//                         {
//                         }
//                         column(AmountCaption;
//                         AmountCaptionLbl)
//                         {
//                         }
//                         column(SalesLineInvDiscAmtCaption;
//                         SalesLineInvDiscAmtCaptionLbl)
//                         {
//                         }
//                         column(SubtotalCaption;
//                         SubtotalCaptionLbl)
//                         {
//                         }
//                         column(VATDiscountAmountCaption;
//                         VATDiscountAmountCaptionLbl)
//                         {
//                         }
//                         column(No_SalesLineCaption;
//                         'Item No.')
//                         {
//                         }
//                         column(Desc_SalesLineCaption;
//                         "Sales Shipment Line".FieldCaption(Description))
//                         {
//                         }
//                         column(Quantity_SalesLineCaption;
//                         'Qty')
//                         {
//                         }
//                         column(UnitofMeasure_SalesLineCaption;
//                         "Sales Shipment Line".FieldCaption("Unit of Measure"))
//                         {
//                         }
//                         column(VariantCode;
//                         "Sales Shipment Line"."Variant Code")
//                         {
//                         }
//                         // column(MainSalesLine; "Sales Shipment Line"."Main Sales Line")
//                         // { }
//                         // column(ClientDep;
//                         // "Sales Shipment Line"."Sub Department")
//                         // {
//                         // }
//                         // jinan
//                         column(Discount_SalesInvLine;
//                         "Line Discount %")
//                         {
//                         }
//                         // column(VATIdentifier_SalesInvLine; "VAT Identifier")
//                         // {
//                         // }
//                         column(PostedShipmentDate;
//                         Format("Shipment Date"))
//                         {
//                         }
//                         column(Type_SalesInvLine;
//                         Format(Type))
//                         {
//                         }
//                         column(DocNo_SalesInvLine;
//                         "Document No.")
//                         {
//                         }
//                         column(LineNo_SalesInvLine;
//                         "Line No.")
//                         {
//                         }
//                         column(PostedShipmentDateCaption;
//                         PostedShipmentDateCaptionLbl)
//                         {
//                         }
//                         column(LineAmtAfterInvDiscCptn;
//                         LineAmtAfterInvDiscCptnLbl)
//                         {
//                         }
//                         column(Desc_SalesInvLineCaption;
//                         FieldCaption(Description))
//                         {
//                         }
//                         column(No_SalesInvLineCaption;
//                         FieldCaption("No."))
//                         {
//                         }
//                         column(Qty_SalesInvLineCaption;
//                         FieldCaption(Quantity))
//                         {
//                         }
//                         column(UOM_SalesInvLineCaption;
//                         FieldCaption("Unit of Measure"))
//                         {
//                         }
//                         // column(VATIdentifier_SalesInvLineCaption; FieldCaption("VAT Identifier"))
//                         // {
//                         // }
//                         column(IsLineWithTotals;
//                         LineNoWithTotal = "Line No.")
//                         {
//                         }
//                         //edm.ai
//                         /*    column(Amount_Including_VAT; "Amount Including VAT")
//                                                   { }
//                                                   column(Amount; Amount)
//                                                   { }*/
//                         column(VAT__;
//                         "VAT %")
//                         {
//                         }
//                         // dataitem("Sales Order Sizes";
//                         // "Sales Order Sizes")
//                         // {
//                         //     column(Size_Code;
//                         //     "Size Code")
//                         //     {
//                         //     }
//                         //     column(SizeQuantity;
//                         //     Quantity)
//                         //     {
//                         //     }
//                         //     trigger OnAfterGetRecord()
//                         //     begin
//                         //         if "Sales Shipment Line".Type <> "Sales Shipment Line".Type::Item then CurrReport.skip;
//                         //         HasSize := true;
//                         //     end;

//                         //     trigger OnPreDataItem()
//                         //     begin
//                         //         /*  if "Sales Shipment Header"."Pre-Assigned No." = '' then
//                         //                                           SetRange("Document No.", "Sales Shipment Header"."Order No.")
//                         //                                       else*/
//                         //         SetRange("Document No.", "Sales Shipment Line"."Document No.");
//                         //         SetRange("Document Line No.", "Sales Shipment Line"."Line No.");
//                         //     end;
//                         // }
//                         dataitem("Sales Shipment Buffer";
//                         "Integer")
//                         {
//                             DataItemTableView = SORTING(Number);

//                             column(SalesShptBufferPostDate;
//                             Format(SalesShipmentBuffer."Posting Date"))
//                             {
//                             }
//                             column(SalesShptBufferQty;
//                             SalesShipmentBuffer.Quantity)
//                             {
//                                 DecimalPlaces = 0 : 5;
//                             }
//                             column(ShipmentCaption;
//                             ShipmentCaptionLbl)
//                             {
//                             }
//                             trigger OnAfterGetRecord()
//                             begin
//                                 if Number = 1 then
//                                     SalesShipmentBuffer.Find('-')
//                                 else
//                                     SalesShipmentBuffer.Next;
//                             end;

//                             trigger OnPreDataItem()
//                             begin
//                                 SalesShipmentBuffer.SetRange("Document No.", "Sales Shipment Line"."Document No.");
//                                 SalesShipmentBuffer.SetRange("Line No.", "Sales Shipment Line"."Line No.");
//                                 SetRange(Number, 1, SalesShipmentBuffer.Count);
//                             end;
//                         }
//                         dataitem(DimensionLoop2;
//                         "Integer")
//                         {
//                             DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

//                             column(DimText_DimnLoop2;
//                             DimText)
//                             {
//                             }
//                             column(LineDimensionsCaption;
//                             LineDimensionsCaptionLbl)
//                             {
//                             }
//                             trigger OnAfterGetRecord()
//                             begin
//                                 if Number = 1 then begin
//                                     if not DimSetEntry2.FindSet then CurrReport.Break;
//                                 end
//                                 else
//                                     if not Continue then CurrReport.Break;
//                                 Clear(DimText);
//                                 Continue := false;
//                                 repeat
//                                     OldDimText := DimText;
//                                     if DimText = '' then
//                                         DimText := StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
//                                     else
//                                         DimText := StrSubstNo('%1, %2 %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
//                                     if StrLen(DimText) > MaxStrLen(OldDimText) then begin
//                                         DimText := OldDimText;
//                                         Continue := true;
//                                         exit;
//                                     end;
//                                 until DimSetEntry2.Next = 0;
//                             end;

//                             trigger OnPreDataItem()
//                             begin
//                                 if not ShowInternalInfo then CurrReport.Break;
//                                 DimSetEntry2.SetRange("Dimension Set ID", "Sales Shipment Line"."Dimension Set ID");
//                             end;
//                         }
//                         dataitem(AsmLoop;
//                         "Integer")
//                         {
//                             DataItemTableView = SORTING(Number);

//                             column(TempPostedAsmLineNo;
//                             BlanksForIndent + TempPostedAsmLine."No.")
//                             {
//                             }
//                             column(TempPostedAsmLineQuantity;
//                             TempPostedAsmLine.Quantity)
//                             {
//                                 DecimalPlaces = 0 : 5;
//                             }
//                             column(TempPostedAsmLineDesc;
//                             BlanksForIndent + TempPostedAsmLine.Description)
//                             {
//                             }
//                             column(TempPostAsmLineVartCode;
//                             BlanksForIndent + TempPostedAsmLine."Variant Code")
//                             {
//                             }
//                             column(TempPostedAsmLineUOM;
//                             GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
//                             {
//                             }
//                             trigger OnAfterGetRecord()
//                             var
//                                 ItemTranslation: Record "Item Translation";
//                             begin
//                                 if Number = 1 then
//                                     TempPostedAsmLine.FindSet
//                                 else
//                                     TempPostedAsmLine.Next;
//                                 if ItemTranslation.Get(TempPostedAsmLine."No.", TempPostedAsmLine."Variant Code", "Sales Shipment Header"."Language Code") then TempPostedAsmLine.Description := ItemTranslation.Description;
//                             end;

//                             trigger OnPreDataItem()
//                             begin
//                                 Clear(TempPostedAsmLine);
//                                 if not DisplayAssemblyInformation then CurrReport.Break;
//                                 CollectAsmInformation;
//                                 Clear(TempPostedAsmLine);
//                                 SetRange(Number, 1, TempPostedAsmLine.Count);
//                             end;
//                         }
//                         trigger OnAfterGetRecord()
//                         var
//                             recItem: Record Item;
//                         begin
//                             HasSize := false;
//                             HSCode := '';
//                             if Type = type::Item then begin
//                                 recItem.get("No.");
//                                 //SCode := recItem."HS Code";//Exquitech-ER "HS Code"
//                             end;
//                             InitializeShipmentBuffer;
//                             if (Type = Type::"G/L Account") and (not ShowInternalInfo) then "No." := '';
//                             VATAmountLine.Init;
//                             // VATAmountLine."VAT Identifier" := "VAT Identifier";
//                             VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
//                             VATAmountLine."Tax Group Code" := "Tax Group Code";
//                             VATAmountLine."VAT %" := "VAT %";
//                             /*    VATAmountLine."VAT Base" := Amount;
//                                                           VATAmountLine."Amount Including VAT" := "Amount Including VAT";
//                                                           VATAmountLine."Line Amount" := "Line Amount";
//                                                           if "Allow Invoice Disc." then
//                                                               VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
//                                                           VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
//                                                           VATAmountLine."VAT Clause Code" := "VAT Clause Code";
//                                                           VATAmountLine.InsertLine;
//                                                           CalcVATAmountLineLCY(
//                                                             "Sales Shipment Header", VATAmountLine, TempVATAmountLineLCY,
//                                                             VATBaseRemainderAfterRoundingLCY, AmtInclVATRemainderAfterRoundingLCY);

//                                                           TotalSubTotal += "Line Amount";
//                                                           TotalInvDiscAmount -= "Inv. Discount Amount";
//                                                           TotalAmount += Amount;
//                                                           TotalAmountVAT += "Amount Including VAT" - Amount;
//                                                           TotalAmountInclVAT += "Amount Including VAT";
//                                                           TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");*/
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             VATAmountLine.DeleteAll;
//                             TempVATAmountLineLCY.DeleteAll;
//                             VATBaseRemainderAfterRoundingLCY := 0;
//                             AmtInclVATRemainderAfterRoundingLCY := 0;
//                             SalesShipmentBuffer.Reset;
//                             SalesShipmentBuffer.DeleteAll;
//                             FirstValueEntryNo := 0;
//                             MoreLines := Find('+');
//                             while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) /*and (Amount = 0)*/do MoreLines := Next(-1) <> 0;
//                             if not MoreLines then CurrReport.Break;
//                             LineNoWithTotal := "Line No.";
//                             SetRange("Line No.", 0, "Line No.");
//                             SetFilter(Quantity, '<> %1', 0);
//                         end;
//                     }
//                     dataitem(VATCounter;
//                     "Integer")
//                     {
//                         DataItemTableView = SORTING(Number);

//                         column(VATBase_VATAmtLine;
//                         VATAmountLine."VAT Base")
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmt_VATAmtLine;
//                         VATAmountLine."VAT Amount")
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(LineAmount_VATAmtLine;
//                         VATAmountLine."Line Amount")
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(InvDiscBaseAmt_VATAmtLine;
//                         VATAmountLine."Inv. Disc. Base Amount")
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(InvoiceDiscAmt_VATAmtLine;
//                         VATAmountLine."Invoice Discount Amount")
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VAT_VATAmtLine;
//                         VATAmountLine."VAT %")
//                         {
//                             DecimalPlaces = 0 : 5;
//                         }
//                         column(VATIdentifier_VATAmtLine;
//                         VATAmountLine."VAT Identifier")
//                         {
//                         }
//                         column(VATAmountLineVATCaption;
//                         VATAmountLineVATCaptionLbl)
//                         {
//                         }
//                         column(VATBaseCaption;
//                         VATBaseCaptionLbl)
//                         {
//                         }
//                         column(VATAmtCaption;
//                         VATAmtCaptionLbl)
//                         {
//                         }
//                         column(VATAmountSpecificationCaption;
//                         VATAmountSpecificationCaptionLbl)
//                         {
//                         }
//                         column(LineAmtCaption;
//                         LineAmtCaptionLbl)
//                         {
//                         }
//                         column(InvoiceDiscBaseAmtCaption;
//                         InvoiceDiscBaseAmtCaptionLbl)
//                         {
//                         }
//                         column(InvoiceDiscAmtCaption;
//                         InvoiceDiscAmtCaptionLbl)
//                         {
//                         }
//                         column(TotalCaption;
//                         TotalCaptionLbl)
//                         {
//                         }
//                         trigger OnAfterGetRecord()
//                         begin
//                             VATAmountLine.GetLine(Number);
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             SetRange(Number, 1, VATAmountLine.Count);
//                         end;
//                     }
//                     dataitem(VATClauseEntryCounter;
//                     "Integer")
//                     {
//                         DataItemTableView = SORTING(Number);

//                         column(VATClauseVATIdentifier;
//                         VATAmountLine."VAT Identifier")
//                         {
//                         }
//                         column(VATClauseCode;
//                         VATAmountLine."VAT Clause Code")
//                         {
//                         }
//                         column(VATClauseDescription;
//                         VATClause.Description)
//                         {
//                         }
//                         column(VATClauseDescription2;
//                         VATClause."Description 2")
//                         {
//                         }
//                         column(VATClauseAmount;
//                         VATAmountLine."VAT Amount")
//                         {
//                             AutoFormatExpression = "Sales Shipment Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATClausesCaption;
//                         VATClausesCap)
//                         {
//                         }
//                         column(VATClauseVATIdentifierCaption;
//                         VATIdentifierCaptionLbl)
//                         {
//                         }
//                         column(VATClauseVATAmtCaption;
//                         VATAmtCaptionLbl)
//                         {
//                         }
//                         trigger OnAfterGetRecord()
//                         begin
//                             VATAmountLine.GetLine(Number);
//                             if not VATClause.Get(VATAmountLine."VAT Clause Code") then CurrReport.Skip;
//                             VATClause.TranslateDescription("Sales Shipment Header"."Language Code");
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             Clear(VATClause);
//                             SetRange(Number, 1, VATAmountLine.Count);
//                         end;
//                     }
//                     dataitem(VATCounterLCY;
//                     "Integer")
//                     {
//                         DataItemTableView = SORTING(Number);

//                         column(VALExchRate;
//                         VALExchRate)
//                         {
//                         }
//                         column(VALSpecLCYHeader;
//                         VALSpecLCYHeader)
//                         {
//                         }
//                         column(VALVATBaseLCY;
//                         VALVATBaseLCY)
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(VALVATAmountLCY;
//                         VALVATAmountLCY)
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(VATCtrl_VATAmtLine;
//                         VATAmountLine."VAT %")
//                         {
//                             DecimalPlaces = 0 : 5;
//                         }
//                         column(VATIdentifierCtrl_VATAmtLine;
//                         VATAmountLine."VAT Identifier")
//                         {
//                         }
//                         trigger OnAfterGetRecord()
//                         begin
//                             TempVATAmountLineLCY.GetLine(Number);
//                             VALVATBaseLCY := TempVATAmountLineLCY."VAT Base";
//                             VALVATAmountLCY := TempVATAmountLineLCY."Amount Including VAT" - TempVATAmountLineLCY."VAT Base";
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             if (not GLSetup."Print VAT specification in LCY") or ("Sales Shipment Header"."Currency Code" = '') then CurrReport.Break;
//                             SetRange(Number, 1, VATAmountLine.Count);
//                             Clear(VALVATBaseLCY);
//                             Clear(VALVATAmountLCY);
//                             if GLSetup."LCY Code" = '' then
//                                 VALSpecLCYHeader := Text007 + Text008
//                             else
//                                 VALSpecLCYHeader := Text007 + Format(GLSetup."LCY Code");
//                             CurrExchRate.FindCurrency("Sales Shipment Header"."Posting Date", "Sales Shipment Header"."Currency Code", 1);
//                             CalculatedExchRate := Round(1 / "Sales Shipment Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
//                             VALExchRate := StrSubstNo(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
//                         end;
//                     }
//                     dataitem(PaymentReportingArgument;
//                     "Payment Reporting Argument")
//                     {
//                         DataItemTableView = SORTING(Key);
//                         UseTemporary = true;

//                         column(PaymentServiceLogo;
//                         Logo)
//                         {
//                         }
//                         column(PaymentServiceURLText;
//                         "URL Caption")
//                         {
//                         }
//                         column(PaymentServiceURL;
//                         GetTargetURL)
//                         {
//                         }
//                         trigger OnPreDataItem()
//                         var
//                             PaymentServiceSetup: Record "Payment Service Setup";
//                         begin
//                             // PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, "Sales Shipment Header");
//                             // if IsEmpty then
//                             //     CurrReport.Break;
//                         end;
//                     }
//                     dataitem(Total;
//                     "Integer")
//                     {
//                         DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

//                         column(SelltoCustNo_SalesInvHdr;
//                         "Sales Shipment Header"."Sell-to Customer No.")
//                         {
//                         }
//                         column(ShipToAddr1;
//                         ShipToAddr[1])
//                         {
//                         }
//                         column(ShipToAddr2;
//                         ShipToAddr[2])
//                         {
//                         }
//                         column(ShipToAddr3;
//                         ShipToAddr[3])
//                         {
//                         }
//                         column(ShipToAddr4;
//                         ShipToAddr[4])
//                         {
//                         }
//                         column(ShipToAddr5;
//                         ShipToAddr[5])
//                         {
//                         }
//                         column(ShipToAddr6;
//                         ShipToAddr[6])
//                         {
//                         }
//                         column(ShipToAddr7;
//                         ShipToAddr[7])
//                         {
//                         }
//                         column(ShipToAddr8;
//                         ShipToAddr[8])
//                         {
//                         }
//                         column(ShiptoAddrCaption;
//                         ShiptoAddrCaptionLbl)
//                         {
//                         }
//                         column(SelltoCustNo_SalesInvHdrCaption;
//                         "Sales Shipment Header".FieldCaption("Sell-to Customer No."))
//                         {
//                         }
//                         trigger OnPreDataItem()
//                         begin
//                             if not ShowShippingAddr then CurrReport.Break;
//                         end;
//                     }
//                     dataitem(LineFee;
//                     "Integer")
//                     {
//                         DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1 ..));

//                         column(LineFeeCaptionLbl;
//                         TempLineFeeNoteOnReportHist.ReportText)
//                         {
//                         }
//                         trigger OnAfterGetRecord()
//                         begin
//                             if not DisplayAdditionalFeeNote then CurrReport.Break;
//                             if Number = 1 then begin
//                                 if not TempLineFeeNoteOnReportHist.FindSet then CurrReport.Break
//                             end
//                             else
//                                 if TempLineFeeNoteOnReportHist.Next = 0 then CurrReport.Break;
//                         end;
//                     }
//                 }
//                 trigger OnAfterGetRecord()
//                 var
//                 begin
//                     if Number > 1 then begin
//                         CopyText := FormatDocument.GetCOPYText;
//                         OutputNo += 1;
//                     end;
//                     CurrReport.PageNo := 1;
//                     TotalSubTotal := 0;
//                     TotalInvDiscAmount := 0;
//                     TotalAmount := 0;
//                     TotalAmountVAT := 0;
//                     TotalAmountInclVAT := 0;
//                     TotalPaymentDiscOnVAT := 0;
//                 end;

//                 trigger OnPostDataItem()
//                 begin
//                     //   if not IsReportInPreviewMode then
//                     //      CODEUNIT.Run(CODEUNIT::"Sales Inv.-Printed", "Sales Shipment Header");
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     NoOfLoops := Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
//                     if NoOfLoops <= 0 then NoOfLoops := 1;
//                     CopyText := '';
//                     SetRange(Number, 1, NoOfLoops);
//                     OutputNo := 1;
//                 end;
//             }
//             trigger OnAfterGetRecord() //sales Hdr
//             var
//                 Handled: Boolean;
//                 GeneralLedgerSetup: record "General Ledger Setup";
//                 BaseCurr: code[20];
//                 CurrExch: Record "Currency Exchange Rate";
//             begin
//                 CompanyInfo3.CalcFields(Picture);
//                 //CompanyInfo3.CalcFields("Sub Picture"); //karim
//                 //CurrReport.LANGUAGE:=Language.GetLanguageID("Language Code"); //Exquitech-ER function does not exists 
//                 FormatAddressFields("Sales Shipment Header");
//                 FormatDocumentFields("Sales Shipment Header");
//                 IF NOT Cust.GET("Bill-to Customer No.") THEN CLEAR(Cust);
//                 DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");
//                 GetLineFeeNoteOnReportHist("No.");
//                 OnAfterGetRecordSalesInvoiceHeader("Sales Shipment Header");
//                 OnGetReferenceText("Sales Shipment Header", ReferenceText, Handled);
//                 if "Currency Code" = '' then
//                     BaseCurr := GeneralLedgerSetup."Local Currency Symbol"
//                 else
//                     BaseCurr := "Currency Code";
//                 /* "Sales Shipment Header".calcfields("Amount Including VAT", Amount);
//                              amountToText.FormatNoText(ShowAmounttxt, "Sales Shipment Header"."Amount Including VAT", BaseCurr);
//                              VATLCY := CurrExch.ExchangeAmtFCYToLCY("Document Date", "Currency Code", "Amount Including VAT" - Amount, "Currency Factor");
//              */
//                 Clear(DimensionSetEntry);
//                 GLSetup.Get();
//                 DimensionSetEntry.SetRange("Dimension Set ID", "Sales Shipment Header"."Dimension Set ID");
//                 DimensionSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 3 Code"); //cust project
//                 IF DimensionSetEntry.FindFirst() then begin
//                     DimensionValueCode := DimensionSetEntry."Dimension Value Code";
//                     DimensionSetEntry.CalcFields("Dimension Value Name");
//                     ShiptoCustName_SalesHeader := DimensionSetEntry."Dimension Value Name";
//                     DimenionValue.Get(GLSetup."Shortcut Dimension 3 Code", DimensionSetEntry."Dimension Value Code");
//                     //shipToAddress := DimenionValue.Address;
//                 end
//                 else begin
//                     ShiptoCustName_SalesHeader := "Sales Shipment Header"."Ship-to Name";
//                     shipToAddress := "Sales Shipment Header"."Ship-to Address";
//                 end;
//             end;

//             trigger OnPostDataItem()
//             var
//             begin
//                 OnAfterPostDataItem("Sales Shipment Header");
//             end;
//         }
//     }
//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';

//                     field(NoOfCopies; NoOfCopies)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'No. of Copies';
//                         ToolTip = 'Specifies how many copies of the document to print.';
//                     }
//                     field(ShowInternalInfo; ShowInternalInfo)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Show Internal Information';
//                         ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
//                     }
//                     field(LogInteraction; LogInteraction)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Log Interaction';
//                         Enabled = LogInteractionEnable;
//                         ToolTip = 'Specifies that interactions with the contact are logged.';
//                     }
//                     field(DisplayAsmInformation; DisplayAssemblyInformation)
//                     {
//                         ApplicationArea = Assembly;
//                         Caption = 'Show Assembly Components';
//                         ToolTip = 'Specifies if you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold.';
//                     }
//                     field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Show Additional Fee Note';
//                         ToolTip = 'Specifies that any notes about additional fees are included on the document.';
//                     }
//                     field(PrintTerms; PrintTerms)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Print Terms and Conditions';
//                         ToolTip = 'Specifies if you want to print Terms & Conditions';
//                     }
//                 }
//             }
//         }
//         actions
//         {
//         }
//         trigger OnInit()
//         begin
//             LogInteractionEnable := true;
//         end;

//         trigger OnOpenPage()
//         begin
//             InitLogInteraction;
//             LogInteractionEnable := LogInteraction;
//         end;
//     }
//     labels
//     {
//     }
//     trigger OnInitReport()
//     begin
//         PrintTerms := true;
//         GLSetup.Get;
//         CompanyInfo.Get;
//         CompanyInfo3.get;
//         SalesSetup.Get;
//         FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
//         CompanyInfo.VerifyAndSetPaymentInfo;
//         OnAfterInitReport;
//     end;

//     trigger OnPostReport()
//     begin
//         if LogInteraction and not IsReportInPreviewMode then
//             if "Sales Shipment Header".FindSet then
//                 repeat
//                     if "Sales Shipment Header"."Bill-to Contact No." <> '' then
//                         SegManagement.LogDocument(SegManagement.SalesInvoiceInterDocType, "Sales Shipment Header"."No.", 0, 0, DATABASE::Contact, "Sales Shipment Header"."Bill-to Contact No.", "Sales Shipment Header"."Salesperson Code", "Sales Shipment Header"."Campaign No.", "Sales Shipment Header"."Posting Description", '')
//                     else
//                         SegManagement.LogDocument(SegManagement.SalesInvoiceInterDocType, "Sales Shipment Header"."No.", 0, 0, DATABASE::Customer, "Sales Shipment Header"."Bill-to Customer No.", "Sales Shipment Header"."Salesperson Code", "Sales Shipment Header"."Campaign No.", "Sales Shipment Header"."Posting Description", '');
//                 until "Sales Shipment Header".Next = 0;
//     end;

//     trigger OnPreReport()
//     begin
//         if not CurrReport.UseRequestPage then InitLogInteraction;
//     end;

//     var
//         HSCode: code[20];
//         //amountToText: Codeunit "Amount To text";
//         ShowAmounttxt: array[2] of Text;
//         Text004: Label 'Sales - Invoice %1', Comment = '%1 = Document No.';
//         Text005: Label 'Page %1';
//         GLSetup: Record "General Ledger Setup";
//         ShipmentMethod: Record "Shipment Method";
//         PaymentTerms: Record "Payment Terms";
//         SalesPurchPerson: Record "Salesperson/Purchaser";
//         CompanyInfo: Record "Company Information";
//         CompanyInfo1: Record "Company Information";
//         CompanyInfo2: Record "Company Information";
//         CompanyInfo3: Record "Company Information";
//         SalesSetup: Record "Sales & Receivables Setup";
//         SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
//         Cust: Record Customer;
//         VATAmountLine: Record "VAT Amount Line" temporary;
//         TempVATAmountLineLCY: Record "VAT Amount Line" temporary;
//         SalesLine: Record "Sales Shipment Line" temporary;
//         DimSetEntry1: Record "Dimension Set Entry";
//         DimSetEntry2: Record "Dimension Set Entry";
//         RespCenter: Record "Responsibility Center";
//         Language: Record Language;
//         CurrExchRate: Record "Currency Exchange Rate";
//         TempPostedAsmLine: Record "Posted Assembly Line" temporary;
//         VATClause: Record "VAT Clause";
//         FormatAddr: Codeunit "Format Address";
//         FormatDocument: Codeunit "Format Document";
//         SegManagement: Codeunit SegManagement;
//         CustAddr: array[8] of Text[100];
//         ShipToAddr: array[8] of Text[100];
//         CompanyAddr: array[8] of Text[100];
//         SalesPersonText: Text[30];
//         VATNoText: Text[80];
//         ReferenceText: Text[80];
//         TotalText: Text[50];
//         TotalExclVATText: Text[50];
//         TotalInclVATText: Text[50];
//         MoreLines: Boolean;
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         CopyText: Text[30];
//         ShowShippingAddr: Boolean;
//         NextEntryNo: Integer;
//         FirstValueEntryNo: Integer;
//         DimText: Text[120];
//         OldDimText: Text[75];
//         ShowInternalInfo: Boolean;
//         Continue: Boolean;
//         ArchiveDocument: Boolean;
//         LogInteraction: Boolean;
//         VATAmount: Decimal;
//         VATBaseAmount: Decimal;
//         VATDiscountAmount: Decimal;
//         NoOfRecords: Integer;
//         VALVATBaseLCY: Decimal;
//         VALVATAmountLCY: Decimal;
//         VALSpecLCYHeader: Text[80];
//         Text007: Label 'VAT Amount Specification in ';
//         Text008: Label 'Local Currency';
//         VALExchRate: Text[50];
//         Text009: Label 'Exchange rate: %1/%2';
//         CalculatedExchRate: Decimal;
//         Text010: Label 'Sales - Prepayment Invoice %1';
//         OutputNo: Integer;
//         Print: Boolean;
//         TotalSubTotal: Decimal;
//         TotalAmount: Decimal;
//         TotalAmountInclVAT: Decimal;
//         TotalAmountVAT: Decimal;
//         TotalInvDiscAmount: Decimal;
//         TotalPaymentDiscOnVAT: Decimal;
//         
//         LogInteractionEnable: Boolean;
//         DisplayAssemblyInformation: Boolean;
//         CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
//         CompanyInfoVATRegNoCaptionLbl: Label 'VAT #';
//         CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
//         CompanyInfoBankNameCaptionLbl: Label 'Bank';
//         CompanyInfoBankAccountNoCaptionLbl: Label 'Account No.';
//         SalesHeaderShipmentDateCaptionLbl: Label 'Shipment Date';
//         SalesHeaderNoCaptionLbl: Label 'Invoice No.';
//         HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
//         UnitPriceCaptionLbl: Label 'Unit Price';
//         SalesLineLineDiscCaptionLbl: Label 'Disc %';
//         AmountCaptionLbl: Label 'Amount';
//         SalesLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
//         SubtotalCaptionLbl: Label 'Subtotal';
//         VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
//         LineDimensionsCaptionLbl: Label 'Line Dimensions';
//         VATAmountLineVATCaptionLbl: Label 'VAT %';
//         VATBaseCaptionLbl: Label 'VAT Base';
//         VATAmtCaptionLbl: Label 'VAT Amount';
//         VATAmountSpecificationCaptionLbl: Label 'VAT Amount Specification';
//         LineAmtCaptionLbl: Label 'Line Amount';
//         InvoiceDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
//         InvoiceDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
//         TotalCaptionLbl: Label 'Total';
//         ShiptoAddressCaptionLbl: Label 'Ship-to Address';
//         SalesLineVATIdentifierCaptionLbl: Label 'VAT Identifier';
//         PaymentTermsDescriptionCaptionLbl: Label 'Payment Terms';
//         ShipmentMethodDescriptionCaptionLbl: Label 'Shipment Method';
//         CompanyInfoHomePageCaptionLbl: Label 'Home Page';
//         CompanyInfoEmailCaptionLbl: Label 'Email';
//         DocumentDateCaptionLbl: Label 'Document Date';
//         SalesLineAllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount';
//         BillCustomer: Record Customer;
//         ShipToCustomer: Record Customer;
//         VATLCY: decimal;
//         HasSize: boolean;
//         PrintTerms: boolean;
//         MainLineDesc: text;
//         OrderNoText: text[80];
//         TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
//         VATClausesCap: Label 'VAT Clause';
//         PostedShipmentDateCaptionLbl: Label 'Posted Shipment Date';
//         LineAmtAfterInvDiscCptnLbl: Label 'Payment Discount on VAT';
//         ShipmentCaptionLbl: Label 'Shipment';
//         LineDimCaptionLbl: Label 'Line Dimensions';
//         VATAmtSpecificationCptnLbl: Label 'VAT Amount Specification';
//         InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
//         ShiptoAddrCaptionLbl: Label 'Ship-to Address';
//         InvDiscountAmtCaptionLbl: Label 'Invoice Discount Amount';
//         PaymentTermsDescCaptionLbl: Label 'Payment Terms';
//         ShptMethodDescCaptionLbl: Label 'Shipment Method';
//         VATPercentageCaptionLbl: Label 'VAT %';
//         VATIdentifierCaptionLbl: Label 'VAT Identifier';
//         HomePageCaptionLbl: Label 'Home Page';
//         EMailCaptionLbl: Label 'Email';
//         DisplayAdditionalFeeNote: Boolean;
//         LineNoWithTotal: Integer;
//         VATBaseRemainderAfterRoundingLCY: Decimal;
//         AmtInclVATRemainderAfterRoundingLCY: Decimal;
//         DimensionSetEntry: Record "Dimension Set Entry";
//         DimensionValueCode: Text[100];
//         DimensionValueName: Text[100];
//         DimensionValueAddress: Text[100];
//         DimenionValue: Record "Dimension Value";
//         ShiptoCustName_SalesHeader: Text[100];
//         shipToAddress: Text[250];

//     [Scope('Personalization')]
//     procedure InitLogInteraction()
//     begin
//         LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
//     end;

//     local procedure IsReportInPreviewMode(): Boolean
//     var
//         MailManagement: Codeunit "Mail Management";
//     begin
//         exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
//     end;

//     local procedure InitializeShipmentBuffer()
//     var
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         TempSalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
//     begin
//         NextEntryNo := 1;
//         /* if "Sales Shipment Line"."Shipment No." <> '' then
//                  if SalesShipmentHeader.Get("Sales Shipment Line"."Shipment No.") then
//                      exit;*/
//         if "Sales Shipment Header"."Order No." = '' then exit;
//         case "Sales Shipment Line".Type of
//             "Sales Shipment Line".Type::Item:
//                 GenerateBufferFromValueEntry("Sales Shipment Line");
//             "Sales Shipment Line".Type::"G/L Account", "Sales Shipment Line".Type::Resource, "Sales Shipment Line".Type::"Charge (Item)", "Sales Shipment Line".Type::"Fixed Asset":
//                 GenerateBufferFromShipment("Sales Shipment Line");
//         end;
//         SalesShipmentBuffer.Reset;
//         SalesShipmentBuffer.SetRange("Document No.", "Sales Shipment Line"."Document No.");
//         SalesShipmentBuffer.SetRange("Line No.", "Sales Shipment Line"."Line No.");
//         if SalesShipmentBuffer.Find('-') then begin
//             TempSalesShipmentBuffer := SalesShipmentBuffer;
//             if SalesShipmentBuffer.Next = 0 then begin
//                 SalesShipmentBuffer.Get(TempSalesShipmentBuffer."Document No.", TempSalesShipmentBuffer."Line No.", TempSalesShipmentBuffer."Entry No.");
//                 SalesShipmentBuffer.Delete;
//                 exit;
//             end;
//             SalesShipmentBuffer.CalcSums(Quantity);
//             if SalesShipmentBuffer.Quantity <> "Sales Shipment Line".Quantity then begin
//                 SalesShipmentBuffer.DeleteAll;
//                 exit;
//             end;
//         end;
//     end;

//     local procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Shipment Line")
//     var
//         ValueEntry: Record "Value Entry";
//         ItemLedgerEntry: Record "Item Ledger Entry";
//         TotalQuantity: Decimal;
//         Quantity: Decimal;
//     begin
//         TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
//         ValueEntry.SetCurrentKey("Document No.");
//         ValueEntry.SetRange("Document No.", SalesInvoiceLine2."Document No.");
//         ValueEntry.SetRange("Posting Date", "Sales Shipment Header"."Posting Date");
//         ValueEntry.SetRange("Item Charge No.", '');
//         ValueEntry.SetFilter("Entry No.", '%1..', FirstValueEntryNo);
//         if ValueEntry.Find('-') then
//             repeat
//                 if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
//                     if SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 then
//                         Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
//                     else
//                         Quantity := ValueEntry."Invoiced Quantity";
//                     AddBufferEntry(SalesInvoiceLine2, -Quantity, ItemLedgerEntry."Posting Date");
//                     TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
//                 end;
//                 FirstValueEntryNo := ValueEntry."Entry No." + 1;
//             until (ValueEntry.Next = 0) or (TotalQuantity = 0);
//     end;

//     local procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Shipment Line")
//     var
//         SalesInvoiceHeader: Record "Sales Shipment Header";
//         SalesInvoiceLine2: Record "Sales Shipment Line";
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         SalesShipmentLine: Record "Sales Shipment Line";
//         TotalQuantity: Decimal;
//         Quantity: Decimal;
//     begin
//         TotalQuantity := 0;
//         SalesInvoiceHeader.SetCurrentKey("Order No.");
//         SalesInvoiceHeader.SetFilter("No.", '..%1', "Sales Shipment Header"."No.");
//         SalesInvoiceHeader.SetRange("Order No.", "Sales Shipment Header"."Order No.");
//         if SalesInvoiceHeader.Find('-') then
//             repeat
//                 SalesInvoiceLine2.SetRange("Document No.", SalesInvoiceHeader."No.");
//                 SalesInvoiceLine2.SetRange("Line No.", SalesInvoiceLine."Line No.");
//                 SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine.Type);
//                 SalesInvoiceLine2.SetRange("No.", SalesInvoiceLine."No.");
//                 SalesInvoiceLine2.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
//                 if SalesInvoiceLine2.Find('-') then
//                     repeat
//                         TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
//                     until SalesInvoiceLine2.Next = 0;
//             until SalesInvoiceHeader.Next = 0;
//         SalesShipmentLine.SetCurrentKey("Order No.", "Order Line No.");
//         SalesShipmentLine.SetRange("Order No.", "Sales Shipment Header"."Order No.");
//         SalesShipmentLine.SetRange("Order Line No.", SalesInvoiceLine."Line No.");
//         SalesShipmentLine.SetRange("Line No.", SalesInvoiceLine."Line No.");
//         SalesShipmentLine.SetRange(Type, SalesInvoiceLine.Type);
//         SalesShipmentLine.SetRange("No.", SalesInvoiceLine."No.");
//         SalesShipmentLine.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
//         SalesShipmentLine.SetFilter(Quantity, '<>%1', 0);
//         if SalesShipmentLine.Find('-') then
//             repeat /* if "Sales Shipment Header"."Get Shipment Used" then
//                      CorrectShipment(SalesShipmentLine);*/
//                 if Abs(SalesShipmentLine.Quantity) <= Abs(TotalQuantity - SalesInvoiceLine.Quantity) then
//                     TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
//                 else begin
//                     if Abs(SalesShipmentLine.Quantity) > Abs(TotalQuantity) then SalesShipmentLine.Quantity := TotalQuantity;
//                     Quantity := SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);
//                     TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
//                     SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;
//                     if SalesShipmentHeader.Get(SalesShipmentLine."Document No.") then AddBufferEntry(SalesInvoiceLine, Quantity, SalesShipmentHeader."Posting Date");
//                 end;
//             until (SalesShipmentLine.Next = 0) or (TotalQuantity = 0);
//     end;

//     local procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
//     var
//         SalesInvoiceLine: Record "Sales Shipment Line";
//     begin
//         /* SalesInvoiceLine.SetCurrentKey("Shipment No.", "Shipment Line No.");
//              SalesInvoiceLine.SetRange("Shipment No.", SalesShipmentLine."Document No.");
//              SalesInvoiceLine.SetRange("Shipment Line No.", SalesShipmentLine."Line No.");*/
//         if SalesInvoiceLine.Find('-') then
//             repeat
//                 SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
//             until SalesInvoiceLine.Next = 0;
//     end;

//     local procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Shipment Line";
//     QtyOnShipment: Decimal;
//     PostingDate: Date)
//     begin
//         SalesShipmentBuffer.SetRange("Document No.", SalesInvoiceLine."Document No.");
//         SalesShipmentBuffer.SetRange("Line No.", SalesInvoiceLine."Line No.");
//         SalesShipmentBuffer.SetRange("Posting Date", PostingDate);
//         if SalesShipmentBuffer.Find('-') then begin
//             SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
//             SalesShipmentBuffer.Modify;
//             exit;
//         end;
//         with SalesShipmentBuffer do begin
//             "Document No." := SalesInvoiceLine."Document No.";
//             "Line No." := SalesInvoiceLine."Line No.";
//             "Entry No." := NextEntryNo;
//             Type := SalesInvoiceLine.Type;
//             "No." := SalesInvoiceLine."No.";
//             Quantity := QtyOnShipment;
//             "Posting Date" := PostingDate;
//             Insert;
//             NextEntryNo := NextEntryNo + 1
//         end;
//     end;

//     local procedure DocumentCaption(): Text[250]
//     var
//         DocCaption: Text;
//     begin
//         OnBeforeGetDocumentCaption("Sales Shipment Header", DocCaption);
//         if DocCaption <> '' then exit(DocCaption);
//         /*   if "Sales Shipment Header"."Prepayment Invoice" then
//                    exit(Text010);*/
//         exit(Text004);
//     end;

//     [Scope('Personalization')]
//     procedure InitializeRequest(NewNoOfCopies: Integer;
//     NewShowInternalInfo: Boolean;
//     NewLogInteraction: Boolean;
//     DisplayAsmInfo: Boolean)
//     begin
//         NoOfCopies := NewNoOfCopies;
//         ShowInternalInfo := NewShowInternalInfo;
//         LogInteraction := NewLogInteraction;
//         DisplayAssemblyInformation := DisplayAsmInfo;
//     end;

//     local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Shipment Header")
//     begin
//         with SalesInvoiceHeader do begin
//             FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
//             FormatDocument.SetSalesPerson(SalesPurchPerson, "Salesperson Code", SalesPersonText);
//             FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
//             FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
//             OrderNoText := FormatDocument.SetText("Order No." <> '', FieldCaption("Order No."));
//             ReferenceText := FormatDocument.SetText("Your Reference" <> '', FieldCaption("Your Reference"));
//             VATNoText := FormatDocument.SetText("VAT Registration No." <> '', FieldCaption("VAT Registration No."));
//         end;
//     end;

//     local procedure FormatAddressFields(SalesInvoiceHeader: Record "Sales Shipment Header")
//     begin
//         FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
//         //   FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
//         //  ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);
//     end;

//     local procedure CollectAsmInformation()
//     var
//         ValueEntry: Record "Value Entry";
//         ItemLedgerEntry: Record "Item Ledger Entry";
//         PostedAsmHeader: Record "Posted Assembly Header";
//         PostedAsmLine: Record "Posted Assembly Line";
//         SalesShipmentLine: Record "Sales Shipment Line";
//     begin
//         TempPostedAsmLine.DeleteAll;
//         if "Sales Shipment Line".Type <> "Sales Shipment Line".Type::Item then exit;
//         with ValueEntry do begin
//             SetCurrentKey("Document No.");
//             SetRange("Document No.", "Sales Shipment Line"."Document No.");
//             SetRange("Document Type", "Document Type"::"Sales Invoice");
//             SetRange("Document Line No.", "Sales Shipment Line"."Line No.");
//             SetRange(Adjustment, false);
//             if not FindSet then exit;
//         end;
//         repeat
//             if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then
//                 if ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" then begin
//                     SalesShipmentLine.Get(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
//                     if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) then begin
//                         PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
//                         if PostedAsmLine.FindSet then
//                             repeat
//                                 TreatAsmLineBuffer(PostedAsmLine);
//                             until PostedAsmLine.Next = 0;
//                     end;
//                 end;
//         until ValueEntry.Next = 0;
//     end;

//     local procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
//     begin
//         Clear(TempPostedAsmLine);
//         TempPostedAsmLine.SetRange(Type, PostedAsmLine.Type);
//         TempPostedAsmLine.SetRange("No.", PostedAsmLine."No.");
//         TempPostedAsmLine.SetRange("Variant Code", PostedAsmLine."Variant Code");
//         TempPostedAsmLine.SetRange(Description, PostedAsmLine.Description);
//         TempPostedAsmLine.SetRange("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
//         if TempPostedAsmLine.FindFirst then begin
//             TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
//             TempPostedAsmLine.Modify;
//         end
//         else begin
//             Clear(TempPostedAsmLine);
//             TempPostedAsmLine := PostedAsmLine;
//             TempPostedAsmLine.Insert;
//         end;
//     end;

//     local procedure GetUOMText(UOMCode: Code[10]): Text[50]
//     var
//         UnitOfMeasure: Record "Unit of Measure";
//     begin
//         if not UnitOfMeasure.Get(UOMCode) then exit(UOMCode);
//         exit(UnitOfMeasure.Description);
//     end;

//     [Scope('Personalization')]
//     procedure BlanksForIndent(): Text[10]
//     begin
//         exit(PadStr('', 2, ' '));
//     end;

//     local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
//     var
//         LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
//         CustLedgerEntry: Record "Cust. Ledger Entry";
//         Customer: Record Customer;
//     begin
//         TempLineFeeNoteOnReportHist.DeleteAll;
//         CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
//         CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
//         if not CustLedgerEntry.FindFirst then exit;
//         if not Customer.Get(CustLedgerEntry."Customer No.") then exit;
//         LineFeeNoteOnReportHist.SetRange("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
//         LineFeeNoteOnReportHist.SetRange("Language Code", Customer."Language Code");
//         if LineFeeNoteOnReportHist.FindSet then begin
//             repeat
//                 InsertTempLineFeeNoteOnReportHist(LineFeeNoteOnReportHist, TempLineFeeNoteOnReportHist);
//             until LineFeeNoteOnReportHist.Next = 0;
//         end
//         else begin
//             //LineFeeNoteOnReportHist.SetRange("Language Code", Language.GetUserLanguage);//Exquitech-ER function does not exists 
//             if LineFeeNoteOnReportHist.FindSet then
//                 repeat
//                     InsertTempLineFeeNoteOnReportHist(LineFeeNoteOnReportHist, TempLineFeeNoteOnReportHist);
//                 until LineFeeNoteOnReportHist.Next = 0;
//         end;
//     end;

//     local procedure CalcVATAmountLineLCY(SalesInvoiceHeader: Record "Sales Shipment Header";
//     TempVATAmountLine2: Record "VAT Amount Line" temporary;
//     var TempVATAmountLineLCY2: Record "VAT Amount Line" temporary;
//     var VATBaseRemainderAfterRoundingLCY2: Decimal;
//     var AmtInclVATRemainderAfterRoundingLCY2: Decimal)
//     var
//         VATBaseLCY: Decimal;
//         AmtInclVATLCY: Decimal;
//     begin
//         if (not GLSetup."Print VAT specification in LCY") or (SalesInvoiceHeader."Currency Code" = '') then exit;
//         TempVATAmountLineLCY2.Init;
//         TempVATAmountLineLCY2 := TempVATAmountLine2;
//         with SalesInvoiceHeader do begin
//             VATBaseLCY := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", TempVATAmountLine2."VAT Base", "Currency Factor") + VATBaseRemainderAfterRoundingLCY2;
//             AmtInclVATLCY := CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", TempVATAmountLine2."Amount Including VAT", "Currency Factor") + AmtInclVATRemainderAfterRoundingLCY2;
//         end;
//         TempVATAmountLineLCY2."VAT Base" := Round(VATBaseLCY);
//         TempVATAmountLineLCY2."Amount Including VAT" := Round(AmtInclVATLCY);
//         TempVATAmountLineLCY2.InsertLine;
//         VATBaseRemainderAfterRoundingLCY2 := VATBaseLCY - TempVATAmountLineLCY2."VAT Base";
//         AmtInclVATRemainderAfterRoundingLCY2 := AmtInclVATLCY - TempVATAmountLineLCY2."Amount Including VAT";
//     end;

//     local procedure InsertTempLineFeeNoteOnReportHist(var LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
//     var TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary)
//     begin
//         repeat
//             TempLineFeeNoteOnReportHist.Init;
//             TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
//             TempLineFeeNoteOnReportHist.Insert;
//         until TempLineFeeNoteOnReportHist.Next = 0;
//     end;

//     [IntegrationEvent(false, TRUE)]
//     [Scope('Personalization')]
//     procedure OnAfterGetRecordSalesInvoiceHeader(SalesInvoiceHeader: Record "Sales Shipment Header")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeGetDocumentCaption(SalesInvoiceHeader: Record "Sales Shipment Header";
//     var DocCaption: Text)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnGetReferenceText(SalesInvoiceHeader: Record "Sales Shipment Header";
//     var ReferenceText: Text[80];
//     var Handled: Boolean)
//     begin
//     end;

//     [IntegrationEvent(TRUE, TRUE)]
//     local procedure OnAfterInitReport()
//     begin
//     end;

//     [IntegrationEvent(TRUE, TRUE)]
//     local procedure OnAfterPostDataItem(var SalesInvoiceHeader: Record "Sales Shipment Header")
//     begin
//     end;
// }
