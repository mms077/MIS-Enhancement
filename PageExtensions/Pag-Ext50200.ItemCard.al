pageextension 50200 ItemCard extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            field("French Name"; Rec."Description 2")
            {
                ApplicationArea = all;
            }
            field("Arabic Description"; Rec."Arabic Name")
            {
                ApplicationArea = all;
            }
            field("Hs Code"; Rec."Hs Code")
            {
                ApplicationArea = all;
                Importance = Standard;
            }
        }
        addafter(Type)
        {
            field("Design Code"; Rec."Design Code")
            {
                ApplicationArea = All;
                Importance = Standard;
                Lookup = true;
                LookupPageId = Designs;
            }
            field("Design Name"; Rec."Design Name")
            {
                ApplicationArea = All;
                Importance = Standard;
            }
            field("Brand Code"; Rec."Brand Code")
            {
                ApplicationArea = All;
                Importance = Standard;
                Lookup = true;
                LookupPageId = Brands;
            }
            field("Brand Name"; Rec."Brand Name")
            {
                ApplicationArea = All;
                Importance = Standard;
            }
            /*field("Fabric Code"; Rec."Fabric Code")
            {
                ApplicationArea = All;
                Importance = Standard;
            }
            field("Fabric Name"; Rec."Fabric Name")
            {
                ApplicationArea = All;
                Importance = Standard;
            }*/
            field(IsRawMaterial; Rec.IsRawMaterial)
            {
                ApplicationArea = all;
                Importance = Standard;
            }
        }
        modify("Item Category Code")
        {
            Editable = false;
        }
        modify("Unit Cost")
        {
            Visible = CostVisible;
        }
    }
    actions
    {
        addlast(Navigation_Item)
        {
            /*action("Design Details")
            {
                ApplicationArea = All;
                Image = Design;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = page "Design Form";
                RunPageLink = "Code" = field("Design Code");
            }*/
            action("Item Cuts")
            {
                ApplicationArea = All;
                Image = Link;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = page "Item Cuts";
                RunPageLink = "Item No." = field("No.");
            }
            action("Item Colors")
            {
                ApplicationArea = All;
                Image = AllocatedCapacity;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = page "Item Colors";
                RunPageLink = "Item No." = field("No.");
            }
            action("Item Design Section RM")
            {
                ApplicationArea = All;
                Image = JobListSetup;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = page "Item Design Section RM";
                RunPageLink = "Item No." = field("No.");
                trigger OnAction()
                var
                    ItemDesignSectionRM: Record "Item Design Section RM";
                    DesignDetails: Record "Design Detail";
                    RMCategoryDesignSec: Record "RM Category Design Section";
                    Design: Record Design;
                begin
                    if Rec."Design Code" <> '' then begin
                        Design.Get(Rec."Design Code");
                        Clear(DesignDetails);
                        Clear(ItemDesignSectionRM);
                        DesignDetails.SetRange("Design Code", Rec."Design Code");
                        if DesignDetails.FindSet() then
                            repeat
                                RMCategoryDesignSec.SetRange("Design Section Code", DesignDetails."Design Section Code");
                                RMCategoryDesignSec.SetRange("Design Type", Design.Type);
                                if RMCategoryDesignSec.FindFirst() then begin
                                    RMCategoryDesignSec.CalcFields("RM Category Count By DS");
                                    if RMCategoryDesignSec."RM Category Count By DS" > 1 then begin
                                        Clear(ItemDesignSectionRM);
                                        ItemDesignSectionRM.Init();
                                        ItemDesignSectionRM."Item No." := Rec."No.";
                                        ItemDesignSectionRM."Design Section Code" := DesignDetails."Design Section Code";
                                        if ItemDesignSectionRM.Insert(true) then;
                                    end;
                                end;

                            until DesignDetails.Next() = 0;
                    end;
                end;
            }
            action("Item Sizes")
            {
                ApplicationArea = All;
                Image = ItemGroup;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                /*RunObject = page "Item Sizes";
                RunPageLink = "Item No." = field("No.");*/
                trigger OnAction()
                var
                    ItemSizeRec: Record "Item Size";
                    NewItemSizeRec: Record "Item Size";
                    ItemSizePage: Page "Item Sizes";
                    RMItemSizePage: Page "RM Item Sizes";
                begin
                    Rec.CalcFields(IsRawMaterial);
                    if Rec.IsRawMaterial then begin
                        //Raw Material
                        Clear(ItemSizeRec);
                        ItemSizeRec.SetRange("Item No.", Rec."No.");
                        if ItemSizeRec.FindSet() then
                            RMItemSizePage.SetTableView(ItemSizeRec)
                        else begin
                            //Create Item Size for this RM
                            Clear(NewItemSizeRec);
                            NewItemSizeRec.Init();
                            NewItemSizeRec."Item No." := Rec."No.";
                            NewItemSizeRec.Insert(true);
                            Clear(ItemSizeRec);
                            ItemSizeRec.SetRange("Item No.", NewItemSizeRec."Item No.");
                            if ItemSizeRec.FindSet() then
                                RMItemSizePage.SetTableView(ItemSizeRec)
                        end;
                        RMItemSizePage.Run();
                    end else begin
                        //Finished Item
                        Clear(ItemSizeRec);
                        ItemSizeRec.SetRange("Item No.", Rec."No.");
                        //Fill Item Sizes
                        ItemSizePage.FillSizesFromDesignDetails(Rec."No.");
                        ItemSizePage.DeleteSizesNotInDesignDetails(Rec."No.");
                        ItemSizePage.SetTableView(ItemSizeRec);
                        ItemSizePage.Run();
                    end;
                end;
            }
            action("Item Fits")
            {
                ApplicationArea = All;
                Image = PersonInCharge;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = page "Item Fits";
                RunPageLink = "Item No." = field("No.");
            }
            action("Item Features")
            {
                Caption = 'Item Features';
                ApplicationArea = All;
                Image = NewSparkle;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = page "Item Features";
                RunPageLink = "Item No." = field("No.");
            }
            /*action("Item Specs")
            {
                ApplicationArea = All;
                Image = ServiceAccessories;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = page "Item Specs";
                RunPageLink = "Item No." = field("No.");
            }*/
            action("Generate EAN Barcode")
            {
                ApplicationArea = All;
                Image = BarCode;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                //Visible = false;
                trigger OnAction()
                var
                    MasterItem: Codeunit MasterItem;
                begin
                    MasterItem.GenerateEAN(Rec."No.", '', Rec."Base Unit of Measure");
                end;
            }
            action("Create Item As Raw Material")
            {
                ApplicationArea = All;
                Image = AssemblyBOM;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                trigger OnAction()
                var
                    MasterItem: Codeunit MasterItem;
                begin
                    MasterItem.CreateRMFromItem(Rec);
                end;
            }
            /*action("TEST")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                RunObject = codeunit 50203;
            }*/
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
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Rec.CalcFields(IsRawMaterial);
        if (Rec."No." <> '') and (Rec.IsRawMaterial = false) then
            Rec.TestField("Design Code");
    end;

    var
        CostVisible: Boolean;
}

