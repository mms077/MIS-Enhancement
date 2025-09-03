pageextension 50262 "Revaluation Journal Ext" extends "Revaluation Journal"
{
    actions
    {
        addafter("Calculate Inventory Value")
        {
            action("Revalue Items 2024")
            {
                ApplicationArea = All;
                Caption = 'Revalue Items 2024';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Revalues items from 2023 with specific pricing rules.';

                trigger OnAction()
                var
                    ValueEntry: Record "Value Entry";
                    SumCostACY: Decimal;
                    SumCostLCY: Decimal;
                    InventoryValueRevalued: Decimal;
                    StartDate: Date;
                    EndDate: Date;
                    ItemJournalLine: Record "Item Journal Line";
                    ErrorText: Text;
                    LineCounter: Integer;
                begin
                    // Use the ItemJournalLine parameter directly
                    Clear(ItemJournalLine);
                    ItemJournalLine.SetFilter("Journal Template Name", 'REVALUATIO');
                    ItemJournalLine.SetFilter("Journal Batch Name", 'DEFAULT');
                    LineCounter := 0;
                    if ItemJournalLine.FindSet() then
                        repeat
                            LineCounter += 1;
                            StartDate := DMY2DATE(1, 1, 2024);
                            EndDate := DMY2DATE(31, 12, 2024);
                            SumCostACY := 0;
                            SumCostLCY := 0;
                            ValueEntry.Reset();
                            ValueEntry.SetRange("Item No.", ItemJournalLine."Item No.");
                            ValueEntry.SetRange("Posting Date", StartDate, EndDate);
                            ValueEntry.SetFilter("Location Code", ItemJournalLine."Location Code");
                            // Filter by variant code if it's not empty
                            if ItemJournalLine."Variant Code" <> '' then
                                ValueEntry.SetRange("Variant Code", ItemJournalLine."Variant Code");
                            if ValueEntry.FindSet() then begin
                                repeat
                                    SumCostACY += ValueEntry."Cost Amount (Actual) (ACY)";
                                    SumCostLCY += ValueEntry."Cost Amount (Actual)";
                                until ValueEntry.Next() = 0;

                                // Apply formula: (SumCostACY * 89500) - SumCostLCY
                                InventoryValueRevalued := (SumCostACY * 89500) - SumCostLCY;

                                // Add to existing Inventory Value (Revalued)
                                InventoryValueRevalued := ItemJournalLine."Inventory Value (Revalued)" + InventoryValueRevalued;

                                // Try to modify the line with error handling
                                if not TryModifyJournalLine(ItemJournalLine, InventoryValueRevalued) then begin
                                    ErrorText := GetLastErrorText();
                                    Message('Error modifying journal line %1 (Item: %2, Line No: %3): %4',
                                           LineCounter, ItemJournalLine."Item No.", ItemJournalLine."Line No.", ErrorText);
                                    ClearLastError();
                                end;
                            end;
                        until ItemJournalLine.Next() = 0;
                end;
            }
            // action("Revalue Items 2023 on 89,500")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Revalue Items 2023 on 89,500';
            //     Image = Report;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ToolTip = 'Revalues items from 2023 with specific pricing rules.';

            //     trigger OnAction()
            //     var
            //         RevalJnlLine: Record "Item Journal Line";
            //         RevalueItems2023: Report "Revalue Items 2023";
            //     begin
            //         RevalJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
            //         RevalJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");

            //         // Pass template and batch name to the report
            //         RevalueItems2023.RunModal();
            //     end;
            // }
        }
    }

    [TryFunction]
    local procedure TryModifyJournalLine(var ItemJournalLine: Record "Item Journal Line"; InventoryValueRevalued: Decimal)
    begin
        ItemJournalLine.Validate("Inventory Value (Revalued)", InventoryValueRevalued);
        ItemJournalLine.Adjustment := true;
        ItemJournalLine.Modify(true);
    end;
}
