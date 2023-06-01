tableextension 50213 "Item Unit of Measure" extends "Item Unit of Measure"
{
    trigger OnAfterInsert()
    var
        Item: Record Item;
        MasterItemCU: Codeunit MasterItem;
    begin
        if Item.Get(Rec."Item No.") then begin
            Item.CalcFields(IsRawMaterial);
            if Item.IsRawMaterial = true then begin
                MasterItemCU.CreateItemReference(Item."No.", Item."No." + '-' + Rec.Code, '', Rec.Code);
            end;
        end;
    end;

    trigger OnAfterRename()
    var
        Item: Record Item;
        MasterItemCU: Codeunit MasterItem;
        ItemReference: Record "Item Reference";
    begin
        ItemReference.SetRange("Item No.", Rec."Item No.");
        ItemReference.SetFilter("Reference No.", Rec."Item No." + '' + Rec.Code);
        if not ItemReference.FindFirst() then begin
            if Item.Get(Rec."Item No.") then begin
                Item.CalcFields(IsRawMaterial);
                if Item.IsRawMaterial = true then begin
                    MasterItemCU.CreateItemReference(Item."No.", Item."No." + '-' + Rec.Code, '', Rec.Code);
                end;
            end;
        end;
    end;

    trigger OnAfterModify()
    var
        Item: Record Item;
        MasterItemCU: Codeunit MasterItem;
        ItemReference: Record "Item Reference";
    begin
        Clear(ItemReference);
        ItemReference.SetRange("Item No.", Rec."Item No.");
        ItemReference.SetFilter("Reference No.", Rec."Item No." + '' + Rec.Code);
        if not ItemReference.FindFirst() then begin
            if Item.Get(Rec."Item No.") then begin
                Item.CalcFields(IsRawMaterial);
                if Item.IsRawMaterial = true then begin
                    MasterItemCU.CreateItemReference(Item."No.", Item."No." + '-' + Rec.Code, '', Rec.Code);
                end;
            end;
        end;
    end;
}
