report 50208 "Receipt and Payment Voucher"
{
    // version NAVW19.00
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports Layouts/Voucher.rdlc';
    Caption = 'Voucher';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Entry";
        "G/L Entry")
        {
            RequestFilterFields = "Document No.", "Posting Date", "Bal. Account No.";

            column(DutyStampCaption;
            DutyStampCaption)
            {
            }
            column(ReportTitleGL;
            ReportTitle)
            {
            }
            column(BaseCurr;
            BaseCurr)
            {
            }
            column(CompNameGL;
            CompanyInfo.Name)
            {
            }
            column(CompanyInfoPhone;
            CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfovar;
            CompanyInfo."VAT Registration No.")
            {
            }
            column(CompPostFax;
            CompanyInfo."Fax No.")
            {
            }
            column(CompEmail;
            CompanyInfo."E-Mail")
            {
            }
            column(CompPostPhone;
            CompanyInfo."Phone No.")
            {
            }
            column(CompPosAddress;
            CompanyInfo.Address)
            {
            }
            column(CompPosAddress2;
            CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoVATRegNo;
            CompanyInfo."VAT Registration No.")
            {
            }
            // column(CompanyInfoCapital;
            // CompanyInfo.Capital)
            // {
            // }
            column(CompPic;
            CompanyInfo.Picture)
            {
            }
            column(CompPostCode;
            CompanyInfo.City + ' ' + CompanyInfo."Post Code")
            {
            }
            column(CompVatRegNoGL;
            CompanyInfo."VAT Registration No.")
            {
            }
            column(compAddr1GL;
            CompanyInfo.Address)
            {
            }
            column(paymentCurrencyGL;
            paymentCurrencyGL)
            {
            }
            column(amountOriginalGL;
            amountOriginalGL)
            {
            }
            column(compAddr2GL;
            CompanyInfo."Address 2")
            {
            }
            column(CompFaxNoGL;
            CompanyInfo."Fax No.")
            {
            }
            column(CompPhoneNoGL;
            CompanyInfo."Phone No.")
            {
            }
            column(CompEmailGL;
            CompanyInfo."E-Mail")
            {
            }
            column(EntryNoGL;
            "G/L Entry"."Entry No.")
            {
            }
            column(PayFromBankNoGL;
            "G/L Entry"."G/L Account No.")
            {
            }
            column(GLAccountName;
            "G/L Entry"."G/L Account Name")
            {
            }
            column(PayFromBankNameGL;
            fromBankNameGl)
            {
            }
            column(PayToBankNoGL;
            "G/L Entry"."Bal. Account No.")
            {
            }
            column(PayToBankNameGL;
            toBankNameGL)
            {
            }
            column(DocNoGL;
            "G/L Entry"."Document No.")
            {
            }
            column(postingDateGL;
            "G/L Entry"."Posting Date")
            {
            }
            // column(origAmountGL;
            // "G/L Entry"."Original Amount")
            // {
            // }
            column(origAmountGL;
            "G/L Entry"."Additional-Currency Amount")
            {
            }
            column(compCityGL;
            CompanyInfo.City)
            {
            }
            column(compCountryGL;
            CompanyInfo.County)
            {
            }
            column(CompanyInfoCountryRegionCode;
            CompanyInfo."Country/Region Code")
            {
            }
            column(Amount;
            "G/L Entry".Amount)
            {
            }
            column(AddCurAmount;
            "G/L Entry"."Additional-Currency Amount")
            {
            }
            column(descriptionGL;
            "G/L Entry".Description)
            {
            }
            column(ShowAmounttxtGL;
            ShowAmounttxtGL[1])
            {
            }
            // column(CurrencyGL;
            // "G/L Entry"."Original Currency Code")
            // {
            // }
            column(CurrencyGL;
            addCurr)
            {
            }
            column(checkExtDocNoGL;
            "G/L Entry"."External Document No.")
            {
            }
            column(comment;
            Comment)
            {
            }
            column(PayToName;
            PayToName)
            {
            }
            column(SourceNo;
            DebitAccount)
            {
            }
            column(BankName;
            bankTable.Name)
            {
            }
            // column(LineSource;
            // "G/L Entry"."Line Source")
            // {
            // }
            // column(LineSourceNo;
            // "G/L Entry"."Source No.")
            // {
            // }
            // column(DueDate;
            // "G/L Entry"."Check Due Date")
            // {
            // }
            column(PayReceive;
            PayReceive)
            {
            }
            column(CustVendorAddress;
            CustVendorAddress)
            {
            }
            column(CustVendorAddress2;
            CustVendorAddress2)
            {
            }
            column(CustVendorPhone;
            CustVendorPhone)
            {
            }
            column(CustVendorMOF;
            CustVendorMOF)
            {
            }
            column(HeaderAccount;
            HeaderAccount)
            {
            }
            column(HeaderAmount;
            HeaderAmount)
            {
            }
            column(HeaderName;
            HeaderName)
            {
            }
            column(HeaderAdd;
            HeaderAdd)
            {
            }
            column(HeaderAdd2;
            HeaderAdd2)
            {
            }
            column(HeaderPhone;
            HeaderPhone)
            {
            }
            column(HeaderMOF;
            HeaderMOF)
            {
            }
            column(ShowAppliedDoc;
            ShowAppliedDoc)
            {
            }
            column(CompanyInfoGiroNo;
            CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfoBankName;
            CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfoBankAccountNo;
            CompanyInfo."Bank Account No.")
            {
            }
            column(DimensionValueCode;
            DimensionValueCode)
            {
            }
            column(DimensionValueName;
            DimensionValueName)
            {
            }
            column(ShowDimension;
            ShowDimension)
            {
            }
            column(ShowAsReceipt;
            ShowAsReceipt)
            {
            }
            trigger OnAfterGetRecord();
            var
                Customer: Record Customer;
                Vendor: Record Vendor;
                GLAccount: Record "G/L Account";
                Vendor2: Record Vendor;
                GLEntryAcc: Record "G/L Entry";
                DimensionSetEntry: Record "Dimension Set Entry";
                GLSetup: Record "General Ledger Setup";
            begin
                //  Clear(DimensionSetEntry);
                GLSetup.Get();

                addCurr := GLSetup."Additional Reporting Currency";

                /*  IF "G/L Entry"."Dimension Set ID" <> 0 then begin
                                  DimensionSetEntry.SetRange("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                                  DimensionSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 3 Code");//cust project
                                  IF DimensionSetEntry.FindFirst() then begin
                                      DimensionValueCode := DimensionSetEntry."Dimension Value Code";
                                      DimensionSetEntry.CalcFields("Dimension Value Name");
                                      DimensionValueName := DimensionSetEntry."Dimension Value Name";

                                  end;
                              end;*/
                Clear(GlEntry);
                GlEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                GlEntry.SetFilter("Shortcut Dimension 3 Code", '<> %1', '');
                IF GlEntry.FindFirst() then begin
                    GlEntry.CalcFields("Shortcut Dimension 3 Code");
                    DimensionValueCode := GlEntry."Shortcut Dimension 3 Code";
                    Clear(DimensionValue);
                    DimensionValue.Get(GLSetup."Shortcut Dimension 3 Code", GlEntry."Shortcut Dimension 3 Code");
                    DimensionValueName := DimensionValue.Name;
                end;
                /* IF "G/L Entry"."Shortcut Dimension 3 Code" <> '' then begin
                                 DimensionValueCode := "G/L Entry"."Shortcut Dimension 3 Code";
                                 Clear(DimensionValue);
                                 DimensionValue.Get(GLSetup."Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                                 DimensionValueName := DimensionValue.Name;
                             end;*/
                //if "G/L Entry"."Original Amount" = 0 then CurrReport.skip;
                //if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::" " then if strpos(UpperCase("G/L Account Name"), 'VAT') > 0 then if "Original Amount" > 0 then CurrReport.skip;
                if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::" " then if strpos(UpperCase("G/L Account Name"), 'VAT') = 0 then CurrReport.skip;
                CLEAR(bankTable);
                CLEAR(GLAccount);
                if "G/L Entry"."Bal. Account No." <> '' then begin
                    bankTable.SETFILTER("No.", "G/L Entry"."Bal. Account No.");
                    if bankTable.FINDLAST then fromBankNameGl := bankTable.Name;
                    if fromBankNameGl = '' then begin
                        GLAccount.SETFILTER("No.", "G/L Entry"."Bal. Account No.");
                        if GLAccount.FINDLAST then fromBankNameGl := GLAccount.Name;
                    end
                end
                else
                    fromBankNameGl := '';
                CLEAR(bankTable);
                CLEAR(GLAccount);
                if "G/L Entry"."G/L Account No." <> '' then begin
                    bankTable.SETFILTER("No.", "G/L Entry"."Source No.");
                    if bankTable.FINDLAST then
                        toBankNameGL := bankTable.Name
                    else
                        if Vendor2.GET("G/L Entry"."Source No.") then
                            toBankNameGL := Vendor2.Name
                        else begin
                            GLAccount.SETFILTER("No.", "G/L Entry"."G/L Account No.");
                            if GLAccount.FINDLAST then toBankNameGL := GLAccount.Name;
                        end
                end
                else
                    toBankNameGL := '';
                DebitAccount := "G/L Entry"."Source No.";
                if "G/L Entry"."Source Code" = 'PAYMENTJNL' then begin
                    if ("G/L Entry".Amount > 0) then begin
                        if ("G/L Entry"."Bal. Account No." <> '') and ("G/L Entry"."Bal. Account Type" = "G/L Entry"."Bal. Account Type"::"Bank Account") and ("G/L Entry"."Source Type" = "G/L Entry"."Source Type"::"Bank Account") then begin
                            "G/L Entry".CALCFIELDS("G/L Account Name");
                            toBankNameGL := "G/L Entry"."G/L Account Name";
                            DebitAccount := "G/L Entry"."G/L Account No.";
                        end;
                        // PayReceive := 'Paid To';
                        case "G/L Entry"."Source Type" of
                            "G/L Entry"."Source Type"::"Bank Account":
                                begin
                                    bankTable.GET("G/L Entry"."Source No.");
                                    PayToName := bankTable.Name;
                                end;
                            "G/L Entry"."Source Type"::Customer:
                                begin
                                    Customer.GET("G/L Entry"."Source No.");
                                    PayToName := Customer.Name + ' ' + Customer."No.";
                                    CustVendorAddress := Customer.Address;
                                    CustVendorAddress2 := Customer."Address 2";
                                    CustVendorPhone := Customer."Phone No.";
                                    CustVendorMOF := Customer."VAT Registration No.";
                                end;
                            "G/L Entry"."Source Type"::Vendor:
                                begin
                                    Vendor.GET("G/L Entry"."Source No.");
                                    PayToName := Vendor.Name + ' ' + Vendor."No.";
                                    CustVendorAddress := Vendor.Address;
                                    CustVendorAddress2 := Vendor."Address 2";
                                    CustVendorPhone := Vendor."Phone No.";
                                    CustVendorMOF := Vendor."VAT Registration No.";
                                end;
                        /*else begin
                            if "G/L Entry"."Line Source" = '' then begin
                                "G/L Entry".CALCFIELDS("G/L Entry"."G/L Account Name");
                                PayToName := "G/L Entry"."G/L Account Name";
                            end
                            else begin
                                case "G/L Entry"."Source Type" of
                                    "G/L Entry"."Source Type"::Customer:
                                        begin
                                            Customer.GET("G/L Entry"."Source No.");
                                            PayToName := Customer.Name + ' ' + Customer."No.";
                                            CustVendorAddress := Customer.Address;
                                            CustVendorAddress2 := Customer."Address 2";
                                            CustVendorPhone := Customer."Phone No.";
                                            CustVendorMOF := Customer."VAT Registration No.";
                                        end;
                                    "G/L Entry"."Source Type"::Vendor:
                                        begin
                                            Vendor.GET("G/L Entry"."Source No.");
                                            PayToName := Vendor.Name + ' ' + Vendor."No.";
                                            CustVendorAddress := Vendor.Address;
                                            CustVendorAddress2 := Vendor."Address 2";
                                            CustVendorPhone := Vendor."Phone No.";
                                            CustVendorMOF := Vendor."VAT Registration No.";
                                        end;
                                end;
                            end;
                        end;*/
                        end;
                    end;
                end;
                if ("G/L Entry".Amount < 0) then begin
                    if "G/L Entry"."Source Code" = 'CASHRECJNL' then //(NOT "G/L Entry"."System-Created Entry" ) AND
               begin
                        // PayReceive := 'Received From';
                        case "G/L Entry"."Source Type" of
                            "G/L Entry"."Source Type"::"Bank Account":
                                begin
                                    bankTable.GET("G/L Entry"."Source No.");
                                    PayToName := bankTable.Name;
                                end;
                            "G/L Entry"."Source Type"::Customer:
                                begin
                                    Customer.GET("G/L Entry"."Source No.");
                                    PayToName := Customer.Name + ' ' + Customer."No.";
                                    CustVendorAddress := Customer.Address;
                                    CustVendorAddress2 := Customer."Address 2";
                                    CustVendorPhone := Customer."Phone No.";
                                    CustVendorMOF := Customer."VAT Registration No.";
                                end;
                            "G/L Entry"."Source Type"::Vendor:
                                begin
                                    Vendor.GET("G/L Entry"."Source No.");
                                    PayToName := Vendor.Name + ' ' + Vendor."No.";
                                    CustVendorAddress := Vendor.Address;
                                    CustVendorAddress2 := Vendor."Address 2";
                                    CustVendorPhone := Vendor."Phone No.";
                                    CustVendorMOF := Vendor."VAT Registration No.";
                                end;
                        // else begin
                        //     if "G/L Entry"."Line Source" = '' then begin
                        //         "G/L Entry".CALCFIELDS("G/L Entry"."G/L Account Name");
                        //         PayToName := "G/L Entry"."G/L Account Name";
                        //     end
                        //     else begin
                        //         case "G/L Entry"."Source Type" of
                        //             "G/L Entry"."Source Type"::Customer:
                        //                 begin
                        //                     Customer.GET("G/L Entry"."Source No.");
                        //                     PayToName := Customer.Name + ' ' + Customer."No.";
                        //                     CustVendorAddress := Customer.Address;
                        //                     CustVendorAddress2 := Customer."Address 2";
                        //                     CustVendorPhone := Customer."Phone No.";
                        //                     CustVendorMOF := Customer."VAT Registration No.";
                        //                 end;
                        //             "G/L Entry"."Source Type"::Vendor:
                        //                 begin
                        //                     Vendor.GET("G/L Entry"."Source No.");
                        //                     PayToName := Vendor.Name + ' ' + Vendor."No.";
                        //                     CustVendorAddress := Vendor.Address;
                        //                     CustVendorAddress2 := Vendor."Address 2";
                        //                     CustVendorPhone := Vendor."Phone No.";
                        //                     CustVendorMOF := Vendor."VAT Registration No.";
                        //                 end;
                        //         end;
                        //     end;
                        // end;
                        end;
                    end
                    else begin
                        case "G/L Entry"."Source Type" of
                            "G/L Entry"."Source Type"::"Bank Account":
                                begin
                                    bankTable.GET("G/L Entry"."Source No.");
                                    PayToName := bankTable.Name;
                                end;
                            "G/L Entry"."Source Type"::Customer:
                                begin
                                    Customer.GET("G/L Entry"."Source No.");
                                    PayToName := Customer.Name + ' ' + Customer."No.";
                                    CustVendorAddress := Customer.Address;
                                    CustVendorAddress2 := Customer."Address 2";
                                    CustVendorPhone := Customer."Phone No.";
                                    CustVendorMOF := Customer."VAT Registration No.";
                                end;
                            "G/L Entry"."Source Type"::Vendor:
                                begin
                                    Vendor.GET("G/L Entry"."Source No.");
                                    PayToName := Vendor.Name + ' ' + Vendor."No.";
                                    CustVendorAddress := Vendor.Address;
                                    CustVendorAddress2 := Vendor."Address 2";
                                    CustVendorPhone := Vendor."Phone No.";
                                    CustVendorMOF := Vendor."VAT Registration No.";
                                end;
                        // else begin
                        //     if "G/L Entry"."Line Source" = '' then begin
                        //         "G/L Entry".CALCFIELDS("G/L Entry"."G/L Account Name");
                        //         PayToName := "G/L Entry"."G/L Account Name";
                        //     end
                        //     else begin
                        //         case "G/L Entry"."Source Type" of
                        //             "G/L Entry"."Source Type"::Customer:
                        //                 begin
                        //                     Customer.GET("G/L Entry"."Source No.");
                        //                     PayToName := Customer.Name + ' ' + Customer."No.";
                        //                     CustVendorAddress := Customer.Address;
                        //                     CustVendorAddress2 := Customer."Address 2";
                        //                     CustVendorPhone := Customer."Phone No.";
                        //                     CustVendorMOF := Customer."VAT Registration No.";
                        //                 end;
                        //             "G/L Entry"."Source Type"::Vendor:
                        //                 begin
                        //                     Vendor.GET("G/L Entry"."Source No.");
                        //                     PayToName := Vendor.Name + ' ' + Vendor."No.";
                        //                     CustVendorAddress := Vendor.Address;
                        //                     CustVendorAddress2 := Vendor."Address 2";
                        //                     CustVendorPhone := Vendor."Phone No.";
                        //                     CustVendorMOF := Vendor."VAT Registration No.";
                        //                 end;
                        //         end;
                        //     end;
                        // end;
                        end;
                    end;
                end;
                // amountOriginalGL := ABS("G/L Entry"."Original Amount");
                // if "G/L Entry"."Original Currency Code" = '' then
                //     paymentCurrencyGL := GeneralLedgerSetup."Local Currency Symbol"
                // else
                //     paymentCurrencyGL := "G/L Entry"."Original Currency Code";
                //   amountToText.FormatNoText(ShowAmounttxtGL, amountOriginalGL,  GeneralLedgerSetup."Local Currency Symbol")
                //  else
                //   amountToText.FormatNoText(ShowAmounttxtGL, amountOriginalGL, "G/L Entry"."Original Currency Code");
                GeneralLedgerSetup.GET;
                GLEntryAcc.RESET;
                GLEntryAcc.SETRANGE("Document No.", "Document No.");
                GLEntryAcc.setfilter("Source Type", '%1|%2', "Source Type"::Customer, "Source Type"::Vendor);
                if GLEntryAcc.FINDFIRST then begin
                    if GLEntryAcc.Amount < 0 then
                        PayReceive := 'Received From'
                    else
                        PayReceive := 'Pay to';
                    HeaderAccount := GLEntryAcc."Source No.";
                    HeaderName := GetHeaderName(GLEntryAcc);
                    HeaderAdd := GetHeaderAdd(GLEntryAcc);
                    HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                    HeaderPhone := GetHeaderPhone(GLEntryAcc);
                    HeaderMOF := GetHeaderMOF(GLEntryAcc);
                    // amountOriginalGL := ABS(GLEntryAcc."Original Amount");
                    // if GLEntryAcc."Original Currency Code" = '' then
                    //     BaseCurr := GeneralLedgerSetup."Local Currency Symbol"
                    // else
                    //     BaseCurr := GLEntryAcc."Original Currency Code";
                    //amountToText.FormatNoText(ShowAmounttxtGL, ROUND(amountOriginalGL, 0.01, '='), BaseCurr);
                    case GLEntryAcc."Source Code" of
                        'PAYMENTJNL':
                            begin
                                ReportTitle := 'Payment';
                                if GLEntryAcc.Amount > 0 then begin
                                    if GLEntryAcc."Source No." = '' then begin
                                        HeaderAccount := GLEntryAcc."G/L Account No.";
                                        GLEntryAcc.CALCFIELDS("G/L Account Name");
                                        HeaderName := GLEntryAcc."G/L Account Name";
                                    end
                                    else begin
                                        HeaderAccount := GLEntryAcc."Source No.";
                                        HeaderName := GetHeaderName(GLEntryAcc);
                                        HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                        HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                        HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                        HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                        if (GLEntryAcc."Bal. Account No." <> '') and (GLEntryAcc."Bal. Account Type" = GLEntryAcc."Bal. Account Type"::"Bank Account") and (GLEntryAcc."Source Type" = GLEntryAcc."Source Type"::"Bank Account") then begin
                                            HeaderAccount := GLEntryAcc."G/L Account No.";
                                            GLEntryAcc.CALCFIELDS("G/L Account Name");
                                            HeaderName := GLEntryAcc."G/L Account Name";
                                        end;
                                    end;
                                    //HeaderAmount := GLEntryAcc."Original Amount";
                                end
                                else begin
                                    GLEntryAcc.RESET;
                                    GLEntryAcc.SETRANGE("Document No.", GLEntryAcc."Document No.");
                                    GLEntryAcc.SETFILTER(Amount, '>0');
                                    if GLEntryAcc.FINDFIRST then begin
                                        if GLEntryAcc."Source No." = '' then begin
                                            HeaderAccount := GLEntryAcc."G/L Account No.";
                                            GLEntryAcc.CALCFIELDS("G/L Account Name");
                                            HeaderName := GLEntryAcc."G/L Account Name";
                                        end
                                        else begin
                                            HeaderAccount := GLEntryAcc."Source No.";
                                            HeaderName := GetHeaderName(GLEntryAcc);
                                            HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                            HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                            HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                            HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                        end;
                                        //HeaderAmount := GLEntryAcc."Original Amount";
                                    end;
                                end;
                            end;
                        'CASHRECJNL':
                            begin
                                if GLEntryAcc."Document Type" = GLEntryAcc."Document Type"::Payment then begin
                                    ReportTitle := 'Receipt';
                                    ShowDimension := true;
                                end
                                else
                                    ReportTitle := 'Payment';
                                if GLEntryAcc.Amount < 0 then begin
                                    if GLEntryAcc."Source No." = '' then begin
                                        HeaderAccount := GLEntryAcc."G/L Account No.";
                                        GLEntryAcc.CALCFIELDS("G/L Account Name");
                                        HeaderName := GLEntryAcc."G/L Account Name";
                                    end
                                    else begin
                                        HeaderAccount := GLEntryAcc."Source No.";
                                        HeaderName := GetHeaderName(GLEntryAcc);
                                        HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                        HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                        HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                        HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                    end;
                                    //HeaderAmount := GLEntryAcc."Original Amount";
                                end
                                else begin
                                    GLEntryAcc.RESET;
                                    GLEntryAcc.SETRANGE("Document No.", GLEntryAcc."Document No.");
                                    GLEntryAcc.SETFILTER(Amount, '<0');
                                    if GLEntryAcc.FINDFIRST then begin
                                        if GLEntryAcc."Source No." = '' then begin
                                            HeaderAccount := GLEntryAcc."G/L Account No.";
                                            GLEntryAcc.CALCFIELDS("G/L Account Name");
                                            HeaderName := GLEntryAcc."G/L Account Name";
                                        end
                                        else begin
                                            HeaderAccount := GLEntryAcc."Source No.";
                                            HeaderName := GetHeaderName(GLEntryAcc);
                                            HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                            HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                            HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                            HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                        end;
                                        // HeaderAmount := GLEntryAcc."Original Amount";
                                    end;
                                end;
                            end;
                        else
                            ReportTitle := 'Voucher'; //edm.ai changed from voucher to receipt
                            if GLEntryAcc."Source Type" = GLEntryAcc."Source Type"::Vendor then begin
                                if GLEntryAcc.Amount > 0 then begin
                                    HeaderAccount := GLEntryAcc."Source No.";
                                    HeaderName := GetHeaderName(GLEntryAcc);
                                    HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                    HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                    HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                    HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                    // HeaderAmount := GLEntryAcc."Original Amount";
                                end
                                else begin
                                    GLEntryAcc.RESET;
                                    GLEntryAcc.SETRANGE("Document No.", GLEntryAcc."Document No.");
                                    GLEntryAcc.SETFILTER(Amount, '>0');
                                    if GLEntryAcc.FINDFIRST then begin
                                        HeaderAccount := GLEntryAcc."Source No.";
                                        HeaderName := GetHeaderName(GLEntryAcc);
                                        HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                        HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                        HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                        HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                        // HeaderAmount := GLEntryAcc."Original Amount";
                                    end;
                                end;
                            end
                            else
                                if GLEntryAcc."Source Type" = GLEntryAcc."Source Type"::Customer then begin
                                    if GLEntryAcc.Amount < 0 then begin
                                        HeaderAccount := GLEntryAcc."Source No.";
                                        HeaderName := GetHeaderName(GLEntryAcc);
                                        HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                        HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                        HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                        HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                        // HeaderAmount := GLEntryAcc."Original Amount";
                                    end
                                    else begin
                                        GLEntryAcc.RESET;
                                        GLEntryAcc.SETRANGE("Document No.", GLEntryAcc."Document No.");
                                        GLEntryAcc.SETFILTER(Amount, '<0');
                                        if GLEntryAcc.FINDFIRST then begin
                                            HeaderAccount := GLEntryAcc."Source No.";
                                            HeaderName := GetHeaderName(GLEntryAcc);
                                            HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                            HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                            HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                            HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                            // HeaderAmount := GLEntryAcc."Original Amount";
                                        end;
                                    end;
                                end;
                    end;
                end;
            end;

            trigger OnPreDataItem();
            var
                GLEntryAcc: Record "G/L Entry";
            begin
                //   Setrange("Document Type", "Document Type"::Payment);
                setfilter("Source Type", '%1|%2', "Source Type"::"Bank Account", "Source Type"::" ");
                ShowAppliedDoc := false;
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);
                GeneralLedgerSetup.GET;
                GLEntryAcc.RESET;
                GLEntryAcc.SETRANGE("Document No.", "Document No.");
                GLEntryAcc.setfilter("Source Type", '%1|%2', "Source Type"::Customer, "Source Type"::Vendor);
                if GLEntryAcc.FINDFIRST then begin
                    if GLEntryAcc.Amount < 0 then
                        PayReceive := 'Received From'
                    else
                        PayReceive := 'Pay to';
                    // IF CompanyInfo."French Company" then //EDM.AI
                    //     PayReceive := 'Reçu De ';
                    HeaderAccount := GLEntryAcc."Source No.";
                    HeaderName := GetHeaderName(GLEntryAcc);
                    HeaderAdd := GetHeaderAdd(GLEntryAcc);
                    HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                    HeaderPhone := GetHeaderPhone(GLEntryAcc);
                    HeaderMOF := GetHeaderMOF(GLEntryAcc);
                    //amountOriginalGL := ABS(GLEntryAcc."Original Amount");
                    // if GLEntryAcc."Original Currency Code" = '' then
                    //     BaseCurr := GeneralLedgerSetup."Local Currency Symbol"
                    // else
                    //     BaseCurr := GLEntryAcc."Original Currency Code";
                    //amountToText.FormatNoText(ShowAmounttxtGL, amountOriginalGL, BaseCurr);
                    case GLEntryAcc."Source Code" of
                        'PAYMENTJNL':
                            begin
                                ReportTitle := 'Payment';
                                if GLEntryAcc.Amount > 0 then begin
                                    if GLEntryAcc."Source No." = '' then begin
                                        HeaderAccount := GLEntryAcc."G/L Account No.";
                                        GLEntryAcc.CALCFIELDS("G/L Account Name");
                                        HeaderName := GLEntryAcc."G/L Account Name";
                                    end
                                    else begin
                                        HeaderAccount := GLEntryAcc."Source No.";
                                        HeaderName := GetHeaderName(GLEntryAcc);
                                        HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                        HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                        HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                        HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                        if (GLEntryAcc."Bal. Account No." <> '') and (GLEntryAcc."Bal. Account Type" = GLEntryAcc."Bal. Account Type"::"Bank Account") and (GLEntryAcc."Source Type" = GLEntryAcc."Source Type"::"Bank Account") then begin
                                            HeaderAccount := GLEntryAcc."G/L Account No.";
                                            GLEntryAcc.CALCFIELDS("G/L Account Name");
                                            HeaderName := GLEntryAcc."G/L Account Name";
                                        end;
                                    end;
                                    //HeaderAmount := GLEntryAcc."Original Amount";
                                end
                                else begin
                                    GLEntryAcc.RESET;
                                    GLEntryAcc.SETRANGE("Document No.", GLEntryAcc."Document No.");
                                    GLEntryAcc.SETFILTER(Amount, '>0');
                                    if GLEntryAcc.FINDFIRST then begin
                                        if GLEntryAcc."Source No." = '' then begin
                                            HeaderAccount := GLEntryAcc."G/L Account No.";
                                            GLEntryAcc.CALCFIELDS("G/L Account Name");
                                            HeaderName := GLEntryAcc."G/L Account Name";
                                        end
                                        else begin
                                            HeaderAccount := GLEntryAcc."Source No.";
                                            HeaderName := GetHeaderName(GLEntryAcc);
                                            HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                            HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                            HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                            HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                        end;
                                        // HeaderAmount := GLEntryAcc."Original Amount";
                                    end;
                                end;
                            end;
                        'CASHRECJNL':
                            begin
                                //if GLEntryAcc."Document Type" = GLEntryAcc."Document Type"::Payment then
                                ReportTitle := 'Receipt';
                                ShowDimension := true;
                                if GLEntryAcc.Amount < 0 then begin
                                    if GLEntryAcc."Source No." = '' then begin
                                        HeaderAccount := GLEntryAcc."G/L Account No.";
                                        GLEntryAcc.CALCFIELDS("G/L Account Name");
                                        HeaderName := GLEntryAcc."G/L Account Name";
                                    end
                                    else begin
                                        HeaderAccount := GLEntryAcc."Source No.";
                                        HeaderName := GetHeaderName(GLEntryAcc);
                                        HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                        HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                        HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                        HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                    end;
                                    //HeaderAmount := GLEntryAcc."Original Amount";
                                end
                                else begin
                                    GLEntryAcc.RESET;
                                    GLEntryAcc.SETRANGE("Document No.", GLEntryAcc."Document No.");
                                    GLEntryAcc.SETFILTER(Amount, '<0');
                                    if GLEntryAcc.FINDFIRST then begin
                                        if GLEntryAcc."Source No." = '' then begin
                                            HeaderAccount := GLEntryAcc."G/L Account No.";
                                            GLEntryAcc.CALCFIELDS("G/L Account Name");
                                            HeaderName := GLEntryAcc."G/L Account Name";
                                        end
                                        else begin
                                            HeaderAccount := GLEntryAcc."Source No.";
                                            HeaderName := GetHeaderName(GLEntryAcc);
                                            HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                            HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                            HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                            HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                        end;
                                        // HeaderAmount := GLEntryAcc."Original Amount";
                                    end;
                                end;
                            end;
                        else
                            ReportTitle := 'Voucher';
                            if GLEntryAcc."Source Type" = GLEntryAcc."Source Type"::Vendor then begin
                                if GLEntryAcc.Amount > 0 then begin
                                    HeaderAccount := GLEntryAcc."Source No.";
                                    HeaderName := GetHeaderName(GLEntryAcc);
                                    HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                    HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                    HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                    HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                    // HeaderAmount := GLEntryAcc."Original Amount";
                                end
                                else begin
                                    GLEntryAcc.RESET;
                                    GLEntryAcc.SETRANGE("Document No.", GLEntryAcc."Document No.");
                                    GLEntryAcc.SETFILTER(Amount, '>0');
                                    if GLEntryAcc.FINDFIRST then begin
                                        HeaderAccount := GLEntryAcc."Source No.";
                                        HeaderName := GetHeaderName(GLEntryAcc);
                                        HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                        HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                        HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                        HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                        //  HeaderAmount := GLEntryAcc."Original Amount";
                                    end;
                                end;
                            end
                            else
                                if GLEntryAcc."Source Type" = GLEntryAcc."Source Type"::Customer then begin
                                    if GLEntryAcc.Amount < 0 then begin
                                        HeaderAccount := GLEntryAcc."Source No.";
                                        HeaderName := GetHeaderName(GLEntryAcc);
                                        HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                        HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                        HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                        HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                        //   HeaderAmount := GLEntryAcc."Original Amount";
                                    end
                                    else begin
                                        GLEntryAcc.RESET;
                                        GLEntryAcc.SETRANGE("Document No.", GLEntryAcc."Document No.");
                                        GLEntryAcc.SETFILTER(Amount, '<0');
                                        if GLEntryAcc.FINDFIRST then begin
                                            HeaderAccount := GLEntryAcc."Source No.";
                                            HeaderName := GetHeaderName(GLEntryAcc);
                                            HeaderAdd := GetHeaderAdd(GLEntryAcc);
                                            HeaderAdd2 := GetHeaderAdd2(GLEntryAcc);
                                            HeaderPhone := GetHeaderPhone(GLEntryAcc);
                                            HeaderMOF := GetHeaderMOF(GLEntryAcc);
                                            //  HeaderAmount := GLEntryAcc."Original Amount";
                                        end;
                                    end;
                                end;
                    end;
                    // IF CompanyInfo."French Company" then ReportTitle := 'Reçu';
                end;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(ShowAsReceipt; ShowAsReceipt)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
        CurrencyCodeCaption = 'Currency Code';
        PageCaption = 'Page';
        DocDateCaption = 'Document Date';
        EmailCaption = 'E-Mail';
        HomePageCaption = 'Home Page';
    }
    trigger OnPreReport()
    var
    // ExtensionDateValidation: Codeunit "Extension Date Validation";
    begin
        //ExtensionDateValidation.CheckIfCustomerIsActive();
        CompanyInfo.Get();
        // If CompanyInfo."Show Duty Stamp caption" then
        DutyStampCaption := '*** Duty Stamp is paid in cash, MOF Receipt- 21-84-12101084 ***'
        // else
        //     DutyStampCaption := '';
    end;

    var
        addCurr: code[20];
        CompanyInfo: Record "Company Information";
        ReportTitle: Text;
        bankTable: Record "Bank Account";
        toBankName: Text;
        toBankNameGL: Text;
        fromBankName: Text;
        fromBankNameGl: Text;
        GLedgerEntry: Record "G/L Entry";
        paymentCurrency: Text;
        //amountToText: Codeunit "Amount to Text EDM";
        ShowAmounttxt: array[2] of Text;
        ShowAmounttxtGL: array[2] of Text;
        amountOriginal: Decimal;
        GLAccount: Record "G/L Account";
        amountOriginalGL: Decimal;
        paymentCurrencyGL: Text;
        PayToName: Text;
        pay: Label 'Pay To:';
        Receive: Label 'Recive From:';
        PayReceive: Text;
        CustVendorAddress: text;
        CustVendorAddress2: text;
        CustVendorPhone: text;
        CustVendorMOF: text;
        HeaderAccount: Text;
        HeaderAmount: Decimal;
        HeaderName: Text;
        HeaderAdd: text;
        HeaderAdd2: text;
        HeaderPhone: text;
        HeaderMOF: text;
        DebitAccount: Code[20];
        CustLedgerEntry: Record "Cust. Ledger Entry";
        PaidAmount: Decimal;
        PreAmount: Decimal;
        InvoiceCurrency: Code[10];
        GeneralLedgerSetup: Record "General Ledger Setup";
        ShowAppliedDoc: Boolean;
        BaseCurr: code[20];
        PostCode: Record "Post Code";
        DutyStampCaption: Text[250];
        DimensionValueCode: Code[100];
        DimensionValueName: Text[100];
        DimensionValue: Record "Dimension Value";
        GlEntry: Record "G/L Entry";
        ShowDimension: Boolean;
        ShowAsReceipt: Boolean;

    local procedure GetHeaderName(GLEntryName: Record "G/L Entry"): Text;
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
    begin
        case GLEntryName."Source Type" of
            GLEntryName."Source Type"::"Bank Account":
                begin
                    bankTable.GET(GLEntryName."Source No.");
                    exit(bankTable.Name);
                end;
            GLEntryName."Source Type"::Customer:
                begin
                    Customer.GET(GLEntryName."Source No.");
                    exit(Customer.Name + ' ' + Customer."No.");
                end;
            GLEntryName."Source Type"::Vendor:
                begin
                    Vendor.GET(GLEntryName."Source No.");
                    exit(Vendor.Name + ' ' + Vendor."No.");
                end;
        // else begin
        //     if GLEntryName."Line Source" <> '' then begin
        //         case GLEntryName."Source Type" of
        //             GLEntryName."Source Type"::Customer:
        //                 begin
        //                     Customer.GET(GLEntryName."Source No.");
        //                     exit(Customer.Name + ' ' + Customer."No.");
        //                 end;
        //             GLEntryName."Source Type"::Vendor:
        //                 begin
        //                     Vendor.GET(GLEntryName."Source No.");
        //                     exit(Vendor.Name + ' ' + Vendor."No.");
        //                 end;
        //         end;
        //     end;
        // end;
        end;
    end;

    local procedure GetHeaderAdd(GLEntryName: Record "G/L Entry"): Text;
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
    begin
        case GLEntryName."Source Type" of
            GLEntryName."Source Type"::"Bank Account":
                begin
                    bankTable.GET(GLEntryName."Source No.");
                    exit(bankTable.Name);
                end;
            GLEntryName."Source Type"::Customer:
                begin
                    Customer.GET(GLEntryName."Source No.");
                    exit(Customer.Address)
                end;
            GLEntryName."Source Type"::Vendor:
                begin
                    Vendor.GET(GLEntryName."Source No.");
                    exit(Vendor.Address);
                end;
        // else begin
        //     if GLEntryName."Line Source" <> '' then begin
        //         case GLEntryName."Source Type" of
        //             GLEntryName."Source Type"::Customer:
        //                 begin
        //                     Customer.GET(GLEntryName."Source No.");
        //                     exit(Customer.Address);
        //                 end;
        //             GLEntryName."Source Type"::Vendor:
        //                 begin
        //                     Vendor.GET(GLEntryName."Source No.");
        //                     exit(Vendor.Address);
        //                 end;
        //         end;
        //     end;
        // end;
        end;
    end;

    local procedure GetHeaderAdd2(GLEntryName: Record "G/L Entry"): Text;
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
    begin
        case GLEntryName."Source Type" of
            GLEntryName."Source Type"::"Bank Account":
                begin
                    bankTable.GET(GLEntryName."Source No.");
                    exit(bankTable.Name);
                end;
            GLEntryName."Source Type"::Customer:
                begin
                    Customer.GET(GLEntryName."Source No.");
                    exit(Customer."Address 2")
                end;
            GLEntryName."Source Type"::Vendor:
                begin
                    Vendor.GET(GLEntryName."Source No.");
                    exit(Vendor."Address 2");
                end;
        // else begin
        //     if GLEntryName."Line Source" <> '' then begin
        //         case GLEntryName."Source Type" of
        //             GLEntryName."Source Type"::Customer:
        //                 begin
        //                     Customer.GET(GLEntryName."Source No.");
        //                     exit(Customer."Address 2");
        //                 end;
        //             GLEntryName."Source Type"::Vendor:
        //                 begin
        //                     Vendor.GET(GLEntryName."Source No.");
        //                     exit(Vendor."Address 2");
        //                 end;
        //         end;
        //     end;
        // end;
        end;
    end;

    local procedure GetHeaderPhone(GLEntryName: Record "G/L Entry"): Text;
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
    begin
        case GLEntryName."Source Type" of
            GLEntryName."Source Type"::"Bank Account":
                begin
                    bankTable.GET(GLEntryName."Source No.");
                    exit(bankTable."Phone No.");
                end;
            GLEntryName."Source Type"::Customer:
                begin
                    Customer.GET(GLEntryName."Source No.");
                    exit(Customer."Phone No.")
                end;
            GLEntryName."Source Type"::Vendor:
                begin
                    Vendor.GET(GLEntryName."Source No.");
                    exit(Vendor."Phone No.");
                end;
        // else begin
        //     if GLEntryName."Line Source" <> '' then begin
        //         case GLEntryName."Source Type" of
        //             GLEntryName."Source Type"::Customer:
        //                 begin
        //                     Customer.GET(GLEntryName."Source No.");
        //                     exit(Customer."Phone No.");
        //                 end;
        //             GLEntryName."Source Type"::Vendor:
        //                 begin
        //                     Vendor.GET(GLEntryName."Source No.");
        //                     exit(Vendor."Phone No.");
        //                 end;
        //         end;
        //     end;
        // end;
        end;
    end;

    local procedure GetHeaderMOF(GLEntryName: Record "G/L Entry"): Text;
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
    begin
        case GLEntryName."Source Type" of
            GLEntryName."Source Type"::"Bank Account":
                begin
                    bankTable.GET(GLEntryName."Source No.");
                    exit('');
                end;
            GLEntryName."Source Type"::Customer:
                begin
                    Customer.GET(GLEntryName."Source No.");
                    exit(Customer."VAT Registration No.")
                end;
            GLEntryName."Source Type"::Vendor:
                begin
                    Vendor.GET(GLEntryName."Source No.");
                    exit(Vendor."VAT Registration No.");
                end;
        // else begin
        //     if GLEntryName."Line Source" <> '' then begin
        //         case GLEntryName."Source Type" of
        //             GLEntryName."Source Type"::Customer:
        //                 begin
        //                     Customer.GET(GLEntryName."Source No.");
        //                     exit(Customer."VAT Registration No.")
        //                 end;
        //             GLEntryName."Source Type"::Vendor:
        //                 begin
        //                     Vendor.GET(GLEntryName."Source No.");
        //                     exit(Vendor."VAT Registration No.");
        //                 end;
        //         end;
        //     end;
        // end;
        end;
    end;
}
