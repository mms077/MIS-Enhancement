pageextension 50236 "Whse. Shipment Subform" extends "Whse. Shipment Subform"
{
    layout
    {
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
            field("Assembly No."; Rec."Assembly No.")
            {
                ApplicationArea = all;
                Lookup = true;
                trigger OnDrillDown()
                var
                    AssemblyHeader: Record "Assembly Header";
                begin
                    if AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, Rec."Assembly No.") then
                        Page.Run(Page::"Assembly Order", AssemblyHeader);
                end;

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
            field("Parent Parameter Header ID"; Rec."Parent Parameter Header ID")
            {
                ApplicationArea = all;
                Lookup = true;
                trigger OnDrillDown()
                var
                    ParamHeader: Record "Parameter Header";
                    DesignSecParamForm: Page "Parameters Form";
                begin
                    ParamHeader.Get(Rec."Parent Parameter Header ID");
                    Page.Run(Page::"Parameters Form", ParamHeader);
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
            /*field(CurrentActivity; CurrentActivity)
            {
                Caption = 'Current Activity';
                ApplicationArea = all;
                Editable = false;
            }*/
            field("Control Number"; Rec."Control Number")
            {
                ApplicationArea = all;
            }
        }
        addafter("Item No.")
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

    }

    var
        DesignSectionParamHeader: Record "Parameter Header";
        DesignSectionParamLine: Record "Design Section Param Lines";
        ColorName: Text[100];
        TonalityCode: Code[50];
        //CurrentActivity: Text[100];
        PriceVisible: Boolean;
        ReservationWarning: Text[100];
}