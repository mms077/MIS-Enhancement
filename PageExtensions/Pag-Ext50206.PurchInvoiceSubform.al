pageextension 50206 "Purch. Invoice Subform" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("FA Posting Type")
        {
            field("Maintenance Code"; Rec."Maintenance Code")
            {
                ApplicationArea = all;
            }

        }
        addafter(Description)
        {

            field(Size; Rec.Size)
            {
                ApplicationArea = all;

            }
            field(Fit; Rec.Fit)
            {
                ApplicationArea = all;

            }
            field(Color; Rec.Color)
            {
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                var
                    Item: Record Item;
                    ItemColorPage: Page "Item Colors";
                    ItemColorRec: Record "Item Color";
                begin
                    if Item.Get(Rec."No.") then begin
                        ItemColorRec.SetRange("Item No.", Item."No.");
                        if ItemColorRec.FindSet() then begin
                            ItemColorPage.SetTableView(ItemColorRec);
                            ItemColorPage.LookupMode(true);
                            if ItemColorPage.RunModal() = Action::LookupOK then begin
                                ItemColorPage.GetRecord(ItemColorRec);
                                Rec.Validate(Color, ItemColorRec."Color ID");
                                Rec.Validate(Tonality, ItemColorRec."Tonality Code");
                            end;
                        end;
                    end;
                end;

            }
            field(ColorName; ColorName)
            {
                Caption = 'Color Name';
                ApplicationArea = all;
                Editable = false;
            }
            field(TonalityCode; Rec.Tonality)
            {
                Caption = 'Tonality';
                ApplicationArea = all;
                Editable = false;
            }
            field(Cut; Rec.Cut)
            {
                ApplicationArea = all;

            }
            field("Allocation Type"; Rec."Allocation Type")
            {
                ApplicationArea = all;
            }
            field("Allocation Code"; Rec."Allocation Code")
            {
                ApplicationArea = all;
            }

            field("Needed RM Batch"; Rec."Needed RM Batch")
            {
                ApplicationArea = all;
                Lookup = true;
                trigger OnDrillDown()
                var
                    NeededRawMaterial: Record "Needed Raw Material";
                begin
                    NeededRawMaterial.SetRange(Batch, Rec."Needed RM Batch");
                    if NeededRawMaterial.FindSet() then
                        Page.Run(Page::"Needed Raw Materials", NeededRawMaterial);
                end;
            }
            field("Parameters Header ID"; Rec."Parameters Header ID")
            {
                ApplicationArea = all;
                Lookup = true;
                trigger OnDrillDown()
                var
                    ParamHeader: Record "Parameter Header";
                    DesignSecParamForm: Page "Parameters Form";
                begin
                    ParamHeader.Get(Rec."Parameters Header ID");
                    Page.Run(Page::"Parameters Form", ParamHeader);
                end;
            }
        }
        addafter("No.")
        {
            field("VariantCode"; Rec."Variant Code")
            {
                ApplicationArea = All;
                //Editable = false;
                Visible = true;
            }
        }

        modify("Variant Code")
        {
            Visible = false;
        }
        modify("Unit Cost (LCY)")
        {
            Visible = CostVisible;
        }
        modify("Direct Unit Cost")
        {
            Visible = CostVisible;
        }
        modify("Line Amount")
        {
            Visible = CostVisible;
        }
        modify("Total Amount Excl. VAT")
        {
            Visible = CostVisible;
        }
        modify("Total Amount Incl. VAT")
        {
            Visible = CostVisible;
        }
        modify(Control39) //Total Amount Section
        {
            Visible = CostVisible;
        }
    }
    trigger OnOpenPage()
    var
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.AllowShowCost() then
            CostVisible := true
        else
            CostVisible := false;
    end;

    trigger OnAfterGetRecord()
    var
        Color: Record Color;
        CuttingSheetsDashboard: Record "Cutting Sheets Dashboard";
        WorkflowActivities: Record "Workflow Activities - ER";
    begin
        if Color.Get(Rec.Color) then
            ColorName := Color.Name;
    end;

    var
        ColorName: Text[100];
        CostVisible: Boolean;

}
