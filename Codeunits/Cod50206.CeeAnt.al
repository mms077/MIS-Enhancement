codeunit 50206 CeeAnt
{
    procedure GetCreditLineLanguageDescription(var DocumentNo: Code[20]; var LineNo: Integer; var SelectedLanguage: code[10]): Text[100]
    var
        L_RecCreditLine: Record "Sales Cr.Memo Line";
        L_RecItem: Record Item;
        LineItemDesc: text[100];
    begin
        L_RecCreditLine.reset();
        L_RecCreditLine.get(DocumentNo, LineNo);
        LineItemDesc := L_RecCreditLine.Description;//Getting the description of the line
        if L_RecCreditLine.Type.AsInteger() = 2 then begin//checking if line type is an item
            Case G_CULanguage.GetLanguageId(SelectedLanguage) of
                1036:
                    begin//If company information language Selected is French
                        L_RecItem.reset();
                        if L_RecItem.get(L_RecCreditLine."No.") then
                            exit(L_RecItem."Description 2");//Return Description 2
                    end
                else
                    exit(LineItemDesc);
            end;
        end
        else
            exit(LineItemDesc);
    End;

    procedure GetSizeValue(var SizeCode: Code[50]; var SelectedLanguage: Code[10]): Code[20]
    var
        L_RecSizes: Record "Size";
    begin
        L_RecSizes.Reset();
        if SizeCode <> '' then begin
            L_RecSizes.SetRange(Code, SizeCode);
            if L_RecSizes.FindFirst() then
                CASE G_CULanguage.GetLanguageId(SelectedLanguage) OF
                    1036://If company information language Selected is French
                        exit(L_RecSizes.ER);//Return size ER Values
                    2057://If company information language Selected is English
                        exit(L_RecSizes.code);//Return size INTL Values
                    /* Example if language is Arabic:
                    1025:
                        exit(L_RecItem.ArabicDescription) */
                    else
                        exit(L_RecSizes.code);//Return size INTL if no case found
                end;
        end
        else
            exit('');
    end;




    procedure GetSalesInvoiceLineLanguageDescription(var DocumentNo: Code[20]; var LineNo: Integer; var SelectedLanguage: Code[10]): Text[100]
    var
        L_RecSalesInvoiceLine: Record "Sales Invoice Line";
        L_RecItem: Record Item;
        LineItemDesc: text[100];
    begin
        L_RecSalesInvoiceLine.reset();
        L_RecSalesInvoiceLine.get(DocumentNo, LineNo);
        LineItemDesc := L_RecSalesInvoiceLine.Description;//Getting the description of the line
        if L_RecSalesInvoiceLine.Type.AsInteger() = 2 then begin//checking if line type is an item
            Case G_CULanguage.GetLanguageId(SelectedLanguage) of
                1036:
                    begin//If company information language Selected is French
                        L_RecItem.reset();
                        if L_RecItem.get(L_RecSalesInvoiceLine."No.") then
                            exit(L_RecItem."Description 2");//Return Description 2
                    end
                else
                    exit(LineItemDesc);
            end;
        end
        else
            exit(LineItemDesc);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Item", 'OnAfterCopyItem', '', false, false)]
    local procedure OnAfterCopyItem(var CopyItemBuffer: Record "Copy Item Buffer"; SourceItem: Record Item; var TargetItem: Record Item)
    var
    begin//Copy Records from Source Item to Target Item that are selected
        CopyCuts(SourceItem."No.", TargetItem."No.", CopyItemBuffer.Cuts);
        CopyColors(SourceItem."No.", TargetItem."No.", CopyItemBuffer.Colors);
        CopyDesignSectionColor(SourceItem."No.", TargetItem."No.", CopyItemBuffer.Colors);
        CopyDesignSectionRM(SourceItem."No.", TargetItem."No.", CopyItemBuffer."Design Section RM");
        CopySizes(SourceItem."No.", TargetItem."No.", CopyItemBuffer.Sizes);
        CopyFits(SourceItem."No.", TargetItem."No.", CopyItemBuffer.Fits);
        CopyFeatures(SourceItem."No.", TargetItem."No.", CopyItemBuffer.Features);
    end;

    local procedure CopyCuts(FromItemNo: Code[20]; ToItemNo: Code[20]; Selected: Boolean)
    var
        ItemCut: Record "Item Cut";
    begin
        //incase record had previously deleted item
        ItemCut.SetRange("Item No.", ToItemNo);
        if ItemCut.FindSet() then
            //delete rows in range
            ItemCut.DeleteAll();
        Clear(ItemCut);
        if not Selected then
            exit;
        G_CICU.CopyItemRelatedTable(DATABASE::"Item Cut", ItemCut.FieldNo("Item No."), FromItemNo, ToItemNo);
    end;

    local procedure CopyColors(FromItemNo: Code[20]; ToItemNo: Code[20]; Selected: Boolean)
    var
        ItemColor: Record "Item Color";
    begin
        //incase record had previously deleted item
        ItemColor.SetRange("Item No.", ToItemNo);
        if ItemColor.FindSet() then
            //delete rows in range
            ItemColor.DeleteAll();
        if not Selected then
            exit;
        G_CICU.CopyItemRelatedTable(DATABASE::"Item Color", ItemColor.FieldNo("Item No."), FromItemNo, ToItemNo);
    end;

    local procedure CopyDesignSectionRM(FromItemNo: Code[20]; ToItemNo: Code[20]; Selected: Boolean)
    var
        ItemDesignSectionRM: Record "Item Design Section RM";
    begin
        //incase record had previously deleted item
        ItemDesignSectionRM.SetRange("Item No.", ToItemNo);
        if ItemDesignSectionRM.FindSet() then
            //delete rows in range
            ItemDesignSectionRM.DeleteAll();
        if not Selected then
            exit;
        G_CICU.CopyItemRelatedTable(DATABASE::"Item Design Section RM", ItemDesignSectionRM.FieldNo("Item No."), FromItemNo, ToItemNo);
    end;

    local procedure CopyDesignSectionColor(FromItemNo: Code[20]; ToItemNo: Code[20]; Selected: Boolean)
    var
        ItemDesignSectionColor: Record "Item Design Section Color";
    begin
        //incase record had previously deleted item
        ItemDesignSectionColor.SetRange("Item No.", ToItemNo);
        if ItemDesignSectionColor.FindSet() then
            //delete rows in range
            ItemDesignSectionColor.DeleteAll();
        if not Selected then
            exit;
        G_CICU.CopyItemRelatedTable(DATABASE::"Item Design Section Color", ItemDesignSectionColor.FieldNo("Item No."), FromItemNo, ToItemNo);
    end;

    local procedure CopySizes(FromItemNo: Code[20]; ToItemNo: Code[20]; Selected: Boolean)
    var
        ItemSize: Record "Item Size";
    begin
        //incase record had previously deleted item
        ItemSize.SetRange("Item No.", ToItemNo);
        if ItemSize.FindSet() then
            //delete rows in range
            ItemSize.DeleteAll();
        if not Selected then
            exit;
        G_CICU.CopyItemRelatedTable(DATABASE::"Item Size", ItemSize.FieldNo("Item No."), FromItemNo, ToItemNo);
    end;

    local procedure CopyFits(FromItemNo: Code[20]; ToItemNo: Code[20]; Selected: Boolean)
    var
        ItemFit: Record "Item Fit";
    begin
        //incase record had previously deleted item
        ItemFit.SetRange("Item No.", ToItemNo);
        if ItemFit.FindSet() then
            //delete rows in range
            ItemFit.DeleteAll();
        if not Selected then
            exit;
        G_CICU.CopyItemRelatedTable(DATABASE::"Item Fit", ItemFit.FieldNo("Item No."), FromItemNo, ToItemNo);
    end;

    local procedure CopyFeatures(FromItemNo: Code[20]; ToItemNo: Code[20]; Selected: Boolean)
    var
        ItemFeature: Record "Item Feature";
    begin
        //incase record had previously deleted item
        ItemFeature.SetRange("Item No.", ToItemNo);
        if ItemFeature.FindSet() then
            //delete rows in range
            ItemFeature.DeleteAll();
        if not Selected then
            exit;
        G_CICU.CopyItemRelatedTable(DATABASE::"Item Feature", ItemFeature.FieldNo("Item No."), FromItemNo, ToItemNo);
    end;

    procedure RefreshQtytoAssemble(WhsShpHeader: Record "Warehouse Shipment Header")
    var
        WarehouseShipmentLineRec: Record "Warehouse Shipment Line";
        AssemblyOrder: Record "Assembly Header";
        Mynotification: Notification;
    begin
        Clear(WarehouseShipmentLineRec);
        WarehouseShipmentLineRec.SetRange("No.", WhsShpHeader."No.");
        if WarehouseShipmentLineRec.FindSet() then
            repeat
                Clear(AssemblyOrder);
                AssemblyOrder.SetRange("No.", WarehouseShipmentLineRec."Assembly No.");
                if AssemblyOrder.FindFirst() then begin
                    AssemblyOrder.Quantity := WarehouseShipmentLineRec.Quantity;
                    AssemblyOrder.Validate("Quantity to Assemble", AssemblyOrder.Quantity);
                    AssemblyOrder.Modify(true);
                end;
            until WarehouseShipmentLineRec.Next() = 0;
        MyNotification.Message('Quantity to Assemble has been refreshed.');
        MyNotification.Scope(NotificationScope::LocalScope);
        MyNotification.Send();
    end;


    var
        G_CULanguage: Codeunit Language;
        G_CICU: Codeunit "Copy Item";
}
