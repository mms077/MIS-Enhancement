codeunit 50223 AdjustLocationsGF2024
{
    trigger OnRun()
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJournalLine: Record "Item Journal Line";
        //ItemJournalTemplate: Record "Item Journal Template";
        //ItemJournalBatch: Record "Item Journal Batch";
        SumCostAmountLCY: Decimal;
        SumRemainingQuantity: Decimal;
        LocationCode: Code[10];
        LineNo: Integer;
        StartDate: Date;
        EndDate: Date;
    begin
        LocationCode := 'GF';
        StartDate := DMY2DATE(1, 1, 2024);
        EndDate := DMY2DATE(31, 12, 2024);



        // Get next line number
        ItemJournalLine.SetRange("Journal Template Name", 'ITEM');
        ItemJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        //ItemJournalLine.SetRange("Location Code", 'B2');
        if ItemJournalLine.FindLast() then
            LineNo := ItemJournalLine."Line No." + 10000
        else
            LineNo := 10000;

        // Loop through all non-blocked items
        Item.SetRange(Blocked, false);
        if Item.FindSet() then
            repeat
                // Calculate IsRawMaterial flow field
                Item.CalcFields(IsRawMaterial);

                // If item is raw material, process without variants
                if Item.IsRawMaterial then
                    ProcessItemEntries(Item, '', LocationCode, StartDate, EndDate, LineNo)
                else begin
                    // If item is not raw material, check per variant
                    Clear(ItemVariant);
                    ItemVariant.SetRange("Item No.", Item."No.");
                    if ItemVariant.FindSet() then
                        repeat
                            ProcessItemEntries(Item, ItemVariant.Code, LocationCode, StartDate, EndDate, LineNo);
                        until ItemVariant.Next() = 0

                end;
            until Item.Next() = 0;
    end;

    local procedure ProcessItemEntries(ItemRec: Record Item; VariantCode: Code[10]; LocationCode: Code[10]; StartDate: Date; EndDate: Date; var LineNo: Integer)
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        WarehouseItemJournalLine: Record "Item Journal Line";
        SumCostAmountLCY: Decimal;
        SumRemainingQuantity: Decimal;
    begin
        // Check sum of Value Entry cost amount (LCY) for location and variant
        Clear(ValueEntry);
        ValueEntry.SetRange("Item No.", ItemRec."No.");
        ValueEntry.SetRange("Location Code", LocationCode);
        ValueEntry.SetRange("Posting Date", StartDate, EndDate);
        if VariantCode <> '' then
            ValueEntry.SetRange("Variant Code", VariantCode);
        ValueEntry.CalcSums("Cost Amount (Actual)");
        SumCostAmountLCY := ValueEntry."Cost Amount (Actual)";

        // If cost amount is not zero, check Item Ledger Entry remaining quantity
        if SumCostAmountLCY <> 0 then begin
            Clear(ItemLedgerEntry);
            ItemLedgerEntry.SetRange("Item No.", ItemRec."No.");
            ItemLedgerEntry.SetRange("Location Code", LocationCode);
            ItemLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
            if VariantCode <> '' then
                ItemLedgerEntry.SetRange("Variant Code", VariantCode);
            ItemLedgerEntry.CalcSums("Remaining Quantity");
            SumRemainingQuantity := ItemLedgerEntry."Remaining Quantity";

            // If remaining quantity is zero, create item journal adjustment
            if SumRemainingQuantity = 0 then begin
                Clear(WarehouseItemJournalLine);
                WarehouseItemJournalLine.Init();
                WarehouseItemJournalLine."Journal Template Name" := 'ITEM';
                WarehouseItemJournalLine."Journal Batch Name" := 'DEFAULT';
                WarehouseItemJournalLine."Location Code" := 'GF';
                WarehouseItemJournalLine."Line No." := LineNo;
                WarehouseItemJournalLine.Validate("Posting Date", EndDate);
                WarehouseItemJournalLine."Document No." := 'PositiveExq';
                WarehouseItemJournalLine.Validate("Item No.", ItemRec."No.");
                WarehouseItemJournalLine.Validate("Entry Type", WarehouseItemJournalLine."Entry Type"::"Positive Adjmt.");

                if VariantCode <> '' then
                    WarehouseItemJournalLine.Validate("Variant Code", VariantCode);
                WarehouseItemJournalLine.Validate(Quantity, 1);
                if VariantCode <> '' then
                    WarehouseItemJournalLine.Description := StrSubstNo('Location adjustment for %1-%2', ItemRec."No.", VariantCode)
                else
                    WarehouseItemJournalLine.Description := StrSubstNo('Location adjustment for %1', ItemRec."No.");
                WarehouseItemJournalLine.Insert(true);
                LineNo += 10000;

            end;
        end;
    end;



    var
        myInt: Integer;
}