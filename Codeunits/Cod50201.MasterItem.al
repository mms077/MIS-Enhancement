codeunit 50201 MasterItem
{
    procedure GenerateEAN(

        ItemNo: Code[50]; VariantCode: Code[50]; UnitOfMeasure: Code[20])
    var
        Txt001: Label 'EAN Number %1 generated successfully for this item';
        Txt002: Label 'The EAN for this category has been exceeded';
        EAN: Text[30];
        Weight: Text[30];
        CheckSum: Integer;
        NewItemNo: Code[50];
        ItemReference: Record "Item Reference";
        ItemCategory: Record "Item Category";
        Item: Record Item;
        FormattedEAN: Text[50];
        EANInteger: BigInteger;
    begin
        Item.Get(ItemNo);
        //Dont Generate a new EAN if it's already generated
        if (GetItemEANNumber(Item, UnitOfMeasure) <> '') and (VariantCode = '') then
            exit;
        if Item."Item Category Code" <> '' then begin
            ItemCategory.Get(Item."Item Category Code");
            if ItemCategory."Ean Current" = 0 then begin
                //First Time
                FormattedEAN := format(ItemCategory."Ean Start");
                ItemCategory."Ean Current" := ItemCategory."Ean Start" + 1;
            end else begin
                //Not First Time
                FormattedEAN := format(ItemCategory."Ean Current");
                ItemCategory."Ean Current" := ItemCategory."Ean Current" + 1;
            end;

            if StrLen(FormattedEAN) <> 12 then
                NewItemNo := COPYSTR(FormattedEAN, 1, 12)
            else
                NewItemNo := FormattedEAN;
            Weight := '131313131313';
            CheckSum := StrCheckSum(NewItemNo, Weight);
            EAN := NewItemNo + Format(CheckSum);

            //Check if grater than max value
            Evaluate(EANInteger, COPYSTR(EAN, 1, 12));
            if EANInteger > ItemCategory."Ean Ending" then
                Error(Txt002);

            //Create Item Reference
            CreateItemReference(ItemNo, EAN, VariantCode, UnitOfMeasure);

            ItemCategory.Modify();
        end;
    end;

    procedure CreateItemReference(ItemNoPar: Code[50]; EANPar: Text[30]; VariantCodePar: Code[50]; UnitOfMeasurePar: Code[20])
    var
        ItemReference: Record "Item Reference";
        LastItemReference: Record "Item Reference";
        UniqueCode: Code[50];
        ParentGlobalSyncSetup: Record "Global Sync Setup";
        CurrentGlobalSyncSetup: Record "Global Sync Setup";
        GlobalSyncSetup: Record "Global Sync Setup";
        RecRef: RecordRef;
        GlobalSyncData: Codeunit "Global Sync Data";
        EntryType: Enum "Global Sync Log Entry Type";
        CurrentItemReference: Record "Item Reference";
        RecordOwner: Record "Record Owner";
    begin
        Clear(ParentGlobalSyncSetup);
        ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
        ParentGlobalSyncSetup.FindFirst();
        Clear(CurrentGlobalSyncSetup);
        CurrentGlobalSyncSetup.Get(CompanyName);
        if CurrentGlobalSyncSetup."Sync Type" = CurrentGlobalSyncSetup."Sync Type"::Child then
            ItemReference.ChangeCompany(ParentGlobalSyncSetup."Company Name");
        ItemReference.Init();
        ItemReference."Item No." := ItemNoPar;
        ItemReference."Reference Type" := ItemReference."Reference Type"::"Bar Code";
        ItemReference."Reference No." := EANPar;
        ItemReference."Variant Code" := VariantCodePar;
        ItemReference."Unit of Measure" := UnitOfMeasurePar;
        //Set unique code for each variant
        LastItemReference.SetCurrentKey("Unique Code");
        if LastItemReference.FindLast() then
            UniqueCode := IncStr(LastItemReference."Unique Code")
        else
            UniqueCode := 'BC-000000001';
        ItemReference."Unique Code" := UniqueCode;
        if CurrentGlobalSyncSetup."Sync Type" = CurrentGlobalSyncSetup."Sync Type"::Child then begin
            if ItemReference.Insert() then;
        end else
            if ItemReference.Insert(true) then;
        //If the company is child, create record owner for variant in the parent company
        if CurrentGlobalSyncSetup."Sync Type" = CurrentGlobalSyncSetup."Sync Type"::Child then begin
            RecordOwner.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            RecordOwner.Init();
            RecordOwner."Table No." := 5777;
            RecordOwner."Primary Key" := ItemReference.RecordId;
            RecordOwner."Primary Key Text" := Format(ItemReference.RecordId);
            RecordOwner."Company Name" := CompanyName;
            if RecordOwner.Insert() then;
        end;
        //If the company is child, create the logs to synch later
        if CurrentGlobalSyncSetup."Sync Type" = CurrentGlobalSyncSetup."Sync Type"::Child then begin
            //Change to parent company
            RecRef.Open(Database::"Item Reference");
            RecRef.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            RecRef.Get(ItemReference.RecordId);
            Clear(GlobalSyncSetup);
            GlobalSyncSetup.SetRange("Sync Type", GlobalSyncSetup."Sync Type"::Child);
            if GlobalSyncSetup.FindSet() then
                repeat
                    if GlobalSyncSetup."Company Name" = CompanyName then
                        GlobalSyncData.InitLogInsert(RecRef, RecRef, GlobalSyncSetup."Company Name", true)
                    else
                        GlobalSyncData.InitLogInsert(RecRef, RecRef, GlobalSyncSetup."Company Name", false)
                until GlobalSyncSetup.Next() = 0;
            CurrentItemReference := ItemReference;
            if CurrentItemReference.Insert(true) then;
        end;
    end;

    procedure CreateRMFromItem(Item: Record Item)
    var
        RawMaterial: Record "Raw Material";
        RMParamDialog: Page "Raw Material Parameters";
        DesignSection: Code[50];
        ColorID: Integer;
        FabricCode: Code[50];
        TonalityCode: Code[50];
        Txt001: Label 'Raw Material %1 created successfully!';
    begin
        if RMParamDialog.RunModal() = Action::OK then begin
            RMParamDialog.GetParameters(DesignSection, ColorID, FabricCode, TonalityCode);
            RawMaterial.Init();
            RawMaterial.Code := Item."No.";
            RawMaterial.Name := Item.Description;
            RawMaterial."UOM Code" := Item."Purch. Unit of Measure";
            RawMaterial."Raw Material Category" := FabricCode;
            //RawMaterial."Design Section Code" := DesignSection;
            RawMaterial."Color ID" := ColorID;
            RawMaterial."Tonality Code" := TonalityCode;
            RawMaterial.Insert();
            Message(Txt001, Item."No.")
        end else
            exit;
    end;

    procedure CanDeleteDesign(UserIDPar: Text[100]): boolean
    var
        UserSetup: Record "User Setup";
    begin
        Clear(UserSetup);
        if UserSetup.Get(UserIDPar) then
            if UserSetup."Delete Design" then
                exit(true);
        exit(false);
    end;

    procedure CanModifyAssembly(UserIDPar: Text[100]): boolean
    var
        UserSetup: Record "User Setup";
    begin
        Clear(UserSetup);
        if UserSetup.Get(UserIDPar) then
            if UserSetup."Modify Assembly" then
                exit(true);
        exit(false);
    end;

    procedure CanDeleteItem(UserIDPar: Text[100]): boolean
    var
        UserSetup: Record "User Setup";
    begin
        Clear(UserSetup);
        if UserSetup.Get(UserIDPar) then
            if UserSetup."Delete Item" then
                exit(true);
        exit(false);
    end;

    procedure UpdateUniqueCombination()
    var
        DesignSectionSet: Record "Design Sections Set";
        DesignSectionSet2: Record "Design Sections Set";
        ItemFeaturesSet: Record "Item Features Set";
        ItemFeaturesSet2: Record "Item Features Set";
        ItemBrandingsSet: Record "Item Brandings Set";
        ItemBrandingsSet2: Record "Item Brandings Set";
        SetId: Integer;
        UniqueCombination: Text;
    begin
        //Update DesignSectionSet Combination
        SetId := 0;
        UniqueCombination := '';
        DesignSectionSet.Reset();
        DesignSectionSet.SetCurrentKey("Design Section Set ID", "Design Section Code", "Color Id");
        if DesignSectionSet.FindFirst() then
            repeat
                if SetId <> DesignSectionSet."Design Section Set ID" then begin
                    UniqueCombination := '';
                    DesignSectionSet2.Reset();
                    DesignSectionSet2.SetCurrentKey("Design Section Set ID", "Design Section Code", "Color Id");
                    DesignSectionSet2.SetRange("Design Section Set ID", DesignSectionSet."Design Section Set ID");
                    if DesignSectionSet2.Findfirst() then
                        repeat
                            UniqueCombination := UniqueCombination + DesignSectionSet2."Design Section Code" + '-' + Format(DesignSectionSet2."Color ID") + '/';
                        until DesignSectionSet2.Next() = 0;
                    DesignSectionSet2.ModifyAll("Unique Combination", UniqueCombination);
                end;
                SetId := DesignSectionSet."Design Section Set ID";
            until DesignSectionSet.Next() = 0;

        //Update ItemFeaturesSet Combination
        SetId := 0;
        UniqueCombination := '';
        ItemFeaturesSet.Reset();
        ItemFeaturesSet.SetCurrentKey("Item Feature Set ID", "Item Feature Name", "Value", "Color Id");
        if ItemFeaturesSet.FindFirst() then
            repeat
                if SetId <> ItemFeaturesSet."Item Feature Set ID" then begin
                    UniqueCombination := '';
                    ItemFeaturesSet2.Reset();
                    ItemFeaturesSet2.SetCurrentKey("Item Feature Set ID", "Item Feature Name", "Value", "Color Id");
                    ItemFeaturesSet2.SetRange("Item Feature Set ID", ItemFeaturesSet."Item Feature Set ID");
                    if ItemFeaturesSet2.Findfirst() then
                        repeat
                            UniqueCombination := UniqueCombination + ItemFeaturesSet2."Item Feature Name" + '-' + ItemFeaturesSet2."Value" + '-' + Format(ItemFeaturesSet2."Color ID") + '/';
                        until ItemFeaturesSet2.Next() = 0;
                    ItemFeaturesSet2.ModifyAll("Unique Combination", UniqueCombination);
                end;
                SetId := ItemFeaturesSet."Item Feature Set ID";
            until ItemFeaturesSet.Next() = 0;

        //Update ItemBrandingsSet Comination
        SetId := 0;
        UniqueCombination := '';
        ItemBrandingsSet.Reset();
        ItemBrandingsSet.SetCurrentKey("Item Branding Set ID", "Item Branding Code", "Company Name");
        if ItemBrandingsSet.FindFirst() then
            repeat
                if SetId <> ItemBrandingsSet."Item Branding Set ID" then begin
                    UniqueCombination := '';
                    ItemBrandingsSet2.Reset();
                    ItemBrandingsSet2.SetCurrentKey("Item Branding Set ID", "Item Branding Code", "Company Name");
                    ItemBrandingsSet2.SetRange("Item Branding Set ID", ItemBrandingsSet."Item Branding Set ID");
                    if ItemBrandingsSet2.Findfirst() then
                        repeat
                            UniqueCombination := UniqueCombination + ItemBrandingsSet2."Item Branding Code" + '/';
                        until ItemBrandingsSet2.Next() = 0;
                    ItemBrandingsSet2.ModifyAll("Unique Combination", UniqueCombination);
                end;
                SetId := ItemBrandingsSet."Item Branding Set ID";
            until ItemBrandingsSet.Next() = 0;
    end;

    procedure GenerateDesignSectionSetID(var
                                             DesignSecLinesParHeader: Record "Parameter Header")
    var
        DesignSectionParameterLines: Record "Design Section Param Lines";
        DesignSectionsSet: Record "Design Sections Set";
        DesignSectionsSetPar: Record "Design Sections Set";
        SameCombination: Boolean;
        SamesDesignSectionSetID: Integer;
        VarianceCombination: Text[2048];
        VarianceCombinationDesignSet: Text[2048];
        Assigned: Boolean;
    begin
        Assigned := false;
        SameCombination := false;
        Clear(DesignSectionParameterLines);
        //Sort Parameters
        DesignSectionParameterLines.SetCurrentKey("Header ID", "Design Section Code", "Color ID");
        DesignSectionParameterLines.SetRange("Header ID", DesignSecLinesParHeader."ID");
        if DesignSectionParameterLines.FindFirst() then begin
            repeat
                VarianceCombination := VarianceCombination + DesignSectionParameterLines."Design Section Code" + '-' + Format(DesignSectionParameterLines."Color ID") + '/';
            until DesignSectionParameterLines.Next() = 0;
        end;

        //We added Unique Combination in table sets to just filter if this combination already exists
        Clear(DesignSectionsSet);
        DesignSectionsSet.SetRange("Unique Combination", VarianceCombination);
        if DesignSectionsSet.FindFirst() then
            AssignDesiSecSet(DesignSecLinesParHeader, DesignSectionsSet, VarianceCombination)
        else begin
            CreateNewDesignSectionSet(DesignSectionParameterLines, VarianceCombination, DesignSecLinesParHeader);
        end;

        /*DesignSectionParameterLines.CalcFields("Design Sections Count");
        //Sort DesignSectionsSet
        DesignSectionsSet.SetCurrentKey("Design Section Set ID", "Design Section Code", "Color ID");
        DesignSectionsSet.SetRange("Design Sections Count", DesignSectionParameterLines."Design Sections Count");
        if DesignSectionsSet.FindFirst() then begin
            SamesDesignSectionSetID := DesignSectionsSet."Design Section Set ID";
            repeat
                //Combine the variance for the same set
                if DesignSectionsSet."Design Section Set ID" = SamesDesignSectionSetID then begin
                    VarianceCombinationDesignSet := VarianceCombinationDesignSet + DesignSectionsSet."Design Section Code" + '-' + Format(DesignSectionsSet."Color ID") + '/';
                    SamesDesignSectionSetID := DesignSectionsSet."Design Section Set ID";

                    //Different Set
                end else begin
                    //If Deisgn Section Set Changed then compare the combination with latest one
                    if VarianceCombination = VarianceCombinationDesignSet then begin
                        SameCombination := true;
                        DesignSectionsSetPar.SetRange("Design Section Set ID", SamesDesignSectionSetID);
                        DesignSectionsSetPar.FindFirst();
                        AssignDesiSecSet(DesignSecLinesParHeader, DesignSectionsSetPar, VarianceCombination);
                        Assigned := true;
                        break;
                    end else begin
                        //clear the combination variable if different set to start
                        Clear(VarianceCombinationDesignSet);
                        VarianceCombinationDesignSet := VarianceCombinationDesignSet + DesignSectionsSet."Design Section Code" + '-' + Format(DesignSectionsSet."Color ID") + '/';
                        SamesDesignSectionSetID := DesignSectionsSet."Design Section Set ID";
                    end;
                end;
            until DesignSectionsSet.Next() = 0;
        end;

        //Not found similar combination
        if (SameCombination = false)
    //Just if the loop exit before comparing them
    and (VarianceCombination <> VarianceCombinationDesignSet) then
            CreateNewDesignSectionSet(DesignSectionParameterLines, VarianceCombination, DesignSecLinesParHeader)
        else
            if Assigned = false then begin
                SameCombination := true;
                DesignSectionsSetPar.SetRange("Design Section Set ID", SamesDesignSectionSetID);
                if DesignSectionsSetPar.FindFirst() then
                    AssignDesiSecSet(DesignSecLinesParHeader, DesignSectionsSetPar, VarianceCombination);
            end;*/
    end;

    //Parameter passed by reference "var DesignSecParHeader" so we can modify it
    procedure CreateNewDesignSectionSet(DesignSecParamLines: Record "Design Section Param Lines"; VarianceCombinationPar: Text[2048]; var DesignSecParHeader: Record "Parameter Header")
    var
        DesignSectionParLines: Record "Design Section Param Lines";
        DesignSectionsSet: Record "Design Sections Set";
        Number: Integer;
    begin
        Clear(DesignSectionParLines);
        DesignSectionParLines.SetCurrentKey("Header ID", "Design Section Code", "Color ID");
        DesignSectionParLines.SetRange("Header ID", DesignSecParamLines."Header ID");
        if DesignSectionParLines.FindFirst() then begin
            if DesignSectionsSet.FindLast() then
                Number := DesignSectionsSet."Design Section Set ID" + 1
            else
                Number := 1;
            repeat
                Clear(DesignSectionsSet);
                DesignSectionsSet.Init();
                DesignSectionsSet."Design Section Set ID" := Number;
                DesignSectionsSet."Design Section Code" := DesignSectionParLines."Design Section Code";
                DesignSectionsSet."Color Id" := DesignSectionParLines."Color ID";
                DesignSectionsSet."Unique Combination" := VarianceCombinationPar;
                DesignSectionsSet.Insert();
            until DesignSectionParLines.Next() = 0;
            DesignSecParHeader."Design Sections Set ID" := DesignSectionsSet."Design Section Set ID";
            DesignSecParHeader."Variance Combination Text" := DesignSecParHeader."Item Size" + '-'
                                                             + DesignSecParHeader."Item Fit" + '-'
                                                             + Format(DesignSecParHeader."Item Color Id") + '-'
                                                             + DesignSecParHeader."Item Cut" + '-'
                                                             + DesignSecParHeader."Tonality Code" + '-'
                                                             + Format(DesignSecParHeader."Design Sections Set ID") + '-'
                                                             + Format(DesignSecParHeader."Item Features Set ID") + '-'
                                                             + Format(DesignSecParHeader."Item Brandings Set ID");
            DesignSecParHeader.Modify();
        end;
    end;

    procedure CreateNewItemFeatureSet(ItemFeaturesParamLines: Record "Item Features Param Lines"; VarianceCombinationPar: Text[2048]; var DesignSecParHeader: Record "Parameter Header")
    var
        ItemFeaturesParLines: Record "Item Features Param Lines";
        ItemFeaturesSet: Record "Item Features Set";
        Number: Integer;
    begin
        Clear(ItemFeaturesParLines);
        ItemFeaturesParLines.SetCurrentKey("Header ID", "Feature Name", "Value", "Color ID");
        ItemFeaturesParLines.SetRange("Header ID", ItemFeaturesParamLines."Header ID");
        if ItemFeaturesParLines.FindFirst() then begin
            if ItemFeaturesSet.FindLast() then
                Number := ItemFeaturesSet."Item Feature Set ID" + 1
            else
                Number := 1;
            repeat
                Clear(ItemFeaturesSet);
                ItemFeaturesSet.Init();
                ItemFeaturesSet."Item Feature Set ID" := Number;
                ItemFeaturesSet."Item Feature Name" := ItemFeaturesParLines."Feature Name";
                ItemFeaturesSet.Value := ItemFeaturesParLines.Value;
                ItemFeaturesSet."Color Id" := ItemFeaturesParLines."Color ID";
                ItemFeaturesSet."Unique Combination" := VarianceCombinationPar;
                ItemFeaturesSet.Insert();
            until ItemFeaturesParLines.Next() = 0;
            DesignSecParHeader."Item Features Set ID" := ItemFeaturesSet."Item Feature Set ID";
            DesignSecParHeader."Variance Combination Text" := DesignSecParHeader."Item Size" + '-'
                                                             + DesignSecParHeader."Item Fit" + '-'
                                                             + Format(DesignSecParHeader."Item Color Id") + '-'
                                                             + DesignSecParHeader."Item Cut" + '-'
                                                             + DesignSecParHeader."Tonality Code" + '-'
                                                             + Format(DesignSecParHeader."Design Sections Set ID") + '-'
                                                             + Format(DesignSecParHeader."Item Features Set ID") + '-'
                                                             + Format(DesignSecParHeader."Item Brandings Set ID");
            DesignSecParHeader.Modify();
        end;
    end;

    procedure CreateNewItemBrandingSet(ItemBrandingParamLines: Record "Item Branding Param Lines"; VarianceCombinationPar: Text[2048]; var DesignSecParHeader: Record "Parameter Header")
    var
        ItemBrandingsParLines: Record "Item Branding Param Lines";
        ItemBrandingsSet: Record "Item Brandings Set";
        Number: Integer;
    begin
        Clear(ItemBrandingsParLines);
        ItemBrandingsParLines.SetCurrentKey("Header ID", Code);
        ItemBrandingsParLines.SetRange("Header ID", ItemBrandingParamLines."Header ID");
        ItemBrandingsParLines.SetRange(Include, true);
        if ItemBrandingsParLines.FindFirst() then begin
            if ItemBrandingsSet.FindLast() then
                Number := ItemBrandingsSet."Item Branding Set ID" + 1
            else
                Number := 1;
            repeat
                Clear(ItemBrandingsSet);
                ItemBrandingsSet.Init();
                ItemBrandingsSet."Item Branding Set ID" := Number;
                ItemBrandingsSet."Item Branding Code" := ItemBrandingsParLines.Code;
                ItemBrandingsSet."Company Name" := CompanyName;
                ItemBrandingsSet."Unique Combination" := VarianceCombinationPar;
                ItemBrandingsSet.Insert();
            until ItemBrandingsParLines.Next() = 0;
            DesignSecParHeader."Item Brandings Set ID" := ItemBrandingsSet."Item Branding Set ID";
            DesignSecParHeader."Variance Combination Text" := DesignSecParHeader."Item Size" + '-'
                                                             + DesignSecParHeader."Item Fit" + '-'
                                                             + Format(DesignSecParHeader."Item Color Id") + '-'
                                                             + DesignSecParHeader."Item Cut" + '-'
                                                             + DesignSecParHeader."Tonality Code" + '-'
                                                             + Format(DesignSecParHeader."Design Sections Set ID") + '-'
                                                             + Format(DesignSecParHeader."Item Features Set ID") + '-'
                                                             + Format(DesignSecParHeader."Item Brandings Set ID");
            DesignSecParHeader.Modify();
        end;
    end;

    procedure AssignDesiSecSet(var DesignSectionParHeader: Record "Parameter Header"; DesignSectSet: Record "Design Sections Set"; VarianceCombination: Text[2048])
    begin
        DesignSectionParHeader."Design Sections Set ID" := DesignSectSet."Design Section Set ID";
        DesignSectionParHeader."Variance Combination Text" := DesignSectionParHeader."Item Size" + '-'
                                                             + DesignSectionParHeader."Item Fit" + '-'
                                                             + Format(DesignSectionParHeader."Item Color Id") + '-'
                                                             + DesignSectionParHeader."Item Cut" + '-'
                                                             + DesignSectionParHeader."Tonality Code" + '-'
                                                             + Format(DesignSectionParHeader."Design Sections Set ID") + '-'
                                                             + Format(DesignSectionParHeader."Item Features Set ID") + '-'
                                                             + Format(DesignSectionParHeader."Item Brandings Set ID");
        DesignSectionParHeader.Modify();
    end;

    procedure AssignItemFeatureSet(var DesignSectionParHeader: Record "Parameter Header"; ItemFeaturesSet: Record "Item Features Set"; VarianceCombination: Text[2048])
    begin
        DesignSectionParHeader."Item Features Set ID" := ItemFeaturesSet."Item Feature Set ID";
        DesignSectionParHeader."Variance Combination Text" := DesignSectionParHeader."Item Size" + '-'
                                                             + DesignSectionParHeader."Item Fit" + '-'
                                                             + Format(DesignSectionParHeader."Item Color Id") + '-'
                                                             + DesignSectionParHeader."Item Cut" + '-'
                                                             + DesignSectionParHeader."Tonality Code" + '-'
                                                             + Format(DesignSectionParHeader."Design Sections Set ID") + '-'
                                                             + Format(DesignSectionParHeader."Item Features Set ID") + '-'
                                                             + Format(DesignSectionParHeader."Item Brandings Set ID");
        DesignSectionParHeader.Modify();
    end;

    procedure AssignItemBrandingSet(var DesignSectionParHeader: Record "Parameter Header"; ItemBrandingsSet: Record "Item Brandings Set"; VarianceCombination: Text[2048])
    begin
        DesignSectionParHeader."Item Brandings Set ID" := ItemBrandingsSet."Item Branding Set ID";
        DesignSectionParHeader."Variance Combination Text" := DesignSectionParHeader."Item Size" + '-'
                                                             + DesignSectionParHeader."Item Fit" + '-'
                                                             + Format(DesignSectionParHeader."Item Color Id") + '-'
                                                             + DesignSectionParHeader."Item Cut" + '-'
                                                             + DesignSectionParHeader."Tonality Code" + '-'
                                                             + Format(DesignSectionParHeader."Design Sections Set ID") + '-'
                                                             + Format(DesignSectionParHeader."Item Features Set ID") + '-'
                                                             + Format(DesignSectionParHeader."Item Brandings Set ID");
        DesignSectionParHeader.Modify();
    end;

    procedure CreateVariant(DesignSectionParHeader: Record "Parameter Header"): Code[10]
    var
        ItemVariant: Record "Item Variant";
        lastItemVariant: Record "Item Variant";
        ItemLocal: Record Item;
        ItemReference: Record "Item Reference";
        ItemUOM: Record "Item Unit of Measure";
        ParentGlobalSyncSetup: Record "Global Sync Setup";
        ChildGlobalSyncSetup: Record "Global Sync Setup";
        GlobalSyncSetup: Record "Global Sync Setup";
        NewCode: Code[10];
        NewID: Integer;
        MasterItemCU: Codeunit MasterItem;
        GlobalSyncData: Codeunit "Global Sync Data";
        RecRef: RecordRef;
        EntryType: Enum "Global Sync Log Entry Type";
        CurrentItemVariant: Record "Item Variant";
        RecordOwner: Record "Record Owner";
    begin
        Clear(ChildGlobalSyncSetup);
        ChildGlobalSyncSetup.Get(CompanyName);
        if ChildGlobalSyncSetup."Sync Type" = ChildGlobalSyncSetup."Sync Type"::Child then begin
            //Sync Log to insert any modifications from parent
            //Stopped because it needs Global Sync Admin user access
            //GlobalSyncData.Run();
            //Change to parent company
            Clear(ParentGlobalSyncSetup);
            ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
            ParentGlobalSyncSetup.FindFirst();
            ItemVariant.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            lastItemVariant.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            ItemLocal.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            ItemReference.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            ItemUOM.ChangeCompany(ParentGlobalSyncSetup."Company Name");
        end;
        ItemVariant.SetRange("Item No.", DesignSectionParHeader."Item No.");
        ItemVariant.SetRange("Item Size", DesignSectionParHeader."Item Size");
        ItemVariant.SetRange("Item Fit", DesignSectionParHeader."Item Fit");
        ItemVariant.SetRange("Item Color ID", DesignSectionParHeader."Item Color ID");
        ItemVariant.SetRange("Item Cut Code", DesignSectionParHeader."Item Cut");
        ItemVariant.SetRange("Tonality Code", DesignSectionParHeader."Tonality Code");
        ItemVariant.SetRange("Design Sections Set ID", DesignSectionParHeader."Design Sections Set ID");
        ItemVariant.SetRange("Item Features Set ID", DesignSectionParHeader."Item Features Set ID");
        ItemVariant.SetRange("Item Brandings Set ID", DesignSectionParHeader."Item Brandings Set ID");
        if not ItemVariant.FindFirst() then begin
            //Get Latest number if exist
            lastItemVariant.SetRange("Item No.", DesignSectionParHeader."Item No.");
            if lastItemVariant.FindLast() then begin
                NewCode := IncStr(lastItemVariant.Code);
                NewID := lastItemVariant.ID + 1
            end else begin
                NewCode := 'VAR-00001';
                NewID := 1;
            end;
            //Create New Variant
            Clear(ItemVariant);
            Clear(ChildGlobalSyncSetup);
            ChildGlobalSyncSetup.Get(CompanyName);
            if ChildGlobalSyncSetup."Sync Type" = ChildGlobalSyncSetup."Sync Type"::Child then
                ItemVariant.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            ItemVariant.Init();
            //for picture factbox relation use
            ItemVariant.ID := NewID;
            ItemVariant.Code := NewCode;
            ItemVariant."Item No." := DesignSectionParHeader."Item No.";
            ItemVariant."Item Size" := DesignSectionParHeader."Item Size";
            ItemVariant."Item Fit" := DesignSectionParHeader."Item Fit";
            ItemVariant."Item Color ID" := DesignSectionParHeader."Item Color ID";
            ItemVariant."Item Cut Code" := DesignSectionParHeader."Item Cut";
            ItemVariant."Tonality Code" := DesignSectionParHeader."Tonality Code";
            ItemVariant."Design Sections Set ID" := DesignSectionParHeader."Design Sections Set ID";
            ItemVariant."Item Features Set ID" := DesignSectionParHeader."Item Features Set ID";
            ItemVariant."Item Brandings Set ID" := DesignSectionParHeader."Item Brandings Set ID";
            if ItemLocal.Get(DesignSectionParHeader."Item No.") then
                ItemVariant.Description := ItemLocal.Description;
            ItemVariant."Variance Combination Text" := DesignSectionParHeader."Item Size" + '-'
                                                             + DesignSectionParHeader."Item Fit" + '-'
                                                             + Format(DesignSectionParHeader."Item Color Id") + '-'
                                                             + DesignSectionParHeader."Item Cut" + '-'
                                                             + DesignSectionParHeader."Tonality Code" + '-'
                                                             + Format(DesignSectionParHeader."Design Sections Set ID") + '-'
                                                             + Format(DesignSectionParHeader."Item Features Set ID") + '-'
                                                             + Format(DesignSectionParHeader."Item Brandings Set ID");
            ItemVariant.Insert();
            //If the company is child, create record owner for variant in the parent company
            if ChildGlobalSyncSetup."Sync Type" = ChildGlobalSyncSetup."Sync Type"::Child then begin
                RecordOwner.ChangeCompany(ParentGlobalSyncSetup."Company Name");
                RecordOwner.Init();
                RecordOwner."Table No." := 5401;
                RecordOwner."Primary Key" := ItemVariant.RecordId;
                RecordOwner."Primary Key Text" := Format(ItemVariant.RecordId);
                RecordOwner."Company Name" := CompanyName;
                RecordOwner.Insert();
            end;


            //If the company is child, create the logs for all children to synch later
            Clear(ChildGlobalSyncSetup);
            ChildGlobalSyncSetup.Get(CompanyName);
            if ChildGlobalSyncSetup."Sync Type" = ChildGlobalSyncSetup."Sync Type"::Child then begin
                //Change to parent company
                Clear(ParentGlobalSyncSetup);
                ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
                ParentGlobalSyncSetup.FindFirst();
                RecRef.Open(Database::"Item Variant");
                RecRef.ChangeCompany(ParentGlobalSyncSetup."Company Name");
                RecRef.Get(ItemVariant.RecordId);
                Clear(GlobalSyncSetup);
                GlobalSyncSetup.SetRange("Sync Type", GlobalSyncSetup."Sync Type"::Child);
                if GlobalSyncSetup.FindSet() then
                    repeat
                        if GlobalSyncSetup."Company Name" = CompanyName then
                            GlobalSyncData.InitLogInsert(RecRef, RecRef, GlobalSyncSetup."Company Name", true)
                        else
                            GlobalSyncData.InitLogInsert(RecRef, RecRef, GlobalSyncSetup."Company Name", false)
                    until GlobalSyncSetup.Next() = 0;
            end;
            //Create Item Reference - Barcode EAN Number
            Clear(ItemUOM);
            ItemUOM.SetRange("Item No.", ItemLocal."No.");
            if ItemUOM.FindSet() then
                repeat
                    //Get the EAN for the initial item
                    ItemReference.SetRange("Item No.", ItemLocal."No.");
                    ItemReference.SetFilter("Variant Code", '');
                    ItemReference.SetRange("Unit of Measure", ItemLocal."Base Unit of Measure");
                    if ItemReference.FindFirst() then
                        //For each UOM - For Each Variant - Same EAN as initial item
                        MasterItemCU.CreateItemReference(ItemLocal."No.", ItemVariant.Code + '-' + ItemUOM.Code, ItemVariant.Code, ItemUOM.Code)
                    else begin
                        //Generate EAN for initial Item
                        MasterItemCU.GenerateEAN(ItemLocal."No.", '', ItemLocal."Base Unit of Measure");
                        Clear(ItemReference);
                        ItemReference.SetRange("Item No.", ItemLocal."No.");
                        ItemReference.SetFilter("Variant Code", '');
                        ItemReference.SetRange("Unit of Measure", ItemLocal."Base Unit of Measure");
                        ItemReference.FindFirst();
                        MasterItemCU.CreateItemReference(ItemLocal."No.", ItemVariant.Code + '-' + ItemUOM.Code, ItemVariant.Code, ItemUOM.Code)
                    end;
                until ItemUOM.Next() = 0;

            //Insert in current company , late in logs it will just modify it
            Clear(ChildGlobalSyncSetup);
            ChildGlobalSyncSetup.Get(CompanyName);
            if ChildGlobalSyncSetup."Sync Type" = ChildGlobalSyncSetup."Sync Type"::Child then begin
                CurrentItemVariant := ItemVariant;
                CurrentItemVariant.Insert(true);
            end;

            exit(ItemVariant.Code);

        end else
            exit(ItemVariant.Code);


    end;

    procedure GenerateItemFeatureSetID(var DesignSecLinesParHeader: Record "Parameter Header")
    var
        ItemFeaturesParLines: Record "Item Features Param Lines";
        ItemFeatureSet: Record "Item Features Set";
        ItemFeatureSetPar: Record "Item Features Set";
        SameCombination: Boolean;
        SamesFeatureSetID: Integer;
        VarianceCombination: Text[2048];
        VarianceCombinationFeatureSet: Text[2048];
        Assigned: Boolean;
    begin
        Assigned := false;
        SameCombination := false;
        Clear(ItemFeaturesParLines);
        //Sort Parameters
        ItemFeaturesParLines.SetCurrentKey("Header ID", "Feature Name", "Value", "Color ID");
        ItemFeaturesParLines.SetRange("Header ID", DesignSecLinesParHeader."ID");
        if ItemFeaturesParLines.FindFirst() then begin
            repeat
                VarianceCombination := VarianceCombination + ItemFeaturesParLines."Feature Name" + '-' + ItemFeaturesParLines."Value" + '-' + Format(ItemFeaturesParLines."Color ID") + '/';
            until ItemFeaturesParLines.Next() = 0;
        end;

        //We added Unique Combination in table sets to just filter if this combination already exists
        Clear(ItemFeatureSet);
        ItemFeatureSet.SetRange("Unique Combination", VarianceCombination);
        if ItemFeatureSet.FindFirst() then
            AssignItemFeatureSet(DesignSecLinesParHeader, ItemFeatureSet, VarianceCombination)
        else begin
            CreateNewItemFeatureSet(ItemFeaturesParLines, VarianceCombination, DesignSecLinesParHeader);
        end;
        /*Clear(ItemFeatureSet);
        ItemFeaturesParLines.CalcFields("Item Features Count");
        //Sort ItemFeatures Set
        ItemFeatureSet.SetCurrentKey("Item Feature Set ID", "Item Feature Name", value, "Color ID");
        ItemFeatureSet.SetRange("Features Count", ItemFeaturesParLines."Item Features Count");
        if ItemFeatureSet.FindFirst() then begin
            SamesFeatureSetID := ItemFeatureSet."Item Feature Set ID";
            repeat
                //Combine the variance for the same set
                if ItemFeatureSet."Item Feature Set ID" = SamesFeatureSetID then begin
                    VarianceCombinationFeatureSet := VarianceCombinationFeatureSet + ItemFeatureSet."Item Feature Name" + '-' + ItemFeatureSet."Value" + '-' + Format(ItemFeatureSet."Color ID") + '/';
                    SamesFeatureSetID := ItemFeatureSet."Item Feature Set ID";

                    //Different Set
                end else begin
                    //If Item Features Set Changed then compare the combination with latest one
                    if VarianceCombination = VarianceCombinationFeatureSet then begin
                        SameCombination := true;
                        ItemFeatureSetPar.SetRange("Item Feature Set ID", SamesFeatureSetID);
                        ItemFeatureSetPar.FindFirst();
                        AssignItemFeatureSet(DesignSecLinesParHeader, ItemFeatureSetPar, VarianceCombination);
                        Assigned := true;
                        break;
                    end else begin
                        //clear the combination variable if different set to start
                        Clear(VarianceCombinationFeatureSet);
                        VarianceCombinationFeatureSet := VarianceCombinationFeatureSet + ItemFeatureSet."Item Feature Name" + '-' + ItemFeatureSet."Value" + '-' + Format(ItemFeatureSet."Color ID") + '/';
                        SamesFeatureSetID := ItemFeatureSet."Item Feature Set ID";
                    end;
                end;
            until ItemFeatureSet.Next() = 0;
        end;
        //Not found similar combination
        if (SameCombination = false)
        //Just if the loop exit before comparing them
        and (VarianceCombination <> VarianceCombinationFeatureSet) then
            CreateNewItemFeatureSet(ItemFeaturesParLines, VarianceCombination, DesignSecLinesParHeader)
        else
            if Assigned = false then begin
                SameCombination := true;
                ItemFeatureSetPar.SetRange("Item Feature Set ID", SamesFeatureSetID);
                If ItemFeatureSetPar.FindFirst() then
                    AssignItemFeatureSet(DesignSecLinesParHeader, ItemFeatureSetPar, VarianceCombination);
            end;*/
    end;

    procedure GenerateItemBrandingSetID(var DesignSecLinesParHeader: Record "Parameter Header")
    var
        ItemBrandingParLines: Record "Item Branding Param Lines";
        ItemBrandingsSet: Record "Item Brandings Set";
        ItemBrandingSetPar: Record "Item Brandings Set";
        SameCombination: Boolean;
        SamesBrandingSetID: Integer;
        VarianceCombination: Text[2048];
        VarianceCombinationBrandingSet: Text[2048];
        Assigned: Boolean;
    begin
        Assigned := false;
        SameCombination := false;
        Clear(ItemBrandingParLines);
        //Sort Parameters
        ItemBrandingParLines.SetCurrentKey("Header ID", Code);
        ItemBrandingParLines.SetRange("Header ID", DesignSecLinesParHeader."ID");
        ItemBrandingParLines.SetRange(Include, true);
        if ItemBrandingParLines.FindFirst() then begin
            repeat
                VarianceCombination := VarianceCombination + ItemBrandingParLines.Code + '/';
            until ItemBrandingParLines.Next() = 0;
        end;

        //We added Unique Combination in table sets to just filter if this combination already exists
        Clear(ItemBrandingsSet);
        ItemBrandingsSet.SetRange("Unique Combination", VarianceCombination);
        if ItemBrandingsSet.FindFirst() then
            AssignItemBrandingSet(DesignSecLinesParHeader, ItemBrandingsSet, VarianceCombination)
        else begin
            CreateNewItemBrandingSet(ItemBrandingParLines, VarianceCombination, DesignSecLinesParHeader);
        end;

        /*Clear(ItemBrandingsSet);
        ItemBrandingParLines.CalcFields("Brandings Count In Parameter");
        //Sort ItemBrandings Set
        ItemBrandingsSet.SetCurrentKey("Item Branding Set ID", "Item Branding Code");
        ItemBrandingsSet.SetRange("Brandings Count In Set", ItemBrandingParLines."Brandings Count In Parameter");
        ItemBrandingsSet.SetRange("Company Name", CompanyName);
        if ItemBrandingsSet.FindFirst() then begin
            SamesBrandingSetID := ItemBrandingsSet."Item Branding Set ID";
            repeat
                //Combine the variance for the same set
                if ItemBrandingsSet."Item Branding Set ID" = SamesBrandingSetID then begin
                    VarianceCombinationBrandingSet := VarianceCombinationBrandingSet + ItemBrandingsSet."Item Branding Code" + '/';
                    SamesBrandingSetID := ItemBrandingsSet."Item Branding Set ID";

                    //Different Set
                end else begin
                    //If Item Brandings Set Changed then compare the combination with latest one
                    if VarianceCombination = VarianceCombinationBrandingSet then begin
                        SameCombination := true;
                        ItemBrandingSetPar.SetRange("Item Branding Set ID", SamesBrandingSetID);
                        ItemBrandingSetPar.FindFirst();
                        AssignItemBrandingSet(DesignSecLinesParHeader, ItemBrandingSetPar, VarianceCombination);
                        Assigned := true;
                        break;
                    end else begin
                        //clear the combination variable if different set to start
                        Clear(VarianceCombinationBrandingSet);
                        VarianceCombinationBrandingSet := VarianceCombinationBrandingSet + ItemBrandingsSet."Item Branding Code" + '/';
                        SamesBrandingSetID := ItemBrandingsSet."Item Branding Set ID";
                    end;
                end;
            until ItemBrandingsSet.Next() = 0;
        end;
        //Not found similar combination
        if (SameCombination = false)
        //Just if the loop exit before comparing them
        and (VarianceCombination <> VarianceCombinationBrandingSet) then
            CreateNewItemBrandingSet(ItemBrandingParLines, VarianceCombination, DesignSecLinesParHeader)
        else
            if Assigned = false then begin
                SameCombination := true;
                ItemBrandingSetPar.SetRange("Item Branding Set ID", SamesBrandingSetID);
                If ItemBrandingSetPar.FindFirst() then
                    AssignItemBrandingSet(DesignSecLinesParHeader, ItemBrandingSetPar, VarianceCombination);
            end;*/
    end;

    procedure CheckUserResponibility(AssemblyNo: Code[20]; Username: Code[50])
    var
        CuttingSheetDashboard: Record "Cutting Sheets Dashboard";
        SalesRecivableSetup: Record "Sales & Receivables Setup";
        WorkflowUserGroupMemberER: Record "Workflow User Group Member-ER";
        Txt001: Label 'User is not existing in this workflow 👎';
        Txt002: Label 'You are not allowed to approve at this stage 👎';
    begin
        SalesRecivableSetup.Get();
        if not WorkflowUserGroupMemberER.Get(SalesRecivableSetup."Cutting Sheet Workflow Group", Username) then begin
            //To show the message to user before error
            Message(Txt001);
            Error(Txt001);
        end;
        CuttingSheetDashboard.Get(AssemblyNo);
        if CuttingSheetDashboard."Current Sequence No." <> WorkflowUserGroupMemberER."Sequence No." then begin
            //To show the message to user before error
            Message(Txt002);
            Error(Txt002);
        end;
    end;

    //procedure CheckUserResponibilityScanning(AssemblyNo: Code[20]; Username: Code[50]; CurrentSequence: Integer)
    procedure CheckUserResponibilityScanning(CurrentActivity: Code[50]; Username: Code[50])
    var
        SalesRecivableSetup: Record "Sales & Receivables Setup";
        WorkflowUserGroupMemberER: Record "Workflow User Memb-Scan";
        Txt001: Label 'User is not existing in this workflow 👎';
        Txt002: Label 'You are not allowed to approve at this stage 👎';
    begin
        if CurrentActivity = '' then
            Error('Please select stage to Scan');
        SalesRecivableSetup.Get();
        //if not WorkflowUserGroupMemberER.Get(SalesRecivableSetup."Cutting Sheet Workflow Group", Username) then begin
        //     //To show the message to user before error
        //     Message(Txt001);
        //     Error(Txt001);
        // end;
        // WorkflowUserGroupMemberER.Get(SalesRecivableSetup."Scanning Workflow Group", Username,ActivitySelected);
        WorkflowUserGroupMemberER.get(SalesRecivableSetup."Scanning Workflow Group", Username, CurrentActivity);
        if CurrentActivity <> WorkflowUserGroupMemberER."Activity Code" then begin
            //To show the message to user before error
            Message(Txt002);
            Error(Txt002);
        end;
    end;


    procedure CreateCuttingSheetScanningEntry2(AssemblyNoPar: Code[20]; UserName: Code[50]): Option "In","Out"
    var
        CuttingSheetScanningDetails: Record "Cutting Sheet Scanning Details";
        ScanType: Option "Scan In","Scan Out";
        CuttingSheetDashboard: Record "Cutting Sheets Dashboard";
        ScanActivities: Record "Scan Activities";
        AssemblyHeader: Record "Assembly Header";
        Item: Record Item;
        Txt001: Label 'Scan In 👍';
        Txt002: Label 'Scan Out 👍';
        Txt003: Label 'No Scan Activities found for Design "%1" and Sequence "%2".';
        Txt004: Label 'Invalid sequence for Scan Out. Expected sequence: %1.';
        ScanOption: Option "In","Out";
        CurrentActivity: Text[100];
    begin
        // Get the Assembly Header for the assembly
        if not AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, AssemblyNoPar) then
            Error('No Assembly Header found for Assembly "%1".', AssemblyNoPar);

        // Get the item associated with the assembly
        if not Item.Get(AssemblyHeader."Item No.") then
            Error('Item "%1" does not exist.', AssemblyHeader."Item No.");

        // Validate the design code
        if Item."Design Code" = '' then
            Error('No Design Code found for Item "%1".', Item."No.");
        CuttingSheetDashboard.Get(AssemblyNoPar);
        // Fetch the scan activities for the design and current sequence
        ScanActivities.SetRange("Design Code", Item."Design Code");
        ScanActivities.SetRange("Sequence No.", CuttingSheetDashboard."Current Sequence No.");
        if not ScanActivities.FindFirst() then
            Error(Txt003, Item."Design Code", CuttingSheetDashboard."Current Sequence No.");

        // Get the current activity name
        CurrentActivity := ScanActivities."Activity Name";

        // Check the last scan type (In or Out)
        CuttingSheetScanningDetails.SetRange("Assembly No.", AssemblyNoPar);
        if CuttingSheetScanningDetails.FindLast() then begin
            if CuttingSheetScanningDetails."Scan Type" = CuttingSheetScanningDetails."Scan Type"::"Scan In" then begin
                // Validate sequence for Scan Out
                if CuttingSheetDashboard."Current Sequence No." <> ScanActivities."Sequence No." then
                    Error(Txt004, ScanActivities."Sequence No.");

                // Create Cutting Sheet Scanning Details for OUT
                CreateCuttingSheetScanningDetails(AssemblyNoPar, ScanType::"Scan Out", UserName);

                // Update Dashboard
                CuttingSheetDashboard.CalcFields("Total Sequence");
                if CuttingSheetDashboard."Total Sequence" <> CuttingSheetDashboard."Current Sequence No." then
                    UpdateDashboardFields(CuttingSheetDashboard, ScanType::"Scan Out", false, CuttingSheetScanningDetailsCreated)
                else begin
                    CuttingSheetDashboard."Ending Time" := CurrentDateTime;
                    UpdateDashboardFields(CuttingSheetDashboard, ScanType::"Scan Out", false, CuttingSheetScanningDetailsCreated);
                end;

                exit(ScanOption::"Out");
                Message(Txt002);
            end else begin
                // Create Cutting Sheet Scanning Details for IN (Not First Time)
                CreateCuttingSheetScanningDetails(AssemblyNoPar, ScanType::"Scan In", UserName);

                // Update Dashboard
                UpdateDashboardFields(CuttingSheetDashboard, ScanType::"Scan In", false, CuttingSheetScanningDetailsCreated);

                exit(ScanOption::"In");
                Message(Txt001);
            end;
        end else begin
            // Create Cutting Sheet Scanning Details for IN (First Scan)
            CreateCuttingSheetScanningDetails(AssemblyNoPar, ScanType::"Scan In", UserName);

            // Update Dashboard
            CuttingSheetDashboard."Starting Time" := CurrentDateTime;
            UpdateDashboardFields(CuttingSheetDashboard, ScanType::"Scan In", false, CuttingSheetScanningDetailsCreated);

            exit(ScanOption::"In");
            Message(Txt001);
        end;
    end;

    procedure CreateCuttingSheetScanningEntry(AssemblyNoPar: Code[20]; UserName: code[50]): Option "In","Out"
    var
        CuttingSheetScanningDetails: Record "Cutting Sheet Scanning Details";
        ScanType: Option "Scan In","Scan Out";
        CuttingSheetDashboard: Record "Cutting Sheets Dashboard";
        Txt001: Label 'Scan In 👍';
        Txt002: Label 'Scan Out 👍';
        ScanOption: Option "In","Out";
    begin
        CuttingSheetScanningDetails.SetRange("Assembly No.", AssemblyNoPar);
        //Check last entry if existed if it's IN or Out
        if CuttingSheetScanningDetails.FindLast() then
            if CuttingSheetScanningDetails."Scan Type" = CuttingSheetScanningDetails."Scan Type"::"Scan In" then begin
                //Create Cutting Sheet Scanning Details for OUT
                CreateCuttingSheetScanningDetails(AssemblyNoPar, ScanType::"Scan Out", UserName);
                //Update Dashboard
                CuttingSheetDashboard.Get(AssemblyNoPar);
                CuttingSheetDashboard.CalcFields("Total Sequence");
                //Not Last Approval
                if CuttingSheetDashboard."Total Sequence" <> CuttingSheetDashboard."Current Sequence No." then begin
                    UpdateDashboardFields(CuttingSheetDashboard, ScanType::"Scan Out", false, CuttingSheetScanningDetailsCreated);
                end
                //Last Approval
                else begin
                    CuttingSheetDashboard."Ending Time" := CurrentDateTime;
                    UpdateDashboardFields(CuttingSheetDashboard, ScanType::"Scan Out", false, CuttingSheetScanningDetailsCreated);
                    //CuttingSheetDashboard.Modify();
                end;
                exit(ScanOption::"Out");
                Message(Txt002);
            end
            //Last Scan was Scan Out
            else begin
                //Create Cutting Sheet Scanning Details for IN  (Not First Time)
                CreateCuttingSheetScanningDetails(AssemblyNoPar, ScanType::"Scan In", UserName);
                //Update Dashboard
                CuttingSheetDashboard.Get(AssemblyNoPar);
                UpdateDashboardFields(CuttingSheetDashboard, ScanType::"Scan In", false, CuttingSheetScanningDetailsCreated);
                exit(ScanOption::"In");
                Message(Txt001);
            end
        else begin
            //Create Cutting Sheet Scanning Details for IN first Scan
            CreateCuttingSheetScanningDetails(AssemblyNoPar, ScanType::"Scan In", UserName);
            //Update Dashboard
            CuttingSheetDashboard.Get(AssemblyNoPar);
            CuttingSheetDashboard."Starting Time" := CurrentDateTime;
            UpdateDashboardFields(CuttingSheetDashboard, ScanType::"Scan In", false, CuttingSheetScanningDetailsCreated);
            exit(ScanOption::"In");
            Message(Txt001);
        end;
    end;

    procedure CreateCuttingSheetScanningEntryScanActivities(WorkflowActivitiesER: Record "Workflow Activities - ER"; AssemblyNoPar: Code[20]; UserName: code[50]): Option "In","Out"
    var
        CuttingSheetScanningDetails: Record "Cutting Sheet Scanning Details";
        ScanType: Option "Scan In","Scan Out";
        CuttingSheetDashboard: Record "Cutting Sheets Dashboard";
        Txt001: Label 'Scan In 👍';
        Txt002: Label 'Scan Out 👍';
        ScanOption: Option "In","Out";
    begin
        CuttingSheetScanningDetails.SetRange("Assembly No.", AssemblyNoPar);
        //Check last entry if existed if it's IN or Out
        if CuttingSheetScanningDetails.FindLast() then
            if CuttingSheetScanningDetails."Scan Type" = CuttingSheetScanningDetails."Scan Type"::"Scan In" then begin
                //Create Cutting Sheet Scanning Details for OUT
                CreateCuttingSheetScanningDetails(AssemblyNoPar, ScanType::"Scan Out", UserName);
                //Update Dashboard
                CuttingSheetDashboard.Get(AssemblyNoPar);
                CuttingSheetDashboard.CalcFields("Total Sequence");
                //Not Last Approval
                if CuttingSheetDashboard."Total Sequence" <> CuttingSheetDashboard."Current Sequence No." then begin
                    UpdateDashboardFields2(WorkflowActivitiesER, CuttingSheetDashboard, ScanType::"Scan Out", false, CuttingSheetScanningDetailsCreated);
                end
                //Last Approval
                else begin
                    CuttingSheetDashboard."Ending Time" := CurrentDateTime;
                    UpdateDashboardFields2(WorkflowActivitiesER, CuttingSheetDashboard, ScanType::"Scan Out", false, CuttingSheetScanningDetailsCreated);
                    //CuttingSheetDashboard.Modify();
                end;
                exit(ScanOption::"Out");
                Message(Txt002);
            end
            //Last Scan was Scan Out
            else begin
                //Create Cutting Sheet Scanning Details for IN  (Not First Time)
                CreateCuttingSheetScanningDetails(AssemblyNoPar, ScanType::"Scan In", UserName);
                //Update Dashboard
                CuttingSheetDashboard.Get(AssemblyNoPar);
                UpdateDashboardFields2(WorkflowActivitiesER, CuttingSheetDashboard, ScanType::"Scan In", false, CuttingSheetScanningDetailsCreated);
                exit(ScanOption::"In");
                Message(Txt001);
            end
        else begin
            //Create Cutting Sheet Scanning Details for IN first Scan
            CreateCuttingSheetScanningDetails(AssemblyNoPar, ScanType::"Scan In", UserName);
            //Update Dashboard
            CuttingSheetDashboard.Get(AssemblyNoPar);
            CuttingSheetDashboard."Starting Time" := CurrentDateTime;
            UpdateDashboardFields2(WorkflowActivitiesER, CuttingSheetDashboard, ScanType::"Scan In", false, CuttingSheetScanningDetailsCreated);
            exit(ScanOption::"In");
            Message(Txt001);
        end;
    end;

    procedure CreateCuttingSheetScanningDetails(AssemblyNoPar: code[20]; ScanType: Option "Scan In","Scan Out"; UserName: Code[50])
    var
    begin
        Clear(CuttingSheetScanningDetailsCreated);
        CuttingSheetScanningDetailsCreated.Init();
        CuttingSheetScanningDetailsCreated."Assembly No." := AssemblyNoPar;
        if ScanType = ScanType::"Scan In" then
            CuttingSheetScanningDetailsCreated."Scan Type" := CuttingSheetScanningDetailsCreated."Scan Type"::"Scan In"
        else begin
            CheckLastCheckIn(AssemblyNoPar);
            CuttingSheetScanningDetailsCreated."Scan Type" := CuttingSheetScanningDetailsCreated."Scan Type"::"Scan Out";
        end;
        CuttingSheetScanningDetailsCreated.UserName := UserName;
        CuttingSheetScanningDetailsCreated.Insert();
    end;

    procedure UpdateDashboardFields(var CuttingSheetDashboard: Record "Cutting Sheets Dashboard"; ScanType: Option "Scan In","Scan Out"; LastScan: Boolean; var CuttSheetScanDetailsPar: Record "Cutting Sheet Scanning Details")
    var
        FieldCaption1: Integer;
        FieldCaption2: Integer;
        FieldCaption3: Integer;
        FieldCaption4: Integer;
        FieldCaption5: Integer;
        FieldCaption6: Integer;
        FieldCaption7: Integer;
        ERManufacturingOrder: Record "ER - Manufacturing Order";
    begin
        Evaluate(FieldCaption1, CuttingSheetDashboard.FIELDCAPTION("1"));
        Evaluate(FieldCaption2, CuttingSheetDashboard.FIELDCAPTION("2"));
        Evaluate(FieldCaption3, CuttingSheetDashboard.FIELDCAPTION("3"));
        Evaluate(FieldCaption4, CuttingSheetDashboard.FIELDCAPTION("4"));
        Evaluate(FieldCaption5, CuttingSheetDashboard.FIELDCAPTION("5"));
        Evaluate(FieldCaption6, CuttingSheetDashboard.FIELDCAPTION("6"));
        Evaluate(FieldCaption7, CuttingSheetDashboard.FIELDCAPTION("7"));
        case CuttingSheetDashboard."Current Sequence No." of
            1:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then
                        CuttingSheetDashboard."1" := CuttingSheetDashboard."1"::"IN"
                    else begin
                        CuttingSheetDashboard."1" := CuttingSheetDashboard."1"::"OUT"
                    end
                end;
            2:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then
                        CuttingSheetDashboard."2" := CuttingSheetDashboard."2"::"IN"
                    else
                        CuttingSheetDashboard."2" := CuttingSheetDashboard."2"::"OUT"
                end;
            3:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then
                        CuttingSheetDashboard."3" := CuttingSheetDashboard."3"::"IN"
                    else
                        CuttingSheetDashboard."3" := CuttingSheetDashboard."3"::"OUT"
                end;
            4:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then begin
                        CuttingSheetDashboard."4" := CuttingSheetDashboard."4"::"IN";
                        //Open Links related to this item
                        OpenItemLinks(CuttingSheetDashboard);
                    end else
                        CuttingSheetDashboard."4" := CuttingSheetDashboard."4"::"OUT"
                end;
            5:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then
                        CuttingSheetDashboard."5" := CuttingSheetDashboard."5"::"IN"
                    else
                        CuttingSheetDashboard."5" := CuttingSheetDashboard."5"::"OUT"
                end;
            6:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then
                        CuttingSheetDashboard."6" := CuttingSheetDashboard."6"::"IN"
                    else
                        CuttingSheetDashboard."6" := CuttingSheetDashboard."6"::"OUT"
                end;
            7:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then
                        CuttingSheetDashboard."7" := CuttingSheetDashboard."7"::"IN"
                    else begin
                        CuttingSheetDashboard."7" := CuttingSheetDashboard."7"::"OUT";
                        CuttingSheetDashboard.CalcFields("ER - Manufacturing Order No.");
                        ERManufacturingOrder.Get(CuttingSheetDashboard."ER - Manufacturing Order No.");
                        ERManufacturingOrder.Status := ERManufacturingOrder.Status::Closed;
                    end;
                end;
        end;

        if ScanType = ScanType::"Scan Out" then begin
            CuttingSheetDashboard.CalcFields("Total Sequence", "ER - Manufacturing Order No.");
            //Last stage dont add sequence number
            if CuttingSheetDashboard."Current Sequence No." <> CuttingSheetDashboard."Total Sequence" then begin
                //Skip the embroidery if not available
                if (CuttingSheetDashboard."Current Sequence No." = 2) and (CuttingSheetDashboard."3" = CuttingSheetDashboard."3"::"Not Available") then
                    CuttingSheetDashboard."Current Sequence No." := CuttingSheetDashboard."Current Sequence No." + 2
                else
                    CuttingSheetDashboard."Current Sequence No." := CuttingSheetDashboard."Current Sequence No." + 1;

                //Update ER Manufacturing Order Current Sequence
                ERManufacturingOrder.Get(CuttingSheetDashboard."ER - Manufacturing Order No.");
                ERManufacturingOrder."Current Sequence No." := CuttingSheetDashboard."Current Sequence No.";
            end;
        end;
        /* else
            CuttingSheetDashboard."Scanned In" := true;*/
        if ERManufacturingOrder.Modify(true) then;
        CuttingSheetDashboard.Modify();
    end;

    procedure UpdateDashboardFields2(var WorkflowActivitiesER: Record "Workflow Activities - ER"; var CuttingSheetDashboard: Record "Cutting Sheets Dashboard"; ScanType: Option "Scan In","Scan Out"; LastScan: Boolean; var CuttSheetScanDetailsPar: Record "Cutting Sheet Scanning Details")
    var
        FieldCaption1: Integer;
        FieldCaption2: Integer;
        FieldCaption3: Integer;
        FieldCaption4: Integer;
        FieldCaption5: Integer;
        FieldCaption6: Integer;
        FieldCaption7: Integer;
        ERManufacturingOrder: Record "ER - Manufacturing Order";
    begin
        Evaluate(FieldCaption1, CuttingSheetDashboard.FIELDCAPTION("1"));
        Evaluate(FieldCaption2, CuttingSheetDashboard.FIELDCAPTION("2"));
        Evaluate(FieldCaption3, CuttingSheetDashboard.FIELDCAPTION("3"));
        Evaluate(FieldCaption4, CuttingSheetDashboard.FIELDCAPTION("4"));
        Evaluate(FieldCaption5, CuttingSheetDashboard.FIELDCAPTION("5"));
        Evaluate(FieldCaption6, CuttingSheetDashboard.FIELDCAPTION("6"));
        Evaluate(FieldCaption7, CuttingSheetDashboard.FIELDCAPTION("7"));

        case WorkflowActivitiesER."Workflow User Group Sequence" of
            1:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then
                        CuttingSheetDashboard."1" := CuttingSheetDashboard."1"::"IN"
                    else begin
                        CuttingSheetDashboard."1" := CuttingSheetDashboard."1"::"OUT"
                    end
                end;
            2:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then
                        CuttingSheetDashboard."2" := CuttingSheetDashboard."2"::"IN"
                    else
                        CuttingSheetDashboard."2" := CuttingSheetDashboard."2"::"OUT"
                end;
            3:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then
                        CuttingSheetDashboard."3" := CuttingSheetDashboard."3"::"IN"
                    else
                        CuttingSheetDashboard."3" := CuttingSheetDashboard."3"::"OUT"
                end;
            4:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then begin
                        CuttingSheetDashboard."4" := CuttingSheetDashboard."4"::"IN";
                        //Open Links related to this item
                        OpenItemLinks(CuttingSheetDashboard);
                    end else
                        CuttingSheetDashboard."4" := CuttingSheetDashboard."4"::"OUT"
                end;
            5:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then
                        CuttingSheetDashboard."5" := CuttingSheetDashboard."5"::"IN"
                    else
                        CuttingSheetDashboard."5" := CuttingSheetDashboard."5"::"OUT"
                end;
            6:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then
                        CuttingSheetDashboard."6" := CuttingSheetDashboard."6"::"IN"
                    else
                        CuttingSheetDashboard."6" := CuttingSheetDashboard."6"::"OUT"
                end;
            7:
                begin
                    CuttSheetScanDetailsPar."Sequence No." := CuttingSheetDashboard."Current Sequence No.";
                    CuttSheetScanDetailsPar.Modify();
                    if ScanType = ScanType::"Scan In" then
                        CuttingSheetDashboard."7" := CuttingSheetDashboard."7"::"IN"
                    else
                        CuttingSheetDashboard."7" := CuttingSheetDashboard."7"::"OUT";
                    // CuttingSheetDashboard.CalcFields("ER - Manufacturing Order No.");
                    // ERManufacturingOrder.Get(CuttingSheetDashboard."ER - Manufacturing Order No.");
                    // ERManufacturingOrder.Status := ERManufacturingOrder.Status::Closed;

                end;
        end;

        if ScanType = ScanType::"Scan Out" then begin
            CuttingSheetDashboard.CalcFields("Total Sequence", "ER - Manufacturing Order No.");
            //Last stage dont add sequence number
            if CuttingSheetDashboard."Current Sequence No." <> CuttingSheetDashboard."Total Sequence" then begin
                //Skip the embroidery if not available
                if (CuttingSheetDashboard."Current Sequence No." = 2) and (CuttingSheetDashboard."3" = CuttingSheetDashboard."3"::"Not Available") then
                    CuttingSheetDashboard."Current Sequence No." := CuttingSheetDashboard."Current Sequence No." + 2
                else
                    CuttingSheetDashboard."Current Sequence No." := CuttingSheetDashboard."Current Sequence No." + 1;

                //Update ER Manufacturing Order Current Sequence
                ERManufacturingOrder.Get(CuttingSheetDashboard."ER - Manufacturing Order No.");
                ERManufacturingOrder."Current Sequence No." := CuttingSheetDashboard."Current Sequence No.";
            end;
        end;
        /* else
            CuttingSheetDashboard."Scanned In" := true;*/
        if ERManufacturingOrder.Modify(true) then;
        CuttingSheetDashboard.Modify();
    end;

    procedure CreateDesignPlotting(ParameterHeader: Record "Parameter Header")
    var
        DesignPlotting: Record "Design Plotting";
        Item: Record Item;
        Design: Record Design;
        LastDesignPlotting: Record "Design Plotting";
        LastId: Integer;
        /*ParentGlobalSyncSetup: Record "Global Sync Setup";
CurrentGlobalSyncSetup: Record "Global Sync Setup";
RecordOwner: record "Record Owner";
RecRef: RecordRef;
GlobalSyncSetup: Record "Global Sync Setup";
GlobalSyncData: Codeunit "Global Sync Data";*/
        CurrentDesignPloting: Record "Design Plotting";
    begin
        Item.get(ParameterHeader."Item No.");
        Design.Get(Item."Design Code");
        if DesignPlotting.Get(Design.Code, ParameterHeader."Item Size", ParameterHeader."Item Fit") then
            CreatePlottingFiles(DesignPlotting, ParameterHeader)
        //Create Design Plotting
        else begin

            /*Clear(ParentGlobalSyncSetup);
            ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
            ParentGlobalSyncSetup.FindFirst();
            Clear(CurrentGlobalSyncSetup);
            CurrentGlobalSyncSetup.Get(CompanyName);
            if CurrentGlobalSyncSetup."Sync Type" = CurrentGlobalSyncSetup."Sync Type"::Child then
                DesignPlotting.ChangeCompany(ParentGlobalSyncSetup."Company Name");*/
            DesignPlotting.Init();
            DesignPlotting."Design Code" := Design.Code;
            DesignPlotting.Size := ParameterHeader."Item Size";
            DesignPlotting.Fit := ParameterHeader."Item Fit";


            //LastDesignPlotting.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            LastDesignPlotting.SetCurrentKey("id");
            if LastDesignPlotting.FindLast() then
                LastId := LastDesignPlotting.id
            else
                LastId := 0;
            DesignPlotting."Id" := LastId + 1;
            /*if CurrentGlobalSyncSetup."Sync Type" = CurrentGlobalSyncSetup."Sync Type"::Child then begin
                if DesignPlotting.Insert() then;
            end else*/
            if DesignPlotting.Insert(true) then;
            //If the company is child, create record owner for variant in the parent company
            /*if CurrentGlobalSyncSetup."Sync Type" = CurrentGlobalSyncSetup."Sync Type"::Child then begin
                RecordOwner.ChangeCompany(ParentGlobalSyncSetup."Company Name");
                RecordOwner.Init();
                RecordOwner."Table No." := 50245;
                RecordOwner."Primary Key" := DesignPlotting.RecordId;
                RecordOwner."Primary Key Text" := Format(DesignPlotting.RecordId);
                RecordOwner."Company Name" := CompanyName;
                if RecordOwner.Insert() then;
            end;*/
            //If the company is child, create the logs to synch later
            /*if CurrentGlobalSyncSetup."Sync Type" = CurrentGlobalSyncSetup."Sync Type"::Child then begin
                //Change to parent company
                RecRef.Open(Database::"Design Plotting");
                RecRef.ChangeCompany(ParentGlobalSyncSetup."Company Name");
                RecRef.Get(DesignPlotting.RecordId);
                Clear(GlobalSyncSetup);
                GlobalSyncSetup.SetRange("Sync Type", GlobalSyncSetup."Sync Type"::Child);
                if GlobalSyncSetup.FindSet() then
                    repeat
                        if GlobalSyncSetup."Company Name" = CompanyName then
                            GlobalSyncData.InitLogInsert(RecRef, RecRef, GlobalSyncSetup."Company Name", true)
                        else
                            GlobalSyncData.InitLogInsert(RecRef, RecRef, GlobalSyncSetup."Company Name", false);
                    until GlobalSyncSetup.Next() = 0;
                CurrentDesignPloting := DesignPlotting;
                if CurrentDesignPloting.Insert(true) then;
            end;*/
            CreatePlottingFiles(DesignPlotting, ParameterHeader);
        end;
    end;

    procedure CreatePlottingFiles(DesignPlottingPar: Record "Design Plotting"; ParameterHeader: Record "Parameter Header")
    var
        PlottingFile: Record "Plotting File";
        LastPlottingFile: Record "Plotting File";
        LastId: Integer;
        /*ParentGlobalSyncSetup: Record "Global Sync Setup";
        CurrentGlobalSyncSetup: Record "Global Sync Setup";
        RecordOwner: record "Record Owner";
        RecRef: RecordRef;
        GlobalSyncSetup: Record "Global Sync Setup";
        GlobalSyncData: Codeunit "Global Sync Data";*/
        CurrentPlottingFile: Record "Plotting File";
        AffectPlotting: Boolean;
    begin
        /*Clear(ParentGlobalSyncSetup);
        ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
        ParentGlobalSyncSetup.FindFirst();
        Clear(CurrentGlobalSyncSetup);
        CurrentGlobalSyncSetup.Get(CompanyName);
        if CurrentGlobalSyncSetup."Sync Type" = CurrentGlobalSyncSetup."Sync Type"::Child then
            PlottingFile.ChangeCompany(ParentGlobalSyncSetup."Company Name");*/

        //Check if there is any feature affect the plotting file
        AffectPlotting := CheckIfFeatureAffectPlotting(ParameterHeader."Item Features Set ID");
        PlottingFile.Init();
        PlottingFile."Design Plotting ID" := DesignPlottingPar.ID;
        PlottingFile.Size := DesignPlottingPar.Size;
        PlottingFile.Fit := DesignPlottingPar.Fit;
        PlottingFile.Cut := ParameterHeader."Item Cut";
        if AffectPlotting then
            PlottingFile."Item Features Set" := ParameterHeader."Item Features Set ID";


        //LastPlottingFile.ChangeCompany(ParentGlobalSyncSetup."Company Name");
        LastPlottingFile.SetCurrentKey("id");
        if LastPlottingFile.FindLast() then
            LastId := LastPlottingFile.id
        else
            LastId := 0;
        PlottingFile."Id" := LastId + 1;
        /*if CurrentGlobalSyncSetup."Sync Type" = CurrentGlobalSyncSetup."Sync Type"::Child then begin
            if PlottingFile.Insert() then;
        end else*/
        if PlottingFile.Insert(true) then;
        //If the company is child, create record owner for variant in the parent company
        /*if CurrentGlobalSyncSetup."Sync Type" = CurrentGlobalSyncSetup."Sync Type"::Child then begin
            RecordOwner.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            RecordOwner.Init();
            RecordOwner."Table No." := 50246;
            RecordOwner."Primary Key" := PlottingFile.RecordId;
            RecordOwner."Primary Key Text" := Format(PlottingFile.RecordId);
            RecordOwner."Company Name" := CompanyName;
            if RecordOwner.Insert() then;
        end;
        //If the company is child, create the logs to synch later
        if CurrentGlobalSyncSetup."Sync Type" = CurrentGlobalSyncSetup."Sync Type"::Child then begin
            //Change to parent company
            RecRef.Open(Database::"Plotting File");
            RecRef.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            RecRef.Get(PlottingFile.RecordId);
            Clear(GlobalSyncSetup);
            GlobalSyncSetup.SetRange("Sync Type", GlobalSyncSetup."Sync Type"::Child);
            if GlobalSyncSetup.FindSet() then
                repeat
                    if GlobalSyncSetup."Company Name" = CompanyName then
                        GlobalSyncData.InitLogInsert(RecRef, RecRef, GlobalSyncSetup."Company Name", true)
                    else
                        GlobalSyncData.InitLogInsert(RecRef, RecRef, GlobalSyncSetup."Company Name", false);
                until GlobalSyncSetup.Next() = 0;
            CurrentPlottingFile := PlottingFile;
            if CurrentPlottingFile.Insert(true) then;
        end;*/
    end;

    procedure CheckLastCheckIn(AssemblyNo: Code[50])
    var
        CuttingSheetScanningDetails: Record "Cutting Sheet Scanning Details";
        SalesReceivableSetup: Record "Sales & Receivables Setup";
        Txt001: Label 'The minimum wait time between scan in and scan out is not exceeded yet';
        Difference: Decimal;
    begin
        SalesReceivableSetup.Get();
        CuttingSheetScanningDetails.SetRange("Assembly No.", AssemblyNo);
        CuttingSheetScanningDetails.SetRange("Scan Type", CuttingSheetScanningDetails."Scan Type"::"Scan In");
        if CuttingSheetScanningDetails.FindLast() then begin
            //  SalesReceivableSetup.TestField("Scan In/Out Interval");
            Difference := (CurrentDateTime - CuttingSheetScanningDetails.SystemCreatedAt) / 60000;
            if Difference < SalesReceivableSetup."Scan In/Out Interval" then
                Error(Txt001);
        end;
    end;

    procedure GenerateParameterHeader(ItemVariantPar: Record "Item Variant"; var SalesLinePar: Record "Sales Line")
    var
        ParameterHeader: Record "Parameter Header";
        ManagementCU: Codeunit Management;
        NeededRawMaterial: Record "Needed Raw Material";
        SalesHeader: Record "Sales Header";
        SalesLineUnitRef: Record "Sales Line Unit Ref.";
        Counter: Integer;
    begin
        if SalesHeader.Get(SalesLinePar."Document Type", SalesLinePar."Document No.") then;
        ParameterHeader.Init();
        ParameterHeader."Item No." := ItemVariantPar."Item No.";
        ParameterHeader."Item Size" := ItemVariantPar."Item Size";
        ParameterHeader."Item Fit" := ItemVariantPar."Item Fit";
        ParameterHeader."Item Color ID" := ItemVariantPar."Item Color ID";
        ParameterHeader."Item Cut" := ItemVariantPar."Item Cut Code";
        ParameterHeader."Tonality Code" := ItemVariantPar."Tonality Code";
        ParameterHeader."Design Sections Set ID" := ItemVariantPar."Design Sections Set ID";
        ParameterHeader."Variance Combination Text" := ItemVariantPar."Variance Combination Text";
        ParameterHeader."Item Features Set ID" := ItemVariantPar."Item Features Set ID";
        ParameterHeader."Item Brandings Set ID" := ItemVariantPar."Item Brandings Set ID";
        ParameterHeader."Sales Line No." := SalesLinePar."Line No.";
        ParameterHeader."Sales Line Document No." := SalesLinePar."Document No.";
        ParameterHeader."Sales Line Document Type" := SalesLinePar."Document Type";
        ParameterHeader."Sales Line Quantity" := SalesLinePar.Quantity;
        ParameterHeader."Sales Line UOM" := SalesLinePar."Unit of Measure Code";
        ParameterHeader."Sales Line Location Code" := SalesLinePar."Location Code";
        ParameterHeader."Customer No." := SalesLinePar."Sell-to Customer No.";
        ParameterHeader.Insert();

        UpdateParameterLinesFromSet(ItemVariantPar, ParameterHeader);

        /*ManagementCU.CreateDesignSectionParameterLines(ParameterHeader);
        ManagementCU.CreateItemBrandingParameterLines(ParameterHeader);
        ManagementCU.CreateItemFeaturesParameterLines(ParameterHeader);*/
        ManagementCU.CreateNeededRawMaterial(ParameterHeader);

        Clear(NeededRawMaterial);
        NeededRawMaterial.SetRange("Paramertes Header ID", ParameterHeader.ID);
        if NeededRawMaterial.FindFirst() then
            SalesLinePar."Needed RM Batch" := NeededRawMaterial.Batch;

        SalesLinePar.Validate("Parameters Header ID", ParameterHeader.ID);
    end;

    Procedure TransferParameterDataToChildren(ParameterHeader: Record "Parameter Header"; var ChildParameterHeader: Record "Parameter Header")
    var
        QtyAssignmentWizard: Record "Qty Assignment Wizard";
        ChildId: Integer;
        ChildSize: Code[50];
        ChildFit: Code[50];
        ChildCut: Code[50];
        ChildQty: Decimal;
    begin
        Commit();
        Clear(QtyAssignmentWizard);
        QtyAssignmentWizard.SetRange("Parent Header Id", ParameterHeader.ID);
        if QtyAssignmentWizard.FindSet() then
            repeat
                UpdateChildParameterHeader(QtyAssignmentWizard, ParameterHeader);
            //ChildParameterHeader.Rename(ChildId);
            until QtyAssignmentWizard.Next() = 0;
    end;

    procedure AllowShowCost(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if UserSetup."Show Cost" then
            exit(true)
        else
            exit(false);
    end;

    procedure AllowShowSalesPrice(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if UserSetup."Show Sales Price" then
            exit(true)
        else
            exit(false);
    end;

    procedure UpdateChildParameterHeader(var QtyAssignmentWizard: Record "Qty Assignment Wizard"; ParameterHeader: Record "Parameter Header")
    var
        ChildId: Integer;
        ChildSize: Code[50];
        ChildFit: Code[50];
        ChildCut: Code[50];
        ChildQty: Decimal;
        ChildParameterHeader: Record "Parameter Header";
        ChildParameterHeader2: Record "Parameter Header";
        SalesLine: Record "Sales Line";
    begin
        Clear(ChildParameterHeader);
        ChildParameterHeader.Get(QtyAssignmentWizard."Header Id");
        //ChildParameterHeader.TransferFields(ParameterHeader);
        ChildParameterHeader."Item No." := ParameterHeader."Item No.";
        ChildParameterHeader."Item Size" := ChildParameterHeader."Item Size";
        ChildParameterHeader."Item Fit" := ChildParameterHeader."Item Fit";
        ChildParameterHeader."Item Cut" := ChildParameterHeader."Item Cut";
        ChildParameterHeader."Quantity To Assign" := ChildParameterHeader."Quantity To Assign";
        ChildParameterHeader."Sales Line Quantity" := ChildParameterHeader."Quantity To Assign";
        ChildParameterHeader."Item Color ID" := ParameterHeader."Item Color ID";
        ChildParameterHeader."Item Fabric Code" := ParameterHeader."Item Fabric Code";
        ChildParameterHeader."Tonality Code" := ParameterHeader."Tonality Code";
        ChildParameterHeader."Design Sections Set ID" := ParameterHeader."Design Sections Set ID";
        ChildParameterHeader."Variance Combination Text" := ParameterHeader."Variance Combination Text";
        ChildParameterHeader."Customer No." := ParameterHeader."Customer No.";
        ChildParameterHeader."Item Features Set ID" := ParameterHeader."Item Features Set ID";
        ChildParameterHeader."Item Brandings Set ID" := ParameterHeader."Item Brandings Set ID";
        SalesLine.SetRange("Parameters Header ID", ChildParameterHeader.ID);
        if SalesLine.FindFirst() then begin
            ChildParameterHeader."Sales Line No." := SalesLine."Line No.";
            ChildParameterHeader."Sales Line Quantity" := SalesLine.Quantity;
            ChildParameterHeader."Sales Line UOM" := SalesLine."Unit of Measure Code";
            ChildParameterHeader."Sales Line Location Code" := SalesLine."Location Code";
            ChildParameterHeader."Sales Line Unit Price" := SalesLine."Unit Price";
            ChildParameterHeader."Sales Line Amount" := SalesLine.Amount;
            ChildParameterHeader."Sales Line Line Amount" := SalesLine."Line Amount";
            ChildParameterHeader."Sales Line Amount Incl. VAT" := SalesLine."Amount Including VAT";
            ChildParameterHeader."Extra Charge %" := SalesLine."Extra Charge %";
            ChildParameterHeader."Extra Charge Amount" := SalesLine."Extra Charge Amount";
            ChildParameterHeader."Sales Line Discount %" := SalesLine."Line Discount %";
            ChildParameterHeader."Sales Line Discount Amount" := SalesLine."Line Discount Amount";
        end;
        ChildParameterHeader.Modify(true);
    end;

    procedure GetItemEANNumber(ItemPar: Record Item; UnitOfMeasurePar: Code[20]): Code[50]
    var
        ItemReference: Record "Item Reference";
    begin
        Clear(ItemReference);
        ItemReference.SetRange("Item No.", ItemPar."No.");
        ItemReference.SetRange("Variant Code", '');
        ItemReference.SetRange("Unit of Measure", UnitOfMeasurePar);
        ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::"Bar Code");
        if ItemReference.FindFirst() then
            if ItemReference."Reference No." <> '' then
                exit(ItemReference."Reference No.");
        exit('');
    end;

    procedure CheckLedgerEditorAccess(): Boolean
    var
        UserSetup: Record "User Setup";
        Txt001: Label 'You do not have access to editor';
    begin
        Clear(UserSetup);
        UserSetup.Get(UserId);
        if not UserSetup."Ledger Editor Access" then
            Error(Txt001);
    end;

    procedure CheckIfFeatureAffectPlotting(FeatureSetID: Integer): Boolean
    var
        ItemFeatureSet: Record "Item Features Set";
        ItemFeaturePossibleValue: Record "Item Feature Possible Values";
    begin
        Clear(ItemFeatureSet);
        ItemFeatureSet.SetRange("Item Feature Set ID", FeatureSetID);
        if ItemFeatureSet.FindSet() then
            repeat
                Clear(ItemFeaturePossibleValue);
                ItemFeaturePossibleValue.SetRange("Feature Name", ItemFeatureSet."Item Feature Name");
                if ItemFeaturePossibleValue.FindSet() then
                    repeat
                        if ItemFeaturePossibleValue."Affect Plotting" then
                            exit(true);
                    until ItemFeaturePossibleValue.Next() = 0;
            until ItemFeatureSet.Next() = 0;
        exit(false);
    end;

    procedure UpdateParameterLinesFromSet(ItemVariantPar: Record "Item Variant"; ParameHeaderPar: Record "Parameter Header")
    var
        DesignSectionSet: Record "Design Sections Set";
        ItemFeatureSet: Record "Item Features Set";
        ItemBrandingSet: Record "Item Brandings Set";
        DesSecSetParLines: Record "Design Section Param Lines";
        ItemFeatureParLines: Record "Item Features Param Lines";
        ItemBrandParLines: Record "Item Branding Param Lines";
        ManagementCU: Codeunit Management;
        ModifyAction: Option "Insert","Modify";
        MasterItemCU: Codeunit MasterItem;
    begin
        if ParameHeaderPar."Design Sections Set ID" <> 0 then begin
            Clear(DesSecSetParLines);
            DesSecSetParLines.SetRange("Header ID", ParameHeaderPar.ID);
            if DesSecSetParLines.FindSet() then
                DesSecSetParLines.DeleteAll();
            Clear(DesignSectionSet);
            DesignSectionSet.SetRange("Design Section Set ID", ParameHeaderPar."Design Sections Set ID");
            if DesignSectionSet.FindSet() then
                repeat
                    Clear(DesSecSetParLines);
                    DesSecSetParLines.Init();
                    DesSecSetParLines."Header ID" := ParameHeaderPar.ID;
                    DesSecSetParLines."Design Section Code" := DesignSectionSet."Design Section Code";
                    DesSecSetParLines."Color ID" := DesignSectionSet."Color Id";
                    DesSecSetParLines."Tonality Code" := ParameHeaderPar."Tonality Code";
                    DesSecSetParLines.Insert(true);
                    ManagementCU.CheckDesignSectionRawMaterial(DesSecSetParLines, ParameHeaderPar, ModifyAction::Modify);
                until DesignSectionSet.Next() = 0;
        end;
        if ParameHeaderPar."Item Features Set ID" <> 0 then begin
            Clear(ItemFeatureParLines);
            ItemFeatureParLines.SetRange("Header ID", ParameHeaderPar.ID);
            if ItemFeatureParLines.FindSet() then
                ItemFeatureParLines.DeleteAll();
            Clear(ItemFeatureSet);
            ItemFeatureSet.SetRange("Item Feature Set ID", ParameHeaderPar."Item Features Set ID");
            if ItemFeatureSet.FindSet() then
                repeat
                    Clear(ItemFeatureParLines);
                    ItemFeatureParLines.Init();
                    ItemFeatureParLines."Header ID" := ParameHeaderPar.ID;
                    ItemFeatureParLines."Feature Name" := ItemFeatureSet."Item Feature Name";
                    ItemFeatureParLines.Value := ItemFeatureSet.Value;
                    ItemFeatureParLines."Color ID" := ItemFeatureSet."Color Id";
                    ItemFeatureParLines.Insert(true);
                until ItemFeatureSet.Next() = 0;
        end;
        if ParameHeaderPar."Item Brandings Set ID" <> 0 then begin
            Clear(ItemBrandParLines);
            ItemBrandParLines.SetRange("Header ID", ParameHeaderPar.ID);
            if ItemBrandParLines.FindSet() then
                ItemBrandParLines.DeleteAll();
            Clear(ItemBrandingSet);
            ItemBrandingSet.SetRange("Item Branding Set ID", ParameHeaderPar."Item Brandings Set ID");
            if ItemBrandingSet.FindSet() then
                repeat
                    Clear(ItemBrandParLines);
                    ItemBrandParLines.Init();
                    ItemBrandParLines."Header ID" := ParameHeaderPar.ID;
                    ItemBrandParLines.Code := ItemBrandingSet."Item Branding Code";
                    ItemBrandParLines.Insert(true);
                until ItemBrandingSet.Next() = 0;
        end;
    end;

    procedure UpdateFeaturesParamLinesFromParent(HeaderID: Integer)
    var
        ParameterHeaderLoc: Record "Parameter Header";
        SalesLineLoc: Record "Sales Line";
        ChildFeaturesParLines: Record "Item Features Param Lines";
        ParentFeaturesParLines: Record "Item Features Param Lines";
    begin
        Clear(ParameterHeaderLoc);
        if ParameterHeaderLoc.Get(HeaderID) then begin
            Clear(SalesLineLoc);
            SalesLineLoc.SetRange("Parameters Header ID", HeaderID);
            if SalesLineLoc.FindFirst() then begin
                if SalesLineLoc."Parent Parameter Header ID" <> 0 then begin
                    Clear(ParentFeaturesParLines);
                    ParentFeaturesParLines.SetRange("Header ID", SalesLineLoc."Parent Parameter Header ID");
                    if ParentFeaturesParLines.FindSet() then
                        repeat
                            //if ParentFeaturesParLines.Instructions <> '' then begin
                            Clear(ChildFeaturesParLines);
                            ChildFeaturesParLines.SetRange("Header ID", HeaderID);
                            ChildFeaturesParLines.SetRange("Feature Name", ParentFeaturesParLines."Feature Name");
                            if ChildFeaturesParLines.FindFirst() then begin
                                ChildFeaturesParLines."Color Id" := ParentFeaturesParLines."Color Id";
                                ChildFeaturesParLines.Value := ParentFeaturesParLines.Value;
                                ChildFeaturesParLines.Cost := ParentFeaturesParLines.Cost;
                                ChildFeaturesParLines.Instructions := ParentFeaturesParLines.Instructions;
                                if ChildFeaturesParLines.Modify(true) then;
                            end;
                        //end;
                        until ParentFeaturesParLines.Next() = 0;
                end;
            end;
        end;
    end;

    procedure OpenItemLinks(CuttingSheetDashboard: Record "Cutting Sheets Dashboard")
    var
        RecordLink: Record "Record Link";
        Item: Record Item;
    begin
        Clear(Item);
        if Item.Get(CuttingSheetDashboard."Item No.") then begin
            Clear(RecordLink);
            RecordLink.SetRange(Type, RecordLink.Type::Link);
            RecordLink.SetRange("Record ID", Item.RecordId);
            RecordLink.SetRange(Company, CompanyName);
            if RecordLink.FindSet() then
                repeat
                    Hyperlink(RecordLink.URL1);
                until RecordLink.Next() = 0;
        end;
    end;

    var
        CuttingSheetScanningDetailsCreated: Record "Cutting Sheet Scanning Details";
}
