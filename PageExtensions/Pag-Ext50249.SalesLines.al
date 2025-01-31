pageextension 50249 "Sales Lines" extends "Sales Lines"
{
    layout
    {
        addbefore("Document Type")
        {
            field("Parameters Header ID"; Rec."Parameters Header ID")
            {
                ApplicationArea = all;
            }
            field("Parent Parameter Header ID"; Rec."Parent Parameter Header ID")
            {
                ApplicationArea = all;
            }
        }

        addafter(Description)
        {

            field(Size; Rec.Size)
            {
                ApplicationArea = all;

            }
            field(Fit; Rec.Fit)
            {
                ApplicationArea = all;

            }
            field(Color; Rec.Color)
            {
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                var
                    Item: Record Item;
                    ItemColorPage: Page "Item Colors";
                    ItemColorRec: Record "Item Color";
                begin
                    if Item.Get(Rec."No.") then begin
                        ItemColorRec.SetRange("Item No.", Item."No.");
                        if ItemColorRec.FindSet() then begin
                            ItemColorPage.SetTableView(ItemColorRec);
                            ItemColorPage.LookupMode(true);
                            if ItemColorPage.RunModal() = Action::LookupOK then begin
                                ItemColorPage.GetRecord(ItemColorRec);
                                Rec.Validate(Color, ItemColorRec."Color ID");
                                Rec.Validate(Tonality, ItemColorRec."Tonality Code");
                            end;
                        end;
                    end;
                end;

            }
            // field(ColorName; ColorName)
            // {
            //     Caption = 'Color Name';
            //     ApplicationArea = all;
            //     Editable = false;
            // }
            // field(FrenchColorName; FrenchColorName)
            // {
            //     Caption = 'French Color';
            //     ApplicationArea = all;
            //     Editable = false;
            // }
            field(TonalityCode; Rec.Tonality)
            {
                Caption = 'Tonality';
                ApplicationArea = all;
                Editable = false;
            }
            field(Cut; Rec.Cut)
            {
                ApplicationArea = all;

            }
            field("Allocation Type"; Rec."Allocation Type")
            {
                ApplicationArea = all;
            }
            field("Allocation Code"; Rec."Allocation Code")
            {
                ApplicationArea = all;
            }
            field("Par Level"; Rec."Par Level")
            {
                ApplicationArea = All;
            }
            field("Assembly No."; Rec."Assembly No.")
            {
                ApplicationArea = all;
                Lookup = true;
                trigger OnDrillDown()
                var
                    AssemblyHeader: Record "Assembly Header";
                begin
                    if AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, Rec."Assembly No.") then
                        Page.Run(Page::"Assembly Order", AssemblyHeader);
                end;

            }
            field("Needed RM Batch"; Rec."Needed RM Batch")
            {
                ApplicationArea = all;
                Lookup = true;
                trigger OnDrillDown()
                var
                    NeededRawMaterial: Record "Needed Raw Material";
                begin
                    NeededRawMaterial.SetRange(Batch, Rec."Needed RM Batch");
                    if NeededRawMaterial.FindSet() then
                        Page.Run(Page::"Needed Raw Materials", NeededRawMaterial);
                end;
            }
            field("Department Code"; Rec."Department Code")
            {
                ApplicationArea = All;
            }
            field("Position Code"; Rec."Position Code")
            {
                ApplicationArea = All;
            }
            field("Staff Code"; Rec."Staff Code")
            {
                ApplicationArea = All;
            }
            field("Qty Assignment Wizard Id"; Rec."Qty Assignment Wizard Id")
            {
                ApplicationArea = all;
            }
        }
        addafter("Variant Code")
        {
            field("Control Number"; Rec."Control Number")
            {
                ApplicationArea = all;
            }
            field("Design Sections Set"; Rec."Design Sections Set")
            {
                ApplicationArea = all;
            }
            field("Item Features Set"; Rec."Item Features Set")
            {
                ApplicationArea = all;
            }
            field("Item Brandings Set"; Rec."Item Brandings Set")
            {
                ApplicationArea = all;
            }
        }
        addafter("No.")
        {
            field("VariantCode"; Rec."Variant Code")
            {
                ApplicationArea = All;
                //Editable = false;
                Visible = true;
            }
        }

    }

    actions
    {
        addafter("Reservation Entries")
        {
            action("Reorder")
            {
                ApplicationArea = All;
                Caption = 'Reorder';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Quote;
                trigger OnAction()
                var
                    SL: Record "Sales Line";
                    SH: Record "Sales Header";
                begin
                    CurrPage.SetSelectionFilter(SL);
                    if SL.FindFirst() then begin
                        SH.SetFilter("No.", Format(SL."Document No."));
                        SH.SetFilter("Document Type", Format(SL."Document Type"));
                        if SH.FindFirst() then begin
                            CreateSalesQuote(SH, SL);
                        end;

                    end;

                end;

            }
        }

    }
    procedure CreateSalesQuote(var SH: Record "Sales Header"; var SL: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        OrderHistory: Record "OrderHistory";
        OrderHistoryPage: Page "OrderHistory";
        ParentParamHeaderVar: Integer;
        ParamHeaderVar: Integer;
        ChildrenParameterHeader: Record "Parameter Header";
        QtyAssignWizard: Record "Qty Assignment Wizard";
        OldDesignSectionParamLines: Record "Design Section Param Lines";
        OldItemFeaturesParamLines: Record "Item Features Param Lines";
        OldItemBrandingParamLines: Record "Item Branding Param Lines";
        OldNeededRM: Record "Needed Raw Material";
        LastNeededRM: Record "Needed Raw Material";
        LineNo: Integer;
        LastNeededRMBatch: Integer;
        LastNeededRMID: Integer;
        ParamHeader: Record "Parameter Header";
        ParentParamHeader: Record "Parameter Header";
        OldWizardDepartment: Record "Wizard Departments";
        OldWizardPosition: Record "Wizard Positions";
        OldWizardStaff: Record "Wizard Staff";
        ParentParamHeaderDictionary: Dictionary of [Integer, Integer];
        QtyAssignemtWizardDictionary: Dictionary of [Integer, Integer];
        DesignSectionSetVar: Integer;
        ItemFeaturesSetVar: Integer;
        ItemBrandingsSetVar: Integer;
        WizardID: Integer;
        NoSeriesMngmt: Codeunit "No. Series";
        //Dialog
        Question: Text;
        Answer: Boolean;
        Text000: Label 'Sales Quote Created %1 ,Do you want to Open it?';
        VariantCode: code[10];

    begin
        if OrderHistory.get(SH."No.", Database.SessionId()) then begin
            if OrderHistory.Source = '' then begin
                SalesHeader.init();
                SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
                SalesHeader.Validate("No.", NoSeriesMngmt.GetNextNo(SalesHeader.GetNoSeriesCode()));
                SalesHeader.TransferFields(SH, false, true);
                SalesHeader.Status := SalesHeader.Status::Open;
                SalesHeader.Validate(SalesHeader."Posting Date", Today());
                SalesHeader.Validate(SalesHeader."Order Date", Today());
                SalesHeader.Validate(SalesHeader."Due Date", Today());
                SalesHeader.Validate(SalesHeader."Document Date", Today());
                SalesHeader.Validate(SalesHeader."Promised Delivery Date", 0D); // we cannot set it to Today because it is making issues 'You cannot change the Requested Delivery Date when the Promised Delivery Date has been filled in.'
                SalesHeader.Validate(SalesHeader."Requested Delivery Date", 0D);
                SalesHeader.Validate(SalesHeader."Quote Valid Until Date", Today());
                SalesHeader.Validate("Shipping No.", '');
                SalesHeader.Insert(true);

            end
            else begin

                if SalesHeader.get(SalesHeader."Document Type"::Quote, OrderHistory.Source) then begin
                    SalesHeader.TransferFields(SH, false, true);
                    SalesHeader.Status := SalesHeader.Status::Open;
                    SalesHeader.Validate(SalesHeader."Posting Date", Today());
                    SalesHeader.Validate(SalesHeader."Order Date", Today());
                    SalesHeader.Validate(SalesHeader."Due Date", Today());
                    SalesHeader.Validate(SalesHeader."Document Date", Today());
                    SalesHeader.Validate(SalesHeader."Promised Delivery Date", 0D); // we cannot set it to Today because it is making issues 'You cannot change the Requested Delivery Date when the Promised Delivery Date has been filled in.'
                    SalesHeader.Validate(SalesHeader."Requested Delivery Date", 0D);
                    SalesHeader.Validate(SalesHeader."Quote Valid Until Date", Today());
                    SalesHeader.Validate("Shipping No.", '');
                    SalesHeader.Modify(true);
                end;
            end;

        end;
        if SL.FindFirst() then
            repeat

                sl.CalcFields("Design Sections Set", "Item Features Set", "Item Brandings Set");
                //Get Parent Parameter Header from Old SO
                if ParentParamHeaderDictionary.ContainsKey(SL."Parent Parameter Header ID") then begin
                    ParentParamHeaderVar := ParentParamHeaderDictionary.Get(SL."Parent Parameter Header ID");
                end else begin
                    ParentParamHeaderVar := CopyParameterHeader(SL."Parent Parameter Header ID", LineNo, SalesHeader."No.");
                    ParentParamHeaderDictionary.Add(SL."Parent Parameter Header ID", ParentParamHeaderVar);

                    //Copy Design Section
                    OldDesignSectionParamLines.Reset();
                    OldDesignSectionParamLines.SetFilter("Header ID", Format(SL."Parent Parameter Header ID"));
                    if OldDesignSectionParamLines.FindFirst() then begin
                        LineNo := 1;
                        repeat
                            CopyDesignSection(OldDesignSectionParamLines, ParentParamHeaderVar, LineNo);
                            LineNo := LineNo + 1;
                        until OldDesignSectionParamLines.Next() = 0;
                    end;

                    //Copy Item Features
                    OldItemFeaturesParamLines.Reset();
                    OldItemFeaturesParamLines.SetFilter("Header ID", Format(SL."Parent Parameter Header ID"));
                    if OldItemFeaturesParamLines.FindFirst() then begin
                        LineNo := 1;
                        repeat
                            CopyItemFeatures(OldItemFeaturesParamLines, ParentParamHeaderVar, LineNo);
                            LineNo := LineNo + 1;
                        until OldItemFeaturesParamLines.Next() = 0;
                    end;

                    //Copy Item Branding
                    OldItemBrandingParamLines.Reset();
                    OldItemBrandingParamLines.SetFilter("Header ID", Format(SL."Parent Parameter Header ID"));
                    if OldItemBrandingParamLines.FindFirst() then begin
                        repeat
                            CopyItemBranding(OldItemBrandingParamLines, ParentParamHeaderVar);
                        until OldItemBrandingParamLines.Next() = 0;
                    end;

                end;
                //ParentParamHeaderVar:= CopyParameterHeader(SL."Parent Parameter Header ID",LineNo,SalesHeader."No.");
                ParamHeaderVar := CopyParameterHeader(SL."Parameters Header ID", LineNo, SalesHeader."No.");

                QtyAssignWizard.Reset();
                if (SL."Parent Parameter Header ID" <> 0) and (SL."Qty Assignment Wizard Id" <> 0) then begin
                    // ParamHeaderPar.Get(ParentParamHeaderVar);
                    QtyAssignWizard.SetFilter("Header Id", Format(SL."Qty Assignment Wizard Id"));
                    QtyAssignWizard.SetFilter("Parent Header Id", Format(SL."Parent Parameter Header ID"));
                    if QtyAssignWizard.FindFirst() then begin
                        if QtyAssignemtWizardDictionary.ContainsKey(SL."Qty Assignment Wizard Id") then begin
                            SalesLine."Qty Assignment Wizard Id" := QtyAssignemtWizardDictionary.Get(SL."Qty Assignment Wizard Id");
                        end else begin
                            QtyAssignemtWizardDictionary.Add(SL."Qty Assignment Wizard Id", CopyQtyAssignemtWizard(QtyAssignWizard, ParamHeaderVar, ParentParamHeaderVar));
                            SalesLine."Qty Assignment Wizard Id" := QtyAssignemtWizardDictionary.Get(SL."Qty Assignment Wizard Id");
                        end;
                        //WizardID := CopyQtyAssignemtWizard(QtyAssignWizard, ParamHeaderVar, ParentParamHeaderVar);
                        OldWizardDepartment.SetFilter("Parameter Header Id", Format(SL."Qty Assignment Wizard Id"));
                        if OldWizardDepartment.FindFirst() then begin
                            repeat
                                CopyWizardDepartment(OldWizardDepartment, ParamHeaderVar);
                            until OldWizardDepartment.Next() = 0;
                        end;
                        OldWizardPosition.SetFilter("Parameter Header Id", Format(SL."Qty Assignment Wizard Id"));
                        if OldWizardPosition.FindFirst() then begin
                            repeat
                                CopyWizardPosition(OldWizardPosition, ParamHeaderVar);
                            until OldWizardPosition.Next() = 0;
                        end;

                        OldWizardStaff.SetFilter("Parameter Header Id", Format(SL."Qty Assignment Wizard Id"));
                        if OldWizardStaff.FindFirst() then begin
                            repeat
                                CopyWizardStaff(OldWizardStaff, ParamHeaderVar);
                            until OldWizardStaff.Next() = 0;
                        end;
                    end;



                    OldItemFeaturesParamLines.Reset();
                    OldItemFeaturesParamLines.SetFilter("Header ID", Format(SL."Parameters Header ID"));
                    if OldItemFeaturesParamLines.FindFirst() then begin
                        LineNo := 1;
                        repeat
                            CopyItemFeatures(OldItemFeaturesParamLines, ParamHeaderVar, LineNo);
                            LineNo := LineNo + 1;
                        until OldItemFeaturesParamLines.Next() = 0;
                    end;
                    //


                    OldItemBrandingParamLines.Reset();
                    OldItemBrandingParamLines.SetFilter("Header ID", Format(SL."Parameters Header ID"));
                    if OldItemBrandingParamLines.FindFirst() then begin
                        repeat
                            CopyItemBranding(OldItemBrandingParamLines, ParamHeaderVar);
                        until OldItemBrandingParamLines.Next() = 0;
                    end;
                end;
                //
                // LastNeededRM.Reset();
                // LastNeededRM.SetCurrentKey(Batch);
                // if LastNeededRM.FindLast() then begin
                //     LastNeededRMBatch := LastNeededRM.Batch + 1;
                // end;

                // LastNeededRM.Reset();
                // LastNeededRM.SetCurrentKey(ID);
                // if LastNeededRM.FindLast() then begin
                //     LastNeededRMID := LastNeededRM.ID;
                // end;

                // //SalesLine."Needed RM Batch" := LastNeededRMBatch;
                // OldNeededRM.Reset();
                // OldNeededRM.SetFilter(Batch, Format(SL."Needed RM Batch"));
                // if OldNeededRM.FindFirst() then begin
                //     repeat
                //         LastNeededRMID := LastNeededRMID + 1;
                //         CopyNeededRM(OldNeededRM, LastNeededRMBatch, LastNeededRMID, ParamHeaderVar, SalesLineNo, SalesHeader."No.");
                //     until OldNeededRM.Next() = 0;
                // end;
                ///
                ParamHeader.Reset();
                ParentParamHeader.Reset();
                QtyAssignWizard.Reset();

                if ParamHeader.get(ParamHeaderVar) then;
                if ParentParamHeader.get(ParentParamHeaderVar) then;
                QtyAssignWizard.SetRange("Header Id", ParamHeaderVar);
                if QtyAssignWizard.FindFirst() then begin
                    Clear(ChildrenParameterHeader);
                    ChildrenParameterHeader.Get(QtyAssignWizard."Header Id");
                    VariantCode := Management.CheckVariantCode(ChildrenParameterHeader);
                end;


                Management.CreateMultipleSalesLines(ParamHeader, SalesHeader, VariantCode, ParentParamHeader, QtyAssignWizard, true);
                //
                //SalesLine.Insert(true);
                Commit();
            // OldNeededRM.Reset();
            // ParamHeader.Reset();
            // ParentParamHeader.Reset();
            // OldNeededRM.setFilter(Batch, Format(LastNeededRMBatch));
            // ParamHeader.setfilter("ID", Format(ParamHeaderVar));
            // ParentParamHeader.setfilter("ID", Format(ParentParamHeaderVar));
            //if OldNeededRM.FindFirst() and ParamHeader.FindFirst() and ParentParamHeader.FindFirst() then
            //Management.CreateAssemblyOrder(OldNeededRM, ParamHeader, ParentParamHeader, SalesLine);

            until SL.Next() = 0;
        Commit();
        //SalesLineNo := 0;
        Question := Text000;
        Answer := Dialog.Confirm(Question, true, SalesHeader."No.");
        if Answer then begin
            CurrPage.Close();
            Page.Run(Page::"Sales Quote", SalesHeader);
        end;
        Clear(OrderHistory);
        OrderHistory.SetRange("Session ID", Database.SessionId());
        OrderHistory.SetRange("Customer No.", SalesHeader."Sell-to Customer No.");
        if OrderHistory.FindSet() then begin
            OrderHistory.DeleteAll();
        end;
    end;



    // procedure CalculateLineNo()
    // begin
    //     if SalesLineNo = 0 then
    //         SalesLineNo := 10000
    //     else
    //         SalesLineNo := SalesLineNo + 10000;
    // end;


    procedure CopyParameterHeader(var OldParameterHeaderID: Integer; var SalesLineNo: Integer; var SalesLineDocNo: Code[50]): Integer;
    var
        paramHeader: Record "Parameter Header";
        paramHeader_forInsert: Record "Parameter Header";
        newParameterHeaderID: Integer;
        DocType: Enum "Sales Document Type";
    begin
        if OldParameterHeaderID <> 0 then begin
            if paramHeader.FindLast() then begin
                newParameterHeaderID := paramHeader.ID + 1;
            end;
            paramHeader.Reset();
            if paramHeader.get(OldParameterHeaderID) then begin
                paramHeader_forInsert.init();
                paramHeader_forInsert.TransferFields(paramHeader, false, true);
                paramHeader_forInsert."ID" := newParameterHeaderID;
                paramHeader_forInsert."Sales Line No." := SalesLineNo;
                paramHeader_forInsert."Sales Line Document No." := SalesLineDocNo;
                paramHeader_forInsert."Sales Line Document Type" := DocType::Quote;
                paramHeader_forInsert.Insert(true);
                Commit();
                exit(paramHeader_forInsert.ID);//SalesLine."Parameters Header ID" := paramHeader_forInsert.ID;
            end;
        end;
    end;

    procedure CopyQtyAssignemtWizard(var OldQtyAssignemtWizar: Record "Qty Assignment Wizard"; var paramHeaderNo: Integer; ParentParamHeader: Integer): Integer
    var
        NewQtyAssignemtWizard: Record "Qty Assignment Wizard";
    //LastQtyAssignemtWizard: Record "Qty Assignment Wizard";
    begin
        NewQtyAssignemtWizard.Init();
        NewQtyAssignemtWizard.TransferFields(OldQtyAssignemtWizar, false, true);
        NewQtyAssignemtWizard."Header Id" := paramHeaderNo;
        NewQtyAssignemtWizard."Parent Header Id" := ParentParamHeader;
        NewQtyAssignemtWizard.Insert(true);
        exit(NewQtyAssignemtWizard."Header Id");
    end;

    procedure CopyWizardDepartment(var OldWizardDepartment: Record "Wizard Departments"; var paramHeaderNo: Integer)//: Integer
    var
        NewWizardDepartment: Record "Wizard Departments";
    //LastQtyAssignemtWizard: Record "Qty Assignment Wizard";
    begin
        NewWizardDepartment.Reset();
        NewWizardDepartment.Init();
        NewWizardDepartment.TransferFields(OldWizardDepartment);
        NewWizardDepartment."Parameter Header Id" := paramHeaderNo;
        NewWizardDepartment.Insert(true);
        //exit(NewDesignSection."Header Id");
    end;


    procedure CopyDesignSection(var OldDesignSection: Record "Design Section Param Lines"; var paramHeaderNo: Integer; LineNo: Integer)//: Integer
    var
        NewDesignSectionParamLines: Record "Design Section Param Lines";
    //LastQtyAssignemtWizard: Record "Qty Assignment Wizard";
    begin
        NewDesignSectionParamLines.Reset();
        NewDesignSectionParamLines.Init();
        NewDesignSectionParamLines.TransferFields(OldDesignSection, false, true);
        NewDesignSectionParamLines."Header ID" := paramHeaderNo;
        NewDesignSectionParamLines."Line No." := LineNo;
        NewDesignSectionParamLines.Insert(true);
        //exit(NewDesignSection."Header Id");
    end;



    procedure CopyItemFeatures(var OldItemFeatures: Record "Item Features Param Lines"; var paramHeaderNo: Integer; LineNo: Integer)//: Integer
    var
        NewItemFeaturesParamLines: Record "Item Features Param Lines";
    //LastQtyAssignemtWizard: Record "Qty Assignment Wizard";
    begin
        NewItemFeaturesParamLines.Reset();
        NewItemFeaturesParamLines.Init();
        NewItemFeaturesParamLines.TransferFields(OldItemFeatures, false, true);
        NewItemFeaturesParamLines."Header ID" := paramHeaderNo;
        NewItemFeaturesParamLines."Line No." := LineNo;
        NewItemFeaturesParamLines.Insert(true);
        //exit(NewDesignSection."Header Id");
    end;

    procedure CopyItemBranding(var OldItemBranding: Record "Item Branding Param Lines"; var paramHeaderNo: Integer)//: Integer
    var
        NewItemBrandingParamLines: Record "Item Branding Param Lines";
    //LastQtyAssignemtWizard: Record "Qty Assignment Wizard";
    begin
        NewItemBrandingParamLines.Reset();
        NewItemBrandingParamLines.Init();
        NewItemBrandingParamLines.TransferFields(OldItemBranding, false, true);
        NewItemBrandingParamLines."Header ID" := paramHeaderNo;
        NewItemBrandingParamLines.Insert(true);
        //exit(NewDesignSection."Header Id");
    end;


    // procedure CopyNeededRM(var OldNeededRM: Record "Needed Raw Material"; BatchNo: Integer; IDNo: Integer; ParamHeaderNo: Integer; LineNo: Integer; DocumentNo: Code[10])//: Integer
    // var
    //     NewNeededRM: Record "Needed Raw Material";
    // begin
    //     NewNeededRM.Reset();
    //     NewNeededRM.Init();
    //     NewNeededRM.TransferFields(OldNeededRM, false, true);
    //     NewNeededRM.Batch := BatchNo;
    //     NewNeededRM.ID := IDNo;
    //     NewNeededRM."Paramertes Header ID" := ParamHeaderNo;
    //     NewNeededRM."Sales Order No." := DocumentNo;
    //     NewNeededRM."Sales Order Line No." := LineNo;
    //     NewNeededRM.Insert(true);
    // end;

    procedure CopyWizardPosition(var OldWizardPosition: Record "Wizard Positions"; var paramHeaderNo: Integer)//: Integer
    var
        NewWizardPosition: Record "Wizard Positions";
    //LastQtyAssignemtWizard: Record "Qty Assignment Wizard";
    begin
        NewWizardPosition.Reset();
        NewWizardPosition.Init();
        NewWizardPosition.TransferFields(OldWizardPosition);
        NewWizardPosition."Parameter Header Id" := paramHeaderNo;
        NewWizardPosition.Insert(true);
        //exit(NewDesignSection."Header Id");
    end;

    procedure CopyWizardStaff(var OldWizardStaff: Record "Wizard Staff"; var paramHeaderNo: Integer)//: Integer
    var
        NewWizardStaff: Record "Wizard Staff";
    //LastQtyAssignemtWizard: Record "Qty Assignment Wizard";
    begin
        NewWizardStaff.Reset();
        NewWizardStaff.Init();
        NewWizardStaff.TransferFields(OldWizardStaff);
        NewWizardStaff."Parameter Header Id" := paramHeaderNo;
        NewWizardStaff.Insert(true);
        //exit(NewDesignSection."Header Id");
    end;

    var
        //SalesLineNo: Integer;
        //ParamHeaderPar: Record "Parameter Header";
        Management: Codeunit "Management";
}
