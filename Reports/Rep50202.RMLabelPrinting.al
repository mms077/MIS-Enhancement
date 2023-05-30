report 50202 "RM Label Printing"
{
    ApplicationArea = All;
    Caption = 'Raw Materials Label Printing';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Reports Layouts/RMLabelPrinting.rdlc';
    dataset
    {
        dataitem("Raw Material"; "Raw Material")
        {
            //RequestFilterFields = Code;   
            DataItemTableView = SORTING("Raw Material Category", "Color ID", "Tonality Code");
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(Outputno; OutputNo) { }
                    //Raw Material Columns +
                    column(RM_Code; "Raw Material".Code)
                    {
                    }
                    column(RM_UOM; "Raw Material"."UOM Code")
                    {
                    }
                    column(RM_Tonality; "Raw Material"."Tonality Code")
                    {
                    }
                    column(RM_ColorName; GlobalColor.Name)
                    {
                    }
                    column(ItemReference_UniqueCode; GlobalItemReference."Unique Code")
                    {
                    }
                    column(ItemReference_UOM; GlobalItemReference."Unit of Measure")
                    {
                    }
                    //Item Columns + 
                    column(Item_Description; GlobalItem.Description)
                    {
                    }
                    //Request Page Fields
                    column(PrintBCContainingUOM; PrintBCContainingUOM)
                    {
                    }
                }
                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText;
                        OutputNo += 1;
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }
            //Raw Material 
            trigger OnPreDataItem()
            begin
                "Raw Material".SetRange(Code, "Raw Material Code");
            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(GlobalItem);
                GlobalItem.Get("Raw Material"."Code");
                GlobalColor.Get("Raw Material"."Color ID");
                GlobalItemReference.SetRange("Item No.", "Raw Material"."Code");
                if "Barcode UOM" <> '' then
                    GlobalItemReference.SetRange("Unit of Measure", "Barcode UOM")
                else
                    GlobalItemReference.SetRange("Unit of Measure", "Raw Material"."UOM Code");
                if GlobalItemReference.FindFirst() then;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(General)
                {
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'Number of copies';
                        ApplicationArea = all;
                    }
                    field(PrintBCContainingUOM; PrintBCContainingUOM)
                    {
                        Caption = 'Print Barcode Containing UOM';
                        ApplicationArea = all;
                    }
                    field("Raw Material Code"; "Raw Material Code")
                    {
                        ApplicationArea = all;
                        Caption = 'Raw Material Code';
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            RMPage: Page "Raw Materials";
                            RMRec: Record "Raw Material";
                        begin
                            if RMRec.FindSet() then begin
                                RMPage.SetTableView(RMRec);
                                RMPage.LookupMode(true);
                                if RMPage.RunModal() = Action::LookupOK then begin
                                    RMPage.GetRecord(RMRec);
                                    "Raw Material Code" := RMRec.Code;
                                end;
                            end;
                        end;
                    }
                    field(BCUnitOfMeasure; "Barcode UOM")
                    {
                        Caption = 'Barcode UOM';
                        ApplicationArea = all;
                        TableRelation = "Unit Of Measure".Code;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ItemUOM: Record "Item Unit of Measure";
                            ItemUOMPage: Page "Item Units of Measure";
                        begin
                            ItemUOM.SetRange("Item No.", "Raw Material Code");
                            if ItemUOM.FindSet() then begin
                                ItemUOMPage.SetTableView(ItemUOM);
                                ItemUOMPage.LookupMode(true);
                                if ItemUOMPage.RunModal() = Action::LookupOK then begin
                                    ItemUOMPage.GetRecord(ItemUOM);
                                    "Barcode UOM" := ItemUOM.Code;
                                end;
                            end;
                        end;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
        PrintBCContainingUOM := false;
    end;

    trigger OnPreReport()
    var
        Txt001: Label 'You must fill Barcode UOM to display the related barcode';
    begin
        if PrintBCContainingUOM then
            if "Barcode UOM" = '' then
                Error(Txt001);
    end;

    var
        GlobalItem: Record Item;
        GlobalColor: Record Color;
        GlobalItemReference: Record "Item Reference";
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        FormatDocument: Codeunit "Format Document";
        PrintBCContainingUOM: Boolean;
        "Barcode UOM": Code[10];
        "Raw Material Code": Code[20];
}
