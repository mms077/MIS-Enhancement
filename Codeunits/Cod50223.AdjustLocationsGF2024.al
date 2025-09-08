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
        Item.SetRange("Revalued 2024", false);
        Item.SetRange(Type,Item.Type::Inventory);
        if Item.FindSet() then
            repeat
                // Check if item has value entries with variants
                if HasValueEntriesWithVariants(Item."No.", LocationCode, StartDate, EndDate) then begin
                    // Process each variant that has value entries
                    ProcessItemVariantsWithValueEntries(Item, LocationCode, StartDate, EndDate, LineNo);
                end else begin
                    // If no variants in value entries, process without variant
                    ProcessItemEntries(Item, '', LocationCode, StartDate, EndDate, LineNo);
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
        //if SumCostAmountLCY <> 0 then begin
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
        //end;
    end;

    local procedure HasValueEntriesWithVariants(ItemNo: Code[20]; LocationCode: Code[10]; StartDate: Date; EndDate: Date): Boolean
    var
        ValueEntry: Record "Value Entry";
    begin
        Clear(ValueEntry);
        ValueEntry.SetRange("Item No.", ItemNo);
        ValueEntry.SetRange("Location Code", LocationCode);
        ValueEntry.SetRange("Posting Date", StartDate, EndDate);
        ValueEntry.SetFilter("Variant Code", '<>%1', ''); // Filter for non-empty variant codes
        exit(not ValueEntry.IsEmpty());
    end;

    local procedure ProcessItemVariantsWithValueEntries(ItemRec: Record Item; LocationCode: Code[10]; StartDate: Date; EndDate: Date; var LineNo: Integer)
    var
        ValueEntry: Record "Value Entry";
        VariantCode: Code[10];
        ProcessedVariants: List of [Code[10]];
    begin
        // Get all unique variant codes from value entries for this item
        Clear(ValueEntry);
        ValueEntry.SetRange("Item No.", ItemRec."No.");
        ValueEntry.SetRange("Location Code", LocationCode);
        ValueEntry.SetRange("Posting Date", StartDate, EndDate);
        ValueEntry.SetFilter("Variant Code", '<>%1', ''); // Only entries with variant codes

        if ValueEntry.FindSet() then
            repeat
                VariantCode := ValueEntry."Variant Code";
                // Process each unique variant only once
                if not ProcessedVariants.Contains(VariantCode) then begin
                    ProcessedVariants.Add(VariantCode);
                    ProcessItemEntries(ItemRec, VariantCode, LocationCode, StartDate, EndDate, LineNo);
                end;
            until ValueEntry.Next() = 0;
    end;



    var
        myInt: Integer;
}