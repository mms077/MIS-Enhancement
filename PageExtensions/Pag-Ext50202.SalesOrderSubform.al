pageextension 50202 "Sales Order Subform" extends "Sales Order Subform"
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
                Editable = false;
            }
            field("Allocation Code"; Rec."Allocation Code")
            {
                ApplicationArea = all;
                Editable = false;
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
            field("Sales Line Reference"; Rec."Sales Line Reference")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;

            }
            field("Sales Line Reference Text"; Rec."Sales Line Reference Text")
            {
                ApplicationArea = all;
                Editable = false;
                DrillDown = true;
                trigger OnDrillDown()
                var
                    TargetRec: Record "Sales Line Unit Ref.";
                begin
                    TargetRec.SetFilter("Sales Line Ref.", Rec."Sales Line Reference");
                    if TargetRec.FindSet() then
                        PAGE.Run(PAGE::"Line Unit Ref. List", TargetRec);
                end;
            }
            field("Packaging Qty"; Rec."Packaging Qty") { ApplicationArea = all; Editable = false; }
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
            field("IC Parameters Header ID"; Rec."IC Parameters Header ID")
            {
                ApplicationArea = all;
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
        modify(Control51) //Total Amounts in Subform
        {
            Visible = PriceVisible;
        }
        addafter("Reserved Quantity")
        {
            field(ReservationWarning; ReservationWarning)
            {
                Caption = 'Reservation Warning';
                ApplicationArea = all;
            }
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
        addafter("O&rder")
        {
            group("Wizard")
            {
                action("Item Wizard")
                {
                    ApplicationArea = All;
                    Visible = false;
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
                action("Create Variant")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Image = VariableList;
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
            action("Label Printing No Asm")
            {
                ApplicationArea = all;
                Caption = 'Label Printing No Asm';
                Image = Transactions;
                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.SetRange("Document No.", Rec."Document No.");
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Line No.", Rec."Line No.");
                    Report.Run(Report::"Sales Line Label No Assembly", true, true, SalesLine);
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
            action("Unit Sales Line Ref.")
            {
                ApplicationArea = all;
                Caption = 'Unit Sales Line Ref.';
                Image = TaskQualityMeasure;
                RunPageLink = "Sales Line Ref." = field("Sales Line Reference");
                RunObject = Page "Line Unit Ref. List";
            }
            // action("DashboardUnit")
            // {
            //     ApplicationArea = all;
            //     Image = ShowChart;
            //     Caption = 'Dashboard/Unit';
            //     RunObject = page "Scan Activities List";
            //     RunPageLink = "Sales Line Id" = field("Sales Line Reference");
            // }
        }
    }

    trigger OnAfterGetRecord()
    var
        SalesRecSetup: Record "Sales & Receivables Setup";
        SalesLineUnitRef: Record "Sales Line Unit Ref.";
    begin
        //Update Color Name
        UpdateColorName(Rec);

        //Get Current Activity   
        //Commented for better performance..already exists in dashboard action
        //GetCurrentActivity(Rec);

        //Update Reservation Warning
        UpdateReservationWarning(Rec);

        //update Packaging QTy
        SalesRecSetup.Get();
        if Rec."Packaging Qty" > 0 then begin
            Rec."Packaging Qty" := 0;
            Rec.Modify();
        end;
        Clear(SalesLineUnitRef);
        SalesLineUnitRef.SetFilter("Sales Line Ref.", Rec."Sales Line Reference");
        if SalesLineUnitRef.FindSet() then
            repeat
                IF STRPOS(SalesLineUnitRef."Scan Out", SalesRecSetup."Packaging Stage") > 0 then begin
                    Rec."Packaging Qty" := Rec."Packaging Qty" + SalesLineUnitRef.Quantity;
                    Rec.Modify();
                end;
            until SalesLineUnitRef.Next() = 0;

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

    procedure UpdateColorName(SalesLinePar: Record "Sales Line")
    var
        Color: Record Color;
    begin
        ColorName := '';
        FrenchColorName := '';
        if Color.Get(SalesLinePar.Color) then begin
            ColorName := Color.Name;
            FrenchColorName := Color."French Description";
        end;
    end;

    Procedure GetCurrentActivity(SalesLinePar: Record "Sales Line")
    var
        CuttingSheetsDashboard: Record "Cutting Sheets Dashboard";
        WorkflowActivities: Record "Workflow Activities - ER";
    begin
        /*Clear(CuttingSheetsDashboard);
        CuttingSheetsDashboard.SetRange("Source Type", SalesLinePar."Document Type");
        CuttingSheetsDashboard.SetRange("Source No.", SalesLinePar."Document No.");
        CuttingSheetsDashboard.SetRange("Source Line No.", SalesLinePar."Line No.");
        if CuttingSheetsDashboard.FindFirst() then begin*/
        /*
        SalesLinePar.CalcFields("Assembly No.");
        if CuttingSheetsDashboard.Get(SalesLinePar."Assembly No.") then begin
            WorkflowActivities.SetRange("Workflow User Group Sequence", CuttingSheetsDashboard."Current Sequence No.");
            if WorkflowActivities.FindFirst() then
                CurrentActivity := WorkflowActivities."Activity Name"
            else
                CurrentActivity := '';
        end else
            CurrentActivity := '';*/
    end;

    procedure UpdateReservationWarning(SalesLinePar: Record "Sales Line")
    var
    begin
        Clear(ReservationWarning);
        if SalesLinePar.Type = SalesLinePar.Type::Item then begin
            SalesLinePar.CalcFields("Reserved Quantity");
            if SalesLinePar."Reserved Quantity" < SalesLinePar.Quantity then
                ReservationWarning := '🔴'
            else
                ReservationWarning := '🟢';
        end;
    end;

    var
        DesignSectionParamHeader: Record "Parameter Header";
        DesignSectionParamLine: Record "Design Section Param Lines";
        ColorName: Text[100];
        FrenchColorName: Text[100];
        TonalityCode: Code[50];
        //CurrentActivity: Text[100];
        PriceVisible: Boolean;
        ReservationWarning: Text[100];
}
