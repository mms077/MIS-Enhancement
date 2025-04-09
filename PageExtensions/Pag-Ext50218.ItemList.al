pageextension 50218 "Item List" extends "Item List"
{
    layout
    {
        addafter("Default Deferral Template Code")
        {
            field("Hs Code"; Rec."Hs Code")
            {
                ApplicationArea = all;
            }
            field("Created By"; UserCreater)
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Created By';
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = all;
                Caption = 'Created At';
            }
            field("Modified By"; UserModifier)
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Modified By';
            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                ApplicationArea = all;
                Caption = 'Modified At';
            }
        }
        modify("Unit Cost")
        {
            Visible = CostVisible;
        }
        /* addafter(Description)
         {
             field("Description 2"; Rec."Description 2")
             {
                 ApplicationArea = all;
             }
         }*/
    }

    actions
    {
        addafter(CopyItem)
        {
            action("Create Variant")
            {
                ApplicationArea = All;
                Image = VariableList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    Management: Codeunit Management;
                    State: Option "Start","Departments","Positions","Staff","Staff Sizes","Header Parameters 0","Header Parameters","Qty Assignment","Lines Parameters","Features Parameters","Branding Parameters";
                    SalesHeader: Record "Sales Header";
                    Process: Option "Old Way","Assignment","Just Create Variant";
                    SalesLine: Record "Sales Line";
                begin
                    Management.RunTheProcess(State::Start, SalesHeader, Process::"Just Create Variant", SalesLine, '')
                end;
            }
            // action("Clear Pic Issue")
            // {
            //     ApplicationArea = All;
            //     Image = MaintenanceLedger;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //         ItemRec: Record Item;
            //     begin
            //         //Clear item pics
            //         if ItemRec.FindSet() then
            //             repeat
            //                 Clear(ItemRec.Picture);
            //                 ItemRec.Modify(true);
            //             until ItemRec.Next() = 0;
            //     end;
            // }
            // action("Fix Pic Issue")
            // {
            //     ApplicationArea = All;
            //     Image = MaintenanceLedger;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //         ItemRec: Record Item;
            //         Cu: Codeunit "Fix Aver Pics";
            //     begin
            //         // ItemMediaSet;
            //         cu.ItemMediaSet();
            //     end;
            // }
        }

    }
    trigger OnOpenPage()
    var
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.AllowShowSalesPrice() then
            CostVisible := true
        else
            CostVisible := false;
        if CurrPage.LookupMode then
            CurrPage.Editable(false);
    end;

    trigger OnAfterGetRecord()
    begin
        if User.Get(Rec.SystemCreatedBy) then
            UserCreater := User."User Name";
        if User2.Get(Rec.SystemModifiedBy) then
            UserModifier := User2."User Name";
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
        User: Record User;
        User2: Record User;
        UserCreater: Code[50];
        UserModifier: Code[50];
        CostVisible: Boolean;

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

}