codeunit 50214 "Sales Order Grouping Mgt."
{
    procedure GroupSalesLines(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        SalesLineRecRef: RecordRef;
        GroupingFieldRef: FieldRef;
        GroupingValueVariant: Variant;
        GroupingValueText: Text;
        TempGrouping: Record "Name/Value Buffer" temporary;
        Counter: Integer;
    begin
        // Check if a grouping criterion is selected
        if SalesHeader."Grouping Criteria Field No." = 0 then
            exit; // No grouping needed

        // Open RecordRef for Sales Line to get FieldRef later
        SalesLineRecRef.Open(Database::"Sales Line");
        GroupingFieldRef := SalesLineRecRef.Field(SalesHeader."Grouping Criteria Field No.");

        // Check if the selected field is valid
        if not GroupingFieldRef.Active then begin
            SalesLineRecRef.Close();
            Error('Invalid Grouping Criteria Field Number selected on the Sales Header.');
        end;

        // Iterate through sales lines
        Counter := 1; // Initialize counter for ID field
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then begin
            repeat
                // Get the value of the grouping field for the current line
                SalesLineRecRef.Get(SalesLine.RecordId);
                GroupingValueVariant := SalesLineRecRef.Field(SalesHeader."Grouping Criteria Field No.").Value;

                // Convert variant to text to use as key
                GroupingValueText := Format(GroupingValueVariant);
                if GroupingValueText = '' then
                    GroupingValueText := '<BLANK>'; // Handle blank values

                // Store the grouping in temporary record
                // Name will store the group value, Value will store the line number
                TempGrouping.ID := Counter; // Use integer counter
                TempGrouping.Name := GroupingValueText;
                TempGrouping.Value := Format(SalesLine."Line No.");
                TempGrouping.Insert();
                Counter += 1; // Increment counter

            until SalesLine.Next() = 0;
        end;

        SalesLineRecRef.Close();

        // --- Display the groups found
        TempGrouping.Reset();
        TempGrouping.SetCurrentKey(Name);
        DisplayGroups(SalesHeader, TempGrouping);
    end;

    local procedure DisplayGroups(SalesHeader: Record "Sales Header"; var TempGrouping: Record "Name/Value Buffer" temporary)
    var
        OutputMessage: Text;
        GroupingValueText: Text;
    begin
        OutputMessage := 'Sales Lines Grouped by Field "' + SalesHeader."Grouping Criteria Field Name" + '":\';

        if TempGrouping.FindSet() then begin
            GroupingValueText := TempGrouping.Name;
            OutputMessage += '\Group Value: ' + GroupingValueText + ' -> Lines: ';

            repeat
                // If we encounter a new group value, start a new line
                if GroupingValueText <> TempGrouping.Name then begin
                    // Remove trailing comma and space
                    if StrLen(OutputMessage) > 2 then
                        OutputMessage := CopyStr(OutputMessage, 1, StrLen(OutputMessage) - 2);

                    GroupingValueText := TempGrouping.Name;
                    OutputMessage += '\Group Value: ' + GroupingValueText + ' -> Lines: ';
                end;

                OutputMessage += TempGrouping.Value + ', ';
            until TempGrouping.Next() = 0;

            // Remove trailing comma and space from last group
            if StrLen(OutputMessage) > 2 then
                OutputMessage := CopyStr(OutputMessage, 1, StrLen(OutputMessage) - 2);
        end;

        Message(OutputMessage);
    end;
}