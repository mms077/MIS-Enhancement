codeunit 50220 AdjustLocations
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
        LocationCode: Code[10];
        LineNo: Integer;
        StartDate: Date;
        EndDate: Date;
    begin
        LocationCode := 'B2';
        StartDate := DMY2DATE(1, 1, 2024);
        EndDate := DMY2DATE(31, 12, 2024);



        // Get next line number
        ItemJournalLine.SetRange("Journal Template Name", 'Item');
        ItemJournalLine.SetRange("Journal Batch Name", 'B2-ADJ');
        ItemJournalLine.SetRange("Location Code", 'B2');
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
                WarehouseItemJournalLine."Journal Batch Name" := 'B2-ADJ';
                WarehouseItemJournalLine."Location Code" := 'B2';
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



                // // Positive entry for the take
                // WhseJournalLineLineTake.Init();
                // WhseJournalLineLineTake."Journal Template Name" := Location."Journal Template Name";
                // WhseJournalLineLineTake."Journal Batch Name" := Location."Journal Batch Name";
                // WhseJournalLineLineTake."Location Code" := Location.Code;
                // WhseJournalLineLineTake."Line No." := GetLineNo(Location);
                // WhseJournalLineLineTake."Registering Date" := today;
                // WhseJournalLineLineTake."Whse. Document No." := RegisteredWhseActivityLineplace."No.";
                // WhseJournalLineLineTake.Validate("Item No.", RegisteredWhseActivityLineTake."Item No.");
                // WhseJournalLineLineTake.Validate("Entry Type", WhseJournalLineLineTake."Entry Type"::"Positive Adjmt.");
                // WhseJournalLineLineTake.Validate("To Bin Code", RegisteredWhseActivityLineTake."Bin Code");
                // WhseJournalLineLineTake.Validate("Unit of Measure Code", RegisteredWhseActivityLineTake."Unit of Measure Code");
                // WhseJournalLineLineTake.Validate(Quantity, RegisteredWhseActivityLineTake.Quantity);
                // WhseJournalLineLineTake.Validate("from Zone Code", '');
                // WhseJournalLineLineTake.Validate("from bin Code", '');
                // WhseJournalLineLineTake.Insert(true);
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
        bin.SetFilter("Warehouse Class Code", Item."Warehouse Class Code");
        if bin.FindFirst() then begin
            exit(Bin.Code);
        end;
    end;

    var
        myInt: Integer;
}