// report 50250 "Revalue Items 2023"
// {
//     ProcessingOnly = true;
//     Caption = 'Revalue Items 2023';
//     UsageCategory = Tasks;
//     dataset
//     {
//         dataitem(Item; Item)
//         {
//             DataItemTableView = sorting("No.");
//             RequestFilterFields = "No.";
//             trigger OnAfterGetRecord()
//             var
//                 ItemLedgerEntry: Record "Item Ledger Entry";
//                 EntryNo: Integer;
//             begin
//                 Window.Update(1, "No.");

//                 // Get all item ledger entries for this item from 2023
//                 ItemLedgerEntry.Reset();
//                 ItemLedgerEntry.SetRange("Item No.", Item."No.");
//                 ItemLedgerEntry.SetRange(Positive, true);
//                 ItemLedgerEntry.SetRange("Posting Date", DMY2Date(1, 1, 2023), DMY2Date(31, 12, 2023));
//                 if ItemLedgerEntry.FindSet() then
//                     repeat
//                         ProcessItemLedgerEntry(ItemLedgerEntry);
//                         EntryNo += 1;
//                         Window.Update(2, EntryNo);
//                     until ItemLedgerEntry.Next() = 0;
//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(DocumentNo; DocumentNo)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Document No.';
//                         ToolTip = 'Specifies the document number for the journal entries.';
//                     }
//                 }
//             }
//         }

//         trigger OnOpenPage()
//         begin
//             // Set posting date to 31/12/2023 by default
//             PostingDate := DMY2Date(31, 12, 2023);
//             DocumentNo := '';
//             // Always filter on item 2.1191301.301
//             //ItemNoFilter := '1.76204.204';
//             GetCurrentJournalInfo();
//         end;
//     }

//     trigger OnPreReport()
//     var
//         ExistingItemJnlLine: Record "Item Journal Line";
//     begin
//         if DocumentNo = '' then
//             Error(MissingDocNoErr);
//         if JournalTemplateName = '' then
//             Error(MissingTemplateErr);
//         if JournalBatchName = '' then
//             Error(MissingBatchErr);

//         // Initialize LineNo by finding the highest existing line number
//         LineNo := 0;
//         ExistingItemJnlLine.Reset();
//         ExistingItemJnlLine.SetRange("Journal Template Name", JournalTemplateName);
//         ExistingItemJnlLine.SetRange("Journal Batch Name", JournalBatchName);
//         if ExistingItemJnlLine.FindLast() then
//             LineNo := ExistingItemJnlLine."Line No.";

//         // Always filter on the specific item 2.1191301.301
//         // Item.SetRange("No.", '1.76204.204');

//         Window.Open(ProcessingMsg);
//         ItemJnlLine.Reset();
//         ItemJnlLine.SetRange("Journal Template Name", JournalTemplateName);
//         ItemJnlLine.SetRange("Journal Batch Name", JournalBatchName);
//     end;

//     trigger OnPostReport()
//     begin
//         Window.Close();
//         if ItemJnlLine.FindFirst() then
//             Message(ProcessCompletedMsg, ItemJnlLine.Count);
//     end;

//     var
//         ItemJnlLine: Record "Item Journal Line";
//         Window: Dialog;
//         JournalTemplateName: Code[10];
//         JournalBatchName: Code[10];
//         PostingDate: Date;
//         DocumentNo: Code[20];
//         LineNo: Integer;
//         ItemNoFilter: Code[20];
//         MissingTemplateErr: Label 'You must specify a journal template name.';
//         MissingBatchErr: Label 'You must specify a journal batch name.';
//         MissingDateErr: Label 'You must specify a posting date.';
//         MissingDocNoErr: Label 'You must specify a document number.';
//         MissingGenProdPostingGrpErr: Label 'General Product Posting Group must have a value for Item %1.';
//         JournalNotEmptyQst: Label 'The journal batch is not empty. Do you want to continue?';
//         ProcessCompletedMsg: Label 'Process completed. %1 journal lines have been created.';
//         ProcessingMsg: Label 'Processing Item #1##########\Processing Entry #2##########';

