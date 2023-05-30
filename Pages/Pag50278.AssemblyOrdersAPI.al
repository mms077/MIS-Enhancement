page 50278 "Assembly Orders API"
{
    ApplicationArea = All;
    Caption = 'Assembly Orders API';
    SourceTable = "Assembly Header";
    UsageCategory = Lists;
    PageType = API;

    APIVersion = 'v2.0';
    APIPublisher = 'bctech';
    APIGroup = 'demo';

    EntityCaption = 'AssemblyOrders';
    EntitySetCaption = 'AssemblyOrders';
    EntityName = 'AssemblyHeader';
    EntitySetName = 'AssemblyHeader';

    ODataKeyFields = SystemId;

    Extensible = false;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("DocumentType"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("No"; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("SearchDescription"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field("Description2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("CreationDate"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("LastDateModified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("ItemNo"; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("VariantCode"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("InventoryPostingGroup"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("GenProdPostingGroup"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("LocationCode"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("ShortcutDimension1Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("ShortcutDimension2Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("PostingDate"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("DueDate"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("StartingDate"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("EndingDate"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
                field("BinCode"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("QuantityBase"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("RemainingQuantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                }
                field("RemainingQuantityBase"; Rec."Remaining Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("AssembledQuantity"; Rec."Assembled Quantity")
                {
                    ApplicationArea = All;
                }
                field("AssembledQuantityBase"; Rec."Assembled Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("QuantitytoAssemble"; Rec."Quantity to Assemble")
                {
                    ApplicationArea = All;
                }
                field("QuantitytoAssembleBase"; Rec."Quantity to Assemble (Base)")
                {
                    ApplicationArea = All;
                }
                field("ReservedQuantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field("ReservedQtyBase"; Rec."Reserved Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("PlanningFlexibility"; Rec."Planning Flexibility")
                {
                    ApplicationArea = All;
                }
                field("MPSOrder"; Rec."MPS Order")
                {
                    ApplicationArea = All;
                }
                field("AssembletoOrder"; Rec."Assemble to Order")
                {
                    ApplicationArea = All;
                }
                field("PostingNo"; Rec."Posting No.")
                {
                    ApplicationArea = All;
                }
                field("UnitCost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("CostAmount"; Rec."Cost Amount")
                {
                    ApplicationArea = All;
                }
                field("RolledupAssemblyCost"; Rec."Rolled-up Assembly Cost")
                {
                    ApplicationArea = All;
                }
                field("IndirectCost"; Rec."Indirect Cost %")
                {
                    ApplicationArea = All;
                }
                field("OverheadRate"; Rec."Overhead Rate")
                {
                    ApplicationArea = All;
                }
                field("UnitofMeasureCode"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("QtyperUnitofMeasure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("QtyRoundingPrecision"; Rec."Qty. Rounding Precision")
                {
                    ApplicationArea = All;
                }
                field("NoSeries"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("PostingNoSeries"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("DimensionSetID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("AssignedUserID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("SourceType"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("SourceNo"; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("SourceLineNo"; Rec."Source Line No.")
                {
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
