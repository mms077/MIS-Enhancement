codeunit 50221 "Process Assemble to Stock"
{    /// <summary>
     /// Processes an assembly order for assemble-to-stock scenario by creating item tracking and transfer orders
     /// </summary>
     /// <param name="AssemblyHeader">The assembly header to process</param>
     /// <param name="FromLocation">Source location for the transfer</param>
     /// <param name="ToLocation">Destination location for the transfer</param>
    procedure ProcessAssembleToStock(var AssemblyHeader: Record "Assembly Header"; FromLocation: Code[10]; ToLocation: Code[10])
    var
        TransferOrder: Record "Transfer Header";
        TransferOrderLine: Record "Transfer Line";
        Item: Record Item;
        LocationRec: Record Location;
        InventorySetupRec: Record "Inventory Setup";
        NosCU: Codeunit "No. Series";
        InTransitLocation: Code[10];
        Serial: Code[20];
        i: Integer;
    begin
        // Validate assembly header
        AssemblyHeader.TestField("Item No.");
        AssemblyHeader.TestField(Quantity);
        AssemblyHeader.TestField("Location Code");

        if FromLocation = '' then
            FromLocation := AssemblyHeader."Location Code";

        if ToLocation = '' then
            Error('Destination location must be specified');

        // Get item information
        Item.Get(AssemblyHeader."Item No.");

        // Create transfer order and reservations (this will handle the item tracking)
        CreateTransferOrderForAssembly(AssemblyHeader, FromLocation, ToLocation);
        Message('Transfer order created successfully for Assembly Order %1', AssemblyHeader."No.");
    end;

    local procedure CreateTransferOrderForAssembly(var AssemblyHeader: Record "Assembly Header"; FromLocation: Code[10]; ToLocation: Code[10])
    var
        TransferOrder: Record "Transfer Header";
        TransferOrderLine: Record "Transfer Line";
        InventorySetupRec: Record "Inventory Setup";
        LocationRec: Record Location;
        NosCU: Codeunit "No. Series";
        Item: Record Item;
        TransferReserve: Codeunit "Transfer Line-Reserve";
        AssemblyReservationEntry: Record "Reservation Entry";
        TrackingSpecAsb: Record "Tracking Specification";
        InTransitLocation: Code[10];
        directionEnum: Enum "Transfer Direction";
        i: Integer;
        Serial: Code[20];
    begin
        // Find in-transit location
        LocationRec.SetRange("Use As In-Transit", true);
        if LocationRec.FindFirst() then
            InTransitLocation := LocationRec.Code;

        // Create transfer order header
        InventorySetupRec.Get();
        TransferOrder.Init();
        TransferOrder.Validate("No.", NosCU.GetNextNo(InventorySetupRec."Transfer Order Nos."));
        TransferOrder.Validate("Transfer-from Code", FromLocation);
        TransferOrder.Validate("Transfer-to Code", ToLocation);

        if InTransitLocation <> '' then
            TransferOrder.Validate("In-Transit Code", InTransitLocation)
        else
            TransferOrder."Direct Transfer" := true;

        TransferOrder.Validate("Shipment Date", AssemblyHeader."Due Date");
        TransferOrder.Validate("Receipt Date", AssemblyHeader."Due Date");
        TransferOrder.Insert();

        // Create transfer order line
        Item.Get(AssemblyHeader."Item No.");
        TransferOrderLine.Init();
        TransferOrderLine."Document No." := TransferOrder."No.";
        TransferOrderLine."Line No." := 10000;
        TransferOrderLine.Validate("Item No.", AssemblyHeader."Item No.");
        TransferOrderLine.Validate("Variant Code", AssemblyHeader."Variant Code");
        TransferOrderLine.Validate("Unit of Measure Code", Item."Base Unit of Measure");
        TransferOrderLine.Validate("Shipment Date", AssemblyHeader."Due Date");
        TransferOrderLine.Validate("Quantity", AssemblyHeader.Quantity);
        TransferOrderLine.Insert();

        // Create reservations from transfer order to assembly order - following SplitLine pattern exactly
        if AssemblyHeader."No." <> '' then begin
            for i := 1 to AssemblyHeader.Quantity do begin
                // Generate serial numbers
                if Item."Serial Nos." <> '' then
                    Serial := NosCU.GetNextNo(Item."Serial Nos.")
                else
                    Serial := Format(AssemblyHeader."No.") + '-' + Format(i);

                // Create tracking specification that points to the Assembly Header
                TrackingSpecAsb.InitTrackingSpecification(
                    Database::"Assembly Header",
                    1, // Assembly Order = 1
                    AssemblyHeader."No.",
                    '',
                    0,
                    0,
                    AssemblyHeader."Variant Code",
                    AssemblyHeader."Location Code",
                    AssemblyHeader."Qty. per Unit of Measure"
                );
                TrackingSpecAsb."Serial No." := Serial;

                // Create the reservation from Transfer Order to Assembly Order
                TransferReserve.CreateReservationSetFrom(TrackingSpecAsb);
                AssemblyReservationEntry.CopyTrackingFromSpec(TrackingSpecAsb);
                TransferReserve.CreateReservation(
                    TransferOrderLine,
                    TransferOrderLine.Description,
                    TransferOrderLine."Shipment Date",
                    1,
                    1,
                    AssemblyReservationEntry,
                    directionEnum::Outbound
                );
            end;
        end;
    end;

    /// <summary>
    /// Validates if the assembly order can be processed for assemble-to-stock
    /// </summary>
    /// <param name="AssemblyHeader">The assembly header to validate</param>
    /// <returns>True if valid for processing</returns>
    procedure ValidateAssemblyForProcessing(AssemblyHeader: Record "Assembly Header"): Boolean
    begin
        if AssemblyHeader."Item No." = '' then
            exit(false);

        if AssemblyHeader.Quantity <= 0 then
            exit(false);

        if AssemblyHeader.Status <> AssemblyHeader.Status::Open then
            exit(false);

        // Check if it's assemble-to-order (should not process ATO orders)
        if AssemblyHeader."Assemble to Order" then
            exit(false);

        exit(true);
    end;
}
