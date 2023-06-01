pageextension 50223 "Sales Invoice Subform" extends "Sales Invoice Subform"
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
        modify("Unit Price")
        {
            Visible = PriceVisible;
        }
        modify("Line Amount")
        {
            Visible = PriceVisible;
        }
        modify("Total Amount Excl. VAT")
        {
            Visible = PriceVisible;
        }
        modify("Total Amount Incl. VAT")
        {
            Visible = PriceVisible;
        }
        modify(Control39)//Total Amounts Section
        {
            Visible = PriceVisible;
        }
        addbefore("Line Amount")
        {
            field("Extra Charge %"; Rec."Extra Charge %")
            {
                ApplicationArea = all;
            }
            field("Extra Charge Amount"; Rec."Extra Charge Amount")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        Color: Record Color;
        CuttingSheetsDashboard: Record "Cutting Sheets Dashboard";
        WorkflowActivities: Record "Workflow Activities - ER";
    begin
        if Color.Get(Rec.Color) then
            ColorName := Color.Name;

        //Get Current Activity   
        /*CuttingSheetsDashboard.SetRange("Source Type", Rec."Document Type");
        CuttingSheetsDashboard.SetRange("Source No.", Rec."Document No.");
        CuttingSheetsDashboard.SetRange("Source Line No.", Rec."Line No.");
        if CuttingSheetsDashboard.FindFirst() then begin
            WorkflowActivities.SetRange("Workflow User Group Sequence", CuttingSheetsDashboard."Current Sequence No.");
            if WorkflowActivities.FindFirst() then
                CurrentActivity := WorkflowActivities."Activity Name"
            else
                CurrentActivity := '';
        end else
            CurrentActivity := '';*/
    end;

    trigger OnOpenPage()
    var
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.AllowShowSalesPrice() then
            PriceVisible := true
        else
            PriceVisible := false;
    end;

    procedure ValidateMissedFields(SalesLinePar: Record "Sales Line")
    var
        Txt001: Label 'You must specify Quantity for Item No. %1 in the Line No. %2';
        Txt002: Label 'You must specify Location Code for Item No. %1 in the Line No. %2';
        Txt003: Label 'You must specify Size for Item No. %1 in the Line No. %2';
        Txt004: Label 'You must specify Fit for Item No. %1 in the Line No. %2';
        Txt005: Label 'You must specify Color for Item No. %1 in the Line No. %2';
    begin
        if SalesLinePar.Quantity = 0 then
            Error(Txt001, SalesLinePar."No.", SalesLinePar."Line No.");
        if SalesLinePar."Location Code" = '' then
            Error(Txt002, SalesLinePar."No.", SalesLinePar."Line No.");
        if SalesLinePar.Size = '' then
            Error(Txt003, SalesLinePar."No.", SalesLinePar."Line No.");
        if SalesLinePar."Fit" = '' then
            Error(Txt004, SalesLinePar."No.", SalesLinePar."Line No.");
        if SalesLinePar."Color" = 0 then
            Error(Txt005, SalesLinePar."No.", SalesLinePar."Line No.");
    end;

    var
        DesignSectionParamHeader: Record "Parameter Header";
        DesignSectionParamLine: Record "Design Section Param Lines";
        ColorName: Text[100];
        TonalityCode: Code[50];
        //CurrentActivity: Text[100];
        PriceVisible: Boolean;
}
