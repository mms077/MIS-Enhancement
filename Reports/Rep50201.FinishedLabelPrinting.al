report 50201 "Finished Label Printing"
{
    ApplicationArea = All;
    Caption = 'Finished Label Printing';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Reports Layouts/FinishedLabelPrinting.rdlc';
    dataset
    {
        dataitem(ItemReference; "Item Reference")
        {
            RequestFilterFields = "Item No.";

            //Item Reference Columns +
            column(ItemNo; "Item No.")
            {
            }
            column(VariantCode; "Variant Code")
            {
            }
            column(UnitofMeasure; "Unit of Measure")
            {
            }
            column(ReferenceNo; "Reference No.")
            {
            }
            column(UniqueCode; "Unique Code")
            {
            }
            column(Variant_ColorName; GlobalItemVariantColor.Name)
            {
            }
            column(EAN_Number; GlobalReference."Reference No.")
            {
            }
            column(EANEncodedText; EANEncodedText)
            {

            }

            //Item Columns + 
            column(Item_Description; GlobalItem.Description)
            {
            }

            //Variant Columns + 
            column(Variant_ItemSize; GlobalSize."Report Description")
            {
            }
            column(Variant_ItemFit; GlobalFit.Name)
            {
            }
            column(Variant_ItemCut; GlobalCut.Name)
            {
            }
            column(Variant_ItemColor; GlobalItemVariant."Item Color ID")
            {
            }
            column(Variant_Tonality; GlobalItemVariant."Tonality Code")
            {
            }
            column(Variant_DesignSectionsSet; GlobalItemVariant."Design Sections Set ID")
            {
            }
            column(Variant_ItemFeaturesSet; GlobalItemVariant."Item Features Set ID")
            {
            }
            column(Variant_ItemBrandingsSet; GlobalItemVariant."Item Brandings Set ID")
            {
            }

            //Design Sections Set
            dataitem("Design Sections Set"; "Design Sections Set")
            {
                //Design Section Columns + 
                column(DesignSectionSet_DesignSectionCode; "Design Sections Set"."Design Section Code")
                {
                }
                column(DesignSectionSet_Name; GlobalDesignSection.Name)
                {
                }
                column(DesignSectionSet_ColorName; GlobalItemVariantColor.Name)
                {
                }
                trigger OnPreDataItem()
                begin
                    Clear(GlobalDesignSection);
                    "Design Sections Set".SetRange("Design Section Set ID", GlobalItemVariant."Design Sections Set ID");
                    if "Design Sections Set".FindSet() then;
                end;

                trigger OnAfterGetRecord()
                var
                begin
                    Clear(GlobalDesignSection);
                    Clear(GlobalItemVariantColor);
                    if GlobalDesignSection.Get("Design Sections Set"."Design Section Code") then;
                    if GlobalItemVariantColor.Get("Design Sections Set"."Color ID") then;
                end;
            }
            //Item Features Set
            dataitem("Item Features Set"; "Item Features Set")
            {
                //Item Features Column + 
                column(ItemFeaturesSet_ItemFeatureName; "Item Features Set"."Item Feature Name")
                {
                }
                column(ItemFeaturesSet_ItemFeatureValue; "Item Features Set".Value)
                {
                }
                column(ItemFeaturesSet_ColorName; GlobalItemVariantColor.Name)
                {
                }
                trigger OnPreDataItem()
                begin
                    "Item Features Set".SetRange("Item Feature Set ID", GlobalItemVariant."Item Features Set ID");
                    if "Item Features Set".FindSet() then;
                end;

                trigger OnAfterGetRecord()
                var
                begin
                    Clear(GlobalItemVariantColor);
                    if GlobalItemVariantColor.Get("Item Features Set"."Color ID") then;
                end;
            }
            //Brandings Set
            dataitem("Item Brandings Set"; "Item Brandings Set")
            {
                //Item Brandings Column
                column(ItemBrandingsSet_ItemBrandingCode; "Item Brandings Set"."Item Branding Code")
                {
                }
                column(ItemBrandingsSet_ItemBrandingName; GlobalBranding.Name)
                {
                }
                trigger OnPreDataItem()
                begin
                    "Item Brandings Set".SetRange("Item Branding Set ID", GlobalItemVariant."Item Brandings Set ID");
                    if "Item Brandings Set".FindSet() then;
                end;

                trigger OnAfterGetRecord()
                begin
                    GlobalBranding.SetRange(Code, "Item Brandings Set"."Item Branding Code");
                    if GlobalBranding.FindFirst() then;
                end;

            }

            //Item Reference
            trigger OnAfterGetRecord()
            var
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";
                BarcodeString: Text;
            begin
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::Code39;

                Clear(GlobalItem);
                Clear(GlobalItemVariant);
                Clear(GlobalItemVariantColor);
                Clear(GlobalReference);
                GlobalItem.Get(ItemReference."Item No.");
                //Skip Raw Materials
                GlobalItem.CalcFields(IsRawMaterial);
                if GlobalItem.IsRawMaterial then
                    CurrReport.Skip();
                If GlobalItemVariant.Get(ItemReference."Item No.", ItemReference."Variant Code") then begin
                    if GlobalItemVariantColor.Get(GlobalItemVariant."Item Color ID") then;
                    if GlobalSize.Get(GlobalItemVariant."Item Size") then;
                    if GlobalFit.Get(GlobalItemVariant."Item Fit") then;
                    if GlobalCut.Get(GlobalItemVariant."Item Cut Code") then;
                end;
                //Get the Reference No. for EAN
                Clear(GlobalReference);
                GlobalReference.SetRange("Item No.", ItemReference."Item No.");
                GlobalReference.SetFilter("Variant Code", '');
                if GlobalReference.FindFirst() then begin
                    BarcodeString := GlobalReference."Reference No.";
                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    EANEncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology)
                end;
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
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
    var
        GlobalItem: Record Item;
        GlobalItemVariant: Record "Item Variant";
        GlobalItemVariantColor: Record Color;
        GlobalDesignSection: Record "Design Section";
        GlobalBranding: Record Branding;
        GlobalCut: Record Cut;
        GlobalSize: Record Size;
        GlobalFit: Record Fit;
        GlobalReference: Record "Item Reference";
        EANEncodedText: Text[250];
}
