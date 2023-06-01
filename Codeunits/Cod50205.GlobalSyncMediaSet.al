codeunit 50205 "Global Sync Media Set"
{
    Permissions = tabledata "Tenant Media" = RMID, tabledata "Tenant Media Set" = RMID;
    trigger OnRun()
    begin
        if isGlobalSyncAdmin then
            SyncMediaSet()
        else
            Error(Txt003);
    end;

    procedure SyncMediaSet()
    begin
        ItemMediaSet();
        ItemVariantMediaSet();
        //DesignMediaSet();
        //ItemColorMediaSet();
        //ItemDesignSectionColorMediaSet();
        //ItemFeaturePossibleValueMediaSet();
        //PlottingFileMediaSet();
    end;

    procedure ItemMediaSet()
    begin
        Clear(GlobalSyncSetup);
        GlobalSyncSetup.Get(CompanyName);
        if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Child then begin
            //Point to Parent Company
            ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
            ParentGlobalSyncSetup.FindFirst();
            ItemRec.ChangeCompany(ParentGlobalSyncSetup."Company Name");
        end;
        if ItemRec.FindSet() then
            repeat
                for index := 1 to ItemRec.Picture.COUNT do begin
                    TenantMedia.Get(ItemRec.Picture.Item(index));
                    TenantMedia."Company Name" := '';
                    TenantMedia.Modify();
                    if TenantMediaSet.Get(ItemRec.Picture.MEDIAID, ItemRec.Picture.Item(index)) then begin
                        TenantMediaSet."Company Name" := '';
                        TenantMediaSet.Modify();
                    end;
                end;
            until ItemRec.Next() = 0;
    end;

    procedure ItemVariantMediaSet()
    begin
        Clear(GlobalSyncSetup);
        GlobalSyncSetup.Get(CompanyName);
        if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Child then begin
            //Point to Parent Company
            ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
            ParentGlobalSyncSetup.FindFirst();
            ItemVariantRec.ChangeCompany(ParentGlobalSyncSetup."Company Name");
        end;
        if ItemVariantRec.FindSet() then
            repeat
                for index := 1 to ItemVariantRec.Picture.COUNT do begin
                    TenantMedia.Get(ItemVariantRec.Picture.Item(index));
                    TenantMedia."Company Name" := '';
                    TenantMedia.Modify();
                    if TenantMediaSet.Get(ItemVariantRec.Picture.MEDIAID, ItemVariantRec.Picture.Item(index)) then begin
                        TenantMediaSet."Company Name" := '';
                        TenantMediaSet.Modify();
                    end;
                end;
            until ItemVariantRec.Next() = 0;
    end;

    procedure DesignMediaSet()
    begin
        Clear(GlobalSyncSetup);
        GlobalSyncSetup.Get(CompanyName);
        if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Child then begin
            //Point to Parent Company
            ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
            ParentGlobalSyncSetup.FindFirst();
            Design.ChangeCompany(ParentGlobalSyncSetup."Company Name");
        end;
        if Design.FindSet() then
            repeat
                for index := 1 to Design.Picture.COUNT do begin
                    TenantMedia.Get(Design.Picture.Item(index));
                    TenantMedia."Company Name" := '';
                    TenantMedia.Modify();
                    if TenantMediaSet.Get(Design.Picture.MEDIAID, Design.Picture.Item(index)) then begin
                        TenantMediaSet."Company Name" := '';
                        TenantMediaSet.Modify();
                    end;
                end;
            until Design.Next() = 0;
    end;

    procedure ItemColorMediaSet()
    begin
        Clear(GlobalSyncSetup);
        GlobalSyncSetup.Get(CompanyName);
        if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Child then begin
            //Point to Parent Company
            ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
            ParentGlobalSyncSetup.FindFirst();
            ItemColor.ChangeCompany(ParentGlobalSyncSetup."Company Name");
        end;
        if ItemColor.FindSet() then
            repeat
                for index := 1 to ItemColor.Picture.COUNT do begin
                    TenantMedia.Get(ItemColor.Picture.Item(index));
                    TenantMedia."Company Name" := '';
                    TenantMedia.Modify();
                    if TenantMediaSet.Get(ItemColor.Picture.MEDIAID, ItemColor.Picture.Item(index)) then begin
                        TenantMediaSet."Company Name" := '';
                        TenantMediaSet.Modify();
                    end;
                end;
            until ItemColor.Next() = 0;
    end;

    procedure ItemDesignSectionColorMediaSet()
    begin
        Clear(GlobalSyncSetup);
        GlobalSyncSetup.Get(CompanyName);
        if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Child then begin
            //Point to Parent Company
            ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
            ParentGlobalSyncSetup.FindFirst();
            ItemDesignSectionColor.ChangeCompany(ParentGlobalSyncSetup."Company Name");
        end;
        if ItemDesignSectionColor.FindSet() then
            repeat
                for index := 1 to ItemDesignSectionColor.Picture.COUNT do begin
                    TenantMedia.Get(ItemDesignSectionColor.Picture.Item(index));
                    TenantMedia."Company Name" := '';
                    TenantMedia.Modify();
                    if TenantMediaSet.Get(ItemDesignSectionColor.Picture.MEDIAID, ItemDesignSectionColor.Picture.Item(index)) then begin
                        TenantMediaSet."Company Name" := '';
                        TenantMediaSet.Modify();
                    end;
                end;
            until ItemDesignSectionColor.Next() = 0;
    end;

    procedure ItemFeaturePossibleValueMediaSet()
    begin
        Clear(GlobalSyncSetup);
        GlobalSyncSetup.Get(CompanyName);
        if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Child then begin
            //Point to Parent Company
            ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
            ParentGlobalSyncSetup.FindFirst();
            ItemFeaturePossibleValue.ChangeCompany(ParentGlobalSyncSetup."Company Name");
        end;
        if ItemFeaturePossibleValue.FindSet() then
            repeat
                for index := 1 to ItemFeaturePossibleValue.Picture.COUNT do begin
                    TenantMedia.Get(ItemFeaturePossibleValue.Picture.Item(index));
                    TenantMedia."Company Name" := '';
                    TenantMedia.Modify();
                    if TenantMediaSet.Get(ItemFeaturePossibleValue.Picture.MEDIAID, ItemFeaturePossibleValue.Picture.Item(index)) then begin
                        TenantMediaSet."Company Name" := '';
                        TenantMediaSet.Modify();
                    end;
                end;
            until ItemFeaturePossibleValue.Next() = 0;
    end;

    procedure PlottingFileMediaSet()
    begin
        Clear(GlobalSyncSetup);
        GlobalSyncSetup.Get(CompanyName);
        if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Child then begin
            //Point to Parent Company
            ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
            ParentGlobalSyncSetup.FindFirst();
            PlottingFile.ChangeCompany(ParentGlobalSyncSetup."Company Name");
        end;
        if PlottingFile.FindSet() then
            repeat
                for index := 1 to PlottingFile.Picture.COUNT do begin
                    TenantMedia.Get(PlottingFile.Picture.Item(index));
                    TenantMedia."Company Name" := '';
                    TenantMedia.Modify();
                    if TenantMediaSet.Get(PlottingFile.Picture.MEDIAID, PlottingFile.Picture.Item(index)) then begin
                        TenantMediaSet."Company Name" := '';
                        TenantMediaSet.Modify();
                    end;
                end;
            until PlottingFile.Next() = 0;
    end;

    procedure isGlobalSyncAdmin(): Boolean
    begin
        if UserSetup.Get(UserId) then
            if UserSetup."Global Sync Job Queue Runner" then
                exit(true)
            else
                exit(false);
    end;

    var
        index: Integer;
        TenantMedia: Record "Tenant Media";
        TenantMediaSet: Record "Tenant Media Set";
        GlobalSyncSetup: Record "Global Sync Setup";
        ParentGlobalSyncSetup: Record "Global Sync Setup";
        ItemRec: Record Item;
        ItemVariantRec: Record "Item Variant";
        Design: Record Design;
        ItemColor: Record "Item Color";
        ItemDesignSectionColor: Record "Item Design Section Color";
        ItemFeaturePossibleValue: Record "Item Feature Possible Values";
        PlottingFile: Record "Plotting File";
        UserSetup: Record "User Setup";
        Txt003: Label 'You are not Global Sync Admin';
}
