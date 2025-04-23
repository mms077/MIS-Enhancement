page 50355 "Packing List Lines Subform" // Assigning next available ID for the subform page part
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Packing List Line";
    Caption = 'Lines';
    AutoSplitKey = true; // Automatically splits lines based on keys

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Box No."; Rec."Box No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the box number this item unit is assigned to.';
                }
                field("Box Size Code"; Rec."Box Size Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size of the box this item unit is assigned to.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item number.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the item.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the variant code of the item.';
                }
                field("Source Document Line No."; Rec."Source Document Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the line number from the original source document.';
                }
                field("Grouping Criteria Value"; Rec."Grouping Criteria Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the grouping criteria value used for this item''s box assignment.';
                    Visible = false; // Can be made visible if needed
                }
                field("Unit Length"; Rec."Unit Length")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the length of one unit of the item.';
                    Visible = false;
                }
                field("Unit Width"; Rec."Unit Width")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the width of one unit of the item.';
                    Visible = false;
                }
                field("Unit Height"; Rec."Unit Height")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the height of one unit of the item.';
                    Visible = false;
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the volume of one unit of the item.';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // action(ReassignBox)
            // {
            //     Caption = 'Reassign Box';
            //     ToolTip = 'Move selected lines to a different or new box.';
            //     ApplicationArea = All;
            //     Image = MoveNegativeLines; // Example icon

            //     trigger OnAction()
            //     var
            //         PackingListLine: Record "Packing List Line";
            //         NewBoxNo: Integer;
            //         NewBoxSizeCode: Code[20];
            //         ConfirmManagement: Codeunit "Confirm Management";
            //         BoxSize: Record "Box Size";
            //         PackingListHeader: Record "Packing List Header";
            //         NextBoxNo: Integer;
            //     begin
            //         CurrPage.SetSelectionFilter(PackingListLine);
            //         if not PackingListLine.FindFirst() then
            //             exit;

            //         // Simple prompt for now, could be a dedicated page
            //         if not (InputBox('Enter New Box No. (0 for New Box):', PackingListLine."Box No.", NewBoxNo) and
            //                 InputBox('Enter New Box Size Code:', PackingListLine."Box Size Code", NewBoxSizeCode)) then
            //             Error('Reassignment cancelled.');

            //         // Validate Box Size Code
            //         if not BoxSize.Get(NewBoxSizeCode) then
            //             Error('Box Size Code %1 does not exist.', NewBoxSizeCode);

            //         // Check if creating a new box
            //         if NewBoxNo = 0 then begin
            //             if PackingListHeader.Get(PackingListLine."Document Type", PackingListLine."Document No.") then begin
            //                 // Find the next available box number for this document
            //                 NextBoxNo := PackingListHeader."No. of Boxes Calculated" + 1; // Simple approach
            //                 // Could also query max Box No. from lines for robustness
            //                 NewBoxNo := NextBoxNo;
            //                 // Update header count - needs careful handling if multiple users do this
            //                 PackingListHeader."No. of Boxes Calculated" := NewBoxNo;
            //                 PackingListHeader.Modify();
            //             end else
            //                 Error('Could not find Packing List Header.'); // Should not happen
            //         end;


            //         // Confirmation
            //         if not ConfirmManagement.GetResponseOrDefault(StrSubstNo('Reassign %1 selected lines to Box No. %2 (Size: %3)?', PackingListLine.Count, NewBoxNo, NewBoxSizeCode), true) then
            //             Error('Reassignment cancelled.');

            //         // Perform the update
            //         repeat
            //             // **Important**: Add validation here to ensure the moved item's Grouping Criteria Value
            //             // matches the criteria of other items already in the target NewBoxNo (if it's not a new box).
            //             // This requires querying existing lines in the target box. For simplicity, skipping this strict validation for now.

            //             PackingListLine."Box No." := NewBoxNo;
            //             PackingListLine."Box Size Code" := NewBoxSizeCode;
            //             PackingListLine.Modify();
            //         until PackingListLine.Next() = 0;

            //         CurrPage.Update();
            //         Message('%1 lines reassigned.', PackingListLine.Count);
            //     end;
            // }
        }
    }

    // local procedure InputBox(Prompt: Text; DefaultValue: Variant; var ResultValue: Variant): Boolean
    // var
    //     InputString: Text;
    // begin
    //     InputString := Format(DefaultValue); // Start with default
    //     if StrMenu(Prompt + '\Current: ' + InputString, 1, '&OK,&Cancel') = 1 then begin
    //         if Page.RunModal(Page::"Input Dialog", Rec, FieldNo("Document No."), InputString) = Action::OK then begin
    //             // Attempt to evaluate the input based on the type of ResultValue
    //             // This is a simplified example; robust type handling is needed
    //             if ResultValue is Integer then
    //                 Evaluate(ResultValue, InputString)
    //             else
    //                 if ResultValue is Code[20] then
    //                     Evaluate(ResultValue, InputString) // Assumes Code[20] for Box Size Code
    //                 else
    //                     Error('Unsupported data type for input box.'); // Handle other types if needed
    //             exit(true);
    //         end;
    //     end;
    //     exit(false);
    // end;
}