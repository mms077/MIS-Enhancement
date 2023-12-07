codeunit 50202 EventSubscribers
{
    Permissions = tabledata "Bank Account Ledger Entry" = m;
    #region [Document Attachment]
    //Add Documents To Plotting File / Branding / Design  / Item Color / Item Design Section Color / Branding Details / Item Variant +
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        PlottingImage: Record "Plotting File";
        Branding: Record Branding;
        Design: Record Design;
        ItemColor: Record "Item Color";
        ItemDesignSecColor: Record "Item Design Section Color";
        BrandingDetail: Record "Branding Detail";
        ItemVariant: Record "Item Variant";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"Plotting File":
                begin
                    RecRef.Open(DATABASE::"Plotting File");
                    PlottingImage.SetRange(ID, DocumentAttachment."Line No.");
                    //if PlottingImage.Get(DocumentAttachment."Line No.") then
                    if PlottingImage.FindFirst() then
                        RecRef.GetTable(PlottingImage);
                end;
            DATABASE::Branding:
                begin
                    RecRef.Open(DATABASE::"Branding");
                    Branding.SetRange(Code, DocumentAttachment."No.");
                    Branding.SetRange("Customer No.", DocumentAttachment."Link Code");
                    if Branding.FindFirst() then
                        RecRef.GetTable(Branding);
                end;
            DATABASE::Design:
                begin
                    RecRef.Open(DATABASE::"Design");
                    Design.SetRange(Code, DocumentAttachment."No.");
                    if Design.FindFirst() then
                        RecRef.GetTable(Design);
                end;
            DATABASE::"Item Color":
                begin
                    RecRef.Open(DATABASE::"Item Color");
                    ItemColor.SetRange(ID, DocumentAttachment."Line No.");
                    if ItemColor.FindFirst() then
                        RecRef.GetTable(ItemColor);
                end;
            DATABASE::"Item Design Section Color":
                begin
                    RecRef.Open(DATABASE::"Item Design Section Color");
                    ItemDesignSecColor.SetRange(ID, DocumentAttachment."Line No.");
                    if ItemDesignSecColor.FindFirst() then
                        RecRef.GetTable(ItemDesignSecColor);
                end;
            DATABASE::"Branding Detail":
                begin
                    RecRef.Open(DATABASE::"Branding Detail");
                    BrandingDetail.SetRange("Line No.", DocumentAttachment."Line No.");
                    BrandingDetail.SetRange("Branding Code", DocumentAttachment."No.");
                    if BrandingDetail.FindFirst() then
                        RecRef.GetTable(BrandingDetail);
                end;
            DATABASE::"Item Variant":
                begin
                    RecRef.Open(DATABASE::"Item Variant");
                    ItemVariant.SetRange(Id, DocumentAttachment."Line No.");
                    ItemVariant.SetRange(Code, DocumentAttachment."No.");
                    if ItemVariant.FindFirst() then
                        RecRef.GetTable(ItemVariant);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        FieldRef: FieldRef;
        FieldRef2: FieldRef;
        RecNo: Integer;
        RecNo2: Code[50];
        RecNo3: Code[50];
    begin
        case RecRef.Number of
            DATABASE::"Plotting File":
                begin
                    FieldRef := RecRef.Field(4);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("Line No.", RecNo);
                end;
            DATABASE::"Branding":
                begin
                    FieldRef := RecRef.Field(1);
                    FieldRef2 := RecRef.Field(4);
                    RecNo2 := FieldRef.Value;
                    RecNo3 := FieldRef2.Value;
                    DocumentAttachment.SetRange("No.", RecNo2);
                    DocumentAttachment.SetRange("Link Code", RecNo3);
                end;
            DATABASE::"Design":
                begin
                    FieldRef := RecRef.Field(2);
                    RecNo2 := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo2);
                end;
            DATABASE::"Item Color":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("Line No.", RecNo);
                end;
            DATABASE::"Item Design Section Color":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("Line No.", RecNo);
                end;
            DATABASE::"Branding Detail":
                begin
                    FieldRef := RecRef.Field(1);
                    FieldRef2 := RecRef.Field(2);
                    RecNo := FieldRef.Value;
                    RecNo2 := FieldRef2.Value;
                    DocumentAttachment.SetRange("Line No.", RecNo);
                    DocumentAttachment.SetRange("No.", RecNo2);
                end;
            DATABASE::"Item Variant":
                begin
                    FieldRef := RecRef.Field(1);
                    FieldRef2 := RecRef.Field(50210);
                    RecNo := FieldRef.Value;
                    RecNo2 := FieldRef2.Value;
                    DocumentAttachment.SetRange("Line No.", RecNo);
                    DocumentAttachment.SetRange("No.", RecNo2);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        FieldRef2: FieldRef;
        RecNo: Integer;
        RecNo2: Code[50];
        RecNo3: Code[50];
    begin
        case RecRef.Number of
            DATABASE::"Plotting File":
                begin
                    FieldRef := RecRef.Field(4);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("Line No.", RecNo);
                end;
            DATABASE::"Branding":
                begin
                    FieldRef := RecRef.Field(1);
                    FieldRef2 := RecRef.Field(4);
                    RecNo2 := FieldRef.Value;
                    RecNo3 := FieldRef2.Value;
                    DocumentAttachment.Validate("No.", RecNo2);
                    DocumentAttachment.Validate("Link Code", RecNo3);
                end;
            DATABASE::"Design":
                begin
                    FieldRef := RecRef.Field(2);
                    RecNo2 := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo2);
                end;
            DATABASE::"Item Color":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("Line No.", RecNo);
                end;
            DATABASE::"Item Design Section Color":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("Line No.", RecNo);
                end;
            DATABASE::"Branding Detail":
                begin
                    FieldRef := RecRef.Field(1);
                    FieldRef2 := RecRef.Field(2);
                    RecNo := FieldRef.Value;
                    RecNo2 := FieldRef2.Value;
                    DocumentAttachment.Validate("Line No.", RecNo);
                    DocumentAttachment.Validate("No.", RecNo2);
                end;
            DATABASE::"Item Variant":
                begin
                    FieldRef := RecRef.Field(1);
                    FieldRef2 := RecRef.Field(50210);
                    RecNo := FieldRef.Value;
                    RecNo2 := FieldRef2.Value;
                    DocumentAttachment.Validate("Line No.", RecNo);
                    DocumentAttachment.Validate("No.", RecNo2);
                end;
        end;
    end;
    //Add Documents To Plotting File / Branding / Item Color / Item Design Section Color / Branding Details / Item Variant -
    #endregion
    #region [Sales]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostLines', '', false, false)]
    local procedure OnBeforePostLines(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary)
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        SalesLine.CalcFields("Assembly No.");
        if SalesLine."Assembly No." <> '' then begin
            AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, SalesLine."Assembly No.");
            AssemblyHeader.TestField(Status, AssemblyHeader.Status::Released);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order (Yes/No)", 'OnBeforeConfirmConvertToOrder', '', false, false)]
    local procedure OnBeforeConfirmConvertToOrder(SalesHeader: Record "Sales Header"; var Result: Boolean; var IsHandled: Boolean)
    begin
        SalesHeader.TestField(SalesHeader.Status, SalesHeader.Status::Released);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnAfterInsertAllSalesOrderLines', '', false, false)]
    local procedure OnAfterInsertAllSalesOrderLines(var SalesOrderLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header")
    var
        CuttingSheetsDashboard: Record "Cutting Sheets Dashboard";
        AssemblyHeader: Record "Assembly Header";
        PaymentTerms: Record "Payment Terms";
        Item: Record Item;
        AvailableQty: Decimal;
        CUManagement: Codeunit Management;
        SalesLineLoc: Record "Sales Line";
        NeededRawMaterial: Record "Needed Raw Material";
        ParameterHeaderLoc: Record "Parameter Header";
        ParentParameterHeaderLoc: Record "Parameter Header";
        SalesOrdrLines_Local: Record "Sales Line";
    begin
        //Update Cutting Sheet Source Type and Source No.
        CuttingSheetsDashboard.SetRange("Source Type", SalesQuoteHeader."Document Type");
        CuttingSheetsDashboard.SetRange("Source No.", SalesQuoteHeader."No.");
        if CuttingSheetsDashboard.FindSet() then
            repeat
                CuttingSheetsDashboard."Source Type" := SalesOrderHeader."Document Type";
                CuttingSheetsDashboard."Source No." := SalesOrderHeader."No.";
                CuttingSheetsDashboard.Modify();
            until CuttingSheetsDashboard.Next() = 0;

        //Update Assembly Source Type and Source No.
        AssemblyHeader.SetRange("Source Type", SalesQuoteHeader."Document Type");
        AssemblyHeader.SetRange("Source No.", SalesQuoteHeader."No.");
        if AssemblyHeader.FindSet() then
            repeat
                AssemblyHeader."Source Type" := SalesOrderHeader."Document Type";
                AssemblyHeader."Source No." := SalesOrderHeader."No.";
                AssemblyHeader.Modify();
                //Update Cutting Sheet Assembly No.
                CuttingSheetsDashboard.SetRange("Source Type", AssemblyHeader."Source Type");
                CuttingSheetsDashboard.SetRange("Source No.", AssemblyHeader."Source No.");
                CuttingSheetsDashboard.SetRange("Source Line No.", AssemblyHeader."Source Line No.");
                if CuttingSheetsDashboard.FindFirst() then
                    CuttingSheetsDashboard.Rename(AssemblyHeader."No.");
            until AssemblyHeader.Next() = 0;

        //Insert Prepayments Lines
        SalesQuoteHeader.TestField("Payment Terms Code");
        PaymentTerms.Get(SalesQuoteHeader."Payment Terms Code");
        if (PaymentTerms."Prepayment %" <> 0) and (not AlreadyHasPrepayment(SalesQuoteHeader)) then begin
            //I used the built in Prepayment way with unrealized VAT
            //CreatePrepaymentLines(SalesOrderHeader, PaymentTerms."Prepayment %");

            SalesOrderLine.Validate("Prepayment %", PaymentTerms."Prepayment %");
            SalesOrderHeader.Validate("Prepayment %", PaymentTerms."Prepayment %");
            SalesOrderHeader.Modify(true)
        end else begin
            //Release if there is no prepayment
            SalesOrderHeader.Validate(Status, SalesOrderHeader.Status::Released);
            SalesOrderHeader.Modify(true)
        end;

        //Update Needed Raw Materials Sales Order No.
        Clear(NeededRawMaterial);
        NeededRawMaterial.SetRange("Sales Order No.", SalesQuoteHeader."No.");
        if NeededRawMaterial.FindSet() then
            NeededRawMaterial.ModifyAll("Sales Order No.", SalesOrderHeader."No.");
        //Update Assembly Order No.
        Clear(NeededRawMaterial);
        NeededRawMaterial.SetRange("Sales Order No.", SalesOrderHeader."No.");
        if NeededRawMaterial.FindSet() then
            repeat
                if SalesLineLoc.get(SalesLineLoc."Document Type"::Order, SalesOrderHeader."No.", NeededRawMaterial."Sales Order Line No.") then begin
                    SalesLineLoc.CalcFields("Assembly No.");
                    NeededRawMaterial."Assembly Order No." := SalesLineLoc."Assembly No.";
                    NeededRawMaterial.Modify();
                    //Update Parameters Header
                    Clear(ParameterHeaderLoc);
                    if ParameterHeaderLoc.Get(SalesLineLoc."Parameters Header ID") then begin
                        ParameterHeaderLoc."Sales Line Document No." := SalesLineLoc."Document No.";
                        ParameterHeaderLoc."Sales Line Document Type" := SalesLineLoc."Document Type";
                        ParameterHeaderLoc.Modify();
                    end;
                    Clear(ParentParameterHeaderLoc);
                    if ParentParameterHeaderLoc.Get(SalesLineLoc."Parameters Header ID") then begin
                        ParentParameterHeaderLoc."Sales Line Document No." := SalesLineLoc."Document No.";
                        ParentParameterHeaderLoc."Sales Line Document Type" := SalesLineLoc."Document Type";
                        ParentParameterHeaderLoc.Modify();
                    end;
                end;
            until NeededRawMaterial.Next() = 0;

        //Check Item Availability by location
        //Only if company Full Production
        if CUManagement.IsCompanyFullProduction then begin
            SalesOrdrLines_Local.Reset();
            SalesOrdrLines_Local.SetRange("Document Type", SalesOrderLine."Document Type");
            SalesOrdrLines_Local.SetRange("Document No.", SalesOrderLine."Document No.");
            if SalesOrdrLines_Local.FindFirst() then repeat
                Clear(Item);
                AvailableQty := 0;
                if Item.Get(SalesOrdrLines_Local."No.") then;
                Item.SetRange("Location Filter", SalesOrdrLines_Local."Location Code");
                Item.SetRange("Variant Filter", SalesOrdrLines_Local."Variant Code");
                Item.CalcFields(Inventory, "FP Order Receipt (Qty.)", "Rel. Order Receipt (Qty.)", "Qty. on Assembly Order", "Qty. on Purch. Order", "Trans. Ord. Receipt (Qty.)", "Qty. On Sales Order", "Qty. on Component Lines", "Qty. on Asm. Component", "Trans. Ord. Shipment (Qty.)");
                AvailableQty := Item.Inventory
                            + (Item."FP Order Receipt (Qty.)" + Item."Rel. Order Receipt (Qty.)" + Item."Qty. on Assembly Order" + Item."Qty. on Purch. Order" + Item."Trans. Ord. Receipt (Qty.)")
                            - (Item."Qty. on Sales Order" + Item."Qty. on Component Lines" + Item."Qty. on Asm. Component" + Item."Trans. Ord. Shipment (Qty.)");
            //If available quantity less than requested quantity but greater than 0 --> just the difference
                if (AvailableQty < SalesOrdrLines_Local."Quantity") and (AvailableQty >= 0) then begin
                    SalesOrdrLines_Local.Validate("Qty. to Assemble to Order", SalesOrdrLines_Local.Quantity - AvailableQty);
                    SalesOrdrLines_Local.Validate(Reserve, SalesOrdrLines_Local.Reserve::Always);
                    SalesOrdrLines_Local.AutoReserve();
                    SalesOrdrLines_Local.Validate("Qty. to Assemble to Order", SalesOrdrLines_Local.Quantity - AvailableQty);
                    SalesOrdrLines_Local.Modify(true);
                end else
                //If available quantity Negative --> all the requested should be assembled
                    if (AvailableQty < 0) then begin
                        SalesOrdrLines_Local.Validate("Qty. to Assemble to Order", SalesOrdrLines_Local.Quantity);
                        SalesOrdrLines_Local.Validate(Reserve, SalesOrdrLines_Local.Reserve::Always);
                        SalesOrdrLines_Local.AutoReserve();
                        SalesOrdrLines_Local.Validate("Qty. to Assemble to Order", SalesOrdrLines_Local.Quantity);
                        SalesOrdrLines_Local.Modify(true)
                    end else
                    //If available quantity greater than requested quantity
                        if AvailableQty >= SalesOrdrLines_Local.Quantity then begin
                            SalesOrdrLines_Local.Validate("Qty. to Assemble to Order", 0);
                            SalesOrdrLines_Local.Validate(Reserve, SalesOrdrLines_Local.Reserve::Always);
                            SalesOrdrLines_Local.AutoReserve();
                            SalesOrdrLines_Local.Validate("Qty. to Assemble to Order", 0);
                            SalesOrdrLines_Local.Modify(true);
                        end;
                    until SalesOrdrLines_Local.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order (Yes/No)", 'OnAfterSalesQuoteToOrderRun', '', false, false)]
    local procedure OnAfterSalesQuoteToOrderRun(var SalesHeader2: Record "Sales Header"; var SalesHeader: Record "Sales Header")
    var
        SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
        Txt001: Label 'You must set a posting date for prepayment to post it and continue the process';
        PaymentTerms: Record "Payment Terms";
        SalesHeaderDialogRec: Record "Sales Header";
    begin
        //Post Prepayment
        SalesHeader.TestField("Payment Terms Code");
        PaymentTerms.Get(SalesHeader."Payment Terms Code");
        if (PaymentTerms."Prepayment %" <> 0) and (not AlreadyHasPrepayment(SalesHeader)) then begin
            Clear(SalesHeaderDialogRec);
            SalesHeaderDialogRec.SetRange("Document Type", SalesHeader2."Document Type");
            SalesHeaderDialogRec.SetRange("No.", SalesHeader2."No.");
            if SalesHeaderDialogRec.FindSet() then begin
                SalesHeaderDialogRec."Posting Date" := Today;
                SalesHeaderDialogRec.Modify(true);
                PostPrepmtDocument(SalesHeaderDialogRec, SalesHeaderDialogRec."Document Type"::Invoice);
                //Print Prepayment
                Commit();
                GetReport(SalesHeaderDialogRec, 0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterInsertToSalesLine', '', false, false)]
    local procedure OnAfterInsertToSalesLine(var ToSalesLine: Record "Sales Line"; FromSalesLine: Record "Sales Line"; RecalculateLines: Boolean; DocLineNo: Integer; FromSalesDocType: Enum "Sales Document Type From"; FromSalesHeader: Record "Sales Header"; var NextLineNo: Integer)
    begin
        //Update added fields (Customized)
        ToSalesLine.Size := FromSalesLine.Size;
        ToSalesLine.Fit := FromSalesLine.Fit;
        ToSalesLine.Color := FromSalesLine.Color;
        ToSalesLine.Cut := FromSalesLine.Cut;
        ToSalesLine.Tonality := FromSalesLine.Tonality;
        ToSalesLine.Validate("Parent Parameter Header ID", FromSalesLine."Parent Parameter Header ID");
        ToSalesLine.Validate("Parameters Header ID", FromSalesLine."Parameters Header ID");
        ToSalesLine."Allocation Type" := FromSalesLine."Allocation Type";
        ToSalesLine."Allocation Code" := FromSalesLine."Allocation Code";
        ToSalesLine.Modify(true);
    end;

    procedure AlreadyHasPrepayment(SalesQuote: Record "Sales Header"): Boolean
    var
        PostedSalesInvoices: Record "Sales Invoice Header";
        SalesInvoices: Record "Sales Header";
    begin
        Clear(PostedSalesInvoices);
        PostedSalesInvoices.SetRange("Sales Quote No.", SalesQuote."No.");
        if PostedSalesInvoices.FindFirst() then
            exit(true);

        Clear(SalesInvoices);
        SalesInvoices.SetRange("Document Type", SalesInvoices."Document Type"::Invoice);
        SalesInvoices.SetRange("Sales Quote No.", SalesQuote."No.");
        if SalesInvoices.FindFirst() then
            exit(true);

        exit(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; SkipCheckReleaseRestrictions: Boolean)
    var
        SalesLinesToDelete: Record "Sales Line";
        QtyAssignmentWizard: Record "Qty Assignment Wizard";
        ChildrenParameterHeader: Record "Parameter Header";
        VariantCode: Code[50];
        MasterItem: Codeunit MasterItem;
        ManagementCU: Codeunit Management;
        ParamHeader: Record "Parameter Header";
        SalesLine: Record "Sales Line";
        SameParameterParent: Integer;
        UserSetup: Record "User Setup";
        ChildParameterHeaderPar: Record "Parameter Header";
        SalesHeaderOriginalStatus: Enum "Sales Document Status";
        PostedPrePayments: Record "Sales Invoice Header";
        PrepaymentsClosed: Boolean;
        SalesLineLoc: Record "Sales Line";
    begin
        //Check Access
        UserSetup.Get(UserId);
        UserSetup.TestField("Release Sales Documents", true);

        //Project Code Mandatory only on Sales Quote (On Sales Orders sometimes the custproject is IC Project)
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
            SalesHeader.TestField("Cust Project");

        //Only update parameters on release if the sales document type is Quote
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then begin

            //Open Sales order if it's related to prepayment to be able to update lines
            if SalesHeader.Status = SalesHeader.Status::"Pending Prepayment" then begin
                SalesHeaderOriginalStatus := SalesHeader.Status;
                SalesHeader.Status := SalesHeader.Status::Open;
                SalesHeader.Modify();
            end;

            SameParameterParent := 0;
            SalesLine.SetCurrentKey("Parent Parameter Header ID");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetFilter("Parameters Header ID", '<>0');
            if SalesLine.FindSet() then
                repeat
                    if SameParameterParent <> SalesLine."Parent Parameter Header ID" then begin
                        if ParamHeader.Get(SalesLine."Parent Parameter Header ID") then begin

                            ManagementCU.DeleteUnselectedBranding(ParamHeader.ID);
                            //Create Design Section Set
                            MasterItem.GenerateDesignSectionSetID(ParamHeader);
                            //Create Item Features Set
                            MasterItem.GenerateItemFeatureSetID(ParamHeader);
                            //Create Item Brandings Set
                            MasterItem.GenerateItemBrandingSetID(ParamHeader);
                            //Transfer the data from the parent parameter to the children
                            MasterItem.TransferParameterDataToChildren(ParamHeader, ChildParameterHeaderPar);
                            //Create Plotting Files for each child
                            Clear(QtyAssignmentWizard);
                            QtyAssignmentWizard.SetRange("Parent Header ID", ParamHeader.ID);
                            if QtyAssignmentWizard.FindSet() then
                                repeat
                                    Clear(ChildrenParameterHeader);
                                    ChildrenParameterHeader.Get(QtyAssignmentWizard."Header Id");
                                    MasterItem.CreateDesignPlotting(ChildrenParameterHeader);
                                until QtyAssignmentWizard.Next() = 0;


                            //Delete Old Sales lines to create new ones
                            SalesLinesToDelete.SetRange("Parent Parameter Header ID", ParamHeader."ID");
                            if SalesLinesToDelete.FindSet() then begin
                                SalesLinesToDelete.ModifyAll("Prepmt. Amt. Inv.", 0);
                                SalesLinesToDelete.ModifyAll("Prepmt. Line Amount", 0);
                                SalesLinesToDelete.DeleteAll(true);
                            end;
                            //Create Variant for each child
                            Clear(QtyAssignmentWizard);
                            QtyAssignmentWizard.SetRange("Parent Header ID", ParamHeader."ID");
                            if QtyAssignmentWizard.FindSet() then
                                repeat
                                    Clear(ChildrenParameterHeader);
                                    ChildrenParameterHeader.Get(QtyAssignmentWizard."Header Id");
                                    VariantCode := MasterItem.CreateVariant(ChildrenParameterHeader);
                                    //Update The parameters Headers Related to Qty Assignment
                                    //ManagementCU.UpdateDesignFeatureBrandingParamLines(ParamHeader, ChildrenParameterHeader);
                                    //CreateSalesLine + Needed Raw Materials + Assembly
                                    ManagementCU.CreateMultipleSalesLines(ChildrenParameterHeader, SalesHeader, VariantCode, ParamHeader, QtyAssignmentWizard, true);
                                    //Update parameter header to the line (Remove the Assigned Qty)
                                    ChildrenParameterHeader."Sales Line Quantity" := ChildrenParameterHeader."Sales Line Quantity" - ChildrenParameterHeader."Quantity To Assign";
                                    ChildrenParameterHeader."Quantity To Assign" := 0;
                                    ChildrenParameterHeader.Modify();
                                until QtyAssignmentWizard.Next() = 0;
                            SameParameterParent := SalesLine."Parent Parameter Header ID";
                        end;
                    end;
                until SalesLine.Next() = 0;
            //if SalesHeaderOriginalStatus = SalesHeaderOriginalStatus::"Pending Prepayment" then begin
            //Because we deleted the lines we need to check manually if all the posted prepayment are closed
            Clear(PostedPrePayments);
            PostedPrePayments.SetRange("Prepayment Order No.", SalesHeader."No.");
            PostedPrePayments.SetRange(Closed, false);
            if PostedPrePayments.FindFirst() then
                PrepaymentsClosed := false
            else
                PrepaymentsClosed := true;
            if PrepaymentsClosed = true then begin
                SalesHeader.Status := SalesHeader."Status"::Released;
                //Update imvoiced prepayment amount on lines
                Clear(SalesLineLoc);
                SalesLineLoc.SetRange("Document Type", SalesHeader."Document Type");
                SalesLineLoc.SetRange("Document No.", SalesHeader."No.");
                if SalesLineLoc.FindSet() then
                    repeat
                        SalesLineLoc.Validate("Prepmt. Amt. Inv.", SalesLineLoc."Prepmt. Line Amount");
                        SalesLineLoc.Modify(true);
                    until SalesLineLoc.Next() = 0;
            end else
                SalesHeader.Status := SalesHeader."Status"::"Pending Prepayment";
            SalesHeader.Modify();
        end;
    end;
    //end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnBeforeCreateShptLineFromSalesLine', '', false, false)]
    local procedure OnBeforeCreateShptLineFromSalesLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        SalesLine.CalcFields("Assembly No.");
        WarehouseShipmentLine.Size := SalesLine.Size;
        WarehouseShipmentLine.Fit := SalesLine.Fit;
        WarehouseShipmentLine.Cut := SalesLine.Cut;
        WarehouseShipmentLine.Color := SalesLine.Color;
        WarehouseShipmentLine.Tonality := SalesLine.Tonality;
        WarehouseShipmentLine."Allocation Code" := SalesLine."Allocation Code";
        WarehouseShipmentLine."Allocation Type" := SalesLine."Allocation Type";
        WarehouseShipmentLine."Control Number" := SalesLine."Control Number";
        WarehouseShipmentLine."Assembly No." := SalesLine."Assembly No.";
    end;

    /*[EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeDeleteSalesQuote', '', false, false)]
    local procedure OnBeforeDeleteSalesQuote(var IsHandled: Boolean);
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.Get();
        if SalesReceivablesSetup."Keep Sales Quote" then
            IsHandled := true;
    end;*/

    procedure CreateSalesLineGenGrouped(SalesOrder: Record "Sales Header"; GenBusPostingGrp: Code[20]; GenProdPostingGrp: Code[20]; var LineNumber: Integer; GenGrpAmount: Decimal; PrePaymentPercPar: Decimal)
    var
        GeneralPostingSetup: Record "General Posting Setup";
        SalesLineToInsert: Record "Sales Line";
        PaymentTerms: Record "Payment Terms";
    begin
        //Generate G/L Account with 100% prepayment and the amount = the prepayment % of Amount not including VAT
        GeneralPostingSetup.Get(GenBusPostingGrp, GenProdPostingGrp);
        GeneralPostingSetup.TestField("Sales Prepayments Account");
        Clear(SalesLineToInsert);
        SalesLineToInsert.Init();
        SalesLineToInsert."Document Type" := SalesOrder."Document Type";
        SalesLineToInsert."Document No." := SalesOrder."No.";
        SalesLineToInsert."Line No." := LineNumber;
        SalesLineToInsert.Validate(Type, SalesLineToInsert.Type::"G/L Account");
        SalesLineToInsert.Validate("No.", GeneralPostingSetup."Sales Prepayments Account");
        SalesLineToInsert.Validate(Quantity, 1);
        SalesLineToInsert.Validate("Unit Price", (GenGrpAmount * PrePaymentPercPar) / 100);
        SalesLineToInsert.Validate("Gen. Bus. Posting Group", GenBusPostingGrp);
        SalesLineToInsert.Validate("Gen. Prod. Posting Group", GenProdPostingGrp);
        SalesLineToInsert.Validate("Prepayment %", 100);
        SalesLineToInsert.Insert(true);
        LineNumber := LineNumber + 10000;
        //Generate G/L Account with 0 prepayment and the amount = the prepayment % of Amount not including VAT
        Clear(SalesLineToInsert);
        SalesLineToInsert.Init();
        SalesLineToInsert."Document Type" := SalesOrder."Document Type";
        SalesLineToInsert."Document No." := SalesOrder."No.";
        SalesLineToInsert."Line No." := LineNumber;
        SalesLineToInsert.Validate(Type, SalesLineToInsert.Type::"G/L Account");
        SalesLineToInsert.Validate("No.", GeneralPostingSetup."Sales Prepayments Account");
        SalesLineToInsert.Validate(Quantity, 1);
        SalesLineToInsert.Validate("Unit Price", ((GenGrpAmount * -1) * PrePaymentPercPar) / 100);
        SalesLineToInsert.Validate("Gen. Bus. Posting Group", GenBusPostingGrp);
        SalesLineToInsert.Validate("Gen. Prod. Posting Group", GenProdPostingGrp);
        //SalesLine.Validate("Prepayment %", 100);
        SalesLineToInsert.Insert(true);
        LineNumber := LineNumber + 10000;
    end;

    procedure PostPrepmtDocument(var SalesHeader: Record "Sales Header"; PrepmtDocumentType: Enum "Sales Document Type")
    var
        SalesPostPrepayments: Codeunit "Sales-Post Prepayments";
        ErrorMessageHandler: Codeunit "Error Message Handler";
        ErrorMessageMgt: Codeunit "Error Message Management";
        ErrorContextElement: Codeunit "Error Context Element";
    begin
        ErrorMessageMgt.Activate(ErrorMessageHandler);
        ErrorMessageMgt.PushContext(ErrorContextElement, SalesHeader.RecordId, 0, '');
        SalesPostPrepayments.SetDocumentType(PrepmtDocumentType.AsInteger());
        Commit();
        if not SalesPostPrepayments.Run(SalesHeader) then
            ErrorMessageHandler.ShowErrors;
    end;

    procedure GetReport(var SalesHeader: Record "Sales Header"; DocumentType: Option Invoice,"Credit Memo")
    var
        IsHandled: Boolean;
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        case DocumentType of
            DocumentType::Invoice:
                begin
                    SalesInvHeader."No." := SalesHeader."Last Prepayment No.";
                    SalesInvHeader.SetRecFilter;
                    SalesInvHeader.PrintRecords(false);
                end;
            DocumentType::"Credit Memo":
                begin
                    SalesCrMemoHeader."No." := SalesHeader."Last Prepmt. Cr. Memo No.";
                    SalesCrMemoHeader.SetRecFilter;
                    SalesCrMemoHeader.PrintRecords(false);
                end;
        end;
    end;
    #endregion
    #region [Purchase]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Unplanned Demand", 'OnInsertSalesLineOnAfterInitRecord', '', false, false)]
    local procedure OnInsertSalesLineOnAfterInitRecord(var UnplannedDemand: Record "Unplanned Demand"; var SalesLine: Record "Sales Line")
    begin
        UnplannedDemand."Allocation Type" := SalesLine."Allocation Type";
        UnplannedDemand."Allocation Code" := SalesLine."Allocation Code";
        if SalesLine."IC Parent Parameter Header ID" = 0 then
            UnplannedDemand."Parent Parameter Header ID" := SalesLine."Parent Parameter Header ID"
        else
            UnplannedDemand."Parent Parameter Header ID" := SalesLine."IC Parent Parameter Header ID";
        if SalesLine."IC Parameters Header ID" = 0 then
            UnplannedDemand."Parameters Header ID" := SalesLine."Parameters Header ID"
        else
            UnplannedDemand."Parameters Header ID" := SalesLine."IC Parameters Header ID";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Requisition Line", 'OnTransferFromUnplannedDemandOnBeforeSetStatus', '', false, false)]
    local procedure OnTransferFromUnplannedDemandOnBeforeSetStatus(var RequisitionLine: Record "Requisition Line"; var UnplannedDemand: Record "Unplanned Demand")
    begin
        RequisitionLine."Allocation Type" := UnplannedDemand."Allocation Type";
        RequisitionLine."Allocation Code" := UnplannedDemand."Allocation Code";
        RequisitionLine."Parent Parameter Header ID" := UnplannedDemand."Parent Parameter Header ID";
        RequisitionLine."Parameters Header ID" := UnplannedDemand."Parameters Header ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInitPurchOrderLine', '', false, false)]
    local procedure OnAfterInitPurchOrderLine(var PurchaseLine: Record "Purchase Line"; RequisitionLine: Record "Requisition Line")
    begin
        PurchaseLine.Validate("Variant Code", RequisitionLine."Variant Code");
        PurchaseLine."Allocation Type" := RequisitionLine."Allocation Type";
        PurchaseLine."Allocation Code" := RequisitionLine."Allocation Code";
        PurchaseLine."Parent Parameter Header ID" := RequisitionLine."Parent Parameter Header ID";
        PurchaseLine."Parameters Header ID" := RequisitionLine."Parameters Header ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnSendPurchDocOnBeforeReleasePurchDocument', '', false, false)]
    local procedure OnSendPurchDocOnBeforeReleasePurchDocument(var PurchaseHeader: Record "Purchase Header"; var Post: Boolean)
    begin
        PurchaseHeader.TestField("IC Source No.");
        PurchaseHeader.TestField("IC Company Name");
    end;

    #endregion
    #region [Assembly]
    [EventSubscriber(ObjectType::Table, database::"Assembly Header", 'OnAfterInitRecord', '', false, false)]
    local procedure OnAfterInitRecord(var AssemblyHeader: Record "Assembly Header")
    var
        ManagementCU: Codeunit Management;
        ParameterHeader: Record "Parameter Header";
        NeededRawMaterial: Record "Needed Raw Material";
    begin
        if AssemblyHeader."Parameters Header ID" <> 0 then begin
            ParameterHeader.get(AssemblyHeader."Parameters Header ID");
            ManagementCU.CreateNeededRawMaterial(ParameterHeader);
            NeededRawMaterial.SetRange("Assembly Order No.", AssemblyHeader."No.");
            if NeededRawMaterial.FindSet() then
                ManagementCU.CreateAssemblyOrder(NeededRawMaterial, ParameterHeader, ParameterHeader);
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Assemble-to-Order Link", 'OnUpdateAsmOnBeforeSynchronizeAsmFromSalesLine', '', false, false)]
    local procedure OnUpdateAsmOnBeforeSynchronizeAsmFromSalesLine(var AssembleToOrderLink: Record "Assemble-to-Order Link"; var AssemblyHeader: Record "Assembly Header"; SalesLine: Record "Sales Line")
    begin
        AssemblyHeader."Parent Parameter Header ID" := SalesLine."Parent Parameter Header ID";
        AssemblyHeader."Parameters Header ID" := SalesLine."Parameters Header ID";
    end;

    [EventSubscriber(ObjectType::Table, database::"Assembly Header", 'OnValidateVariantCodeOnBeforeUpdateAssemblyLines', '', false, false)]
    local procedure OnValidateVariantCodeOnBeforeUpdateAssemblyLines(var AssemblyHeader: Record "Assembly Header"; xAssemblyHeader: Record "Assembly Header"; CurrentFieldNo: Integer; CurrentFieldNum: Integer; var IsHandled: Boolean)
    begin
        //in some case even if the assembly is assembly to order, assemble to order is false (example intercompany case when validate Sales line field Qty to assemble)
        /*AssemblyHeader.CalcFields("Assemble to Order");
        if (not AssemblyHeader."Assemble to Order") and (not (AssemblyHeader."Document Type" = AssemblyHeader."Document Type"::Quote)) then begin*/

        //based on the parameter header the assembly is assemble to order or not
        if (AssemblyHeader."Parameters Header ID" = 0) and (not (AssemblyHeader."Document Type" = AssemblyHeader."Document Type"::Quote)) then begin
            //Mandatory fields before creating assembly order lines
            AssemblyHeader.TestField("Location Code");
            AssemblyHeader.TestField(Quantity);
            CreateAssemblyOrderNeededRawMaterial(AssemblyHeader);
            IsHandled := true;
        end;
    end;

    procedure CreateAssemblyOrderNeededRawMaterial(var AssemblyHeaderPar: Record "Assembly Header")
    var
        ItemVariantLoc: Record "Item Variant";
        Txt001: Label 'No related raw materials found for this item and variant';
        PostedAssemblyHeader: Record "Posted Assembly Header";
        PostedAssemblyLine: Record "Posted Assembly Line";
        AssemblyLine: Record "Assembly Line";
        QtyRate: Decimal;
        CUManagement: Codeunit Management;
        NeededRawMaterialLoc: Record "Needed Raw Material";
        NeededRawMaterialBatch: Integer;
        LineNumber: Integer;
    begin
        //Delete old lines
        Clear(AssemblyLine);
        AssemblyLine.SetRange("Document Type", AssemblyHeaderPar."Document Type");
        AssemblyLine.SetRange("Document No.", AssemblyHeaderPar."No.");
        if AssemblyLine.FindSet() then
            AssemblyLine.DeleteAll(true);

        //Create new lines
        Clear(ItemVariantLoc);
        if ItemVariantLoc.Get(AssemblyHeaderPar."Item No.", AssemblyHeaderPar."Variant Code") then begin
            Clear(PostedAssemblyHeader);
            PostedAssemblyHeader.SetRange("Item No.", ItemVariantLoc."Item No.");
            PostedAssemblyHeader.SetRange("Variant Code", ItemVariantLoc."Code");
            //Check if there is an old posted assembly
            if PostedAssemblyHeader.FindLast() then begin
                Clear(PostedAssemblyLine);
                PostedAssemblyLine.SetRange("Document No.", PostedAssemblyHeader."No.");
                if PostedAssemblyLine.FindSet() then
                    repeat
                        #region[Create Assembly Line]
                        Clear(AssemblyLine);
                        AssemblyLine.Init();
                        AssemblyLine."Document Type" := AssemblyHeaderPar."Document Type";
                        AssemblyLine."Document No." := AssemblyHeaderPar."No.";
                        AssemblyLine."Line No." := PostedAssemblyLine."Line No.";
                        AssemblyLine.Validate(Type, PostedAssemblyLine.Type);
                        AssemblyLine.Validate("No.", PostedAssemblyLine."No.");
                        //Raw Material Variant Code
                        AssemblyLine.Validate("Variant Code", PostedAssemblyLine."Variant Code");
                        AssemblyLine.Validate("Location Code", AssemblyHeaderPar."Location Code");
                        //Calculate Quantity Rate
                        AssemblyLine.Validate("Quantity Per", PostedAssemblyLine."Quantity per");
                        AssemblyLine.Validate("Quantity", PostedAssemblyLine."Quantity per" * AssemblyHeaderPar.Quantity);
                        AssemblyLine.Validate("Unit of Measure Code", PostedAssemblyLine."Unit of Measure Code");
                        AssemblyLine.Validate(Reserve, AssemblyLine.Reserve::Always);
                        AssemblyLine.Insert(true);
                        AssemblyLine.AutoReserve();
                    #endregion[Create Assembly Line]   
                    until PostedAssemblyLine.Next() = 0;
                exit;
            end else begin
                //Create for new variant (No posted assembly found)
                NeededRawMaterialBatch := CUManagement.CreateNeededRawMaterialForDesignSecParamLines(ItemVariantLoc, AssemblyHeaderPar);
                if NeededRawMaterialBatch <> 0 then begin
                    Clear(NeededRawMaterialLoc);
                    NeededRawMaterialLoc.SetRange(Batch, NeededRawMaterialBatch);
                    if NeededRawMaterialLoc.FindSet() then
                        repeat
                            #region[Create Assembly Line]
                            LineNumber := LineNumber + 10000;
                            Clear(AssemblyLine);
                            AssemblyLine.Init();
                            AssemblyLine."Document Type" := AssemblyHeaderPar."Document Type";
                            AssemblyLine."Document No." := AssemblyHeaderPar."No.";
                            AssemblyLine."Line No." := LineNumber;
                            AssemblyLine.Validate(Type, AssemblyLine.Type::Item);
                            AssemblyLine.Validate("No.", NeededRawMaterialLoc."RM Code");
                            //Raw Material Variant Code
                            AssemblyLine.Validate("Variant Code", NeededRawMaterialLoc."RM Variant Code");
                            AssemblyLine.Validate("Location Code", NeededRawMaterialLoc."Sales Line Location Code");
                            //Calculate Quantity Rate
                            AssemblyLine.Validate("Quantity Per", NeededRawMaterialLoc."Assembly Line Quantity");
                            AssemblyLine.Validate("Quantity", NeededRawMaterialLoc."Assembly Line Quantity" * AssemblyHeaderPar.Quantity);
                            AssemblyLine.Validate("Unit of Measure Code", NeededRawMaterialLoc."Assembly Line UOM Code");
                            AssemblyLine.Validate(Reserve, AssemblyLine.Reserve::Always);
                            AssemblyLine.Insert(true);
                            AssemblyLine.AutoReserve();
                        #endregion[Create Assembly Line]          
                        until NeededRawMaterialLoc.Next() = 0;
                end;
                exit;
            end;
            Message(Txt001);
        end;
    end;
    #endregion
    #region [Journal]
    //TODO
    /*
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnBeforeCheckAccountNo', '', false, false)]
    local procedure OnBeforeCheckAccountNo(var GenJnlLine: Record "Gen. Journal Line"; var CheckDone: Boolean)
    var
        Txt001: Label 'You must apply the line %1 to the related invoice';
    begin
        if (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer) and (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment) then
            if (GenJnlLine."Applies-to Doc. No." = '') and (GenJnlLine."Applies-to ID" = '') then
                Error(Txt001, GenJnlLine."Line No.");
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostCust', '', false, false)]
    local procedure OnAfterPostCust(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        DetCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        SalesHeader: Record "Sales Header";
        AssemblyHeader: Record "Assembly Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        DetCustLedgerEntry.SetRange("Applied Cust. Ledger Entry No.", TempGLEntryBuf."Entry No.");
        if DetCustLedgerEntry.FindSet() then
            repeat
                //Should be different than the initial line
                if DetCustLedgerEntry."Cust. Ledger Entry No." <> TempGLEntryBuf."Entry No." then begin
                    CustLedgerEntry.Get(DetCustLedgerEntry."Cust. Ledger Entry No.");
                    //Get Related Invoice
                    SalesInvoiceHeader.Get(CustLedgerEntry."Document No.");
                    //Check if it is Prepayment
                    if SalesInvoiceHeader."Prepayment Invoice" then begin
                        SalesInvoiceHeader.CalcFields("Remaining Amount");
                        if SalesInvoiceHeader."Remaining Amount" = 0 then begin
                            //Get related sales order to release
                            Clear(SalesHeader);
                            SalesHeader.SetRange("No.", SalesInvoiceHeader."Prepayment Order No.");
                            if SalesHeader.FindFirst() then begin
                                SalesHeader.Validate(Status, SalesHeader.Status::Released);
                                SalesHeader.Modify(true);
                            end;
                        end;
                    end;
                end;
            until DetCustLedgerEntry.Next() = 0;
    end;
    */
    //FIXME Remove Comment

    #endregion
    #region [ICInbox/ICOutbox]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnCreateOutboxPurchDocTransOnBeforeOutboxTransactionInsert', '', false, false)]
    local procedure OnCreateOutboxPurchDocTransOnBeforeOutboxTransactionInsert(var OutboxTransaction: Record "IC Outbox Transaction"; PurchaseHeader: Record "Purchase Header")
    begin
        OutboxTransaction."IC Source No." := PurchaseHeader."IC Source No.";
        OutboxTransaction."IC Company Name" := PurchaseHeader."IC Company Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnCreateOutboxPurchDocTransOnAfterICOutBoxPurchLineInsert', '', false, false)]
    local procedure OnCreateOutboxPurchDocTransOnAfterICOutBoxPurchLineInsert(var ICOutboxPurchaseLine: Record "IC Outbox Purchase Line"; PurchaseLine: Record "Purchase Line")
    begin
        ICOutboxPurchaseLine."Variant Code" := PurchaseLine."Variant Code";
        ICOutboxPurchaseLine."Allocation Type" := PurchaseLine."Allocation Type";
        ICOutboxPurchaseLine."Allocation Code" := PurchaseLine."Allocation Code";
        ICOutboxPurchaseLine."Parent Parameter Header ID" := PurchaseLine."Parent Parameter Header ID";
        ICOutboxPurchaseLine."Parameters Header ID" := PurchaseLine."Parameters Header ID";
        ICOutboxPurchaseLine.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnBeforeOutBoxTransactionInsert', '', false, false)]
    local procedure OnBeforeOutBoxTransactionInsert(var ICOutboxTransaction: Record "IC Outbox Transaction"; SalesHeader: Record "Sales Header")
    begin
        ICOutboxTransaction."IC Source No." := SalesHeader."IC Source No.";
        ICOutboxTransaction."IC Company Name" := SalesHeader."IC Company Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnCreateOutboxSalesDocTransOnAfterICOutBoxSalesLineInsert', '', false, false)]
    local procedure OnCreateOutboxSalesDocTransOnAfterICOutBoxSalesLineInsert(var ICOutboxSalesLine: Record "IC Outbox Sales Line"; SalesLine: Record "Sales Line")
    begin
        ICOutboxSalesLine."Variant Code" := SalesLine."Variant Code";
        ICOutboxSalesLine."Allocation Type" := SalesLine."Allocation Type";
        ICOutboxSalesLine."Allocation Code" := SalesLine."Allocation Code";
        ICOutboxSalesLine."Parent Parameter Header ID" := SalesLine."IC Parent Parameter Header ID";
        ICOutboxSalesLine."Parameters Header ID" := SalesLine."IC Parameters Header ID";
        ICOutboxSalesLine.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnCreateOutboxPurchDocTransOnAfterTransferFieldsFromPurchHeader', '', false, false)]
    local procedure OnCreateOutboxPurchDocTransOnAfterTransferFieldsFromPurchHeader(var ICOutboxPurchHeader: Record "IC Outbox Purchase Header"; PurchHeader: Record "Purchase Header")
    begin
        ICOutboxPurchHeader."IC Source No." := PurchHeader."IC Source No.";
        ICOutboxPurchHeader."IC Company Name" := PurchHeader."IC Company Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnBeforeICInboxSalesHeaderInsert', '', false, false)]
    local procedure OnBeforeICInboxSalesHeaderInsert(var ICInboxSalesHeader: Record "IC Inbox Sales Header"; ICOutboxPurchaseHeader: Record "IC Outbox Purchase Header")
    begin
        ICInboxSalesHeader."IC Source No." := ICOutboxPurchaseHeader."IC Source No.";
        ICInboxSalesHeader."IC Company Name" := ICOutboxPurchaseHeader."IC Company Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnBeforeICInboxSalesLineInsert', '', false, false)]
    local procedure OnBeforeICInboxSalesLineInsert(var ICInboxSalesLine: Record "IC Inbox Sales Line"; ICOutboxPurchaseLine: Record "IC Outbox Purchase Line")
    begin
        ICInboxSalesLine."Variant Code" := ICOutboxPurchaseLine."Variant Code";
        ICInboxSalesLine."Allocation Type" := ICOutboxPurchaseLine."Allocation Type";
        ICInboxSalesLine."Allocation Code" := ICOutboxPurchaseLine."Allocation Code";
        ICInboxSalesLine."Parent Parameter Header ID" := ICOutboxPurchaseLine."Parent Parameter Header ID";
        ICInboxSalesLine."Parameters Header ID" := ICOutboxPurchaseLine."Parameters Header ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnBeforeICInboxTransInsert', '', false, false)]
    local procedure OnBeforeICInboxTransInsert(var ICInboxTransaction: Record "IC Inbox Transaction"; ICOutboxTransaction: Record "IC Outbox Transaction")
    begin
        ICInboxTransaction."IC Source No." := ICOutboxTransaction."IC Source No.";
        ICInboxTransaction."IC Company Name" := ICOutboxTransaction."IC Company Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnBeforeICInboxPurchHeaderInsert', '', false, false)]
    local procedure OnBeforeICInboxPurchHeaderInsert(var ICInboxPurchaseHeader: Record "IC Inbox Purchase Header"; ICOutboxSalesHeader: Record "IC Outbox Sales Header")
    begin
        ICInboxPurchaseHeader."IC Source No." := ICOutboxSalesHeader."IC Source No.";
        ICInboxPurchaseHeader."IC Company Name" := ICOutboxSalesHeader."IC Company Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnBeforeICInboxPurchLineInsert', '', false, false)]
    local procedure OnBeforeICInboxPurchLineInsert(var ICInboxPurchaseLine: Record "IC Inbox Purchase Line"; ICOutboxSalesLine: Record "IC Outbox Sales Line")
    begin
        ICInboxPurchaseLine."Variant Code" := ICOutboxSalesLine."Variant Code";
        ICInboxPurchaseLine."Allocation Type" := ICOutboxSalesLine."Allocation Type";
        ICInboxPurchaseLine."Allocation Code" := ICOutboxSalesLine."Allocation Code";
        ICInboxPurchaseLine."Parent Parameter Header ID" := ICOutboxSalesLine."Parent Parameter Header ID";
        ICInboxPurchaseLine."Parameters Header ID" := ICOutboxSalesLine."Parameters Header ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnCreateSalesDocumentOnBeforeSalesHeaderModify', '', false, false)]
    local procedure OnCreateSalesDocumentOnBeforeSalesHeaderModify(var SalesHeader: Record "Sales Header"; ICInboxSalesHeader: Record "IC Inbox Sales Header"; var ICDocDim: Record "IC Document Dimension")
    begin
        SalesHeader."IC Source No." := ICInboxSalesHeader."IC Source No.";
        SalesHeader."IC Company Name" := ICInboxSalesHeader."IC Company Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnAfterCreateSalesLines', '', false, false)]
    local procedure OnAfterCreateSalesLines(ICInboxSalesLine: Record "IC Inbox Sales Line"; var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    var
        ManagementCU: Codeunit Management;
        NeededRawMaterial: Record "Needed Raw Material";
        ParameterHeader: Record "Parameter Header";
    begin
        SalesLine."IC Parent Parameter Header ID" := ICInboxSalesLine."Parent Parameter Header ID";
        SalesLine."IC Parameters Header ID" := ICInboxSalesLine."Parameters Header ID";
        SalesLine.Validate("Variant Code", ICInboxSalesLine."Variant Code");
        SalesLine."Allocation Type" := ICInboxSalesLine."Allocation Type";
        SalesLine."Allocation Code" := ICInboxSalesLine."Allocation Code";
        //Automatically Create Assembly for the Non Available quantity if the company is Full Production
        Clear(NeededRawMaterial);
        NeededRawMaterial.SetRange(Batch, SalesLine."Needed RM Batch");
        if NeededRawMaterial.FindSet() then begin
            Clear(ParameterHeader);
            if ParameterHeader.Get(SalesLine."Parameters Header ID") then
                ManagementCU.CreateAssemblyOrder(NeededRawMaterial, ParameterHeader, ParameterHeader, SalesLine);
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnCreatePurchDocumentOnBeforePurchHeaderModify', '', false, false)]
    local procedure OnCreatePurchDocumentOnBeforePurchHeaderModify(var PurchHeader: Record "Purchase Header"; ICInboxPurchHeader: Record "IC Inbox Purchase Header")
    begin
        PurchHeader."IC Source No." := ICInboxPurchHeader."IC Source No.";
        PurchHeader."IC Company Name" := ICInboxPurchHeader."IC Company Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnAfterCreatePurchLines', '', false, false)]
    local procedure OnAfterCreatePurchLines(ICInboxPurchLine: Record "IC Inbox Purchase Line"; var PurchLine: Record "Purchase Line")
    begin
        PurchLine.Validate("Variant Code", ICInboxPurchLine."Variant Code");
        PurchLine."Allocation Type" := ICInboxPurchLine."Allocation Type";
        PurchLine."Allocation Code" := ICInboxPurchLine."Allocation Code";
    end;
    #endregion
    #region [G/L]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]

    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        /*if GenJournalLine."Source Currency Code" <> '' then begin
            GLEntry."Original Currency - ER" := GenJournalLine."Source Currency Code";
            if GLEntry.Amount = GenJournalLine."VAT Amount" then
                GLEntry."Original Amount - ER" := GenJournalLine."Source Curr. VAT Amount"
            else
                GLEntry."Original Amount - ER" := GenJournalLine."Source Curr. VAT Base Amount";
            if GLEntry."Original Amount - ER" = 0 then
                GLEntry."Original Amount - ER" := GenJournalLine."Source Currency Amount";
        end else begin
            GLEntry."Original Currency - ER" := GenJournalLine."Currency Code";
            GLEntry."Original Amount - ER" := GenJournalLine.Amount;
        end;
        if GLEntry."Original Amount - ER" > 0 then
            GLEntry."Original Debit Amount - ER" := GLEntry."Original Amount - ER"
        else
            GLEntry."Original Credit Amount - ER" := ABS(GLEntry."Original Amount - ER");*/
    end;
    #endregion

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"G/L Entry-Edit", 'OnBeforeGLLedgEntryModify', '', false, false)]
    local procedure OnBeforeGLLedgEntryModify(var GLEntry: Record "G/L Entry")
    var
        CustLedgerEntries: Record "Cust. Ledger Entry";
        VendLedgerEntries: Record "Vendor Ledger Entry";
        BankLedgerEntries: Record "Bank Account Ledger Entry";
    begin

        if CustLedgerEntries.Get(GLEntry."Entry No.") then begin
            CustLedgerEntries.Description := GLEntry.Description;
            CustLedgerEntries.Modify();
        end
        else begin
            if VendLedgerEntries.Get(GLEntry."Entry No.") then begin
                VendLedgerEntries.Description := GLEntry.Description;
                VendLedgerEntries.Modify();

            end
            else begin
                if BankLedgerEntries.Get(GLEntry."Entry No.") then begin
                    BankLedgerEntries.Description := GLEntry.Description;
                    BankLedgerEntries.Modify();
                end;
            end;

        end;
    end;


}