//     local procedure GetCurrentJournalInfo()
//     var
//         ItemJournalBatch: Record "Item Journal Batch";
//     begin
//         // Use a default Revaluation template
//         ItemJournalBatch.Reset();
//         ItemJournalBatch.SetRange("Template Type", ItemJournalBatch."Template Type"::Revaluation);
//         if ItemJournalBatch.FindFirst() then begin
//             JournalTemplateName := ItemJournalBatch."Journal Template Name";
//             JournalBatchName := ItemJournalBatch.Name;
//         end;
//     end;

//     local procedure ProcessItemLedgerEntry(ItemLedgerEntry: Record "Item Ledger Entry")
//     var
//         NewUnitCost: Decimal;
//         Rate: Decimal;
//         ValueEntry: Record "Value Entry";
//         CostAmountActual: Decimal;
//         CostAmountACY: Decimal;
//     begin
//         // Aggregate only positive value entries (skip negative ones)
//         ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
//         if ValueEntry.FindSet() then
//             repeat
//                 if (ValueEntry."Cost Amount (Actual) (ACY)" > 0) then begin
//                     CostAmountActual += ValueEntry."Cost Amount (Actual)";
//                     CostAmountACY += ValueEntry."Cost Amount (Actual) (ACY)";
//                 end;
//             until ValueEntry.Next() = 0;

//         // Only revalue if ACY is positive and not zero
//         if (CostAmountACY > 0) then begin
//             // Calculate the adjustment so that (LCY + adjustment) / ACY = 89500
//             // Adjustment = (89500 * ACY) - LCY
//             NewUnitCost := 89500 / ItemLedgerEntry.Quantity;
//             Rate := 89500;
//             CreateRevaluationJournalLine(ItemLedgerEntry, NewUnitCost, Rate);
//         end;
//     end;

//     local procedure CreateRevaluationJournalLine(ItemLedgerEntry: Record "Item Ledger Entry"; NewUnitCost: Decimal; Rate: Decimal)
//     var
//         Item: Record Item;
//         ValueEntry: Record "Value Entry";
//         CostAmountActual: Decimal;
//         CostAmountACY: Decimal;
//         InventoryValueToSet: Decimal;
//         CostPerUnit: Decimal;
//         ExistingItemJnlLine: Record "Item Journal Line";
//         SumCostPerUnit: Decimal;
//         SumCostAmountLCY: Decimal;
//         ValueEntryCalc: Record "Value Entry";
//     begin
//         // Find the highest line number in the journal to avoid duplicates
//         ExistingItemJnlLine.Reset();
//         ExistingItemJnlLine.SetRange("Journal Template Name", JournalTemplateName);
//         ExistingItemJnlLine.SetRange("Journal Batch Name", JournalBatchName);
//         if ExistingItemJnlLine.FindLast() then
//             LineNo := ExistingItemJnlLine."Line No." + 10000
//         else
//             LineNo += 10000;

//         // Calculate current unit cost from value entries (only positive ACY)
//         ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
//         if ValueEntry.FindSet() then
//             repeat
//                 if (ValueEntry."Cost Amount (Actual) (ACY)" > 0) then begin
//                     CostAmountActual += ValueEntry."Cost Amount (Actual)";
//                     CostAmountACY += ValueEntry."Cost Amount (Actual) (ACY)";
//                 end;
//             until ValueEntry.Next() = 0;

//         // Get Item information first to ensure Gen. Prod. Posting Group is available
//         if not Item.Get(ItemLedgerEntry."Item No.") then
//             exit;

//         // Validate Gen. Prod. Posting Group
//         if Item."Gen. Prod. Posting Group" = '' then
//             Error(MissingGenProdPostingGrpErr, Item."No.");

