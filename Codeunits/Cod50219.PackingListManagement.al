codeunit 50219 "Packing List Management"
{
    // Removed OnRun trigger

    // Removed EnqueuePackingListGeneration procedure

    // Renamed GeneratePackingListInternal to GeneratePackingList and made public
    procedure GeneratePackingList(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        PackingListHeader: Record "Packing List Header";
        PackingListLine: Record "Packing List Line";
        BoxSize: Record "Box Size";
        Item: Record Item;
        TempGroupedRecIds: Record "Temp Grouped Line RecIds" temporary;
        TempItemUnit: Record "Temp Packing Item Unit" temporary;
        GroupingValue: Text[250];
        LastGroupingValue: Text[250]; // Added to track group changes
        CurrentBoxNo: Integer;
        PackingListLineNo: Integer;
        TotalGroupVolume: Decimal;
        AssignedBoxSizeCode: Code[20];
        IsMisfit: Boolean;
        MaxItemLength, MaxItemWidth, MaxItemHeight : Decimal;
        QtyCounter: Integer;
        OversizeBoxCode: Code[20];
        LineRecId: RecordId;
        SalesLineRecRef: RecordRef;
        GroupingFieldRef: FieldRef;
        GroupingValueVariant: Variant;
        ProgressDialog: Dialog;
        Step: Integer;
        TotalSteps: Integer;
        LogMessageCategory: Label 'PackingList', Locked = true; // Added for LogMessage category
        ProgressMsg: Label 'Generating Packing List for Order #1...\\Step #2 of #3', Comment = '%1 = Sales Order No., %2 = Current Step, %3 = Total Steps', Locked = true;
        GroupProcessingMsg: Label 'Processing Group: %1', Comment = '%1 = Grouping Value', Locked = true;
        FinalizingMsg: Label 'Finalizing Packing List...', Locked = true;
        ItemNotFoundWarning: Label 'Item %1 not found for Sales Line %2.', Comment = '%1 = Item No., %2 = Sales Line No.', Locked = true;
        InvalidGroupingFieldErr: Label 'Invalid Grouping Criteria Field Number (%1) selected on Sales Order %2.', Comment = '%1 = Field No., %2 = Sales Order No.', Locked = true;
        NoGroupingFieldErr: Label 'No Grouping Criteria Field No. selected on Sales Order %1.', Comment = '%1 = Sales Order No.', Locked = true;
        BlankGroupValueLbl: Label '<BLANK>', Locked = true;
        EntryNo: Integer;
    begin
        SalesHeader.TestField("No."); // Ensure we have a valid header

        if SalesHeader."Grouping Criteria Field No." = 0 then
            Error(NoGroupingFieldErr, SalesHeader."No.");

        // --- Progress Dialog Setup ---
        TotalSteps := 4; // Adjusted steps: Delete+Create Header, Group Lines, Process Groups, Finalize
        Step := 0;
        ProgressDialog.Open(ProgressMsg, SalesHeader."No.", Step, TotalSteps);

        // --- Step 1: Delete existing & Create new Packing List Header ---
        Step += 1;
        ProgressDialog.Update(2, Step); // Update step number in the message
        PackingListHeader.SetRange("Document Type", SalesHeader."Document Type");
        PackingListHeader.SetRange("Document No.", SalesHeader."No.");
        if PackingListHeader.FindFirst() then
            PackingListHeader.Delete(true);

        PackingListHeader.Init();
        PackingListHeader."Document Type" := SalesHeader."Document Type";
        PackingListHeader."Document No." := SalesHeader."No.";
        PackingListHeader.Status := PackingListHeader.Status::"In Progress";
        PackingListHeader."Generation DateTime" := CurrentDateTime();
        PackingListHeader.Insert();

        // --- Step 2: Group Sales Lines using Temp Table ---
        Step += 1;
        ProgressDialog.Update(2, Step);
        SalesLineRecRef.Open(Database::"Sales Line");
        GroupingFieldRef := SalesLineRecRef.Field(SalesHeader."Grouping Criteria Field No.");
        if not GroupingFieldRef.Active then begin
            SalesLineRecRef.Close();
            ProgressDialog.Close();
            Error(InvalidGroupingFieldErr, SalesHeader."Grouping Criteria Field No.", SalesHeader."No.");
        end;

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
                TempGroupedRecIds."Grouping Value" := CopyStr(GroupingValue, 1, MaxStrLen(TempGroupedRecIds."Grouping Value")); // Ensure length constraint
                TempGroupedRecIds."Line RecordId" := SalesLine.RecordId;
                TempGroupedRecIds.Insert();
            until SalesLine.Next() = 0;

        SalesLineRecRef.Close();

        // Find Oversize Box Code
        BoxSize.SetRange("Is Oversize Box", true);
        if BoxSize.FindFirst() then
            OversizeBoxCode := BoxSize.Code
        else
            OversizeBoxCode := 'OVERSIZE'; // Default if none found

        // --- Step 3: Process each group ---
        Step += 1;
        ProgressDialog.Update(2, Step);
        CurrentBoxNo := 0;
        PackingListLineNo := 0;
        TotalGroupVolume := 0;
        MaxItemLength := 0;
        MaxItemWidth := 0;
        MaxItemHeight := 0;
        LastGroupingValue := '';
        TempItemUnit.DeleteAll();

        // Assuming TempGroupedRecIds has a key like: Key "GroupingValueKey" ("Grouping Value")
        // If not, add one or adjust the SetCurrentKey call.
        // TempGroupedRecIds.SetCurrentKey("Grouping Value"); // Set key for efficient group processing
        TempGroupedRecIds.Reset();
        if TempGroupedRecIds.FindSet() then begin
            repeat
                GroupingValue := TempGroupedRecIds."Grouping Value";

                // Check if Grouping Value changed (start of a new group)
                if (GroupingValue <> LastGroupingValue) and (LastGroupingValue <> '') then begin
                    // Process the completed group (the one defined by LastGroupingValue)
                    ProcessGroup(PackingListHeader, TempItemUnit, CurrentBoxNo, PackingListLineNo, TotalGroupVolume, MaxItemLength, MaxItemWidth, MaxItemHeight, LastGroupingValue, BoxSize, OversizeBoxCode);

                    // Reset for the new group
                    TempItemUnit.DeleteAll();
                    TotalGroupVolume := 0;
                    MaxItemLength := 0;
                    MaxItemWidth := 0;
                    MaxItemHeight := 0;
                end;

                // Update progress for the current group being processed
                if GroupingValue <> LastGroupingValue then
                    ProgressDialog.Update(1, StrSubstNo(GroupProcessingMsg, GroupingValue));

                // Accumulate data for the current group item
                LineRecId := TempGroupedRecIds."Line RecordId";
                if SalesLine.Get(LineRecId) then begin
                    if Item.Get(SalesLine."No.") then begin
                        for QtyCounter := 1 to SalesLine.Quantity do begin
                            TempItemUnit.Init();
                            EntryNo += 1;
                            TempItemUnit."Entry No." := EntryNo; // Let system handle if AutoIncrement
                            TempItemUnit."Source Line RecId" := SalesLine.RecordId;
                            TempItemUnit."Item No." := SalesLine."No.";
                            TempItemUnit."Variant Code" := SalesLine."Variant Code";
                            TempItemUnit.Description := SalesLine.Description;
                            TempItemUnit."Length" := Item."Length";
                            TempItemUnit."Width" := Item."Width";
                            TempItemUnit."Height" := Item."Height";
                            TempItemUnit.Volume := TempItemUnit."Length" * TempItemUnit."Width" * TempItemUnit."Height";
                            if TempItemUnit.Insert() then begin // Only accumulate if insert succeeds
                                TotalGroupVolume += TempItemUnit.Volume;
                                MaxItemLength := Max(MaxItemLength, TempItemUnit."Length");
                                MaxItemWidth := Max(MaxItemWidth, TempItemUnit."Width");
                                MaxItemHeight := Max(MaxItemHeight, TempItemUnit."Height");
                            end;
                        end;
                    end else begin
                        LogMessage('GeneratePackingList', StrSubstNo(ItemNotFoundWarning, SalesLine."No.", SalesLine."Line No."), Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', LogMessageCategory);
                    end;
                end;

                LastGroupingValue := GroupingValue; // Update last processed group value

            until TempGroupedRecIds.Next() = 0;

            // Process the very last group after the loop finishes
            if LastGroupingValue <> '' then begin
                ProcessGroup(PackingListHeader, TempItemUnit, CurrentBoxNo, PackingListLineNo, TotalGroupVolume, MaxItemLength, MaxItemWidth, MaxItemHeight, LastGroupingValue, BoxSize, OversizeBoxCode);
            end;
        end;

        // --- Step 4: Finalize ---
        Step += 1;
        ProgressDialog.Update(1, FinalizingMsg);
        ProgressDialog.Update(2, Step);
        PackingListHeader.Status := PackingListHeader.Status::Packed; // Or ::Completed, depending on enum values
        PackingListHeader.Modify(true);

        ProgressDialog.Close();

    end;

    local procedure ProcessGroup(PackingListHeader: Record "Packing List Header"; var TempItemUnit: Record "Temp Packing Item Unit" temporary; var CurrentBoxNo: Integer; var PackingListLineNo: Integer; TotalGroupVolume: Decimal; MaxItemLength: Decimal; MaxItemWidth: Decimal; MaxItemHeight: Decimal; GroupingValue: Text[250]; var BoxSize: Record "Box Size"; OversizeBoxCode: Code[20])
    var
        PackingListLine: Record "Packing List Line";
        SalesLine: Record "Sales Line";
        AssignedBoxSizeCode: Code[20];
        IsMisfit: Boolean;
        BoxVolumeKey: Label 'Volume', Locked = true; // Example key name, adjust if needed
    begin
        if not TempItemUnit.FindSet() then // Nothing to process for this group
            exit;

        CurrentBoxNo += 1;

        // Find suitable box
        AssignedBoxSizeCode := '';
        IsMisfit := true;
        BoxSize.Reset();
        BoxSize.SetRange("Is Oversize Box", false);
        // BoxSize.SetCurrentKey(Volume); // Assuming a key on Volume exists for sorting
        BoxSize.SetFilter(Volume, '>=%1', TotalGroupVolume); // Filter for minimum volume first
        BoxSize.SetFilter(Length, '>=%1', MaxItemLength); // Filter for minimum dimensions
        BoxSize.SetFilter(Width, '>=%1', MaxItemWidth);
        BoxSize.SetFilter(Height, '>=%1', MaxItemHeight);
        BoxSize.Ascending(true); // Find the smallest suitable box

        if BoxSize.FindFirst() then begin
            AssignedBoxSizeCode := BoxSize.Code;
            IsMisfit := false;
        end;

        if IsMisfit then
            AssignedBoxSizeCode := OversizeBoxCode;

        // Create Packing List Lines for the items in TempItemUnit
        TempItemUnit.Reset(); // Ensure we iterate all items for the group
        if TempItemUnit.FindSet() then begin
            repeat
                // Getting SalesLine again might be redundant if all info is in TempItemUnit,
                // but needed here for "Source Document Line No."
                if SalesLine.Get(TempItemUnit."Source Line RecId") then begin
                    PackingListLineNo += 1;
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
                    PackingListLine."Box Size Code" := AssignedBoxSizeCode;
                    PackingListLine."Grouping Criteria Value" := GroupingValue;
                    PackingListLine.Insert();
                end;
            until TempItemUnit.Next() = 0;
        end;
    end;

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

}