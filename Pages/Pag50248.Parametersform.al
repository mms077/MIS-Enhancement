page 50248 "Parameters Form"
{
    Caption = 'Parameters Form';
    PageType = Document;
    SourceTable = "Parameter Header";
    RefreshOnActivate = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    //Editable = false;
    layout
    {
        area(content)
        {
            Group(General)
            {
                Editable = false;
                field("ID"; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Size"; Rec."Item Size")
                {
                    ApplicationArea = All;
                }
                field("Item Fit"; Rec."Item Fit")
                {
                    ApplicationArea = All;
                }
                field("Item Color ID"; Rec."Item Color ID")
                {
                    ApplicationArea = All;
                }
                field("Tonality Code"; Rec."Tonality Code")
                {
                    ApplicationArea = All;
                }
                /*field("Item Fabric Code"; Rec."Item Fabric Code")
                {
                    ApplicationArea = All;
                }*/
                field("Item Cut Code"; Rec."Item Cut")
                {
                    ApplicationArea = All;
                }
                /*field("Assembly Header"; Rec."Assembly No.")
                {
                    ApplicationArea = all;
                }*/
            }
            part("Design Section Parameter Lines"; "Design Section Param Lines")
            {
                Caption = 'Design Sections Color';
                ApplicationArea = basic, suite;
                SubPageLink = "Header ID" = field(ID);
                UpdatePropagation = Both;
                Editable = false;
            }
            part("Item Features Parameter Lines"; "Item Features Param Lines")
            {
                Caption = 'Item Features';
                ApplicationArea = basic, suite;
                SubPageLink = "Header ID" = field(ID);
                UpdatePropagation = Both;
            }
            part("Item Branding Parameter Lines"; "Item Branding Param Lines")
            {
                Caption = 'Item Brandings';
                ApplicationArea = basic, suite;
                SubPageLink = "Header ID" = field(ID);
                UpdatePropagation = Both;
                Editable = false;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateNeededRawMaterials)
            {
                Caption = 'Create Needed Raw Materials';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = false;
                trigger OnAction()
                var
                    NeededRMLoc: Record "Needed Raw Material";
                    DesignSectionParamHeader: Record "Parameter Header";
                    DesignSectionParamLine: Record "Design Section Param Lines";
                    SalesLineLoc: Record "Sales Line";
                    Txt001: Label 'An assembly has been already created for Item No. %1 in the Line No. %2';
                begin
                    //Check if an assambly is already created
                    SalesLineLoc.get(Rec."Sales Line Document Type", Rec."Sales Line Document No.", Rec."Sales Line No.");
                    SalesLineLoc.CalcFields("Assembly No.");
                    if SalesLineLoc."Assembly No." = '' then begin
                        //Create Needed RM for non unique design section colors for this item (Count of item design section color > 1)
                        CreateNeededRawMaterialForDesignSecParamLines;
                        //open related page fitered by batch 
                        NeededRMLoc.SetRange(Batch, BatchCounter);
                        if NeededRMLoc.FindFirst() then
                            Page.Run(Page::"Needed Raw Materials", NeededRMLoc);
                        CurrPage.Close();
                        //Delete Parameters Tables
                        /*if DesignSectionParamHeader.FindSet() then
                            DesignSectionParamHeader.DeleteAll();
                        if DesignSectionParamLine.FindSet() then
                            DesignSectionParamLine.DeleteAll();*/
                    end else
                        Error(Txt001, SalesLineLoc."No.", SalesLineLoc."Line No.");
                end;
            }
            action("Update Parameters Lines from Set")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = Action;
                trigger OnAction()
                begin
                    UpdateParameterLinesFromSet();
                end;
            }
            action("Update BULK Parameters Lines from Set")
            {
                ApplicationArea = all;
                Enabled = false;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = Action;
                trigger OnAction()
                begin
                    UpdateParameterLinesFromSetBulk();
                end;
            }
        }
    }

    procedure CreateNeededRawMaterialForDesignSecParamLines()
    var
        ItemDesignSectionColor: Record "Item Design Section Color";
        ItemDesingSecRMLoc: Record "Item Design Section RM";
        ItemLoc: Record Item;
        DesignDetail: Record "Design Detail";
        RawMaterial: Record "Raw Material";
        SalesLineLoc: Record "Sales Line";
        DesignSectionParamLines: Record "Design Section Param Lines";
        DesignSectionLoc: Record "Design Section";
        RMCategoryDesignSection: Record "RM Category Design Section";
        Design: Record Design;
    begin
        if NeededRawMaterial.FindLast() then begin
            Counter := NeededRawMaterial.ID + 1;
        end else begin
            Counter := 1;
        end;
        Clear(DesignSectionParamLines);
        DesignSectionParamLines.SetRange("Header ID", Rec.ID);
        if DesignSectionParamLines.FindSet() then begin
            repeat
                Clear(ItemLoc);
                ItemLoc.Get(Rec."Item No.");
                Clear(DesignDetail);
                DesignDetail.SetCurrentKey("Section Code", "Design Code", "Size Code", "Fit Code");
                DesignDetail.SetRange("Design Code", ItemLoc."Design Code");
                DesignDetail.SetRange("Size Code", Rec."Item Size");
                DesignDetail.SetRange("Fit Code", Rec."Item Fit");
                DesignDetail.SetRange("Design Section Code", DesignSectionParamLines."Design Section Code");
                if DesignDetail.FindSet() then begin
                    Clear(Design);
                    Design.Get(DesignDetail."Design Code");
                    repeat
                        //Get color from item color base on design section code
                        Clear(ItemDesignSectionColor);
                        ItemDesignSectionColor.SetRange("Item No.", Rec."Item No.");
                        ItemDesignSectionColor.SetRange("Design Section Code", DesignDetail."Design Section Code");
                        ItemDesignSectionColor.SetRange("Color ID", DesignSectionParamLines."Color ID");
                        /*ItemDesignSectionColor.CalcFields("Design Section Color Count");
                        ItemDesignSectionColor.Setfilter("Design Section Color Count", '>1');*/
                        if ItemDesignSectionColor.FindFirst() then;

                        //if design section have just one RM Category --> choose the default one
                        DesignSectionLoc.Get(DesignDetail."Design Section Code");
                        DesignSectionLoc.SetFilter("Design Type Filter", Design.Type);
                        DesignSectionLoc.CalcFields("Related RM Categories Count");
                        if DesignSectionLoc."Related RM Categories Count" = 1 then begin
                            RMCategoryDesignSection.SetRange("Design Section Code", DesignSectionLoc.Code);
                            RMCategoryDesignSection.FindFirst();
                            InitRawMaterialFromDesignSecParamLines(RMCategoryDesignSection."RM Category Code", DesignSectionParamLines, DesignDetail);
                        end else begin
                            //if design section have more than one RM Category ---> Get RM Category from item design section fabric base on design section code
                            Clear(ItemDesingSecRMLoc);
                            ItemDesingSecRMLoc.SetRange("Item No.", Rec."Item No.");
                            ItemDesingSecRMLoc.SetRange("Design Section Code", DesignDetail."Design Section Code");
                            if ItemDesingSecRMLoc.FindFirst() then
                                InitRawMaterialFromDesignSecParamLines(ItemDesingSecRMLoc."Raw Material Category", DesignSectionParamLines, DesignDetail);
                        end;
                    until DesignDetail.Next() = 0;
                end;
            until DesignSectionParamLines.Next() = 0;
        end;
    end;

    procedure GetInsertedDesignSectionColor(): Text[2048]
    var
        ItemDesignSecColor: Record "Item Design Section Color";
        PreviousDesignSection: Code[50];
        DesignSectionFilter: Text[2048];
    begin
        Clear(ItemDesignSecColor);
        ItemDesignSecColor.SetCurrentKey("Design Section Code");
        ItemDesignSecColor.SetRange("Item No.", Rec."Item No.");
        ItemDesignSecColor.SetRange("Item Color ID", Rec."Item Color ID");
        if ItemDesignSecColor.FindFirst() then
            repeat
                if PreviousDesignSection <> ItemDesignSecColor."Design Section Code" then begin
                    DesignSectionFilter := DesignSectionFilter + '<>' + ItemDesignSecColor."Design Section Code" + '&';
                end;
                PreviousDesignSection := ItemDesignSecColor."Design Section Code";
            until ItemDesignSecColor.Next() = 0;
        DesignSectionFilter := DELCHR("DesignSectionFilter", '>', '&');
        exit(DesignSectionFilter);
    end;

    procedure InitRawMaterialForNotInserted(RMCategoryCode: Code[50]; DesignDetail: Record "Design Detail")
    var
        SalesLineLoc: Record "Sales Line";
        RawMaterial: Record "Raw Material";
    begin
        Clear(RawMaterial);
        DesignDetail.CalcFields("UOM Code");
        //The Raw Material should be unique by Fabric and Color and tonality
        //RawMaterial.SetRange("Design Section Code", DesignDetail."Design Section Code");

        //disable filter on UOM and do the conversion
        //RawMaterial.SetRange("UOM Code", DesignDetail."UOM Code");
        RawMaterial.SetRange("Color ID", Rec."Item Color ID");
        RawMaterial.SetRange("Raw Material Category", RMCategoryCode);
        RawMaterial.SetRange("Tonality Code", '0');
        if RawMaterial.FindSet() then begin
            Clear(SalesLineLoc);
            SalesLineLoc.Get(Rec."Sales Line Document Type", Rec."Sales Line Document No.", Rec."Sales Line No.");
            repeat
                Clear(NeededRawMaterial);
                NeededRawMaterial.Init();
                NeededRawMaterial.ID := Counter;
                NeededRawMaterial."RM Code" := RawMaterial.Code;
                //Check if Raw Material has variant
                NeededRawMaterial."RM Variant Code" := CUManagement.CheckIfRawMaterialHasVariant(RawMaterial.Code, Rec);
                NeededRawMaterial."Color ID" := RawMaterial."Color ID";
                NeededRawMaterial."Tonality Code" := RawMaterial."Tonality Code";
                NeededRawMaterial."Design Detail Line No." := DesignDetail."Line No.";
                NeededRawMaterial."Design Detail Design Code" := DesignDetail."Design Code";
                NeededRawMaterial."Design Detail Section Code" := DesignDetail."Section Code";
                NeededRawMaterial."Design Detail Design Sec. Code" := DesignDetail."Design Section Code";
                NeededRawMaterial."Design Detail Fit Code" := DesignDetail."Fit Code";
                NeededRawMaterial."Design Detail Quantity" := DesignDetail.Quantity;
                NeededRawMaterial."Design Detail Size Code" := DesignDetail."Size Code";
                NeededRawMaterial."Design Detail UOM Code" := DesignDetail."UOM Code";

                //Calculate Qty per UOM of Raw Material
                ItemRM.Get(RawMaterial.Code);
                QtyPerUOMRM := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, RawMaterial."UOM Code");
                //Calculate Qty per UOM of Design Detail
                QtyPerUOMDesignDetail := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, DesignDetail."UOM Code");

                DerivedQty := (DesignDetail.Quantity * QtyPerUOMDesignDetail) / QtyPerUOMRM;
                DerivedQty := (DesignDetail.Quantity * QtyPerUOMDesignDetail) / QtyPerUOMRM;
                NeededRawMaterial."Raw Material Category" := RawMaterial."Raw Material Category";
                NeededRawMaterial."Sales Line Quantity" := SalesLineLoc."Quantity";
                NeededRawMaterial."Sales Line Item No." := SalesLineLoc."No.";
                NeededRawMaterial."Sales Line Location Code" := SalesLineLoc."Location Code";
                NeededRawMaterial."Sales Line UOM Code" := SalesLineLoc."Unit of Measure Code";
                NeededRawMaterial."Sales Order No." := SalesLineLoc."Document No.";
                NeededRawMaterial."Sales Order Line No." := SalesLineLoc."Line No.";
                NeededRawMaterial."Assembly Line Quantity" := SalesLineLoc.Quantity * DerivedQty;
                NeededRawMaterial."Assembly Line UOM Code" := RawMaterial."UOM Code";
                //Each set of raw material in one batch
                NeededRawMaterial.Batch := BatchCounter;
                //Add Parameters header Link
                NeededRawMaterial."Paramertes Header ID" := Rec.ID;
                NeededRawMaterial.Insert(true);
                Counter := Counter + 1;
            until RawMaterial.Next() = 0;
        end;
    end;

    procedure InitRawMaterialUnique(RMCategoryCode: Code[50]; ItemDesignSectionColor: Record "Item Design Section Color"; ItemDesingSecRMLoc: Record "Item Design Section RM"; DesignDetail: Record "Design Detail")
    var
        SalesLineLoc: Record "Sales Line";
        RawMaterial: Record "Raw Material";
    begin

        Clear(RawMaterial);
        DesignDetail.CalcFields("UOM Code");
        //The Raw Material should be unique by Fabric and Color
        //RawMaterial.SetRange("Design Section Code", DesignDetail."Design Section Code");

        //disable filter on UOM and do the conversion
        //RawMaterial.SetRange("UOM Code", DesignDetail."UOM Code");
        RawMaterial.SetRange("Color ID", ItemDesignSectionColor."Color ID");
        RawMaterial.SetRange("Tonality Code", ItemDesignSectionColor."Tonality Code");
        RawMaterial.SetRange("Raw Material Category", RMCategoryCode);
        if RawMaterial.FindSet() then begin
            Clear(SalesLineLoc);
            SalesLineLoc.Get(Rec."Sales Line Document Type", Rec."Sales Line Document No.", Rec."Sales Line No.");
            repeat
                Clear(NeededRawMaterial);
                NeededRawMaterial.Init();
                NeededRawMaterial.ID := Counter;
                NeededRawMaterial."RM Code" := RawMaterial.Code;
                //Check if Raw Material has variant
                NeededRawMaterial."RM Variant Code" := CUManagement.CheckIfRawMaterialHasVariant(RawMaterial.Code, Rec);
                NeededRawMaterial."Color ID" := RawMaterial."Color ID";
                NeededRawMaterial."Tonality Code" := RawMaterial."Tonality Code";
                NeededRawMaterial."Design Detail Line No." := DesignDetail."Line No.";
                NeededRawMaterial."Design Detail Design Code" := DesignDetail."Design Code";
                NeededRawMaterial."Design Detail Section Code" := DesignDetail."Section Code";
                NeededRawMaterial."Design Detail Design Sec. Code" := DesignDetail."Design Section Code";
                NeededRawMaterial."Design Detail Fit Code" := DesignDetail."Fit Code";
                NeededRawMaterial."Design Detail Quantity" := DesignDetail.Quantity;
                NeededRawMaterial."Design Detail Size Code" := DesignDetail."Size Code";
                NeededRawMaterial."Design Detail UOM Code" := DesignDetail."UOM Code";

                //NeededRawMaterial."Design Section" := RawMaterial."Design Section Code";
                NeededRawMaterial."Raw Material Category" := RawMaterial."Raw Material Category";

                //Calculate Qty per UOM of Raw Material
                ItemRM.Get(RawMaterial.Code);
                QtyPerUOMRM := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, RawMaterial."UOM Code");
                //Calculate Qty per UOM of Design Detail
                QtyPerUOMDesignDetail := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, DesignDetail."UOM Code");
                DerivedQty := (DesignDetail.Quantity * QtyPerUOMDesignDetail) / QtyPerUOMRM;

                NeededRawMaterial."Sales Line Quantity" := SalesLineLoc."Quantity";
                NeededRawMaterial."Sales Line Item No." := SalesLineLoc."No.";
                NeededRawMaterial."Sales Line Location Code" := SalesLineLoc."Location Code";
                NeededRawMaterial."Sales Line UOM Code" := SalesLineLoc."Unit of Measure Code";
                NeededRawMaterial."Sales Order No." := SalesLineLoc."Document No.";
                NeededRawMaterial."Sales Order Line No." := SalesLineLoc."Line No.";
                NeededRawMaterial."Assembly Line Quantity" := SalesLineLoc.Quantity * DerivedQty;
                NeededRawMaterial."Assembly Line UOM Code" := RawMaterial."UOM Code";
                //Each set of raw material in one batch
                NeededRawMaterial.Batch := BatchCounter;
                //Add Parameters header Link
                NeededRawMaterial."Paramertes Header ID" := Rec.ID;
                NeededRawMaterial.Insert(true);
                Counter := Counter + 1;
            until RawMaterial.Next() = 0;
        end;
    end;

    procedure InitRawMaterialFromDesignSecParamLines(RMCategoryCode: Code[50]; DesignSectionParamLines: Record "Design Section Param Lines"; DesignDetail: Record "Design Detail")
    var
        SalesLineLoc: Record "Sales Line";
        RawMaterial: Record "Raw Material";
    begin

        Clear(RawMaterial);
        DesignDetail.CalcFields("UOM Code");
        //The Raw Material should be unique by Fabric and Color
        //RawMaterial.SetRange("Design Section Code", DesignDetail."Design Section Code");

        //disable filter on UOM and do the conversion
        //RawMaterial.SetRange("UOM Code", DesignDetail."UOM Code");
        RawMaterial.SetRange("Color ID", DesignSectionParamLines."Color ID");
        RawMaterial.SetRange("Tonality Code", DesignSectionParamLines."Tonality Code");
        RawMaterial.SetRange("Raw Material Category", RMCategoryCode);
        if RawMaterial.FindSet() then begin
            Clear(SalesLineLoc);
            SalesLineLoc.Get(Rec."Sales Line Document Type", Rec."Sales Line Document No.", Rec."Sales Line No.");
            repeat
                Clear(NeededRawMaterial);
                NeededRawMaterial.Init();
                NeededRawMaterial.ID := Counter;
                NeededRawMaterial."RM Code" := RawMaterial.Code;
                //Check if Raw Material has variant
                NeededRawMaterial."RM Variant Code" := CUManagement.CheckIfRawMaterialHasVariant(RawMaterial.Code, Rec);
                NeededRawMaterial."Color ID" := RawMaterial."Color ID";
                NeededRawMaterial."Tonality Code" := RawMaterial."Tonality Code";
                NeededRawMaterial."Design Detail Line No." := DesignDetail."Line No.";
                NeededRawMaterial."Design Detail Design Code" := DesignDetail."Design Code";
                NeededRawMaterial."Design Detail Section Code" := DesignDetail."Section Code";
                NeededRawMaterial."Design Detail Design Sec. Code" := DesignDetail."Design Section Code";
                NeededRawMaterial."Design Detail Fit Code" := DesignDetail."Fit Code";
                NeededRawMaterial."Design Detail Quantity" := DesignDetail.Quantity;
                NeededRawMaterial."Design Detail Size Code" := DesignDetail."Size Code";
                NeededRawMaterial."Design Detail UOM Code" := DesignDetail."UOM Code";

                NeededRawMaterial."Raw Material Category" := RawMaterial."Raw Material Category";

                //Calculate Qty per UOM of Raw Material
                ItemRM.Get(RawMaterial.Code);
                QtyPerUOMRM := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, RawMaterial."UOM Code");
                //Calculate Qty per UOM of Design Detail
                QtyPerUOMDesignDetail := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, DesignDetail."UOM Code");
                DerivedQty := (DesignDetail.Quantity * QtyPerUOMDesignDetail) / QtyPerUOMRM;

                DerivedQty := (DesignDetail.Quantity * QtyPerUOMDesignDetail) / QtyPerUOMRM;
                NeededRawMaterial."Raw Material Category" := RawMaterial."Raw Material Category";
                NeededRawMaterial."Sales Line Quantity" := SalesLineLoc."Quantity";
                NeededRawMaterial."Sales Line Item No." := SalesLineLoc."No.";
                NeededRawMaterial."Sales Line Location Code" := SalesLineLoc."Location Code";
                NeededRawMaterial."Sales Line UOM Code" := SalesLineLoc."Unit of Measure Code";
                NeededRawMaterial."Sales Order No." := SalesLineLoc."Document No.";
                NeededRawMaterial."Sales Order Line No." := SalesLineLoc."Line No.";
                NeededRawMaterial."Assembly Line Quantity" := SalesLineLoc.Quantity * DerivedQty;
                NeededRawMaterial."Assembly Line UOM Code" := RawMaterial."UOM Code";
                //Each set of raw material in one batch
                NeededRawMaterial.Batch := BatchCounter;
                //Add Parameters header Link
                NeededRawMaterial."Paramertes Header ID" := Rec.ID;
                NeededRawMaterial.Insert(true);
                Counter := Counter + 1;
            until RawMaterial.Next() = 0;
        end;
    end;

    procedure UpdateParameterLinesFromSetBulk()
    var
        DesignSectionSet: Record "Design Sections Set";
        ItemFeatureSet: Record "Item Features Set";
        ItemBrandingSet: Record "Item Brandings Set";
        DesSecSetParLines: Record "Design Section Param Lines";
        ItemFeatureParLines: Record "Item Features Param Lines";
        ItemBrandParLines: Record "Item Branding Param Lines";
        ParameterHeader: Record "Parameter Header";
        ManagementCU: Codeunit Management;
        ModifyAction: Option "Insert","Modify";
        MasterItemCU: Codeunit MasterItem;
    begin
        Clear(ParameterHeader);
        if ParameterHeader.FindSet() then
            repeat
                if ParameterHeader."Design Sections Set ID" <> 0 then begin
                    Clear(DesSecSetParLines);
                    DesSecSetParLines.SetRange("Header ID", ParameterHeader.ID);
                    if DesSecSetParLines.FindSet() then
                        DesSecSetParLines.DeleteAll();
                    Clear(DesignSectionSet);
                    DesignSectionSet.SetRange("Design Section Set ID", ParameterHeader."Design Sections Set ID");
                    if DesignSectionSet.FindSet() then
                        repeat
                            Clear(DesSecSetParLines);
                            DesSecSetParLines.Init();
                            DesSecSetParLines."Header ID" := ParameterHeader.ID;
                            DesSecSetParLines."Design Section Code" := DesignSectionSet."Design Section Code";
                            DesSecSetParLines."Color ID" := DesignSectionSet."Color Id";
                            DesSecSetParLines."Tonality Code" := ParameterHeader."Tonality Code";
                            DesSecSetParLines.Insert(true);
                            ManagementCU.CheckDesignSectionRawMaterial(DesSecSetParLines, ParameterHeader, ModifyAction::Modify);
                        until DesignSectionSet.Next() = 0;
                end;
                if ParameterHeader."Item Features Set ID" <> 0 then begin
                    Clear(ItemFeatureParLines);
                    ItemFeatureParLines.SetRange("Header ID", ParameterHeader.ID);
                    if ItemFeatureParLines.FindSet() then
                        ItemFeatureParLines.DeleteAll();
                    Clear(ItemFeatureSet);
                    ItemFeatureSet.SetRange("Item Feature Set ID", ParameterHeader."Item Features Set ID");
                    if ItemFeatureSet.FindSet() then
                        repeat
                            Clear(ItemFeatureParLines);
                            ItemFeatureParLines.Init();
                            ItemFeatureParLines."Header ID" := ParameterHeader.ID;
                            ItemFeatureParLines."Feature Name" := ItemFeatureSet."Item Feature Name";
                            ItemFeatureParLines.Value := ItemFeatureSet.Value;
                            ItemFeatureParLines."Color ID" := ItemFeatureSet."Color Id";
                            ItemFeatureParLines.Insert(true);
                        until ItemFeatureSet.Next() = 0;
                end;
                if ParameterHeader."Item Brandings Set ID" <> 0 then begin
                    Clear(ItemBrandParLines);
                    ItemBrandParLines.SetRange("Header ID", ParameterHeader.ID);
                    if ItemBrandParLines.FindSet() then
                        ItemBrandParLines.DeleteAll();
                    Clear(ItemBrandingSet);
                    ItemBrandingSet.SetRange("Item Branding Set ID", ParameterHeader."Item Brandings Set ID");
                    if ItemBrandingSet.FindSet() then
                        repeat
                            Clear(ItemBrandParLines);
                            ItemBrandParLines.Init();
                            ItemBrandParLines."Header ID" := ParameterHeader.ID;
                            ItemBrandParLines.Code := ItemBrandingSet."Item Branding Code";
                            ItemBrandParLines.Insert(true);
                        until ItemBrandingSet.Next() = 0;
                end;
            until ParameterHeader.Next() = 0;
        Message('Done');
    end;

    procedure UpdateParameterLinesFromSet()
    var
        DesignSectionSet: Record "Design Sections Set";
        ItemFeatureSet: Record "Item Features Set";
        ItemBrandingSet: Record "Item Brandings Set";
        DesSecSetParLines: Record "Design Section Param Lines";
        ItemFeatureParLines: Record "Item Features Param Lines";
        ItemBrandParLines: Record "Item Branding Param Lines";
        ParameterHeader: Record "Parameter Header";
        ManagementCU: Codeunit Management;
        ModifyAction: Option "Insert","Modify";
        MasterItemCU: Codeunit MasterItem;
    begin
        Clear(ParameterHeader);
        ParameterHeader.SetRange(ID, Rec.ID);
        if ParameterHeader.FindFirst() then
            if ParameterHeader."Design Sections Set ID" <> 0 then begin
                Clear(DesSecSetParLines);
                DesSecSetParLines.SetRange("Header ID", ParameterHeader.ID);
                if DesSecSetParLines.FindSet() then
                    DesSecSetParLines.DeleteAll();
                Clear(DesignSectionSet);
                DesignSectionSet.SetRange("Design Section Set ID", ParameterHeader."Design Sections Set ID");
                if DesignSectionSet.FindSet() then
                    repeat
                        Clear(DesSecSetParLines);
                        DesSecSetParLines.Init();
                        DesSecSetParLines."Header ID" := ParameterHeader.ID;
                        DesSecSetParLines."Design Section Code" := DesignSectionSet."Design Section Code";
                        DesSecSetParLines."Color ID" := DesignSectionSet."Color Id";
                        DesSecSetParLines."Tonality Code" := ParameterHeader."Tonality Code";
                        DesSecSetParLines.Insert(true);
                        ManagementCU.CheckDesignSectionRawMaterial(DesSecSetParLines, ParameterHeader, ModifyAction::Modify);
                    until DesignSectionSet.Next() = 0;
            end;
        if ParameterHeader."Item Features Set ID" <> 0 then begin
            Clear(ItemFeatureParLines);
            ItemFeatureParLines.SetRange("Header ID", ParameterHeader.ID);
            if ItemFeatureParLines.FindSet() then
                ItemFeatureParLines.DeleteAll();
            Clear(ItemFeatureSet);
            ItemFeatureSet.SetRange("Item Feature Set ID", ParameterHeader."Item Features Set ID");
            if ItemFeatureSet.FindSet() then
                repeat
                    Clear(ItemFeatureParLines);
                    ItemFeatureParLines.Init();
                    ItemFeatureParLines."Header ID" := ParameterHeader.ID;
                    ItemFeatureParLines."Feature Name" := ItemFeatureSet."Item Feature Name";
                    ItemFeatureParLines.Value := ItemFeatureSet.Value;
                    ItemFeatureParLines."Color ID" := ItemFeatureSet."Color Id";
                    ItemFeatureParLines.Insert(true);
                until ItemFeatureSet.Next() = 0;
        end;
        if ParameterHeader."Item Brandings Set ID" <> 0 then begin
            Clear(ItemBrandParLines);
            ItemBrandParLines.SetRange("Header ID", ParameterHeader.ID);
            if ItemBrandParLines.FindSet() then
                ItemBrandParLines.DeleteAll();
            Clear(ItemBrandingSet);
            ItemBrandingSet.SetRange("Item Branding Set ID", ParameterHeader."Item Brandings Set ID");
            if ItemBrandingSet.FindSet() then
                repeat
                    Clear(ItemBrandParLines);
                    ItemBrandParLines.Init();
                    ItemBrandParLines."Header ID" := ParameterHeader.ID;
                    ItemBrandParLines.Code := ItemBrandingSet."Item Branding Code";
                    ItemBrandParLines.Insert(true);
                until ItemBrandingSet.Next() = 0;
        end;
        Message('Done');
    end;

    var
        NeededRawMaterial: Record "Needed Raw Material";
        BatchCounter: Integer;
        UOMManagement: Codeunit "Unit of Measure Management";
        QtyPerUOMRM: Decimal;
        QtyPerUOMDesignDetail: Decimal;
        DerivedQty: Decimal;
        ItemRM: Record Item;
        Counter: Integer;
        CUManagement: Codeunit Management;
}
