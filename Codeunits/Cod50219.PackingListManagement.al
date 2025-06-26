codeunit 50219 "Packing List Management"
{
    procedure GeneratePackingList(SalesHeader: Record "Sales Header")
    var
        PackingListHeader: Record "Packing List Header";
        TempGroupedRecIds: Record "Temp Grouped Line RecIds" temporary;
        BoxSize: Record "Box Size";
        OversizeBoxCode: Code[20];
        ProgressDialog: Dialog;
        Step: Integer;
        TotalSteps: Integer;
        LogMessageCategory: Label 'PackingList', Locked = true;
        ProgressMsg: Label 'Generating Packing List for Order #1...\\Step #2 of #3', Comment = '%1 = Sales Order No., %2 = Current Step, %3 = Total Steps', Locked = true;
        FinalizingMsg: Label 'Finalizing Packing List...', Locked = true;
        NoGroupingFieldErr: Label 'No Grouping Criteria Field No. selected on Sales Order %1.', Comment = '%1 = Sales Order No.', Locked = true;
        CurrentBoxNo: Integer; // Track box number globally for the packing list
    begin
        SalesHeader.TestField("No."); // Ensure we have a valid header

        if SalesHeader."Grouping Criteria Field No." = 0 then
            Error(NoGroupingFieldErr, SalesHeader."No.");

        // --- Progress Dialog Setup ---
        TotalSteps := 4; // Steps: Init Header, Group Lines, Process Groups, Finalize
        Step := 0;
        ProgressDialog.Open(ProgressMsg, SalesHeader."No.", Step, TotalSteps);

        // --- Step 1: Initialize Packing List Header ---
        Step += 1;
        ProgressDialog.Update(2, Step);
        InitializePackingListHeader(SalesHeader, PackingListHeader);

        // --- Step 2: Group Sales Lines ---
        Step += 1;
        ProgressDialog.Update(2, Step);
        GroupSalesLines(SalesHeader, TempGroupedRecIds, ProgressDialog); // Pass Dialog to handle errors inside

        // Find Oversize Box Code (can be done once)
        OversizeBoxCode := GetOversizeBoxCode(BoxSize);

        // --- Step 3: Process Grouped Lines ---
        Step += 1;
        ProgressDialog.Update(2, Step);
        CurrentBoxNo := 0; // Initialize once here
        ProcessGroupedLines(PackingListHeader, TempGroupedRecIds, BoxSize, OversizeBoxCode, ProgressDialog, LogMessageCategory, CurrentBoxNo);

        // --- Step 4: Finalize ---
        Step += 1;
        ProgressDialog.Update(1, FinalizingMsg);
        ProgressDialog.Update(2, Step);
        FinalizePackingList(PackingListHeader);

        ProgressDialog.Close();
    end;

    local procedure InitializePackingListHeader(SalesHeader: Record "Sales Header"; var PackingListHeader: Record "Packing List Header")
    begin
        PackingListHeader.SetRange("Document Type", SalesHeader."Document Type");
        PackingListHeader.SetRange("Document No.", SalesHeader."No.");
        if PackingListHeader.FindFirst() then
            PackingListHeader.Delete(true);

        PackingListHeader.Init();
        PackingListHeader."Document Type" := SalesHeader."Document Type";
        PackingListHeader."Document No." := SalesHeader."No.";
        PackingListHeader.Status := PackingListHeader.Status::"In Progress";
        PackingListHeader."Generation DateTime" := CurrentDateTime();
        PackingListHeader."Location Code" := SalesHeader."Location Code";
        PackingListHeader.Insert();
    end;

    local procedure GroupSalesLines(SalesHeader: Record "Sales Header"; var TempGroupedRecIds: Record "Temp Grouped Line RecIds" temporary; var ProgressDialog: Dialog)
    var
        SalesLine: Record "Sales Line";
        SalesLineRecRef: RecordRef;
        GroupingFieldRef: FieldRef;
        GroupingValueVariant: Variant;
        GroupingValue: Text[250];
        InvalidGroupingFieldErr: Label 'Invalid Grouping Criteria Field Number (%1) selected on Sales Order %2.', Comment = '%1 = Field No., %2 = Sales Order No.', Locked = true;
        BlankGroupValueLbl: Label '<BLANK>', Locked = true;
    begin
        SalesLineRecRef.Open(Database::"Sales Line");
        // Validate Grouping Field - Moved validation here
        if not SalesLineRecRef.FieldExist(SalesHeader."Grouping Criteria Field No.") then begin
            SalesLineRecRef.Close();
            ProgressDialog.Close(); // Close dialog before erroring
            Error(InvalidGroupingFieldErr, SalesHeader."Grouping Criteria Field No.", SalesHeader."No.");
        end;

        GroupingFieldRef := SalesLineRecRef.Field(SalesHeader."Grouping Criteria Field No.");
        // It's good practice to check if the field is enabled, although FieldExist often covers this.
        // If needed, add: if not GroupingFieldRef.Active then ... Error ...

        TempGroupedRecIds.DeleteAll();
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter(Type, '%1', SalesLine.Type::Item);
        SalesLine.SetFilter(Quantity, '>0');
        if SalesLine.FindSet() then
            repeat
                SalesLineRecRef.Get(SalesLine.RecordId);
                GroupingValueVariant := GroupingFieldRef.Value();
                GroupingValue := Format(GroupingValueVariant);
                if GroupingValue = '' then
                    GroupingValue := BlankGroupValueLbl;

                TempGroupedRecIds.Init();
                TempGroupedRecIds."Grouping Value" := CopyStr(GroupingValue, 1, MaxStrLen(TempGroupedRecIds."Grouping Value"));
                TempGroupedRecIds."Line RecordId" := SalesLine.RecordId;
                TempGroupedRecIds.Insert();
            until SalesLine.Next() = 0;

        SalesLineRecRef.Close();
    end;

    local procedure GetOversizeBoxCode(var BoxSize: Record "Box Size"): Code[20]
    var
        DefaultOversizeCode: Code[20];
    begin
        DefaultOversizeCode := 'OVERSIZE'; // Define default
        BoxSize.SetRange("Is Oversize Box", true);
        if BoxSize.FindFirst() then
            exit(BoxSize.Code);

        exit(DefaultOversizeCode);
    end;

    local procedure ProcessGroupedLines(var PackingListHeader: Record "Packing List Header"; var TempGroupedRecIds: Record "Temp Grouped Line RecIds" temporary; var BoxSize: Record "Box Size"; OversizeBoxCode: Code[20]; var ProgressDialog: Dialog; LogMessageCategory: Text; var CurrentBoxNo: Integer)
    var
        TempItemUnit: Record "Temp Packing Item Unit" temporary;
        SalesLine: Record "Sales Line";
        Item: Record Item;
        GroupingValue: Text[250];
        LastGroupingValue: Text[250];
        PackingListLineNo: Integer;
        TotalGroupVolume: Decimal;
        MaxItemLength, MaxItemWidth, MaxItemHeight : Decimal;
        LineRecId: RecordId;
        EntryNo: Integer;
        GroupProcessingMsg: Label 'Processing Group: %1', Comment = '%1 = Grouping Value', Locked = true;
        ItemNotFoundWarning: Label 'Item %1 not found for Sales Line %2.', Comment = '%1 = Item No., %2 = Sales Line No.', Locked = true;
    begin
        // CurrentBoxNo is initialized ONCE in GeneratePackingList and must NOT be reset for each group. This ensures unique box numbers across all groups.
        PackingListLineNo := 0;
        TotalGroupVolume := 0;
        MaxItemLength := 0;
        MaxItemWidth := 0;
        MaxItemHeight := 0;
        LastGroupingValue := '';
        EntryNo := 0; // Initialize Entry No
        TempItemUnit.DeleteAll();

        // Consider adding SetCurrentKey if performance is an issue and a suitable key exists
        TempGroupedRecIds.SetCurrentKey("Grouping Value");
        TempGroupedRecIds.Reset();
        if TempGroupedRecIds.FindSet() then begin
            repeat
                GroupingValue := TempGroupedRecIds."Grouping Value";

                // Check if Grouping Value changed (start of a new group)
                if (GroupingValue <> LastGroupingValue) and (LastGroupingValue <> '') then begin
                    // Process the completed group
                    ProcessGroup(PackingListHeader, TempItemUnit, CurrentBoxNo, PackingListLineNo, TotalGroupVolume, MaxItemLength, MaxItemWidth, MaxItemHeight, LastGroupingValue, BoxSize, OversizeBoxCode);

                    // Reset for the new group
                    TempItemUnit.DeleteAll();
                    TotalGroupVolume := 0;
                    MaxItemLength := 0;
                    MaxItemWidth := 0;
                    MaxItemHeight := 0;
                    EntryNo := 0; // Reset Entry No for the new group's TempItemUnit
                end;

                // Update progress for the current group being processed (only when it changes)
                if GroupingValue <> LastGroupingValue then
                    ProgressDialog.Update(1, StrSubstNo(GroupProcessingMsg, GroupingValue));

                // Accumulate data for the current group item
                LineRecId := TempGroupedRecIds."Line RecordId";
                if SalesLine.Get(LineRecId) then
                    AccumulateItemGroupData(SalesLine, Item, TempItemUnit, TotalGroupVolume, MaxItemLength, MaxItemWidth, MaxItemHeight, EntryNo, LogMessageCategory, ItemNotFoundWarning)
                ; // Removed redundant Else block

                LastGroupingValue := GroupingValue; // Update last processed group value

            until TempGroupedRecIds.Next() = 0;

            // Process the very last group after the loop finishes
            if LastGroupingValue <> '' then begin
                ProcessGroup(PackingListHeader, TempItemUnit, CurrentBoxNo, PackingListLineNo, TotalGroupVolume, MaxItemLength, MaxItemWidth, MaxItemHeight, LastGroupingValue, BoxSize, OversizeBoxCode);
            end;
        end;
    end;

    local procedure AccumulateItemGroupData(SalesLine: Record "Sales Line"; var Item: Record Item; var TempItemUnit: Record "Temp Packing Item Unit" temporary; var TotalGroupVolume: Decimal; var MaxItemLength: Decimal; var MaxItemWidth: Decimal; var MaxItemHeight: Decimal; var EntryNo: Integer; LogMessageCategory: Text; ItemNotFoundWarning: Text)
    var
        QtyCounter: Integer;
        TempItemUnitEntry: Record "Temp Packing Item Unit" temporary; // Use a separate variable for insertion
    begin
        if Item.Get(SalesLine."No.") then begin
            for QtyCounter := 1 to SalesLine.Quantity do begin
                TempItemUnitEntry.Init(); // Init the separate variable
                EntryNo += 1;
                TempItemUnitEntry."Entry No." := EntryNo;
                TempItemUnitEntry."Source Line RecId" := SalesLine.RecordId;
                TempItemUnitEntry."Item No." := SalesLine."No.";
                TempItemUnitEntry."Variant Code" := SalesLine."Variant Code";
                TempItemUnitEntry.Description := SalesLine.Description;
                TempItemUnitEntry."Length" := Item."Length";
                TempItemUnitEntry."Width" := Item."Width";
                TempItemUnitEntry."Height" := Item."Height";
                TempItemUnitEntry.Volume := TempItemUnitEntry."Length" * TempItemUnitEntry."Width" * TempItemUnitEntry."Height";

                // Insert into the main temporary table passed by var
                TempItemUnit.TransferFields(TempItemUnitEntry);
                if TempItemUnit.Insert() then begin
                    TotalGroupVolume += TempItemUnit.Volume;
                    MaxItemLength := Max(MaxItemLength, TempItemUnit."Length");
                    MaxItemWidth := Max(MaxItemWidth, TempItemUnit."Width");
                    MaxItemHeight := Max(MaxItemHeight, TempItemUnit."Height");
                end else begin
                    // Handle potential insertion error if needed, e.g., log a message
                    LogMessage('AccumulateItemGroupData', StrSubstNo('Failed to insert TempItemUnit Entry No. %1 for Item %2', EntryNo, SalesLine."No."), Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', LogMessageCategory);
                end;
            end;
        end else begin
            LogMessage('GeneratePackingList', StrSubstNo(ItemNotFoundWarning, SalesLine."No.", SalesLine."Line No."), Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', LogMessageCategory);
        end;
    end;

    local procedure ProcessGroup(var PackingListHeader: Record "Packing List Header"; var TempItemUnit: Record "Temp Packing Item Unit" temporary; var CurrentBoxNo: Integer; var PackingListLineNo: Integer; TotalGroupVolume: Decimal; MaxItemLength: Decimal; MaxItemWidth: Decimal; MaxItemHeight: Decimal; GroupingValue: Text[250]; var BoxSize: Record "Box Size"; OversizeBoxCode: Code[20])
    var
        PackingListLine: Record "Packing List Line";
        SalesLine: Record "Sales Line";
        CurrentBoxSizeCode: Code[20];
        CurrentBoxVolume: Decimal;
        CurrentBoxLength: Decimal;
        CurrentBoxWidth: Decimal;
        CurrentBoxHeight: Decimal;
        RemainingBoxVolume: Decimal;
        ItemFits: Boolean;
        NeedsNewBox: Boolean;
        ItemsInCurrentBox: Integer;
        TempBoxTracker: Record "Packing List Line" temporary; // Used to track boxes and their remaining capacity
        FoundExistingBox: Boolean;
        Counter: Integer;
        NextLineNo: Integer;
    begin
        if not TempItemUnit.FindSet() then // Nothing to process for this group
            exit;

        // Remove any logic that resets or sets CurrentBoxNo here!
        // CurrentBoxNo is only incremented when a new box is created below.

        // Initialize box tracking variables
        CurrentBoxSizeCode := '';
        CurrentBoxVolume := 0;
        CurrentBoxLength := 0;
        CurrentBoxWidth := 0;
        CurrentBoxHeight := 0;
        RemainingBoxVolume := 0;
        ItemsInCurrentBox := 0;
        NextLineNo := GetNextPackingListLineNo(PackingListHeader."Document Type", PackingListHeader."Document No.");

        // Load existing boxes from this document into temp table for tracking
        LoadExistingBoxesInfo(PackingListHeader, TempBoxTracker);

        // Process each item
        repeat
            // Find suitable box for the current item
            ItemFits := false;
            FoundExistingBox := false;
            Counter += 1; // Reset counter for new box entries
            // First, check if item would fit in the currently active box (if any)
            if CurrentBoxSizeCode <> '' then begin
                ItemFits := DoesItemFitInBox(TempItemUnit.Volume, TempItemUnit."Length",
                    TempItemUnit."Width", TempItemUnit."Height", RemainingBoxVolume,
                    CurrentBoxLength, CurrentBoxWidth, CurrentBoxHeight);
            end;

            // If item doesn't fit in current box or no current box, find a suitable box
            if not ItemFits then begin
                // First try to find an existing box of appropriate size with enough space
                FoundExistingBox := FindExistingBoxWithCapacity(TempBoxTracker,
                    TempItemUnit.Volume, TempItemUnit."Length", TempItemUnit."Width",
                    TempItemUnit."Height", CurrentBoxNo, CurrentBoxSizeCode,
                    CurrentBoxVolume, CurrentBoxLength, CurrentBoxWidth, CurrentBoxHeight,
                    RemainingBoxVolume, GroupingValue);

                // If no suitable existing box found, create a new box
                if not FoundExistingBox then begin
                    CurrentBoxNo += 1; // Increment box number for the new box
                    ItemsInCurrentBox := 0; // Reset items count for the new box

                    // Find suitable box size for the current item
                    FindSuitableBox(BoxSize, TempItemUnit."Length", TempItemUnit."Width",
                        TempItemUnit."Height", TempItemUnit.Volume, CurrentBoxSizeCode,
                        CurrentBoxVolume, CurrentBoxLength, CurrentBoxWidth, CurrentBoxHeight, OversizeBoxCode);

                    // Initialize remaining volume with the total box volume
                    RemainingBoxVolume := CurrentBoxVolume;

                    // Add new box to tracker
                    AddBoxToTracker(TempBoxTracker, CurrentBoxNo, CurrentBoxSizeCode,
                        CurrentBoxVolume, CurrentBoxLength, CurrentBoxWidth, CurrentBoxHeight, RemainingBoxVolume, NextLineNo, GroupingValue);
                end;

                // At this point we either found an existing box or created a new one
                ItemFits := true; // We've ensured a suitable box
            end;

            if ItemFits then begin
                // Update remaining volume in the box
                RemainingBoxVolume -= TempItemUnit.Volume;
                ItemsInCurrentBox += 1;

                // Update the box tracker with new remaining volume
                UpdateBoxTrackerVolume(TempBoxTracker, CurrentBoxNo, RemainingBoxVolume);

                // Create packing list line for this item
                if SalesLine.Get(TempItemUnit."Source Line RecId") then begin
                    NextLineNo += 1;
                    PackingListLineNo := NextLineNo;
                    PackingListLine.Init();
                    PackingListLine."Document Type" := PackingListHeader."Document Type";
                    PackingListLine."Document No." := PackingListHeader."Document No.";
                    PackingListLine."Line No." := PackingListLineNo;
                    PackingListLine."Source Document Line No." := SalesLine."Line No.";
                    PackingListLine."Item No." := TempItemUnit."Item No.";
                    PackingListLine."Variant Code" := TempItemUnit."Variant Code";
                    PackingListLine.Description := TempItemUnit.Description;
                    PackingListLine."Unit Length" := TempItemUnit."Length";
                    PackingListLine."Unit Width" := TempItemUnit."Width";
                    PackingListLine."Unit Height" := TempItemUnit."Height";
                    PackingListLine."Unit Volume" := TempItemUnit.Volume;
                    PackingListLine."Box No." := CurrentBoxNo;
                    PackingListLine."Box Size Code" := CurrentBoxSizeCode;
                    PackingListLine."Grouping Criteria Value" := GroupingValue;
                    PackingListLine.Insert();
                end;
            end;
        until TempItemUnit.Next() = 0;

        // Update the header with the count of boxes - get the actual max box number
        UpdateHeaderBoxCount(PackingListHeader);
    end;

    // Loads existing boxes information into the temp tracker table
    local procedure LoadExistingBoxesInfo(PackingListHeader: Record "Packing List Header"; var TempBoxTracker: Record "Packing List Line" temporary)
    var
        PackingListLine: Record "Packing List Line";
        BoxSize: Record "Box Size";
        BoxNo: Integer;
        BoxSizeCode: Code[20];
        BoxVolume: Decimal;
        BoxLength: Decimal;
        BoxWidth: Decimal;
        BoxHeight: Decimal;
        ItemVolumeSum: Decimal;
        Counter: Integer;
    begin
        // Clear any existing data
        TempBoxTracker.Reset();
        TempBoxTracker.DeleteAll();

        // Group by Box No and Box Size Code to get total volume used in each box
        PackingListLine.Reset();
        PackingListLine.SetRange("Document Type", PackingListHeader."Document Type");
        PackingListLine.SetRange("Document No.", PackingListHeader."Document No.");
        if PackingListLine.FindSet() then
            repeat
                Counter += 1;
                // Check if this box is already in the tracker
                TempBoxTracker.Reset();
                TempBoxTracker.SetRange("Box No.", PackingListLine."Box No.");
                if TempBoxTracker.FindFirst() then begin
                    // Update used volume
                    TempBoxTracker."Unit Volume" := TempBoxTracker."Unit Volume" + PackingListLine."Unit Volume";
                    TempBoxTracker.Modify();
                end else begin
                    // This is a new box, add it to tracker
                    BoxNo := PackingListLine."Box No.";
                    BoxSizeCode := PackingListLine."Box Size Code";

                    // Get box dimensions from BoxSize table
                    if BoxSize.Get(BoxSizeCode) then begin
                        BoxVolume := BoxSize.Volume;
                        BoxLength := BoxSize.Length;
                        BoxWidth := BoxSize.Width;
                        BoxHeight := BoxSize.Height;
                    end else begin
                        // For oversize box or if box not found, use very large values
                        BoxVolume := 1000000;
                        BoxLength := 10000;
                        BoxWidth := 10000;
                        BoxHeight := 10000;
                    end;

                    // Add to tracker with the volume of this item already used
                    AddBoxToTracker(TempBoxTracker, BoxNo, BoxSizeCode, BoxVolume,
                        BoxLength, BoxWidth, BoxHeight, BoxVolume - PackingListLine."Unit Volume", Counter, PackingListLine."Grouping Criteria Value");
                end;
            until PackingListLine.Next() = 0;
    end;

    // Adds a box to the box tracker temp table
    local procedure AddBoxToTracker(var TempBoxTracker: Record "Packing List Line" temporary; BoxNo: Integer;
        BoxSizeCode: Code[20]; BoxVolume: Decimal; BoxLength: Decimal; BoxWidth: Decimal;
        BoxHeight: Decimal; RemainingVolume: Decimal; var NextLineNo: Integer; GroupingValue: Text[250])
    begin
        // Always increment NextLineNo to guarantee uniqueness
        NextLineNo += 1;
        TempBoxTracker.Init();
        TempBoxTracker."Line No." := NextLineNo;
        TempBoxTracker."Box No." := BoxNo;
        TempBoxTracker."Box Size Code" := BoxSizeCode;
        TempBoxTracker."Unit Length" := BoxLength; // Repurpose fields to store box dimensions
        TempBoxTracker."Unit Width" := BoxWidth;
        TempBoxTracker."Unit Height" := BoxHeight;
        TempBoxTracker."Unit Volume" := BoxVolume - RemainingVolume; // Store used volume
        TempBoxTracker.Description := Format(RemainingVolume); // Store remaining volume as string in description
        TempBoxTracker."Grouping Criteria Value" := GroupingValue; // Set grouping value for the box
        TempBoxTracker.Insert();
    end;

    // Updates the remaining volume for a box in the tracker
    local procedure UpdateBoxTrackerVolume(var TempBoxTracker: Record "Packing List Line" temporary; BoxNo: Integer; RemainingVolume: Decimal)
    var
        ItemVolume: Decimal;
    begin
        TempBoxTracker.Reset();
        TempBoxTracker.SetRange("Box No.", BoxNo);
        if TempBoxTracker.FindFirst() then begin
            Evaluate(ItemVolume, TempBoxTracker.Description);
            TempBoxTracker."Unit Volume" := (ItemVolume - RemainingVolume); // Update used volume
            TempBoxTracker.Description := Format(RemainingVolume); // Update remaining volume
            TempBoxTracker.Modify();
        end;
    end;

    // Finds an existing box with the same size and grouping value that has enough capacity for the item
    local procedure FindExistingBoxWithCapacity(var TempBoxTracker: Record "Packing List Line" temporary;
        ItemVolume: Decimal; ItemLength: Decimal; ItemWidth: Decimal; ItemHeight: Decimal;
        var BoxNo: Integer; var BoxSizeCode: Code[20]; var BoxVolume: Decimal;
        var BoxLength: Decimal; var BoxWidth: Decimal; var BoxHeight: Decimal;
        var RemainingVolume: Decimal; GroupingValue: Text[250]): Boolean
    var
        RemainingVolumeInBox: Decimal;
    begin
        TempBoxTracker.Reset();
        TempBoxTracker.SetRange("Grouping Criteria Value", GroupingValue); // Only consider boxes with the same grouping value
        if TempBoxTracker.FindSet() then
            repeat
                // Check if the current box has enough remaining capacity
                Evaluate(RemainingVolumeInBox, TempBoxTracker.Description);

                if (RemainingVolumeInBox >= ItemVolume) and
                   (TempBoxTracker."Unit Length" >= ItemLength) and
                   (TempBoxTracker."Unit Width" >= ItemWidth) and
                   (TempBoxTracker."Unit Height" >= ItemHeight) then begin

                    // Found a suitable existing box
                    BoxNo := TempBoxTracker."Box No.";
                    BoxSizeCode := TempBoxTracker."Box Size Code";
                    BoxLength := TempBoxTracker."Unit Length";
                    BoxWidth := TempBoxTracker."Unit Width";
                    BoxHeight := TempBoxTracker."Unit Height";
                    BoxVolume := TempBoxTracker."Unit Volume" + RemainingVolumeInBox;
                    RemainingVolume := RemainingVolumeInBox;

                    exit(true);
                end;
            until TempBoxTracker.Next() = 0;

        exit(false);
    end;

    // Updates header with the correct box count
    local procedure UpdateHeaderBoxCount(var PackingListHeader: Record "Packing List Header")
    var
        PackingListLine: Record "Packing List Line";
        MaxBoxNo: Integer;
    begin
        MaxBoxNo := 0;

        PackingListLine.Reset();
        PackingListLine.SetRange("Document Type", PackingListHeader."Document Type");
        PackingListLine.SetRange("Document No.", PackingListHeader."Document No.");
        PackingListLine.SetCurrentKey("Box No.");
        PackingListLine.Ascending(false); // Get highest box number

        if PackingListLine.FindFirst() then
            MaxBoxNo := PackingListLine."Box No.";

        if PackingListHeader.Get(PackingListHeader."Document Type", PackingListHeader."Document No.") then begin
            PackingListHeader."No. of Boxes Calculated" := MaxBoxNo;
            PackingListHeader.Modify();
        end;
    end;

    local procedure FinalizePackingList(var PackingListHeader: Record "Packing List Header")
    begin
        // Ensure the record is still selected before modifying
        if PackingListHeader.Get(PackingListHeader."Document Type", PackingListHeader."Document No.") then begin
            PackingListHeader.Status := PackingListHeader.Status::Packed; // Or ::Completed
            PackingListHeader.Modify(true);
        end else begin
            // Log error if header suddenly disappeared? Unlikely but possible.
            LogMessage('FinalizePackingList', StrSubstNo('Packing List Header %1 %2 not found for finalization.', PackingListHeader."Document Type", PackingListHeader."Document No."), Verbosity::Error, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', 'PackingList');
        end;
    end;

    // Helper function Max - Already exists in BaseApp, but included for completeness if needed standalone
    local procedure Max(Value1: Decimal; Value2: Decimal): Decimal
    begin
        if Value1 > Value2 then
            exit(Value1);
        exit(Value2);
    end;

    local procedure LogMessage(Activity: Text; MessageText: Text; LogVerbosity: Verbosity; LogDataClassification: DataClassification; LogTelemetryScope: TelemetryScope; CustomDimensionKey: Text; CustomDimensionValue: Text)
    var
        Dimensions: Dictionary of [Text, Text];
    begin
        Dimensions.Add(CustomDimensionKey, CustomDimensionValue);
        Session.LogMessage('AL0000', MessageText, LogVerbosity, LogDataClassification, LogTelemetryScope, Dimensions);
    end;

    // Checks if an item fits within the remaining space in a box
    local procedure DoesItemFitInBox(ItemVolume: Decimal; ItemLength: Decimal;
        ItemWidth: Decimal; ItemHeight: Decimal; RemainingBoxVolume: Decimal;
        BoxLength: Decimal; BoxWidth: Decimal; BoxHeight: Decimal): Boolean
    begin
        // Check if item fits volumetrically and dimensionally
        if (ItemVolume <= RemainingBoxVolume) and
           (ItemLength <= BoxLength) and
           (ItemWidth <= BoxWidth) and
           (ItemHeight <= BoxHeight) then
            exit(true);

        exit(false);
    end;

    // Finds a suitable box size for an item based on its dimensions, volume, and grouping criteria
    local procedure FindSuitableBox(var BoxSize: Record "Box Size"; ItemLength: Decimal;
        ItemWidth: Decimal; ItemHeight: Decimal; ItemVolume: Decimal;
        var BoxSizeCode: Code[20]; var BoxVolume: Decimal;
        var BoxLength: Decimal; var BoxWidth: Decimal;
        var BoxHeight: Decimal; OversizeBoxCode: Code[20])
    var
        BoxFound: Boolean;
    begin
        // Look for the smallest box that can fit the item and matches the grouping criteria
        BoxSize.Reset();
        BoxSize.SetFilter(Length, '>=%1', ItemLength);
        BoxSize.SetFilter(Width, '>=%1', ItemWidth);
        BoxSize.SetFilter(Height, '>=%1', ItemHeight);
        BoxSize.SetFilter(Volume, '>=%1', ItemVolume);
        BoxSize.SetRange("Is Oversize Box", false);
        BoxSize.SetCurrentKey(Volume); // Sort by volume to find smallest suitable box
        BoxSize.Ascending(true);

        BoxFound := BoxSize.FindFirst();

        if BoxFound then begin
            // Found a suitable regular box
            BoxSizeCode := BoxSize.Code;
            BoxVolume := BoxSize.Volume;
            BoxLength := BoxSize.Length;
            BoxWidth := BoxSize.Width;
            BoxHeight := BoxSize.Height;
        end else begin
            // No suitable regular box found, use oversize box
            if BoxSize.Get(OversizeBoxCode) then begin
                BoxSizeCode := OversizeBoxCode;
                BoxVolume := BoxSize.Volume;
                BoxLength := BoxSize.Length;
                BoxWidth := BoxSize.Width;
                BoxHeight := BoxSize.Height;
            end else begin
                // Fallback if oversize box is not found in the database
                BoxSizeCode := OversizeBoxCode;
                BoxVolume := 1000000; // Very large values
                BoxLength := 10000;
                BoxWidth := 10000;
                BoxHeight := 10000;
            end;
        end;
    end;

    // Helper to get the next available line number for a document
    local procedure GetNextPackingListLineNo(DocumentType: Enum "Sales Document Type"; DocumentNo: Code[20]): Integer
    var
        PackingListLine: Record "Packing List Line";
        MaxLineNo: Integer;
    begin
        MaxLineNo := 0;
        PackingListLine.SetRange("Document Type", DocumentType);
        PackingListLine.SetRange("Document No.", DocumentNo);
        if PackingListLine.FindSet() then
            repeat
                if PackingListLine."Line No." > MaxLineNo then
                    MaxLineNo := PackingListLine."Line No.";
            until PackingListLine.Next() = 0;
        exit(MaxLineNo);
    end;

    procedure CreateBinsForPackingList(var PackingListHeader: Record "Packing List Header")
    var
        PackingListLine: Record "Packing List Line";
        Bin: Record Bin;
        LocationCode: Code[10];
        ZoneCode: Code[10];
        BinCode: Code[20];
        BoxNo: Integer;
        LocationRec: Record Location;
    begin
        if PackingListHeader."Bins Created" then
            Error('Bins have already been created for this packing list.');
        LocationCode := PackingListHeader."Location Code";
        // Optionally, set ZoneCode from a default or config, or extend Packing List Header if needed
        ZoneCode := '';
        PackingListLine.SetRange("Document Type", PackingListHeader."Document Type");
        PackingListLine.SetRange("Document No.", PackingListHeader."Document No.");
        // Get zone from location
        if not LocationRec.Get(PackingListHeader."Location Code") then
            Error('Location not found.');
        if LocationRec."Shipping Zone Code" = '' then
            Error('Shipping Zone Code must be set on the Location Card.');
        ZoneCode := LocationRec."Shipping Zone Code";
        if PackingListLine.FindSet() then
            repeat
                BoxNo := PackingListLine."Box No.";
                BinCode := StrSubstNo('PL-%1-%2', DelStr(PackingListHeader."Document No.", 1, 3), BoxNo);
                if not Bin.Get(LocationCode, BinCode) then begin
                    Bin.Init();
                    Bin."Location Code" := LocationCode;
                    Bin."Zone Code" := ZoneCode;
                    Bin.Code := BinCode;
                    Bin."Packing List Document No." := PackingListHeader."Document No.";
                    Bin.Insert();
                end;
                // Set the Bin Code and Location Code on the Packing List Line
                PackingListLine."Bin Code" := BinCode;
                PackingListLine."Location Code" := LocationCode;
                PackingListLine.Modify();
            until PackingListLine.Next() = 0;
        PackingListHeader."Bins Created" := true;
        PackingListHeader.Modify(true);
    end;

    procedure DeleteBinsForPackingList(var PackingListHeader: Record "Packing List Header")
    var
        Bin: Record Bin;
    begin
        if not PackingListHeader."Bins Created" then
            Error('No bins have been created for this packing list.');
        Bin.SetRange("Packing List Document No.", PackingListHeader."Document No.");
        Bin.DeleteAll(true);
        PackingListHeader."Bins Created" := false;
        PackingListHeader.Modify(true);
    end;
}