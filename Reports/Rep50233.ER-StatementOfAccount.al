report 50233 "ER - Statement Of Account"
{
    ApplicationArea = All;
    Caption = 'ER - Statement Of Account';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports Layouts/ER-StatementOfAccount.rdlc';
    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            PrintOnlyIfDetail = true;
            DataItemTableView = sorting("No.") WHERE("Account Type" = CONST(Posting));
            RequestFilterFields = "Date Filter";
            #region Company Information
            Column(CompanyCity; G_RecCompanyInformation.City)
            {

            }

            Column(Capital_Label; Capital_Label)
            {

            }
            Column(AddressLabel; AddressLabel)
            {

            }
            Column(TLabel; TLabel)
            {

            }
            Column(ELabel; ELabel)
            {

            }
            Column(VATCodeLabel; VATCodeLabel)
            {

            }
            column(Company_Picture; G_RecCompanyInformation.Picture)
            {

            }
            column(Company_Address; Company_Address)
            {

            }
            column(Company_Name; G_RecCompanyInformation.Name)
            {

            }
            column(Comapny_City; G_RecCompanyInformation.City)
            {

            }
            column(Company_CRNumber; G_RecCompanyInformation."CR No.")
            {

            }
            column(Company_Capital; G_RecCompanyInformation.Capital)
            {

            }
            column(Company_Vat; G_RecCompanyInformation."VAT Registration No.")
            {

            }
            column(Comapny_Phone; G_RecCompanyInformation."Phone No.")
            {

            }
            column(Company_Fax; G_RecCompanyInformation."Fax No.")
            {

            }
            column(Company_Email; G_RecCompanyInformation."E-Mail")
            {

            }
            column(BankAccLabel; BankAccLabel)
            {

            }
            column(SWIFTLabel; SWIFTLabel)
            {

            }
            column(IBANLabel; IBANLabel)
            {

            }
            column(Company_Bank_Account; G_RecCompanyInformation."Bank Name")
            {

            }
            column(Company_SWIFT; G_RecCompanyInformation."SWIFT Code")
            {

            }
            column(Company_IBAN; G_RecCompanyInformation.IBAN)
            {

            }
            column(Company_CityAndZip; G_RecCompanyInformation.City)
            {

            }
            column(FullyPaidLabel; FullyPaidLabel)
            {

            }
            column(LCY_Code; G_RecGnrlLedgSetup."LCY Code")
            {

            }
            #endregion
            #region Header Information
            Column(StatementOfAccountLabel; StatementOfAccountLabel)
            {

            }
            column(PrintedOnLabel; PrintedOnLabel)
            {

            }
            column(PageLabel; PageLabel)
            {

            }
            column(OfLabel; OfLabel)
            {

            }
            #endregion
            #region Filters
            column(Filter1; Filter1)
            {

            }
            column(Filter2; Filter2)
            {

            }
            column(NumberOfDimensions; x)
            {

            }
            #endregion
            #region G/L Account Labels
            column(AccountNo_Label; AccountNo_Label)
            {

            }
            column(Account_Type; "Account Type")
            {

            }
            column(AccountName_Label; AccountName_Label)
            {

            }
            column(SourceNo_Label; SourceNo_Label)
            {

            }
            column(Curr_Label; Curr_Label)
            {

            }
            column(Entry_Label; Entry_Label)
            {

            }
            column(OrigCurrBalance_Label; OrigCurrBalance_Label)
            {

            }
            column(LCYCurrBalance_Label; LCYCurrBalance_Label)
            {

            }
            column(ACYCurrBalance_Label; ACYCurrBalance_Label)
            {

            }
            column(Debit_Label; Debit_Label)
            {

            }
            column(Credit_Label; Credit_Label)
            {

            }
            column(Balance_Label; Balance_Label)
            {

            }
            #endregion
            #region G/L Account Values
            column(No; "No.")
            {

            }
            column(Name; "Name")
            {

            }
            column(G_CurrencyCode; G_CurrencyCode)
            {

            }
            column(Debit_Amount; "Debit Amount")
            {

            }
            column(Credit_Amount; "Credit Amount")
            {

            }
            column(Balance; "Balance")
            {

            }
            column(Add__Currency_Debit_Amount; "Add.-Currency Debit Amount")
            {

            }
            column(Add__Currency_Credit_Amount; "Add.-Currency Credit Amount")
            {

            }
            column(Add__Currency_Balance; "Additional-Currency Balance")
            {

            }
            #endregion
            #region Footer
            column(FormLabel; FormLabel)
            {

            }
            column(FormValue; FormValue)
            {

            }
            column(IssueDateLabel; IssueDateLabel)
            {

            }
            column(IssueDateValue; IssueDateValue)
            {

            }
            column(RevisionDateLabel; RevisionDateLabel)
            {

            }
            #endregion
            //CheckLater
            column(Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {

            }
            column(Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {

            }
            column(TimeNow; TimeNow)
            {

            }

            column(Additional_Currency_Net_Change; "Additional-Currency Net Change") { }

            column(Dim1Label; SelectedDimensions[1])
            {

            }
            column(Dim2Label; SelectedDimensions[2])
            {

            }
            column(Date_Range; format(FromDate) + '..' + format(ToDate))
            { }
            column(FromDate; Format(FromDate)) { }

            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter");// "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Business Unit Code" = FIELD("Business Unit Filter");
                DataItemLinkReference = "G/L Account";
                DataItemTableView = SORTING("G/L Account No.", "Posting Date");
                RequestFilterFields = "G/L Account No.", "Posting Date"; //"Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code", "Shortcut Dimension 7 Code", "Shortcut Dimension 8 Code";
                column(Account_Id; "Account Id")
                {

                }
                column(DateFilter; DateFilter) { }
                column(GLNoFilter; GLNoFilter) { }
                column(Entry_No; "Entry No.")
                {

                }
                column(Description; Description)
                {

                }
                column(NetChange; NetChange) { }
                column(Document_No_; "Document No.") { }
                column(Posting_Date; "Posting Date") { }
                column(Source_No_; "Source No.")
                {

                }
                column(Entry_Debit_Amount; "Debit Amount")
                {

                }
                column(Entry_Credit_Amount; "Credit Amount")
                {

                }
                Column(Entry_Add__Currency_Debit_Amount; "Add.-Currency Debit Amount")
                {

                }
                column(Entry_Add__Currency_Credit_Amount; "Add.-Currency Credit Amount")
                {

                }

                column(Shortcut_Dimension_3_Code; "Shortcut Dimension 3 Code")
                {

                }
                column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                {

                }
                column(Global_Dimension_2_Code; "Global Dimension 2 Code")
                {

                }
                column(Dim1Value; Dim1Value)
                {

                }
                column(Dim2Value; Dim2Value)
                {

                }
                trigger OnPreDataItem()
                begin
                    case SelectedDimensionsNB[1] of
                        1:
                            begin
                                Dim1ID := 23;
                            end;
                        2:
                            begin
                                Dim1ID := 24;
                            end;
                        3:
                            begin
                                Dim1ID := 481;
                            end;
                        4:
                            begin
                                Dim1ID := 482;
                            end;
                        5:
                            begin
                                Dim1ID := 483;
                            end;
                        6:
                            begin
                                Dim1ID := 484;
                            end;
                        7:
                            begin
                                Dim1ID := 485;
                            end;
                        8:
                            begin
                                Dim1ID := 486;
                            end;
                    end;

                    case SelectedDimensionsNB[2] of
                        1:
                            begin
                                Dim2ID := 23;
                            end;
                        2:
                            begin
                                Dim2ID := 24;
                            end;
                        3:
                            begin
                                Dim2ID := 481;
                            end;
                        4:
                            begin
                                Dim2ID := 482;
                            end;
                        5:
                            begin
                                Dim2ID := 483;
                            end;
                        6:
                            begin
                                Dim2ID := 484;
                            end;
                        7:
                            begin
                                Dim2ID := 485;
                            end;
                        8:
                            begin
                                Dim2ID := 486;
                            end;
                    end;
                end;

                trigger OnAfterGetRecord()
                var
                    MyFieldRef: FieldRef;
                    GLEntryRecref: RecordRef;

                    RecID: RecordID;
                begin
                    GLEntryRecref.OPEN(17);
                    RecID := "G/L Entry".RecordId;
                    GLEntryRecref.Get(RecID);

                    if x > 1 then begin


                        MyFieldRef := GLEntryRecref.FIELD(Dim1ID);
                        if Dim1ID > 24 then
                            MyFieldRef.CALCFIELD;
                        Dim1Value := MyFieldRef.Value;

                        if x > 2 then begin
                            MyFieldRef := GLEntryRecref.FIELD(Dim2ID);
                            if Dim2ID > 24 then
                                MyFieldRef.CALCFIELD;
                            Dim2Value := MyFieldRef.Value;
                        end
                        else
                            Dim2Value := '';


                    end
                    else
                        Dim1Value := '';

                end;

            }

            trigger OnAfterGetRecord()
            var
                GlCode: code[20];
                Date: Record Date;
            begin
                //NetChange := 0;
                //Date := "G/L Account"."Date Filter";
                // CalcFields("Net Change", "Balance at Date", "Additional-Currency Net Change");


                //GlCode := "G/L Entry"."G/L Account No.";
                //SetFilter("No.", GlCode);
                // IF DateFilter <> '' THEN BEGIN
                //SetFilter("No.", GlCode);
                SetRange("Date Filter", 0D, GETRANGEMIN("Date Filter") - 1);

                CalcFields("Net Change");
                NetChange := "Net Change";
                SETFILTER("Date Filter", DateFilter);


            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Groupping by Dimensions")
                {
                    field(Dimension1; DimensionsArray[1])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,1,1';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension2; DimensionsArray[2])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,1,2';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension3; DimensionsArray[3])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,2,3';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension4; DimensionsArray[4])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,2,4';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension5; DimensionsArray[5])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,2,5';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension6; DimensionsArray[6])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,2,6';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension7; DimensionsArray[7])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,2,7';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                    field(Dimension8; DimensionsArray[8])
                    {
                        ApplicationArea = all;
                        CaptionClass = '1,2,8';
                        trigger OnValidate()
                        begin
                            if GetTrue() > 2 then begin
                                Error('You can select only 2 Dimensions');
                                exit;
                            end;
                        end;
                    }
                }
            }
        }
        trigger OnAfterGetRecord()
        var
            myInt: Integer;

        begin


        end;
    }

    trigger OnPreReport()
    var
        i: Integer;
        //x: Integer;
        L_RecDimensions: Record Dimension;

    begin
        GLNoFilter := "G/L Entry".GetFilters;
        PostDateFilter := "G/L Entry".GetFilter("Posting Date");
        DateFilter := "G/L Account".GETFILTER("Date Filter");
        G_RecGnrlLedgSetup.Get();
        G_RecCompanyInformation.Get();
        G_RecCompanyInformation.CalcFields(Picture);
        G_CurrencyCode := G_RecGnrlLedgSetup."LCY Code";
        Company_Address := G_RecCompanyInformation.Address + ' ' + G_RecCompanyInformation."Country/Region Code";



        x := 1;
        TimeNow := Format(System.CurrentDateTime());

        for i := 1 to 8 do begin
            if DimensionsArray[i] = true then begin
                if i = 1 then begin
                    SelectedDimensionsNB[x] := 1;
                    L_RecDimensions.get(G_RecGnrlLedgSetup."Global Dimension 1 Code");
                    SelectedDimensions[x] := L_RecDimensions.Name;
                    ///SelectedDimensionsColumns[x]:="Global Dimension 1 Code";
                    x := x + 1;
                end else begin
                    if i = 2 then begin
                        SelectedDimensionsNB[x] := 2;
                        L_RecDimensions.get(G_RecGnrlLedgSetup."Global Dimension 2 Code");
                        SelectedDimensions[x] := L_RecDimensions.Name;
                        x := x + 1;

                    end else begin
                        if i = 3 then begin
                            SelectedDimensionsNB[x] := 3;
                            L_RecDimensions.get(G_RecGnrlLedgSetup."Shortcut Dimension 3 Code");
                            SelectedDimensions[x] := L_RecDimensions.Name;
                            x := x + 1;

                        end else begin
                            if i = 4 then begin

                                SelectedDimensionsNB[x] := 4;
                                L_RecDimensions.get(G_RecGnrlLedgSetup."Shortcut Dimension 4 Code");
                                SelectedDimensions[x] := L_RecDimensions.Name;
                                x := x + 1;

                            end else begin
                                if i = 5 then begin

                                    SelectedDimensionsNB[x] := 5;
                                    L_RecDimensions.get(G_RecGnrlLedgSetup."Shortcut Dimension 5 Code");
                                    SelectedDimensions[x] := L_RecDimensions.Name;
                                    x := x + 1;

                                end else begin
                                    if i = 6 then begin

                                        SelectedDimensionsNB[x] := 6;
                                        L_RecDimensions.get(G_RecGnrlLedgSetup."Shortcut Dimension 6 Code");
                                        SelectedDimensions[x] := L_RecDimensions.Name;
                                        x := x + 1;

                                    end else begin
                                        if i = 7 then begin

                                            SelectedDimensionsNB[x] := 7;
                                            L_RecDimensions.get(G_RecGnrlLedgSetup."Shortcut Dimension 7 Code");
                                            SelectedDimensions[x] := L_RecDimensions.Name;
                                            x := x + 1;

                                        end else begin
                                            if i = 8 then begin

                                                SelectedDimensionsNB[x] := 8;
                                                L_RecDimensions.get(G_RecGnrlLedgSetup."Shortcut Dimension 8 Code");
                                                SelectedDimensions[x] := L_RecDimensions.Name;
                                                x := x + 1;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;

    end;



    procedure GetTrue(): Integer // Get the number of true values in the shortcuts array
    var
        i: Integer;
        Counter: Integer;
    begin
        Counter := 0;
        for i := 1 to 8 do begin
            if DimensionsArray[i] = true then begin
                Counter := Counter + 1;
            end;
        end;
        exit(Counter)
    end;

    var
        G_RecCompanyInformation: Record "Company Information";
        G_RecGnrlLedgSetup: Record "General Ledger Setup";
        G_CurrencyCode: Code[10];
        Company_Address: Text[250];
        Filter1: Text[250];
        Filter2: Text[250];

        FromDate: Date;
        ToDate: Date;

        #region HeaderLabels
        AddressLabel: Label 'Address';
        Capital_Label: Label 'Capital';
        GLNoFilter: Text[100];
        DateFilter: Text[100];
        VATCodeLabel: Label 'VAT Code';
        FullyPaidLabel: Label 'Fully Paid';
        TLabel: Label 'T:';
        ELabel: Label 'E:';

        BankAccLabel: Label 'Bank Account:';
        SWIFTLabel: Label 'SWIFT Code';
        IBANLabel: Label 'IBAN:';
        StatementOfAccountLabel: Label 'Statement Of Account';
        PrintedOnLabel: Label 'Printed On:';
        PageLabel: Label 'Page';
        OfLabel: Label 'of';
        #endregion

        #region G/L Account Labels
        AccountNo_Label: Label 'Account No.';
        AccountName_Label: Label 'Acc Name';
        SourceNo_Label: Label 'Source No.';
        Curr_Label: Label 'Curr.';
        Entry_Label: Label 'Entry';
        GLAccount: Record "G/L Account";
        OrigCurrBalance_Label: Label 'Orig Curr Balance';
        LCYCurrBalance_Label: Label 'LCY Currency Balance';
        ACYCurrBalance_Label: Label 'ACY Currency Balance';
        Debit_Label: Label 'Debit';
        Credit_Label: Label 'Credit';
        Balance_Label: Label 'Balance';
        #endregion

        #region FooterLabels
        FormLabel: Label 'Form #:';
        FormValue: Label 'ER\LB\AVER\ACCT-SOA\100';
        IssueDateLabel: Label 'Issue Date:';
        IssueDateValue: Label 'Jan 23';
        RevisionDateLabel: Label 'Revision Date/#:';
        #endregion

        #region Group by shortcuts
        DimensionsArray: array[8] of Boolean;
        SelectedDimensions: array[2] of Text;
        Date: Date;
        SelectedDimensionsNB: array[2] of Integer;
        Dim1ID: Integer;
        Dim2ID: Integer;
        Dim1Value: Text;
        Dim2Value: Text;
        #endregion
        TimeNow: Text[25];
        x: Integer;
        NetChange: Decimal;
        PostDateFilter: text;
}