//         // We want (CostAmountActual + AdjustmentValue) / CostAmountACY = 89500
//         // So: AdjustmentValue = (89500 * CostAmountACY) - CostAmountActual
//         InventoryValueToSet := (89500 * CostAmountACY) - CostAmountActual;


//         // Initialize the journal line
//         ItemJnlLine.Init();
//         ItemJnlLine.Validate("Journal Template Name", JournalTemplateName);
//         ItemJnlLine.Validate("Journal Batch Name", JournalBatchName);
//         ItemJnlLine."Line No." := LineNo;
//         ItemJnlLine.Validate("Document No.", DocumentNo);
//         ItemJnlLine.Validate("Posting Date", PostingDate);

//         // Set the entry type based on whether we're adding or subtracting value
//        // if InventoryValueToSet >= 0 then
//             ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.");
        

//         ItemJnlLine.Validate("Item No.", ItemLedgerEntry."Item No.");
//         ItemJnlLine.Validate("Gen. Prod. Posting Group", Item."Gen. Prod. Posting Group");
//         ItemJnlLine.Validate("Inventory Posting Group", Item."Inventory Posting Group");
//         ItemJnlLine.Validate(Description, GetItemDescription(ItemLedgerEntry."Item No."));
//         ItemJnlLine."Location Code" := ItemLedgerEntry."Location Code";
//         ItemJnlLine."Unit of Measure Code" := ItemLedgerEntry."Unit of Measure Code";

//         // Set quantity to the original item ledger entry quantity
//         ItemJnlLine.Validate(Quantity, ItemLedgerEntry.Quantity);
//         ItemJnlLine.Validate("Value Entry Type", ItemJnlLine."Value Entry Type"::Revaluation);

//         // Set the absolute value of the adjustment
//         ItemJnlLine."Inventory Value (Revalued)" := Abs(InventoryValueToSet);


//         // For revaluation entry, we need a direct relationship to the item ledger entry
//         ItemJnlLine."Applies-to Entry" := ItemLedgerEntry."Entry No.";



//         // Check if the line already exists, and if so, modify the line number to avoid duplicate key errors
//         if ItemJournalLineExists(JournalTemplateName, JournalBatchName, LineNo) then
//             LineNo += 1000;  // Add extra increment if line exists

//         ItemJnlLine."Line No." := LineNo;  // Set the line number after potential adjustment
//                                            // Calculate sum of cost per unit and sum of cost amount lcy for all value entries for this item

//         ValueEntryCalc.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
//         if ValueEntryCalc.FindSet() then
//             repeat
//                 SumCostAmountLCY += ValueEntryCalc."Cost Amount (Actual)";
//             until ValueEntryCalc.Next() = 0;

//         SumCostPerUnit := CostAmountActual / ItemLedgerEntry.Quantity;
//         // Set unit cost as requested
//         if SumCostAmountLCY <> 0 then
//             ItemJnlLine."Unit Cost" := Abs(InventoryValueToSet) * (SumCostPerUnit / SumCostAmountLCY)
//         else
//             ItemJnlLine."Unit Cost" := 0;

//         ItemJnlLine.Insert();

//     end;
//     // Check if an item journal line with the same key already exists
//     local procedure ItemJournalLineExists(TemplateName: Code[10]; BatchName: Code[10]; LineNumber: Integer): Boolean
//     var
//         TempItemJnlLine: Record "Item Journal Line";
//     begin
//         TempItemJnlLine.Reset();
//         TempItemJnlLine.SetRange("Journal Template Name", TemplateName);
//         TempItemJnlLine.SetRange("Journal Batch Name", BatchName);
//         TempItemJnlLine.SetRange("Line No.", LineNumber);
//         exit(TempItemJnlLine.FindFirst());
//     end;

//     local procedure GetItemDescription(ItemNo: Code[20]): Text[100]
//     var
//         Item: Record Item;
//     begin
//         if Item.Get(ItemNo) then
//             exit(Item.Description);
//         exit('');
//     end;
// }
