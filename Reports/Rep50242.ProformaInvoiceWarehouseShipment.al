
report 50242 "Pro Forma Inv-Whse Ship"
{
    Caption = 'Pro Forma Invoice';
    ApplicationArea = ALL;
    RDLCLayout = 'Reports Layouts/ER-WhseShipmentProFormaInv.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Header; "Warehouse Shipment Header")
        {
            RequestFilterHeading = 'Pro Forma Invoice';
            column(DocumentDate; Format("Shipment Date", 0, 4))
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(CompanyEMail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyHomePage; CompanyInformation."Home Page")
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyVATRegNo; CompanyInformation.GetVATRegistrationNumber())
            {
            }
            column(CompanyAddress1; CompanyInformation.Name)
            {
            }
            column(CompanyAddress2; CompanyInformation.Address)
            {
            }
            column(CompanyAddress3; CompanyInformation."Address 2")
            {
            }
            column(CompanyAddress4; CompanyInformation.City)
            {
            }
            column(CompanyAddress5; CompanyInformation."VAT Registration No.")
            {
            }
            column(CompanyAddress6; CompanyInformation."E-Mail")
            {
            }
            column(CompanyAddress7; CompanyAddress[7])
            {
            }
            column(CompanyAddress8; CompanyAddress[8])
            {
            }
            column(CustomerAddress1; Customer.Address)
            {
            }
            column(CustomerAddress2; Customer."Address 2")
            {
            }
            column(CustomerAddress3; Customer.City)
            {
            }
            column(CustomerAddress4; CustomerAddress[4])
            {
            }
            column(CustomerAddress5; CustomerAddress[5])
            {
            }
            column(CustomerAddress6; CustomerAddress[6])
            {
            }
            column(CustomerAddress7; CustomerAddress[7])
            {
            }
            column(CustomerAddress8; CustomerAddress[8])
            {
            }
            column(SellToContactPhoneNoLbl; SellToContactPhoneNoLbl)
            {
            }
            column(SellToContactMobilePhoneNoLbl; SellToContactMobilePhoneNoLbl)
            {
            }
            column(SellToContactEmailLbl; SellToContactEmailLbl)
            {
            }
            column(BillToContactPhoneNoLbl; BillToContactPhoneNoLbl)
            {
            }
            column(BillToContactMobilePhoneNoLbl; BillToContactMobilePhoneNoLbl)
            {
            }
            column(BillToContactEmailLbl; BillToContactEmailLbl)
            {
            }
            column(SellToContactPhoneNo; SellToContact."Phone No.")
            {
            }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.")
            {
            }
            column(SellToContactEmail; SellToContact."E-Mail")
            {
            }
            column(BillToContactPhoneNo; BillToContact."Phone No.")
            {
            }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
            {
            }
            column(BillToContactEmail; BillToContact."E-Mail")
            {
            }
            column(YourReference; "No.")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(CompanyLegalOffice; LegalOfficeTxt)
            {
            }
            column(SalesPersonName; SalespersonPurchaserName)
            {
            }
            column(ShipmentMethodDescription; ShipmentMethodDescription)
            {
            }
            column(Currency; CurrencyCode)
            {
            }
            column(CustomerVATRegNo; Customer."VAT Registration No.")
            {
            }
            column(CustomerVATRegistrationNoLbl; 'Customer Vat Registration No')
            {
            }
            column(PageLbl; PageLbl)
            {
            }
            column(DocumentTitleLbl; DocumentCaption())
            {
            }
            column(YourReferenceLbl; 'Reference')
            {
            }
            column(ExternalDocumentNoLbl; FieldCaption("External Document No."))
            {
            }
            column(CompanyLegalOfficeLbl; LegalOfficeLbl)
            {
            }
            column(SalesPersonLbl; SalesPersonLblText)
            {
            }
            column(EMailLbl; CompanyInformation.FieldCaption("E-Mail"))
            {
            }
            column(HomePageLbl; CompanyInformation.FieldCaption("Home Page"))
            {
            }
            column(CompanyPhoneNoLbl; CompanyInformation.FieldCaption("Phone No."))
            {
            }
            column(ShipmentMethodDescriptionLbl; DummyShipmentMethod.TableCaption())
            {
            }
            column(CurrencyLbl; DummyCurrency.TableCaption())
            {
            }
            column(ItemLbl; Item.TableCaption())
            {
            }
            column(TariffLbl; Item.FieldCaption("Tariff No."))
            {
            }
            column(UnitPriceLbl; Item.FieldCaption("Unit Price"))
            {
            }
            column(CountryOfManufactuctureLbl; CountryOfManufactuctureLbl)
            {
            }
            column(AmountLbl; 'Amount')
            {
            }
            column(VATPctLbl; 'VAT')
            {
            }
            column(VATAmountLbl; DummyVATAmountLine.VATAmountText())
            {
            }
            column(TotalWeightLbl; TotalWeightLbl)
            {
            }
            column(TotalAmountLbl; TotalAmountLbl)
            {
            }
            column(TotalAmountInclVATLbl; TotalAmountInclVATLbl)
            {
            }
            column(QuantityLbl; Line.FieldCaption(Quantity))
            {
            }
            column(NetWeightLbl; Line.FieldCaption(Weight))
            {
            }
            column(DeclartionLbl; DeclartionLbl)
            {
            }
            column(SignatureLbl; SignatureLbl)
            {
            }
            column(SignatureNameLbl; SignatureNameLbl)
            {
            }
            column(SignaturePositionLbl; SignaturePositionLbl)
            {
            }
            column(VATRegNoLbl; CompanyInformation.GetVATRegistrationNumberLbl())
            {
            }
            column(ShowWorkDescription; ShowWorkDescription) { }
            dataitem(Line; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("No.", "Line No.");
                column(ItemDescription; Description)
                {
                }
                column(CountryOfManufacturing; Item."Country/Region of Origin Code")
                {
                }
                column(Tariff; Item."Tariff No.")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Price; SalesLine."Unit Price")
                {
                    //  AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                column(NetWeight; SalesLine."Net Weight")
                {
                }
                column(LineAmount; SalesLine.Amount)
                {
                    //AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(VATPct; SalesLine."VAT %")
                {
                }
                column(VATAmount; SalesLine."Amount Including VAT" - SalesLine.Amount)
                {
                }

                trigger OnAfterGetRecord()
                var
                    Location: Record Location;
                    AutoFormatType: Enum "Auto Format";

                begin
                    GetItemForRec("Item No.");
                    OnBeforeLineOnAfterGetRecord(Header, Line);
                    //
                    Clear(SalesLine);
                    if SalesLine.get(SalesLine."Document Type"::Order, line."Source No.", Line."Source Line No.") then begin
                        LineAmount := Round(SalesLine.Amount * SalesLine."Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");
                        Clear(Customer);
                        if Customer.get(SalesLine."Sell-to Customer No.") then;
                    end;


                end;


                trigger OnPreDataItem()
                begin
                    TotalWeight := 0;
                    TotalAmount := 0;
                    TotalVATAmount := 0;
                    TotalAmountInclVAT := 0;
                    //SetRange(Type, Type::Item);

                    //OnAfterLineOnPreDataItem(Header, Line);
                end;
            }
            dataitem(WorkDescriptionLines; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 .. 99999));
                column(WorkDescriptionLineNumber; Number) { }
                column(WorkDescriptionLine; WorkDescriptionLine) { }

                trigger OnAfterGetRecord()
                var
                    TypeHelper: Codeunit "Type Helper";
                begin
                    if WorkDescriptionInStream.EOS() then
                        CurrReport.Break();
                    WorkDescriptionLine := TypeHelper.ReadAsTextWithSeparator(WorkDescriptionInStream, TypeHelper.LFSeparator());
                end;

                trigger OnPostDataItem()
                begin
                    Clear(WorkDescriptionInStream)
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowWorkDescription then
                        CurrReport.Break();
                    //Header."Work Description".CreateInStream(WorkDescriptionInStream, TextEncoding::UTF8);
                end;
            }
            dataitem(Totals; "Integer")
            {
                MaxIteration = 1;
                column(TotalWeight; TotalWeight)
                {
                }
                column(TotalValue; FormattedTotalAmount)
                {
                }
                column(TotalVATAmount; FormattedTotalVATAmount)
                {
                }
                column(TotalAmountInclVAT; FormattedTotalAmountInclVAT)
                {
                }

                trigger OnPreDataItem()
                var
                    AutoFormatType: Enum "Auto Format";
                begin
                    FormattedTotalAmount := Format(TotalAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedTotalVATAmount := Format(TotalVATAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedTotalAmountInclVAT := Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                end;
            }

            trigger OnAfterGetRecord()
            var
                WarehouseShipmentHeader: Record "Warehouse Shipment Header";
            begin

                WarehouseShipmentHeader.SetFilter("No.", Header."No.");
                if WarehouseShipmentHeader.FindFirst() then begin
                    WarehouseShipmentHeader.Printed := true;
                    WarehouseShipmentHeader.Modify();
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }


    labels
    {
    }

    trigger OnInitReport()
    var
        IsHandled: Boolean;
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);

        IsHandled := false;
        OnInitReportForGlobalVariable(IsHandled, LegalOfficeTxt, LegalOfficeLbl);
