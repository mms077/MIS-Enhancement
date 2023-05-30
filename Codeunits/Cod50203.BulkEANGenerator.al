codeunit 50203 "Bulk EAN Generator"
{
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        MasterItemCU: Codeunit MasterItem;
        ItemUOM: Record "Item Unit of Measure";

    trigger OnRun()
    var
        ItemReference: Record "Item Reference";
        LastItemReference: Record "Item Reference";
        BarCode: Code[50];
    begin
        BarCode := 'BC-000000001';
        ItemReference.SetCurrentKey("Item No.", "Variant Code");
        if ItemReference.FindFirst() then
            repeat
                if ItemReference."Unique Code" = '' then begin
                    ItemReference."Unique Code" := BarCode;
                    ItemReference.Modify();
                end else begin
                    BarCode := IncStr(BarCode);
                    ItemReference."Unique Code" := BarCode;
                    ItemReference.Modify();
                end;
            until ItemReference.Next() = 0;
    end;
}