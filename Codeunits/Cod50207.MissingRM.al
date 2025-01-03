codeunit 50207 "Missing RM"
{
    /// <summary>
    /// This function is used to fill the required raw material for the sales quote after release to check for missing RM.
    /// </summary>
    /// <param name="SalesQuoteNo"></param>
    procedure FillRequiredRM(SalesQuoteNo: Code[20])
    var
        GLSetupRec: Record "General Ledger Setup";
        SalesQuoteLineRec: Record "Sales Line";
        NeededRMRec: Record "Needed Raw Material";
        RMperSalesQuoteRec: Record "RM per Sales Quote";
        ItemUOMRec: Record "Item Unit of Measure";
        ItemRec: Record Item;
    begin
        GLSetupRec.Get();
        if GLSetupRec."Company Type" = GLSetupRec."Company Type"::"Full Production" then begin
            SalesQuoteLineRec.SetRange("Document Type", SalesQuoteLineRec."Document Type"::Quote);
            SalesQuoteLineRec.SetRange("Document No.", SalesQuoteNo);
            SalesQuoteLineRec.SetRange("Type", SalesQuoteLineRec."Type"::Item);
            if SalesQuoteLineRec.FindSet() then
                repeat
                    NeededRMRec.SetRange(Batch, SalesQuoteLineRec."Needed RM Batch");
                    if NeededRMRec.FindSet() then
                        repeat
                            RMperSalesQuoteRec.SetRange("Sales Quote No.", NeededRMRec."Sales Order No.");
                            RMperSalesQuoteRec.SetRange("Item No.", NeededRMRec."RM Code");
                            RMperSalesQuoteRec.SetRange("Variant Code", NeededRMRec."RM Variant Code");
                            if RMperSalesQuoteRec.FindFirst() then begin
                                ItemUOMRec.Get(NeededRMRec."RM Code", NeededRMRec."Assembly Line UOM Code");
                                RMperSalesQuoteRec.Validate("Required Qty.", RMperSalesQuoteRec."Required Qty." + (NeededRMRec."Assembly Line Quantity" * ItemUOMRec."Qty. per Unit of Measure"));
                                RMperSalesQuoteRec.Modify();
                            end
                            else begin
                                ItemRec.Get(NeededRMRec."RM Code");
                                ItemUOMRec.Get(NeededRMRec."RM Code", NeededRMRec."Assembly Line UOM Code");
                                RMperSalesQuoteRec.Init();
                                RMperSalesQuoteRec.Validate("Sales Quote No.", NeededRMRec."Sales Order No.");
                                RMperSalesQuoteRec.Validate("Item No.", NeededRMRec."RM Code");
                                RMperSalesQuoteRec.Validate("Variant Code", NeededRMRec."RM Variant Code");
                                RMperSalesQuoteRec.Validate("BUOM", ItemRec."Base Unit of Measure");
                                RMperSalesQuoteRec.Validate("Required Qty.", NeededRMRec."Assembly Line Quantity" * ItemUOMRec."Qty. per Unit of Measure");
                                RMperSalesQuoteRec.Insert();
                            end;
                        until NeededRMRec.Next = 0;
                until SalesQuoteLineRec.next = 0;
        end;
    end;


    /// <summary>
    /// This function is used to delete the previous raw material per sales quote on previous release.
    /// </summary>
    /// <param name="SalesQuoteNo"></param>
    internal procedure DeletePreviousRMperSQ(SalesQuoteNo: Code[20])
    var
        RMperSalesQuoteRec: Record "RM per Sales Quote";
    begin
        RMperSalesQuoteRec.SetRange("Sales Quote No.", SalesQuoteNo);
        if RMperSalesQuoteRec.FindSet() then
            RMperSalesQuoteRec.DeleteAll(true);
    end;

    procedure CalculateAvlQty(SalesQuoteRec: Record "Sales Header")
    var
        RMperSQRec: Record "RM per Sales Quote";
        ItemRec: Record Item;
        RmPerSQSD: Page "RM per Sales Quote SD";
        ItemAvailabilityMgt: Codeunit "Item Availability Forms Mgt";
        GrossRequirement: Decimal; // Declare the variable GrossRequirement
        PlannedOrderReceipt: Decimal; // Declare the variable PlannedOrderReceipt
        ScheduledReceipt: Decimal; // Declare the variable ScheduledReceipt
        PlannedOrderReleases: Decimal; // Declare the variable PlannedOrderReleases
        ProjectedQty: Decimal; // Declare the variable ProjectedQty
        RMAvlLofRec: Record "Raw Material Availability Log";
        RMPerSQList: Page "RM per Sales Quote List";
        UserSetupRec: Record "User Setup";
    begin
        Clear(CountOfMissingItems);
        RMperSQRec.SetFilter("Sales Quote No.", SalesQuoteRec."No.");
        if RMperSQRec.FindSet() then
            repeat
                ItemRec.Get(RMperSQRec."Item No.");
                ItemRec.SetFilter("Variant Filter", RMperSQRec."Variant Code");
                ItemAvailabilityMgt.CalculateNeed(ItemRec, GrossRequirement, PlannedOrderReceipt, ScheduledReceipt, PlannedOrderReleases);
                RMperSQRec.Validate("Available Qty.", (ItemRec.Inventory + PlannedOrderReceipt + ScheduledReceipt - GrossRequirement));
                RMperSQRec.Modify();
                if RMperSQRec."Req Qty is Missing" then
                    CountOfMissingItems += 1;
            until RMperSQRec.Next = 0;
        if CountOfMissingItems > 0 then begin
            Commit();
            UserSetupRec.get(UserId);
            if UserSetupRec."Bypass Missing RM" then begin
                RmPerSQSD.SetTableView(RMperSQRec);
                if RmPerSQSD.RunModal() = Action::OK then begin
                    AddRMWarningLog(RMperSQRec."Sales Quote No.");
                end
                else
                    Error('Make Order Canceled.');
            end else begin
                RMPerSQList.SetTableView(RMperSQRec);
                RMPerSQList.RunModal();
                Error('Make Order Canceled.');
            end;
        end;
    end;

    internal procedure AddRMWarningLog(SalesQuoteNo: Code[20])
    var
        RMAvlLofRec: Record "Raw Material Availability Log";
    begin
        RMAvlLofRec.Init();
        RMAvlLofRec.Validate("SQ Number", SalesQuoteNo);
        RMAvlLofRec.Validate(User, USERID);
        RMAvlLofRec.Validate("Number of unique items", CountOfMissingItems);
        RMAvlLofRec.Insert();
    end;

    var
        CountOfMissingItems: Integer;

}
