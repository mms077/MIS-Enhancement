codeunit 50221 AdjustLocations2024
{
    trigger OnRun()
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJournalLine: Record "Warehouse Journal Line";
        //ItemJournalTemplate: Record "Item Journal Template";
        //ItemJournalBatch: Record "Item Journal Batch";
        SumCostAmountLCY: Decimal;
        SumRemainingQuantity: Decimal;
        LocationCodes: List of [Code[10]];
        LocationCode: Code[10];
        LineNo: Integer;
        StartDate: Date;
        EndDate: Date;
        i: Integer;
    begin
        // Define the locations to process
        LocationCodes.Add('PL1');
        LocationCodes.Add('PL2');
        LocationCodes.Add('B2');

        StartDate := DMY2DATE(1, 1, 2024);
        EndDate := DMY2DATE(31, 12, 2024);

        // Process each location
        for i := 1 to LocationCodes.Count() do begin
            LocationCode := LocationCodes.Get(i);

            // Get next line number for this location
            Clear(ItemJournalLine);
            ItemJournalLine.SetRange("Journal Template Name", 'Item');
            ItemJournalLine.SetRange("Journal Batch Name", LocationCode + '-ADJ');
            ItemJournalLine.SetRange("Location Code", LocationCode);
            if ItemJournalLine.FindLast() then
                LineNo := ItemJournalLine."Line No." + 10000
            else
                LineNo := 10000;

            // Process all items for this location
            ProcessLocationItems(LocationCode, StartDate, EndDate, LineNo);
        end;
    end;

    local procedure ProcessLocationItems(LocationCode: Code[10]; StartDate: Date; EndDate: Date; var LineNo: Integer)
    var
        Item: Record Item;
    begin
        // Loop through all non-blocked items
        Item.SetRange(Blocked, false);
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
        WarehouseItemJournalLine: Record "Warehouse Journal Line";
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
                WarehouseItemJournalLine."Journal Template Name" := 'Item';
                WarehouseItemJournalLine."Journal Batch Name" := LocationCode + '-ADJ';
                WarehouseItemJournalLine."Location Code" := LocationCode;
                WarehouseItemJournalLine."Line No." := LineNo;
                WarehouseItemJournalLine.Validate("Registering Date", EndDate);
                WarehouseItemJournalLine."Whse. Document No." := 'PositiveExq';
                WarehouseItemJournalLine.Validate("Item No.", ItemRec."No.");
                WarehouseItemJournalLine.Validate("Entry Type", WarehouseItemJournalLine."Entry Type"::"Positive Adjmt.");
                WarehouseItemJournalLine.Validate("Bin Code", GetAdjstBinBasedOnwhsreClass(ItemRec, LocationCode));

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

    local procedure GetAdjstBinBasedOnwhsreClass(Item: Record Item; LocationCode: Code[20]): code[20]
    var
        myInt: Integer;
        Bin: Record Bin;
    begin
        Clear(Bin);
        Bin.SetFilter("Location Code", LocationCode);
        Bin.SetRange("Zone Code", 'ADJ');
        bin.SetFilter("Warehouse Class Code", Item."Warehouse Class Code");
        if bin.FindFirst() then begin
            exit(Bin.Code);
        end;
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