#if not CLEAN23
        if not IsHandled then begin
            LegalOfficeTxt := '';
            LegalOfficeLbl := '';
        end;
#endif
    end;

    var
        Customer: Record Customer;
        DummyVATAmountLine: Record "VAT Amount Line";
        DummyShipmentMethod: Record "Shipment Method";
        DummyCurrency: Record Currency;
        AutoFormat: Codeunit "Auto Format";
        LanguageMgt: Codeunit Language;
        CountryOfManufactuctureLbl: Label 'Country';
        TotalWeightLbl: Label 'Total Weight';
        SalespersonPurchaserName: Text;
        ShipmentMethodDescription: Text;
        DocumentTitleLbl: Label 'Pro Forma Invoice';
        PageLbl: Label 'Page';
        DeclartionLbl: Label 'For customs purposes only.';
        SignatureLbl: Label 'For and on behalf of the above named company:';
        SignatureNameLbl: Label 'Name (in print) Signature';
        SignaturePositionLbl: Label 'Position in company';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        LegalOfficeTxt, LegalOfficeLbl : Text;

    protected var
        CompanyInformation: Record "Company Information";
        Item: Record Item;
        Currency: Record Currency;
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        CompanyAddress: array[8] of Text[100];
        CustomerAddress: array[8] of Text[100];
        WorkDescriptionInStream: InStream;
        SalesPersonLblText: Text[50];
        TotalAmountLbl: Text[50];
        TotalAmountInclVATLbl: Text[50];
        FormattedLinePrice: Text;
        FormattedLineAmount: Text;
        FormattedVATAmount: Text;
        FormattedTotalAmount: Text;
        FormattedTotalVATAmount: Text;
        FormattedTotalAmountInclVAT: Text;
        WorkDescriptionLine: Text;
        CurrencyCode: Code[10];
        TotalWeight: Decimal;
        TotalAmount: Decimal;
        TotalVATAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        LinePrice: Decimal;
        LineAmount: Decimal;
        VATAmount: Decimal;
        ShowWorkDescription: Boolean;

    local procedure FormatDocumentFields(WhseShipHeader: Record "Warehouse Shipment Header")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        ResponsibilityCenter: Record "Responsibility Center";
        Customer: Record Customer;
        FormatDocument: Codeunit "Format Document";
        FormatAddress: Codeunit "Format Address";
        TotalAmounExclVATLbl: Text[50];
    begin

        FormatAddress.GetCompanyAddr('', ResponsibilityCenter, CompanyInformation, CompanyAddress);
    end;

    local procedure DocumentCaption(): Text
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption(Header, DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);
        exit(DocumentTitleLbl);
    end;

    local procedure GetItemForRec(ItemNo: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeGetItemForRec(ItemNo, IsHandled);
        if IsHandled then
            exit;

        Item.Get(ItemNo);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLineOnPreDataItem(var WhseShipHeader: Record "Posted Whse. Shipment Header"; var WhseShipLine: Record "Warehouse Shipment Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption("Warehouse Shipment Header": Record "Warehouse Shipment Header"; var DocCaption: Text)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeGetItemForRec(ItemNo: Code[20]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLineOnAfterGetRecord("Warehouse Shipment Header": Record "Warehouse Shipment Header"; var "Warehouse Shipment Line": Record "Warehouse Shipment Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInitReportForGlobalVariable(var IsHandled: Boolean; var LegalOfficeTxt: Text; var LegalOfficeLbl: Text)
    begin
    end;

    var
        SalesLine: Record "Sales Line";
}

