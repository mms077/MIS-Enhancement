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
                    Editable = IsEditable;
                }
                field("Box Size Code"; Rec."Box Size Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size of the box this item unit is assigned to.';
                    Editable = IsEditable;
                }
                field("Grouping Criteria Value"; Rec."Grouping Criteria Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the grouping criteria value used for this item''s box assignment.';
                    Editable = false; // Can be made editable if needed
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item number.';
                    Editable = IsEditable;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the item.';
                    Editable = IsEditable;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the variant code of the item.';
                    Editable = IsEditable;
                }
                field("Source Document Line No."; Rec."Source Document Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the line number from the original source document.';
                    Editable = false;
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
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bin code for the item.';
                    Editable = false;
                    TableRelation = Bin.Code where("Location Code" = field("Location Code"));
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateBoxSizeForBox)
            {
                Caption = 'Update Box Size for Box';
                ToolTip = 'Update the box size for all lines with the same box number.';
                ApplicationArea = All;
                Image = Change;
                trigger OnAction()
                var
                    PackingListLine: Record "Packing List Line";
                    NewBoxSizeCode: Code[20];
                    BoxSize: Record "Box Size";
                begin
                    // Get the selected line
                    PackingListLine.Copy(Rec);
                    // Prompt for new box size
                    if Page.RunModal(Page::"Box Size List", BoxSize) = Action::LookupOK then begin

                        NewBoxSizeCode := BoxSize.Code;
                        // Update all lines with the same Document Type, Document No., and Box No.
                        PackingListLine.SetRange("Document Type", Rec."Document Type");
                        PackingListLine.SetRange("Document No.", Rec."Document No.");
                        PackingListLine.SetRange("Box No.", Rec."Box No.");
                        if PackingListLine.FindSet() then
                            repeat
                                PackingListLine."Box Size Code" := NewBoxSizeCode;
                                PackingListLine.Modify();
                            until PackingListLine.Next() = 0;
                        CurrPage.Update();
                        Message('Box size updated for all lines in box %1.', Rec."Box No.");
                    end;
                end;
            }

            action(MoveToDifferentBox)
            {
                Caption = 'Move to Different Box';
                ToolTip = 'Move the selected item to a different box, enforcing fit, grouping, and document constraints.';
                ApplicationArea = All;
                Image = MoveNegativeLines;
                trigger OnAction()
                var
                    PackingListLine: Record "Packing List Line";
                    TargetBoxNo: Integer;
                    TargetBoxSizeCode: Code[20];
                    BoxSize: Record "Box Size";
                    GroupingValue: Text[250];
                    FitOK: Boolean;
                    BoxNumbers: List of [Integer];
                    BoxLabels: Text[250];
                    SelectedIndex: Integer;
                    BoxLookup: Record "Packing List Line";
                    OldLine: Record "Packing List Line";
                    OldBoxNo: Integer;
                    OnlyOneInBox: Boolean;
                    RemainingInBox: Boolean;
                begin
                    PackingListLine.Copy(Rec);
                    GroupingValue := PackingListLine."Grouping Criteria Value";
                    OldBoxNo := Rec."Box No.";

                    // Check if this is the only item in the box
                    PackingListLine.SetRange("Document Type", Rec."Document Type");
                    PackingListLine.SetRange("Document No.", Rec."Document No.");
                    PackingListLine.SetRange("Box No.", Rec."Box No.");
                    OnlyOneInBox := PackingListLine.Count = 1;

                    if not Confirm('Move to a new box? (Yes = New Box, No = Existing Box)') then begin
                        // Collect available box numbers with the same grouping value
                        BoxLookup.SetRange("Document Type", Rec."Document Type");
                        BoxLookup.SetRange("Document No.", Rec."Document No.");
                        BoxLookup.SetRange("Grouping Criteria Value", GroupingValue);
                        BoxLookup.SetFilter("Box No.", '<>%1', Rec."Box No.");
                        BoxLookup.SetCurrentKey("Box No.");
                        if BoxLookup.FindSet() then
                            repeat
                                if not BoxNumbers.Contains(BoxLookup."Box No.") then begin
                                    BoxNumbers.Add(BoxLookup."Box No.");
                                    BoxLabels := BoxLabels + Format(BoxLookup."Box No.") + ' (' + BoxLookup."Box Size Code" + ')' + ',';
                                end;
                            until BoxLookup.Next() = 0;
                        BoxLabels := BoxLabels.Remove(StrLen(BoxLabels), 1); // Remove trailing comma
                        if BoxNumbers.Count = 0 then begin
                            Message('No existing boxes with the same grouping value. Use Yes to create a new box.');
                            exit;
                        end;
                        SelectedIndex := StrMenu(BoxLabels, 1, 'Select Target Box:');
                        if SelectedIndex < 1 then
                            exit;
                        TargetBoxNo := BoxNumbers.Get(SelectedIndex);
                        // Check fit
                        BoxLookup.SetRange("Box No.", TargetBoxNo);
                        if BoxLookup.FindFirst() then begin
                            BoxSize.Get(BoxLookup."Box Size Code");
                            FitOK := (Rec."Unit Length" <= BoxSize.Length) and (Rec."Unit Width" <= BoxSize.Width) and (Rec."Unit Height" <= BoxSize.Height) and (Rec."Unit Volume" <= BoxSize.Volume);
                            if not FitOK then begin
                                Message('Item does not fit in the selected box.');
                                exit;
                            end;
                            // Restriction: If original box is now empty, decrement all box numbers greater than the old box number by 1
                            if OnlyOneInBox then begin

                                // Move item
                                if TargetBoxNo < Rec."Box No." then begin
                                    Rec."Box No." := TargetBoxNo;
                                    Rec.Modify();
                                end;
                                PackingListLine.Reset();
                                PackingListLine.SetRange("Document Type", Rec."Document Type");
                                PackingListLine.SetRange("Document No.", Rec."Document No.");
                                PackingListLine.SetFilter("Box No.", StrSubstNo('>%1', OldBoxNo));
                                if PackingListLine.FindSet() then
                                    repeat
                                        PackingListLine.Validate("Box No.", PackingListLine."Box No." - 1);
                                        PackingListLine.Modify();
                                    until PackingListLine.Next() = 0;
                                // CurrPage.Update();
                            end
                            else begin
                                // Move item
                                Rec."Box No." := TargetBoxNo;
                                Rec.Modify();
                            end;
                            CurrPage.Update();
                            Message('Item moved to box %1.', TargetBoxNo);
                        end;
                    end else begin
                        // Restriction: If only one item in box, cannot create new box
                        if OnlyOneInBox then begin
                            Message('Cannot create a new box when this is the only item in the current box. Please update the box size instead.');
                            exit;
                        end;
                        // Prompt for box size
                        if Page.RunModal(Page::"Box Size List", BoxSize) = Action::LookupOK then begin
                            TargetBoxSizeCode := BoxSize.Code;
                            // Check fit
                            FitOK := (Rec."Unit Length" <= BoxSize.Length) and (Rec."Unit Width" <= BoxSize.Width) and (Rec."Unit Height" <= BoxSize.Height) and (Rec."Unit Volume" <= BoxSize.Volume);
                            if not FitOK then begin
                                Message('Item does not fit in the new box.');
                                exit;
                            end;
                            if OldLine.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
                                PackingListLine.SetRange("Document Type", OldLine."Document Type");
                                PackingListLine.SetRange("Document No.", OldLine."Document No.");
                                PackingListLine.SetFilter("Box No.", StrSubstNo('>%1', OldBoxNo));
                                if PackingListLine.FindSet() then
                                    repeat
                                        PackingListLine.Validate("Box No.", PackingListLine."Box No." + 1);
                                        PackingListLine.Modify();
                                    until PackingListLine.Next() = 0; // Increment all boxes after the old box number
                                CurrPage.Update();
                                Clear(PackingListLine);
                                PackingListLine.Get(OldLine."Document Type", OldLine."Document No.", OldLine."Line No.");
                                PackingListLine.Validate("Box No.", OldLine."Box No." + 1);
                                PackingListLine.Validate("Box Size Code", TargetBoxSizeCode);
                                PackingListLine.Modify(false);
                            end;
                            CurrPage.Update();
                            Message('Item moved to new box %1. All other boxes incremented.', OldLine."Box No." + 1);
                        end;
                    end;
                end;
            }
        }
    }


    local procedure GetHeaderBinsCreated(): Boolean
    var
        PackingListHeader: Record "Packing List Header";
    begin
        PackingListHeader.SetRange("Document Type", Rec."Document Type");
        PackingListHeader.SetRange("Document No.", Rec."Document No.");
        if PackingListHeader.FindFirst() then
            exit(PackingListHeader."Bins Created");
        exit(false);
    end;

    var
        IsEditable: Boolean;
}