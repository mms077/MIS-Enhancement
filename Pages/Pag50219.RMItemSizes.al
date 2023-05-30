page 50219 "RM Item Sizes"
{
    ApplicationArea = All;
    Caption = 'RM Item Sizes';
    PageType = List;
    SourceTable = "Item Size";
    UsageCategory = Lists;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }*/
                field("Item Size Code"; Rec."Item Size Code")
                {
                    ApplicationArea = All;
                    /*trigger OnLookup(var Text: Text): Boolean
                    var
                        Item: Record Item;
                        DesignDetail: Record "Design Detail";
                        SizeFilter: Text[2048];
                        PreviousSize: Code[100];
                        SizePage: Page Sizes;
                        SizeRec: Record "Size";
                    begin
                        Clear(SizeFilter);
                        Clear(PreviousSize);
                        if Item.Get(Rec."Item No.") then begin
                            Clear(DesignDetail);
                            DesignDetail.SetCurrentKey("Size Code");
                            DesignDetail.SetRange("Design Code", Item."Design Code");
                            if DesignDetail.FindSet() then begin
                                repeat
                                    if PreviousSize <> DesignDetail."Size Code" then begin
                                        SizeFilter := SizeFilter + DesignDetail."Size Code" + '|';
                                    end;
                                    PreviousSize := DesignDetail."Size Code";
                                until DesignDetail.Next() = 0;
                                Clear(SizeRec);
                                SizeFilter := DELCHR("SizeFilter", '>', '|');
                                SizeRec.SetFilter("Code", SizeFilter);
                                if SizeRec.FindSet() then begin
                                    SizePage.SetTableView(SizeRec);
                                    SizePage.LookupMode(true);
                                    if SizePage.RunModal() = Action::LookupOK then begin
                                        SizePage.GetRecord(SizeRec);
                                        Rec.Validate("Item Size Code", SizeRec."Code");
                                    end;
                                end;
                            end;
                        end;
                    end;*/
                }
                field("Size Name"; Rec."Size Name")
                {
                    ApplicationArea = all;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(ER; Rec.ER)
                {
                    ApplicationArea = All;
                }
                field(DE; Rec.DE)
                {
                    ApplicationArea = All;
                }
                field(IT; Rec.IT)
                {
                    ApplicationArea = All;
                }
                field(INTL; Rec.INTL)
                {
                    ApplicationArea = All;
                }
                field(UK; Rec.UK)
                {
                    ApplicationArea = All;
                }
                field(US; Rec.US)
                {
                    ApplicationArea = All;
                }
                field(RU; Rec.RU)
                {
                    ApplicationArea = All;
                }
                field(FR; Rec.FR)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        /*FillSizesFromDesignDetails();
        DeleteSizesNotInDesignDetails();*/
    end;

    procedure FillSizesFromDesignDetails()
    var
        Item: Record Item;
        DesignDetail: Record "Design Detail";
        SizeFilter: Text[2048];
        PreviousSize: Code[100];
        SizeRec: Record "Size";
        ItemSizeLocTemp: Record "Item Size" temporary;
        CheckItemSize: Record "Item Size";
    begin
        Clear(SizeFilter);
        Clear(PreviousSize);
        if Item.Get(Rec."Item No.") then begin
            Clear(DesignDetail);
            DesignDetail.SetCurrentKey("Size Code");
            DesignDetail.SetRange("Design Code", Item."Design Code");
            if DesignDetail.FindSet() then begin
                repeat
                    if PreviousSize <> DesignDetail."Size Code" then begin
                        SizeFilter := SizeFilter + DesignDetail."Size Code" + '|';
                    end;
                    PreviousSize := DesignDetail."Size Code";
                until DesignDetail.Next() = 0;
                Clear(SizeRec);
                SizeFilter := DELCHR("SizeFilter", '>', '|');
                SizeRec.SetFilter("Code", SizeFilter);
                if SizeRec.FindSet() then begin
                    repeat
                        Clear(CheckItemSize);
                        CheckItemSize.SetRange("Item No.", Item."No.");
                        CheckItemSize.SetRange("Item Size Code", SizeRec.Code);
                        if not CheckItemSize.FindFirst() then begin
                            ItemSizeLocTemp.Init();
                            ItemSizeLocTemp."Item No." := Item."No.";
                            ItemSizeLocTemp."Item Size Code" := SizeRec.Code;
                            ItemSizeLocTemp.Insert(true);
                        end;
                    until SizeRec.Next() = 0;
                end;
            end;
            if not ItemSizeLocTemp.IsEmpty then begin
                CopyItemSizesFromTemp(ItemSizeLocTemp)
            end;
        end;
    end;

    procedure CopyItemSizesFromTemp(var ItemSizeTemporary: Record "Item Size" temporary)
    var
        ItemSizeLoc: Record "Item Size";
    begin
        if ItemSizeTemporary.FindSet() then
            repeat
                ItemSizeLoc.Init();
                ItemSizeLoc.TransferFields(ItemSizeTemporary);
                ItemSizeLoc.Insert(true);
            until ItemSizeTemporary.Next() = 0;
    end;

    procedure DeleteSizesNotInDesignDetails()
    var
        Item: Record Item;
        DesignDetail: Record "Design Detail";
        SizeRec: Record "Size";
        ItemSizeTemp: Record "Item Size" temporary;
        ItemSize: Record "Item Size";
    begin
        Clear(ItemSize);
        if Item.Get(Rec."Item No.") then begin
            ItemSize.SetRange("Item No.", Rec."Item No.");
            if ItemSize.FindSet() then
                repeat
                    Clear(DesignDetail);
                    DesignDetail.LoadFields("Design Code", "Size Code");
                    DesignDetail.SetCurrentKey("Size Code");
                    DesignDetail.SetRange("Design Code", Item."Design Code");
                    DesignDetail.SetRange("Size Code", ItemSize."Item Size Code");
                    if not DesignDetail.FindFirst() then begin
                        ItemSizeTemp.Init();
                        ItemSizeTemp.TransferFields(ItemSize);
                        ItemSizeTemp.Insert(false);
                    end;
                until ItemSize.Next() = 0;
            if not ItemSizeTemp.IsEmpty then begin
                DeleteItemSizesFromTemp(ItemSizeTemp)
            end;
        end;
    end;

    procedure DeleteItemSizesFromTemp(var ItemSizeTemporary: Record "Item Size" temporary)
    var
        ItemSizeLoc: Record "Item Size";
    begin
        if ItemSizeTemporary.FindSet() then begin
            repeat
                Clear(ItemSizeLoc);
                ItemSizeLoc.SetRange("Item No.", ItemSizeTemporary."Item No.");
                ItemSizeLoc.SetRange("Item Size Code", ItemSizeTemporary."Item Size Code");
                if ItemSizeLoc.FindFirst() then
                    ItemSizeLoc.Delete(true);
            until ItemSizeTemporary.Next() = 0;
        end;
    end;
}
