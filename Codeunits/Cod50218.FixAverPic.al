codeunit 50218 "Fix Aver Pics"
{
    Permissions = tabledata "Tenant Media" = rimd, tabledata "Tenant Media Set" = rimd;

    trigger OnRun()
    begin

    end;

    procedure ItemMediaSet()
    var
        index: Integer;
        TenantMedia: Record "Tenant Media";
        TenantMediaSet: Record "Tenant Media Set";
        GlobalSyncSetup: Record "Global Sync Setup";
        ParentGlobalSyncSetup: Record "Global Sync Setup";
        ItemRec: Record Item;
        ItemTarget: Record Item;
        ItemVariantRec: Record "Item Variant";
        ItemVariantTarget: Record "Item Variant";
        Design: Record Design;
        ItemColor: Record "Item Color";
        ItemDesignSectionColor: Record "Item Design Section Color";
        ItemFeaturePossibleValue: Record "Item Feature Possible Values";
        PlottingFile: Record "Plotting File";
        UserSetup: Record "User Setup";
        Txt003: Label 'You are not Global Sync Admin';
    begin
        Clear(GlobalSyncSetup);
        GlobalSyncSetup.Get(CompanyName);
        if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin
            //Point to Parent Company
            ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Child);
            ParentGlobalSyncSetup.FindFirst();
            ItemRec.ChangeCompany(ParentGlobalSyncSetup."Company Name");
        end;

        if ItemRec.FindSet() then
            repeat
                for index := 1 to ItemRec.Picture.COUNT do begin
                    // check if item exists in target company
                    if ItemTarget.Get(ItemRec."No.") then begin
                        //if ItemTarget.Picture.Count = 0 then begin
                        ItemTarget.Picture.INSERT(ItemRec.Picture.ITEM(index));
                        ItemTarget.Modify(true);

                        TenantMedia.Get(ItemRec.Picture.Item(index));
                        TenantMedia."Company Name" := '';
                        TenantMedia.Modify();
                        if TenantMediaSet.Get(ItemRec.Picture.MEDIAID, ItemRec.Picture.Item(index)) then begin
                            TenantMediaSet."Company Name" := '';
                            TenantMediaSet.Modify();
                            // end;
                        end;
                    end;
                end;
            until ItemRec.Next() = 0;

    end;

    var
        myInt: Integer;
}