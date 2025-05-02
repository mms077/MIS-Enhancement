codeunit 50207 "Split Line"
{

    #region FullProduction
    internal procedure SplitLineFullProduction(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    var
        //Quantities
        RequiredQty: Decimal;
        AvailableQTY: Decimal;
        QtyToAssemble: Decimal;
        //TempTable
        TempItemRec: Record Item temporary;

        //Assembly
        NeededRawMaterial: Record "Needed Raw Material";
        ParameterHeaderPar: Record "Parameter Header";
        ParentParameterHeaderPar: Record "Parameter Header";
        AssemblyLoc: Code[10];
        AssemblyHeader: Record "Assembly Header";
    begin
        SalesOrderLine.Validate("Location Code", SalesOrderHeader."Shipping Location");
        RequiredQty := SalesOrderLine."Quantity (Base)";
        AvailableQTY := FillQuantityPerLocationAndReturnAvailableQty(TempItemRec, SalesOrderLine);
        //If there is a QTY available in the locations.
        if AvailableQTY > 0 then begin
            //If we need more QTY than we have available, we have to assemble.
            if AvailableQTY < RequiredQty then begin
                QtyToAssemble := RequiredQty - AvailableQTY;
                clear(NeededRawMaterial);
                UpdateRMAndParameterHeaders(SalesOrderHeader, SalesQuoteHeader, SalesOrderLine);
                NeededRawMaterial.SetRange(Batch, SalesOrderLine."Needed RM Batch");
                if NeededRawMaterial.Findfirst() then;
                ParameterHeaderPar.Get(SalesOrderLine."Parameters Header ID");
                ParentParameterHeaderPar.Get(SalesOrderLine."Parent Parameter Header ID");
                // AssemblyLoc := GetAssemblyLocation(SalesOrderLine);
                OnBeforeSettingAssemblyLocation(SalesOrderLine."No.", AssemblyLoc);
                if AssemblyLoc = '' then
                    Error('Assembly Location is not set');
                CreateAssemblyOrder(NeededRawMaterial, ParameterHeaderPar, ParentParameterHeaderPar, SalesOrderLine, AssemblyHeader, QtyToAssemble, AssemblyLoc);
                if AssemblyLoc <> SalesOrderHeader."Shipping Location" then
                    CreateOrAdjustTOAsb(SalesOrderLine, AssemblyHeader, AssemblyLoc, SalesOrderHeader."Shipping Location", QtyToAssemble);
                RequiredQty -= QtyToAssemble;
            end;
            TempItemRec.SetLoadFields("No.", "Budget Quantity");
            TempItemRec.SetCurrentKey("Budget Quantity");
            TempItemRec.SetAscending("Budget Quantity", false);
            if TempItemRec.FindSet() then
                repeat
                    //If the available QTY  is bigger than Required Qty we only need the required QTY.
                    if TempItemRec."Budget Quantity" > RequiredQty then begin
                        //If the location is not the same as the shipping location we need to create a TO.
                        if TempItemRec."No." = SalesOrderHeader."Shipping Location" then
                            RequiredQty -= RequiredQty
                        else begin
                            CreateOrAdjustTO(SalesOrderLine, TempItemRec."No.", SalesOrderHeader."Shipping Location", RequiredQty);
                            RequiredQty -= RequiredQty;
                        end;
                        //Else we will automatically reserve from the shipping location.
                    end
                    //Else we only need the qty on the location.
                    else begin
                        //If the location is not the same as the shipping location we need to create a TO.
                        if TempItemRec."No." = SalesOrderHeader."Shipping Location" then
                            RequiredQty -= TempItemRec."Budget Quantity"
                        else begin
                            CreateOrAdjustTO(SalesOrderLine, TempItemRec."No.", SalesOrderHeader."Shipping Location", TempItemRec."Budget Quantity");
                            RequiredQty -= TempItemRec."Budget Quantity";
                        end;
                        //Else we will automatically reserve from the shipping location.
                    end;
                until (TempItemRec.Next() = 0) or (RequiredQty <= 0);
        end
        // //If we have no QTY available
        else begin
            clear(NeededRawMaterial);
            UpdateRMAndParameterHeaders(SalesOrderHeader, SalesQuoteHeader, SalesOrderLine);
            NeededRawMaterial.SetRange(Batch, SalesOrderLine."Needed RM Batch");
            if NeededRawMaterial.Findfirst() then;
            ParameterHeaderPar.Get(SalesOrderLine."Parameters Header ID");
            ParentParameterHeaderPar.Get(SalesOrderLine."Parent Parameter Header ID");
            OnBeforeSettingAssemblyLocation(SalesOrderLine."No.", AssemblyLoc);

            CreateAssemblyOrder(NeededRawMaterial, ParameterHeaderPar, ParentParameterHeaderPar, SalesOrderLine, AssemblyHeader, RequiredQty, AssemblyLoc);
            if AssemblyLoc <> SalesOrderHeader."Shipping Location" then
                CreateOrAdjustTOAsb(SalesOrderLine, AssemblyHeader, AssemblyLoc, SalesOrderHeader."Shipping Location", RequiredQty);
        end;

        //end;
    end;


    procedure UpdateRMAndParameterHeaders(SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header"; SalesOrderLine: Record "Sales Line")
    var
        NeededRawMaterial: Record "Needed Raw Material";
        ParameterHeaderLoc: Record "Parameter Header";
        ParentParameterHeaderLoc: Record "Parameter Header";
    begin
        Clear(NeededRawMaterial);
        NeededRawMaterial.SetRange("Sales Order No.", SalesQuoteHeader."No.");
        if NeededRawMaterial.FindSet() then
            NeededRawMaterial.ModifyAll("Sales Order No.", SalesOrderHeader."No.");
        //Update Assembly Order No.
        Clear(NeededRawMaterial);
        NeededRawMaterial.SetRange("Sales Order No.", SalesOrderHeader."No.");
        if NeededRawMaterial.FindSet() then
            repeat
                //Update Parameters Header
                Clear(ParameterHeaderLoc);
                if ParameterHeaderLoc.Get(SalesOrderLine."Parameters Header ID") then begin
                    ParameterHeaderLoc."Sales Line Document No." := SalesOrderLine."Document No.";
                    ParameterHeaderLoc."Sales Line Document Type" := SalesOrderLine."Document Type";
                    ParameterHeaderLoc.Modify();
                end;
                Clear(ParentParameterHeaderLoc);
                if ParentParameterHeaderLoc.Get(SalesOrderLine."Parameters Header ID") then begin
                    ParentParameterHeaderLoc."Sales Line Document No." := SalesOrderLine."Document No.";
                    ParentParameterHeaderLoc."Sales Line Document Type" := SalesOrderLine."Document Type";
                    ParentParameterHeaderLoc.Modify();
                end;
            until NeededRawMaterial.Next() = 0;
    end;



    procedure CreateAssemblyOrder(NeededRawMaterial: Record "Needed Raw Material"; ParameterHeaderPar: Record "Parameter Header"; ParentParameterHeaderPar: Record "Parameter Header"; var SalesLine: Record "Sales Line"; var AssemblyHeader: Record "Assembly Header"; AssemblyQty: Decimal; AssemblyLoc: Code[10])
    var
        AssembleToOrderLink: Record "Assemble-to-Order Link";
        AssemblyLine: Record "Assembly Line";
        NeededRMLoc: Record "Needed Raw Material";
        EndingDate: Date;
        DueDate: Date;
        LineNumber: Integer;
        AssemblySetup: Record "Assembly Setup";
        Item: Record Item;
        AvailableQty: Decimal;
        SalesHeader: Record "Sales Header";
        GnrlLedgStpRec: Record "General Ledger Setup";
        ManagementCU: Codeunit "Management";
    begin
        AssemblyHeader.Init();
        AssemblyHeader.Validate("Document Type", AssemblyHeader."Document Type"::Order);
        AssemblyHeader."Starting Date" := Today;
        AssemblyHeader.Validate("Due Date", SalesLine."Requested Delivery Date");
        AssemblyHeader.Validate("Ending Date", SalesLine."Requested Delivery Date");
        AssemblyHeader.Validate("Item No.", NeededRawMaterial."Sales Line Item No.");
        AssemblySetup.Get();
        AssemblyHeader."Workflow User Group Code" := AssemblySetup."Workflow User Group Code";
        AssemblyHeader."Sequence No." := 1;
        AssemblyHeader."Parameters Header ID" := SalesLine."Parameters Header ID";
        AssemblyHeader."Parent Parameter Header ID" := ParentParameterHeaderPar.ID;
        AssemblyHeader."Source Type" := SalesLine."Document Type";
        AssemblyHeader."Source No." := NeededRawMaterial."Sales Order No.";
        AssemblyHeader."Source Line No." := NeededRawMaterial."Sales Order Line No.";
        AssemblyHeader.CalcFields("Item Size", "Item Fit", "Item Cut Code");
        AssemblyHeader.Validate("Variant Code", SalesLine."Variant Code");
        AssemblyHeader.Validate("Location Code", AssemblyLoc);
        //AssemblyHeader.Validate("Location Code", NeededRawMaterial."Sales Line Location Code");

        // Get the base UOM
        Item.Get(SalesLine."No.");

        // Set the quantity in base UOM
        AssemblyHeader.Validate("Quantity", AssemblyQty);
        AssemblyHeader.Validate("Unit of Measure Code", Item."Base Unit of Measure");

        AssemblyHeader.Insert(true);
        #region[Create Assembly Header]


        //check if the item with embroidery
        if WithEmbroidery(AssemblyHeader) then
            AssemblyHeader."Grouping Criteria" := AssemblyHeader."Item No." + '-' + AssemblyHeader."Item Size" + '-' + AssemblyHeader."Item Fit" + '-' + AssemblyHeader."Item Cut Code" + '-WithEmb'
        else
            AssemblyHeader."Grouping Criteria" := AssemblyHeader."Item No." + '-' + AssemblyHeader."Item Size" + '-' + AssemblyHeader."Item Fit" + '-' + AssemblyHeader."Item Cut Code" + '-WithoutEmb';
        AssemblyHeader."Quantity to Assemble" := AssemblyHeader.Quantity;
        AssemblyHeader.Modify();
        #endregion[Create Assembly Header]

        #region[Create Assembly Line]
        Clear(NeededRMLoc);
        LineNumber := 10000;
        NeededRMLoc.SetRange(Batch, NeededRawMaterial.Batch);
        if NeededRMLoc.FindSet() then begin
            repeat
                Clear(AssemblyLine);
                AssemblyLine.Init();
                AssemblyLine."Document Type" := AssemblyHeader."Document Type";
                AssemblyLine."Document No." := AssemblyHeader."No.";
                AssemblyLine."Line No." := LineNumber;
                AssemblyLine.Validate(Type, AssemblyLine.Type::Item);
                AssemblyLine.Validate("No.", NeededRMLoc."RM Code");
                //Raw Material Variant Code
                AssemblyLine.Validate("Variant Code", NeededRMLoc."RM Variant Code");
                AssemblyLine.Validate("Location Code", AssemblyHeader."Location Code");
                AssemblyLine.Validate("Quantity Per", NeededRMLoc."Design Detail Quantity");
                AssemblyLine.Validate("Unit of Measure Code", NeededRMLoc."Assembly Line UOM Code");
                //AssemblyLine.Validate(Reserve, AssemblyLine.Reserve::Always); //Reserve when MO is Created and Released
                AssemblyLine.Insert(true);
                //AssemblyLine.AutoReserve(); //Reserve when MO is Created and Released
                LineNumber := LineNumber + 10000;
                NeededRMLoc."Assembly Order No." := AssemblyHeader."No.";
                NeededRMLoc."Assembly Order Line No." := AssemblyLine."Line No.";
                NeededRMLoc.Modify();
            until NeededRMLoc.Next() = 0;
        end;


        ManagementCU.CreateCuttingSheetDashboard(AssemblyHeader, ParameterHeaderPar."Customer No.");
    end;

    Procedure WithEmbroidery(AssemblyHeaderPar: Record "Assembly Header"): Boolean
    var
        ItemVariant: Record "Item Variant";
        BrandingSet: Record "Item Brandings Set";
        Branding: Record Branding;
        BrandingCategory: Record "Branding Category";
    begin
        Clear(ItemVariant);
        if ItemVariant.Get(AssemblyHeaderPar."Item No.", AssemblyHeaderPar."Variant Code") then begin
            Clear(BrandingSet);
            BrandingSet.SetRange("Item Branding Set ID", ItemVariant."Item Brandings Set ID");
            if BrandingSet.FindSet() then
                repeat
                    Clear(Branding);
                    Branding.SetRange(Code, BrandingSet."Item Branding Code");
                    if Branding.FindFirst() then
                        if BrandingCategory.Get(Branding."Branding Category Code") then
                            //if Branding."Branding Category Code" = SalesReceivSetup."Branding Category Code" then
                            if BrandingCategory."With Embroidery" then
                                exit(true);
                until BrandingSet.Next() = 0;
            exit(false);
        end;
    end;
    #endregion[Create Assembly Line]
    #endregion
    #region Purchase
    internal procedure SplitLinePurchase(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    var
        //Quantities
        RequiredQty: Decimal;
        AvailableQTY: Decimal;
        QtyToAssemble: Decimal;
        //TempTable
        TempItemRec: Record Item temporary;
        ReservationEntryRec: Record "Reservation Entry";

        //Assembly
        NeededRawMaterial: Record "Needed Raw Material";
        ParameterHeaderPar: Record "Parameter Header";
        ParentParameterHeaderPar: Record "Parameter Header";
    begin
        SalesOrderLine.Validate("Location Code", SalesOrderHeader."Shipping Location");
        RequiredQty := SalesOrderLine."Quantity (Base)";
        AvailableQTY := FillQuantityPerLocationAndReturnAvailableQty(TempItemRec, SalesOrderLine);
        //If there is a QTY available in the locations.
        if AvailableQTY > 0 then begin
            //If we need more QTY than we have available, they will be taken from the purchase IC.
            TempItemRec.SetLoadFields("No.", "Budget Quantity");
            TempItemRec.SetCurrentKey("Budget Quantity");
            TempItemRec.SetAscending("Budget Quantity", false);
            if TempItemRec.FindSet() then
                repeat
                    //If the available QTY  is bigger than Required Qty we only need the required QTY.
                    if TempItemRec."Budget Quantity" > RequiredQty then begin
                        //If the location is not the same as the shipping location we need to create a TO.
                        if TempItemRec."No." = SalesOrderHeader."Shipping Location" then
                            RequiredQty -= RequiredQty
                        else begin
                            CreateOrAdjustTO(SalesOrderLine, TempItemRec."No.", SalesOrderHeader."Shipping Location", RequiredQty);
                            RequiredQty -= RequiredQty;
                        end;
                        //Else we will automatically reserve from the shipping location.
                    end
                    //Else we only need the qty on the location.
                    else begin
                        //If the location is not the same as the shipping location we need to create a TO.
                        if TempItemRec."No." = SalesOrderHeader."Shipping Location" then
                            RequiredQty -= TempItemRec."Budget Quantity"
                        else begin
                            CreateOrAdjustTO(SalesOrderLine, TempItemRec."No.", SalesOrderHeader."Shipping Location", TempItemRec."Budget Quantity");
                            RequiredQty -= TempItemRec."Budget Quantity";
                        end;
                        //Else we will automatically reserve from the shipping location.
                    end;
                until (TempItemRec.Next() = 0) or (RequiredQty <= 0);
        end
    end;
    #endregion

    #region IC Full Production
    procedure SplitLineFullProductionIC(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header")
    var
        //Quantities
        RequiredQty: Decimal;
        AvailableQTY: Decimal;
        QtyToAssemble: Decimal;
        //TempTable
        TempItemRec: Record Item temporary;

        //Assembly
        NeededRawMaterial: Record "Needed Raw Material";
        ParameterHeaderPar: Record "Parameter Header";
        ParentParameterHeaderPar: Record "Parameter Header";
        AssemblyLoc: Code[10];
        AssemblyHeader: Record "Assembly Header";
    begin
        SalesOrderLine.Validate("Location Code", SalesOrderHeader."Shipping Location");
        RequiredQty := SalesOrderLine."Quantity (Base)";
        AvailableQTY := FillQuantityPerLocationAndReturnAvailableQty(TempItemRec, SalesOrderLine);
        //If there is a QTY available in the locations.
        if AvailableQTY > 0 then begin
            //If we need more QTY than we have available, we have to assemble.
            if AvailableQTY < RequiredQty then begin
                QtyToAssemble := RequiredQty - AvailableQTY;
                clear(NeededRawMaterial);
                //UpdateRMAndParameterHeaders(SalesOrderHeader, SalesQuoteHeader, SalesOrderLine);
                NeededRawMaterial.SetRange(Batch, SalesOrderLine."Needed RM Batch");
                if NeededRawMaterial.Findfirst() then;
                ParameterHeaderPar.Get(SalesOrderLine."Parameters Header ID");
                ParentParameterHeaderPar.Get(SalesOrderLine."IC Parameters Header ID");
                // AssemblyLoc := GetAssemblyLocation(SalesOrderLine);
                OnBeforeSettingAssemblyLocation(SalesOrderLine."No.", AssemblyLoc);
                if AssemblyLoc = '' then
                    Error('Assembly Location is not set');
                CreateAssemblyOrder(NeededRawMaterial, ParameterHeaderPar, ParentParameterHeaderPar, SalesOrderLine, AssemblyHeader, QtyToAssemble, AssemblyLoc);
                if AssemblyLoc <> SalesOrderHeader."Shipping Location" then
                    CreateOrAdjustTOAsb(SalesOrderLine, AssemblyHeader, AssemblyLoc, SalesOrderHeader."Shipping Location", QtyToAssemble);
                RequiredQty -= QtyToAssemble;
            end;
            TempItemRec.SetLoadFields("No.", "Budget Quantity");
            TempItemRec.SetCurrentKey("Budget Quantity");
            TempItemRec.SetAscending("Budget Quantity", false);
            if TempItemRec.FindSet() then
                repeat
                    //If the available QTY  is bigger than Required Qty we only need the required QTY.
                    if TempItemRec."Budget Quantity" > RequiredQty then begin
                        //If the location is not the same as the shipping location we need to create a TO.
                        if TempItemRec."No." = SalesOrderHeader."Shipping Location" then
                            RequiredQty -= RequiredQty
                        else begin
                            CreateOrAdjustTO(SalesOrderLine, TempItemRec."No.", SalesOrderHeader."Shipping Location", RequiredQty);
                            RequiredQty -= RequiredQty;
                        end;
                        //Else we will automatically reserve from the shipping location.
                    end
                    //Else we only need the qty on the location.
                    else begin
                        //If the location is not the same as the shipping location we need to create a TO.
                        if TempItemRec."No." = SalesOrderHeader."Shipping Location" then
                            RequiredQty -= TempItemRec."Budget Quantity"
                        else begin
                            CreateOrAdjustTO(SalesOrderLine, TempItemRec."No.", SalesOrderHeader."Shipping Location", TempItemRec."Budget Quantity");
                            RequiredQty -= TempItemRec."Budget Quantity";
                        end;
                        //Else we will automatically reserve from the shipping location.
                    end;
                until (TempItemRec.Next() = 0) or (RequiredQty <= 0);
        end
        //If we have no QTY available
        else begin
            clear(NeededRawMaterial);
            //UpdateRMAndParameterHeaders(SalesOrderHeader, SalesQuoteHeader, SalesOrderLine);
            NeededRawMaterial.SetRange(Batch, SalesOrderLine."Needed RM Batch");
            if NeededRawMaterial.Findfirst() then;
            ParameterHeaderPar.Get(SalesOrderLine."Parameters Header ID");
            ParentParameterHeaderPar.Get(SalesOrderLine."IC Parameters Header ID");
            OnBeforeSettingAssemblyLocation(SalesOrderLine."No.", AssemblyLoc);
            if AssemblyLoc = '' then
                Error('Assembly Location is not set');
            CreateAssemblyOrder(NeededRawMaterial, ParameterHeaderPar, ParentParameterHeaderPar, SalesOrderLine, AssemblyHeader, RequiredQty, AssemblyLoc);
            if AssemblyLoc <> SalesOrderHeader."Shipping Location" then
                CreateOrAdjustTOAsb(SalesOrderLine, AssemblyHeader, AssemblyLoc, SalesOrderHeader."Shipping Location", RequiredQty);
        end;
    end;
    #endregion IC Full Production


    #region IC Purchase
    internal procedure SplitLinePurchaseIC(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header")
    var
        //Quantities
        RequiredQty: Decimal;
        AvailableQTY: Decimal;
        QtyToAssemble: Decimal;
        //TempTable
        TempItemRec: Record Item temporary;
        ReservationEntryRec: Record "Reservation Entry";

        //Assembly
        NeededRawMaterial: Record "Needed Raw Material";
        ParameterHeaderPar: Record "Parameter Header";
        ParentParameterHeaderPar: Record "Parameter Header";
    begin
        SalesOrderLine.Validate("Location Code", SalesOrderHeader."Shipping Location");
        RequiredQty := SalesOrderLine."Quantity (Base)";
        AvailableQTY := FillQuantityPerLocationAndReturnAvailableQty(TempItemRec, SalesOrderLine);
        //If there is a QTY available in the locations.
        if AvailableQTY > 0 then begin
            //If we need more QTY than we have available, they will be taken from the purchase IC.
            TempItemRec.SetLoadFields("No.", "Budget Quantity");
            TempItemRec.SetCurrentKey("Budget Quantity");
            TempItemRec.SetAscending("Budget Quantity", false);
            if TempItemRec.FindSet() then
                repeat
                    //If the available QTY  is bigger than Required Qty we only need the required QTY.
                    if TempItemRec."Budget Quantity" > RequiredQty then begin
                        //If the location is not the same as the shipping location we need to create a TO.
                        if TempItemRec."No." = SalesOrderHeader."Shipping Location" then
                            RequiredQty -= RequiredQty
                        else begin
                            CreateOrAdjustTO(SalesOrderLine, TempItemRec."No.", SalesOrderHeader."Shipping Location", RequiredQty);
                            RequiredQty -= RequiredQty;
                        end;
                        //Else we will automatically reserve from the shipping location.
                    end
                    //Else we only need the qty on the location.
                    else begin
                        //If the location is not the same as the shipping location we need to create a TO.
                        if TempItemRec."No." = SalesOrderHeader."Shipping Location" then
                            RequiredQty -= TempItemRec."Budget Quantity"
                        else begin
                            CreateOrAdjustTO(SalesOrderLine, TempItemRec."No.", SalesOrderHeader."Shipping Location", TempItemRec."Budget Quantity");
                            RequiredQty -= TempItemRec."Budget Quantity";
                        end;
                        //Else we will automatically reserve from the shipping location.
                    end;
                until (TempItemRec.Next() = 0) or (RequiredQty <= 0);
        end
    end;
    #endregion

    #region Common
    procedure FillQuantityPerLocationAndReturnAvailableQty(var TempItemRec: Record Item temporary; SalesOrderLine: Record "Sales Line"): Decimal
    var
        LocationRec: Record Location;
        ItemPerLoc: Record Item;
        ItemAvailabilityMgt: Codeunit "Item Availability Forms Mgt";
        GrossRequirement: Decimal;
        PlannedOrderReceipt: Decimal;
        ScheduledReceipt: Decimal;
        PlannedOrderReleases: Decimal;
        ProjectedQty: Decimal;
        AvailableQty: Decimal;
    begin
        Clear(LocationRec);
        Clear(ItemPerLoc);
        if LocationRec.FindSet() then
            repeat
                ItemPerLoc.SetFilter("No.", SalesOrderLine."No.");
                ItemPerLoc.SetFilter("Location Filter", LocationRec.Code);
                ItemPerLoc.SetFilter("Variant Filter", SalesOrderLine."Variant Code");
                if ItemPerLoc.FindFirst() then begin
                    ItemAvailabilityMgt.CalculateNeed(ItemPerLoc, GrossRequirement, PlannedOrderReceipt, ScheduledReceipt, PlannedOrderReleases);
                    ProjectedQty := ItemPerLoc.Inventory + PlannedOrderReceipt + ScheduledReceipt - GrossRequirement;
                    if ProjectedQty > 0 then begin
                        //if we have projected quantity bigger than 0
                        AvailableQty += ProjectedQty;
                        TempItemRec.Init();
                        TempItemRec."No." := LocationRec.Code;
                        TempItemRec."Budget Quantity" := ProjectedQty;
                        TempItemRec.Insert();
                    end;
                end;
            until LocationRec.Next() = 0;
        exit(AvailableQty);
    end;

    internal procedure CreateOrAdjustTO(SalesOrderLine: Record "Sales Line"; FromLocation: Code[10]; ToLocation: Code[10]; Qty: Decimal)
    var
        TransferOrder: Record "Transfer Header";
        TransferOrderLine: Record "Transfer Line";
        LastLineNo: Integer;
        InventorySetupRec: Record "Inventory Setup";
        NosCU: Codeunit "No. Series";
        LocationRec: Record Location;
        InTransitLocation: Code[10];
        ReservationManagementCU: Codeunit "Reservation Management";
        FullAutoReservation: Boolean;
        directionEnum: Enum "Transfer Direction";
        Item: Record Item;
    begin
        Clear(TransferOrder);
        TransferOrder.SetRange("Related SO", SalesOrderLine."Document No.");
        TransferOrder.SetRange("Transfer-from Code", FromLocation);
        if TransferOrder.FindFirst() then begin
            TransferOrderLine.SetRange("Document No.", TransferOrder."No.");
            TransferOrderLine.SetCurrentKey("Line No.");
            if TransferOrderLine.FindLast() then begin
                LastLineNo := TransferOrderLine."Line No.";
                TransferOrderLine.Init();
                TransferOrderLine."Document No." := TransferOrder."No.";
                TransferOrderLine."Line No." := LastLineNo + 10000;
                TransferOrderLine.Validate("Item No.", SalesOrderLine."No.");
                TransferOrderLine.Validate("Variant Code", SalesOrderLine."Variant Code");

                // Get the base UOM
                Item.Get(SalesOrderLine."No.");

                // Set the base UOM first, then the quantity
                TransferOrderLine.Validate("Unit of Measure Code", Item."Base Unit of Measure");
                TransferOrderLine.Validate("Shipment Date", SalesOrderLine."Shipment Date");
                TransferOrderLine.Validate("Quantity", Qty);
                TransferOrderLine.Validate("Related SO", SalesOrderLine."Document No.");
                TransferOrderLine.Validate("SO Line No.", SalesOrderLine."Line No.");
                TransferOrderLine.Insert();
                ReservationManagementCU.SetReservSource(TransferOrderLine, directionEnum::Outbound);
                ReservationManagementCU.AutoReserve(FullAutoReservation, TransferOrderLine."Document No.", TransferOrderLine."Shipment Date", TransferOrderLine.Quantity, TransferOrderLine."Quantity (Base)")
            end;
        end
        else begin
            LocationRec.SetRange("Use As In-Transit", true);
            if LocationRec.FindFirst() then
                InTransitLocation := LocationRec.Code;
            TransferOrder.Init();
            InventorySetupRec.Get();
            TransferOrder.Validate("No.", NosCU.GetNextNo(InventorySetupRec."Transfer Order Nos."));
            TransferOrder.Validate("Related SO", SalesOrderLine."Document No.");
            TransferOrder.Validate("Transfer-from Code", FromLocation);
            TransferOrder.Validate("Transfer-to Code", ToLocation);
            if InTransitLocation <> '' then
                TransferOrder.Validate("In-Transit Code", InTransitLocation)
            else
                TransferOrder."Direct Transfer" := true;
            TransferOrder.Validate("Shipment Date", SalesOrderLine."Shipment Date");
            TransferOrder.Validate("Receipt Date", SalesOrderLine."Shipment Date");
            TransferOrder.Insert();
            TransferOrderLine.Init();
            TransferOrderLine."Document No." := TransferOrder."No.";
            TransferOrderLine."Line No." := 10000;
            TransferOrderLine.Validate("Item No.", SalesOrderLine."No.");
            TransferOrderLine.Validate("Variant Code", SalesOrderLine."Variant Code");

            // Get the base UOM
            Item.Get(SalesOrderLine."No.");

            // Set the base UOM first, then the quantity
            TransferOrderLine.Validate("Unit of Measure Code", Item."Base Unit of Measure");
            TransferOrderLine.Validate("Shipment Date", SalesOrderLine."Shipment Date");
            TransferOrderLine.Validate("Quantity", Qty);
            TransferOrderLine.Validate("Related SO", SalesOrderLine."Document No.");
            TransferOrderLine.Validate("SO Line No.", SalesOrderLine."Line No.");
            TransferOrderLine.Insert();


            ReservationManagementCU.SetReservSource(TransferOrderLine, directionEnum::Outbound);
            ReservationManagementCU.AutoReserve(FullAutoReservation, TransferOrderLine."Document No.", TransferOrderLine."Shipment Date", TransferOrderLine.Quantity, TransferOrderLine."Quantity (Base)")
        end;
    end;

    internal procedure CreateOrAdjustTOAsb(SalesOrderLine: Record "Sales Line"; AssemblyHeader: Record "Assembly Header"; FromLocation: Code[10]; ToLocation: Code[10]; Qty: Decimal)
    var
        TransferOrder: Record "Transfer Header";
        TransferOrderLine: Record "Transfer Line";
        LastLineNo: Integer;
        InventorySetupRec: Record "Inventory Setup";
        NosCU: Codeunit "No. Series";
        LocationRec: Record Location;
        InTransitLocation: Code[10];
        ReservationManagementCU: Codeunit "Reservation Management";
        FullAutoReservation: Boolean;
        directionEnum: Enum "Transfer Direction";
        Item: Record Item;
    begin
        Clear(TransferOrder);
        TransferOrder.SetRange("Related SO", SalesOrderLine."Document No.");
        TransferOrder.SetRange("Transfer-from Code", FromLocation);
        if TransferOrder.FindFirst() then begin
            TransferOrderLine.SetRange("Document No.", TransferOrder."No.");
            TransferOrderLine.SetCurrentKey("Line No.");
            if TransferOrderLine.FindLast() then begin
                LastLineNo := TransferOrderLine."Line No.";
                TransferOrderLine.Init();
                TransferOrderLine."Document No." := TransferOrder."No.";
                TransferOrderLine."Line No." := LastLineNo + 10000;
                TransferOrderLine.Validate("Item No.", SalesOrderLine."No.");
                TransferOrderLine.Validate("Variant Code", SalesOrderLine."Variant Code");

                // Get the base UOM
                Item.Get(SalesOrderLine."No.");

                // Set the base UOM first, then the quantity
                TransferOrderLine.Validate("Unit of Measure Code", Item."Base Unit of Measure");
                TransferOrderLine.Validate("Shipment Date", SalesOrderLine."Shipment Date");
                TransferOrderLine.Validate("Quantity", Qty);
                TransferOrderLine.Validate("Related SO", SalesOrderLine."Document No.");
                TransferOrderLine.Validate("SO Line No.", SalesOrderLine."Line No.");
                TransferOrderLine.Insert();

                ReservationManagementCU.SetReservSource(TransferOrderLine, directionEnum::Outbound);
                // Add assembly order as a second reservation source
                if AssemblyHeader."No." <> '' then
                    ReservationManagementCU.SetReservSource(AssemblyHeader);

                ReservationManagementCU.AutoReserve(FullAutoReservation, TransferOrderLine."Document No.", TransferOrderLine."Shipment Date", TransferOrderLine.Quantity, TransferOrderLine."Quantity (Base)")
            end;
        end
        else begin
            LocationRec.SetRange("Use As In-Transit", true);
            if LocationRec.FindFirst() then
                InTransitLocation := LocationRec.Code;
            TransferOrder.Init();
            InventorySetupRec.Get();
            TransferOrder.Validate("No.", NosCU.GetNextNo(InventorySetupRec."Transfer Order Nos."));
            TransferOrder.Validate("Related SO", SalesOrderLine."Document No.");
            TransferOrder.Validate("Transfer-from Code", FromLocation);
            TransferOrder.Validate("Transfer-to Code", ToLocation);
            if InTransitLocation <> '' then
                TransferOrder.Validate("In-Transit Code", InTransitLocation)
            else
                TransferOrder."Direct Transfer" := true;
            TransferOrder.Validate("Shipment Date", SalesOrderLine."Shipment Date");
            TransferOrder.Validate("Receipt Date", SalesOrderLine."Shipment Date");
            TransferOrder.Insert();
            TransferOrderLine.Init();
            TransferOrderLine."Document No." := TransferOrder."No.";
            TransferOrderLine."Line No." := 10000;
            TransferOrderLine.Validate("Item No.", SalesOrderLine."No.");
            TransferOrderLine.Validate("Variant Code", SalesOrderLine."Variant Code");

            // Get the base UOM
            Item.Get(SalesOrderLine."No.");

            // Set the base UOM first, then the quantity
            TransferOrderLine.Validate("Unit of Measure Code", Item."Base Unit of Measure");
            TransferOrderLine.Validate("Shipment Date", SalesOrderLine."Shipment Date");
            TransferOrderLine.Validate("Quantity", Qty);
            TransferOrderLine.Validate("Related SO", SalesOrderLine."Document No.");
            TransferOrderLine.Validate("SO Line No.", SalesOrderLine."Line No.");
            TransferOrderLine.Insert();
            ReservationManagementCU.SetReservSource(TransferOrderLine, directionEnum::Outbound);

            // Add assembly order as a second reservation source
            if AssemblyHeader."No." <> '' then
                ReservationManagementCU.SetReservSource(AssemblyHeader);
            ReservationManagementCU.AutoReserve(FullAutoReservation, TransferOrderLine."Document No.", TransferOrderLine."Shipment Date", TransferOrderLine.Quantity, TransferOrderLine."Quantity (Base)")
        end;
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeSettingAssemblyLocation(ItemNo: code[20]; var AssemblyLocation: code[10])
    begin
    end;
    #endregion

}
