pageextension 50219 "Sales Quote Subform" extends "Sales Quote Subform"
{
    layout
    {
        addbefore("Type")
        {
            field("LineNo"; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
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
            field(FrenchColorName; FrenchColorName)
            {
                Caption = 'French Color';
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
            field("Par Level"; Rec."Par Level")
            {
                ApplicationArea = All;
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
            field("Department Code"; Rec."Department Code")
            {
                ApplicationArea = All;
            }
            field("Position Code"; Rec."Position Code")
            {
                ApplicationArea = All;
            }
            field("Staff Code"; Rec."Staff Code")
            {
                ApplicationArea = All;
            }
            field("Qty Assignment Wizard Id"; Rec."Qty Assignment Wizard Id")
            {
                ApplicationArea = all;
            }
            /*field(CurrentActivity; CurrentActivity)
            {
                Caption = 'Current Activity';
                ApplicationArea = all;
                Editable = false;
            }*/
        }
        addafter("Variant Code")
        {
            field("Quantity in the Inventory";rec."Quantity in the Inventory"){
                ApplicationArea=all;
            }
            field("Reserved Qty in the Inventory";rec."Reserved Qty in the Inventory"){
                ApplicationArea=all;
            }
            field("Available Qty in the Inventory";AvailableQtyInInventory){
                ApplicationArea=all;
            }
            field("Control Number"; Rec."Control Number")
            {
                ApplicationArea = all;
            }
            field("Design Sections Set"; Rec."Design Sections Set")
            {
                ApplicationArea = all;
            }
            field("Item Features Set"; Rec."Item Features Set")
            {
                ApplicationArea = all;
            }
            field("Item Brandings Set"; Rec."Item Brandings Set")
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
        modify(Control53)
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
        addafter("F&unctions")
        {
            group("Wizard")
            {
                action("Create Line")
                {
                    ApplicationArea = All;
                    Caption = 'Create Line';
                    Image = Simulate;
                    trigger OnAction()
                    var
                        Management: Codeunit Management;
                        State: Option "Start","Departments","Positions","Staff","Staff Sizes","Header Parameters 0","Header Parameters","Qty Assignment","Lines Parameters","Features Parameters","Branding Parameters";
                        SalesHeader: Record "Sales Header";
                        Options: Text[250];
                        Selected: Integer;
                        Text000: Label 'With Staff,Without Staff,Just Create Variant';
                        Text001: Label 'Choose one of the following options:';
                        Process: Option "Old Way","Assignment","Just Create Variant";
                        SalesLine: Record "Sales Line";
                    begin
                        if SalesHeader.get(Rec."Document Type", Rec."Document No.") then begin
                            SalesHeader.TestField(Status, SalesHeader.Status::Open);
                            Management.RunTheProcess(State::Start, SalesHeader, Process::"Assignment", SalesLine, '')
                        end;
                    end;
                }
                action("Load Line")
                {
                    ApplicationArea = All;
                    Caption = 'Load Line';
                    Image = Simulate;
                    trigger OnAction()
                    var
                        Management: Codeunit Management;
                        State: Option "Start","Departments","Positions","Staff","Staff Sizes","Header Parameters 0","Header Parameters","Qty Assignment","Lines Parameters","Features Parameters","Branding Parameters";
                        SalesHeader: Record "Sales Header";
                        Options: Text[250];
                        Selected: Integer;
                        Text000: Label 'With Staff,Without Staff,Just Create Variant';
                        Text001: Label 'Choose one of the following options:';
                        Process: Option "Old Way","Assignment","Just Create Variant";
                        SalesLine: Record "Sales Line";
                    begin
                        if SalesHeader.get(Rec."Document Type", Rec."Document No.") then begin
                            SalesHeader.TestField(Status, SalesHeader.Status::Open);
                            if Rec."Parent Parameter Header ID" <> 0 then
                                Management.RunTheProcess(State::"Header Parameters", SalesHeader, Process::"Assignment", Rec, '')
                            else
                                Management.RunTheProcess(State::Start, SalesHeader, Process::"Assignment", SalesLine, '');
                        end;
                    end;
                }
                action("Create Variant")
                {
                    ApplicationArea = All;
                    Image = VariableList;
                    Visible = false;
                    trigger OnAction()
                    var
                        Management: Codeunit Management;
                        State: Option "Start","Departments","Positions","Staff","Staff Sizes","Header Parameters 0","Header Parameters","Qty Assignment","Lines Parameters","Features Parameters","Branding Parameters";
                        SalesHeader: Record "Sales Header";
                        Process: Option "Old Way","Assignment","Just Create Variant";
                        SalesLine: Record "Sales Line";
                    begin
                        if SalesHeader.get(Rec."Document Type", Rec."Document No.") then begin
                            SalesHeader.TestField(Status, SalesHeader.Status::Open);
                            Management.RunTheProcess(State::Start, SalesHeader, Process::"Just Create Variant", SalesLine, '')
                        end;
                    end;
                }
            }
            action("Label Printing EN")
            {
                ApplicationArea = all;
                Image = Report;
                /*Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;*/
                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.SetRange("Document No.", Rec."Document No.");
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Line No.", Rec."Line No.");
                    Report.Run(Report::"Sales Line Label Printing EN", true, true, SalesLine);
                end;
            }
            action("Label Printing FR")
            {
                ApplicationArea = all;
                Image = Report;
                /*Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;*/
                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.SetRange("Document No.", Rec."Document No.");
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Line No.", Rec."Line No.");
                    Report.Run(Report::"Sales Line Label Printing FR", true, true, SalesLine);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.AllowShowSalesPrice() then
            PriceVisible := true
        else
            PriceVisible := false;
    end;

    trigger OnAfterGetRecord()
    var
        Color: Record Color;
        CuttingSheetsDashboard: Record "Cutting Sheets Dashboard";
        WorkflowActivities: Record "Workflow Activities - ER";
    begin
        rec.CalcFields("Quantity in the Inventory", "Reserved Qty in the Inventory");
        AvailableQtyInInventory := rec."Quantity in the Inventory" - rec."Reserved Qty in the Inventory";

        ColorName := '';
        FrenchColorName := '';
        if Color.Get(Rec.Color) then begin
            ColorName := Color.Name;
            FrenchColorName := Color."French Description";
        end;
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
        FrenchColorName: Text[100];
        TonalityCode: Code[50];
        //CurrentActivity: Text[100];
        PriceVisible: Boolean;
        AvailableQtyInInventory: Decimal;
}