codeunit 50213 "Split Line Reserv. Tracking"
{
    procedure ReserveAfterSalesLineInsert(SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    var
        TransferOrderLine: Record "Transfer Line";
        ReservationManagementCU: Codeunit "Reservation Management";
        directionEnum: Enum "Transfer Direction";
        FullAutoReservation: Boolean;
        ReservedQty: Decimal;
        ReservedQtyBase: Decimal;
        TransferLineOutReserve: Codeunit "Transfer Line-Reserve";
        TransferLineInReserve: Codeunit "Transfer Line-Reserve";
        TOLineTrackingSpec: record "Tracking Specification";
        OutReservationEntry: Record "Reservation Entry";
        InReservationEntry: Record "Reservation Entry";


        ItemLedgerReserve: Codeunit "Item Ledger Entry-Reserve";
        LedgerReservationEntry: Record "Reservation Entry";
        SalesLineReserve: Codeunit "Sales Line-Reserve";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TrackingSpec: record "Tracking Specification";
        SalesReservationEntry: Record "Reservation Entry";
        i: Integer;
        Math: Codeunit Math;
        NosCU: Codeunit "No. Series";
        Item: Record Item;

        TransferReservEntry: Record "Reservation Entry";
        TransferReservEntryInbd: Record "Reservation Entry";
        TransferLineReserve: Codeunit "Transfer Line-Reserve";
    begin
        Clear(ReservedQty);
        Clear(ReservedQtyBase);
        Clear(TransferOrderLine);
        Item.get(SalesOrderLine."No.");
        TransferOrderLine.SetRange("Related SO", SalesOrderHeader."No.");
        TransferOrderLine.SetRange("SO Line No.", SalesOrderLine."Line No.");
        if TransferOrderLine.FindFirst() then begin
            if TransferLineOutReserve.FindReservEntrySet(TransferOrderLine, OutReservationEntry, directionEnum::Outbound) then begin
                repeat
                    TOLineTrackingSpec.InitTrackingSpecification(Database::"Transfer Line", 1, TransferOrderLine."Document No.", '', 0, TransferOrderLine."Line No.", TransferOrderLine."Variant Code", TransferOrderLine."Transfer-to Code", TransferOrderLine."Qty. per Unit of Measure");
                    TOLineTrackingSpec.CopyTrackingFromReservEntry(OutReservationEntry);
                    SalesLineReserve.CreateReservationSetFrom(TOLineTrackingSpec);
                    InReservationEntry.CopyTrackingFromSpec(TOLineTrackingSpec);
                    SalesLineReserve.CreateReservation(SalesOrderLine, SalesOrderLine.Description, SalesOrderLine."Shipment Date", 1, 1, InReservationEntry);
                    ReservedQtyBase += 1;
                until OutReservationEntry.Next() = 0;
                If SalesOrderLine."Quantity (Base)" > ReservedQtyBase then begin
                    Clear(TransferOrderLine);
                    TransferOrderLine.SetRange("Item No.", SalesOrderLine."No.");
                    TransferOrderLine.SetRange("Variant Code", SalesOrderLine."Variant Code");
                    TransferOrderLine.SetRange("Transfer-to Code", SalesOrderLine."Location Code");
                    TransferOrderLine.CalcFields("Reserved Qty. Inbnd. (Base)");
                    TransferOrderLine.SetRange("Reserved Qty. Inbnd. (Base)", 0);
                    if TransferOrderLine.FindSet() then begin
                        repeat
                            Clear(TransferReservEntry);
                            TransferReservEntry.SetRange("Source Type", Database::"Transfer Line");
                            TransferReservEntry.SetRange("Source Subtype", 0);
                            TransferReservEntry.SetRange("Source ID", TransferOrderLine."Document No.");
                            TransferReservEntry.SetRange("Source Ref. No.", TransferOrderLine."Line No.");
                            TransferReservEntry.SetRange("Item No.", TransferOrderLine."Item No.");
                            if TransferReservEntry.FindSet() then
                                repeat
                                    TrackingSpec.InitTrackingSpecification(Database::"Sales Line", 1, SalesOrderLine."Document No.", '', 0, SalesOrderLine."Line No.", SalesOrderLine."Variant Code", SalesOrderLine."Location Code", SalesOrderLine."Qty. per Unit of Measure");
                                    TrackingSpec.CopyTrackingFromReservEntry(TransferReservEntry);
                                    TransferLineReserve.CreateReservationSetFrom(TrackingSpec);
                                    TransferReservEntryInbd.CopyTrackingFromSpec(TrackingSpec);
                                    TransferLineReserve.CreateReservation(TransferOrderLine, TransferOrderLine.Description, TransferOrderLine."Shipment Date", 1, 1, TransferReservEntryInbd, directionEnum::Inbound);
                                    ReservedQtyBase += 1;
                                until (TransferReservEntry.Next() = 0) or (ReservedQtyBase >= SalesOrderLine."Quantity (Base)");
                        until (TransferOrderLine.Next() = 0) or (ReservedQtyBase >= SalesOrderLine."Quantity (Base)");
                    end;
                end;
                If SalesOrderLine."Quantity (Base)" > ReservedQtyBase then begin
                    clear(ItemLedgerEntry);
                    ItemLedgerEntry.SetRange("Item No.", SalesOrderLine."No.");
                    ItemLedgerEntry.SetRange("Variant Code", SalesOrderLine."Variant Code");
                    ItemLedgerEntry.SetRange("Location Code", SalesOrderLine."Location Code");
                    ItemLedgerEntry.SetFilter("Remaining Quantity", '>0');
                    if ItemLedgerEntry.FindSet() then
                        repeat
                            if (ItemLedgerEntry."Serial No." <> '') then begin
                                TrackingSpec.InitTrackingSpecification(Database::"Item Ledger Entry", 1, ItemLedgerEntry."Item No.", '', 0, ItemLedgerEntry."Entry No.", ItemLedgerEntry."Variant Code", ItemLedgerEntry."Location Code", ItemLedgerEntry."Qty. per Unit of Measure");
                                TrackingSpec.CopyTrackingFromItemLedgEntry(ItemLedgerEntry);
                                SalesLineReserve.CreateReservationSetFrom(TrackingSpec);
                                SalesReservationEntry.CopyTrackingFromSpec(TrackingSpec);
                                SalesLineReserve.CreateReservation(SalesOrderLine, SalesOrderLine.Description, SalesOrderLine."Shipment Date", 1, 1, SalesReservationEntry);
                                ReservedQtyBase += 1;
                            end
                            else begin
                                for i := 1 to Math.Min(ItemLedgerEntry."Remaining Quantity", SalesOrderLine."Quantity (Base)" - ReservedQtyBase) do begin
                                    TrackingSpec.InitTrackingSpecification(Database::"Item Ledger Entry", 1, ItemLedgerEntry."Item No.", '', 0, ItemLedgerEntry."Entry No.", ItemLedgerEntry."Variant Code", ItemLedgerEntry."Location Code", ItemLedgerEntry."Qty. per Unit of Measure");
                                    TrackingSpec."Serial No." := NosCU.GetNextNo(Item."Serial Nos.");
                                    SalesLineReserve.CreateReservationSetFrom(TrackingSpec);
                                    SalesReservationEntry.CopyTrackingFromSpec(TrackingSpec);
                                    SalesLineReserve.CreateReservation(SalesOrderLine, SalesOrderLine.Description, SalesOrderLine."Shipment Date", 1, 1, SalesReservationEntry);
                                    ReservedQtyBase += 1;
                                end;
                            end;
                        until (ItemLedgerEntry.Next() = 0) or (ReservedQtyBase >= SalesOrderLine."Quantity (Base)");
                end;
            end;
        end
        else begin
            //if the qty is in the transfer order (ex: assembly to stock not posted), we reserve inbound
            Clear(TransferOrderLine);
            TransferOrderLine.SetRange("Item No.", SalesOrderLine."No.");
            TransferOrderLine.SetRange("Variant Code", SalesOrderLine."Variant Code");
            TransferOrderLine.SetRange("Transfer-to Code", SalesOrderLine."Location Code");
            TransferOrderLine.CalcFields("Reserved Qty. Inbnd. (Base)");
            TransferOrderLine.SetRange("Reserved Qty. Inbnd. (Base)", 0);
            if TransferOrderLine.FindSet() then begin
                repeat
                    Clear(TransferReservEntry);
                    TransferReservEntry.SetRange("Source Type", Database::"Transfer Line");
                    TransferReservEntry.SetRange("Source Subtype", 0);
                    TransferReservEntry.SetRange("Source ID", TransferOrderLine."Document No.");
                    TransferReservEntry.SetRange("Source Ref. No.", TransferOrderLine."Line No.");
                    TransferReservEntry.SetRange("Item No.", TransferOrderLine."Item No.");
                    if TransferReservEntry.FindSet() then
                        repeat
                            TrackingSpec.InitTrackingSpecification(Database::"Sales Line", 1, SalesOrderLine."Document No.", '', 0, SalesOrderLine."Line No.", SalesOrderLine."Variant Code", SalesOrderLine."Location Code", SalesOrderLine."Qty. per Unit of Measure");
                            TrackingSpec.CopyTrackingFromReservEntry(TransferReservEntry);
                            TransferLineReserve.CreateReservationSetFrom(TrackingSpec);
                            TransferReservEntryInbd.CopyTrackingFromSpec(TrackingSpec);
                            TransferLineReserve.CreateReservation(TransferOrderLine, TransferOrderLine.Description, TransferOrderLine."Shipment Date", 1, 1, TransferReservEntryInbd, directionEnum::Inbound);
                            ReservedQtyBase += 1;
                        until (TransferReservEntry.Next() = 0) or (ReservedQtyBase >= SalesOrderLine."Quantity (Base)");
                until (TransferOrderLine.Next() = 0) or (ReservedQtyBase >= SalesOrderLine."Quantity (Base)");
            end;
            if SalesOrderLine."Quantity (Base)" > ReservedQtyBase then begin
                clear(ItemLedgerEntry);
                ItemLedgerEntry.SetRange("Item No.", SalesOrderLine."No.");
                ItemLedgerEntry.SetRange("Variant Code", SalesOrderLine."Variant Code");
                ItemLedgerEntry.SetRange("Location Code", SalesOrderLine."Location Code");
                ItemLedgerEntry.SetFilter("Remaining Quantity", '>0');
                if ItemLedgerEntry.FindSet() then
                    repeat
                        if (ItemLedgerEntry."Serial No." <> '') then begin
                            TrackingSpec.InitTrackingSpecification(Database::"Item Ledger Entry", 1, ItemLedgerEntry."Item No.", '', 0, ItemLedgerEntry."Entry No.", ItemLedgerEntry."Variant Code", ItemLedgerEntry."Location Code", ItemLedgerEntry."Qty. per Unit of Measure");
                            TrackingSpec.CopyTrackingFromItemLedgEntry(ItemLedgerEntry);
                            SalesLineReserve.CreateReservationSetFrom(TrackingSpec);
                            SalesReservationEntry.CopyTrackingFromSpec(TrackingSpec);
                            SalesLineReserve.CreateReservation(SalesOrderLine, SalesOrderLine.Description, SalesOrderLine."Shipment Date", 1, 1, SalesReservationEntry);
                            ReservedQtyBase += 1;
                        end
                        else begin
                            for i := 1 to Math.Min(ItemLedgerEntry."Remaining Quantity", SalesOrderLine."Quantity (Base)" - ReservedQtyBase) do begin
                                TrackingSpec.InitTrackingSpecification(Database::"Item Ledger Entry", 1, ItemLedgerEntry."Item No.", '', 0, ItemLedgerEntry."Entry No.", ItemLedgerEntry."Variant Code", ItemLedgerEntry."Location Code", ItemLedgerEntry."Qty. per Unit of Measure");
                                TrackingSpec."Serial No." := NosCU.GetNextNo(Item."Serial Nos.");
                                SalesLineReserve.CreateReservationSetFrom(TrackingSpec);
                                SalesReservationEntry.CopyTrackingFromSpec(TrackingSpec);
                                SalesLineReserve.CreateReservation(SalesOrderLine, SalesOrderLine.Description, SalesOrderLine."Shipment Date", 1, 1, SalesReservationEntry);
                                ReservedQtyBase += 1;
                            end;
                        end;
                    until (ItemLedgerEntry.Next() = 0) or (ReservedQtyBase >= SalesOrderLine."Quantity (Base)");
            end;
        end;
    end;
}
