page 50245 "Needed Raw Materials"
{
    ApplicationArea = All;
    Caption = 'Needed Raw Materials';
    PageType = List;
    SourceTable = "Needed Raw Material";
    UsageCategory = Lists;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("RM Code"; Rec."RM Code")
                {
                    ApplicationArea = All;
                }
                field("Raw Material Name"; Rec."Raw Material Name")
                {
                    ApplicationArea = all;
                }
                field("RM Variant Code"; Rec."RM Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Raw Material Category"; Rec."Raw Material Category")
                {
                    ApplicationArea = All;
                }
                field("Color ID"; Rec."Color ID")
                {
                    ApplicationArea = All;
                }
                field("Tonality Code"; Rec."Tonality Code")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Line No."; Rec."Design Detail Line No.")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Design Code"; Rec."Design Detail Design Code")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Design Section Code"; Rec."Design Detail Design Sec. Code")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Size Code"; Rec."Design Detail Size Code")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Fit Code"; Rec."Design Detail Fit Code")
                {
                    ApplicationArea = All;
                }
                field("Section"; Rec."Design Detail Section Code")
                {
                    ApplicationArea = All;
                }
                field("Design Section"; Rec."Design Detail Design Sec. Code")
                {
                    ApplicationArea = All;
                }
                field("Design Detail UOM Code"; Rec."Design Detail UOM Code")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Quantity"; Rec."Design Detail Quantity")
                {
                    ApplicationArea = All;
                }
                field("Sales Line Quantity"; Rec."Sales Line Quantity")
                {
                    ApplicationArea = All;
                }
                field("Sales Line Item No."; Rec."Sales Line Item No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Line Location Code"; Rec."Sales Line Location Code")
                {
                    ApplicationArea = All;
                }
                field("Sales Line UOM Code"; Rec."Sales Line UOM Code")
                {
                    ApplicationArea = All;
                }
                field("Assembly Order No."; Rec."Assembly Order No.")
                {
                    ApplicationArea = All;
                }
                field("Assembly Order Line No."; Rec."Assembly Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order Line No."; Rec."Sales Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Assembly Line Quantity"; Rec."Assembly Line Quantity")
                {
                    ApplicationArea = All;
                }
                field("Assembly Line UOM Code"; Rec."Assembly Line UOM Code")
                {
                    ApplicationArea = All;
                }
                field(Batch; Rec.Batch)
                {
                    ApplicationArea = All;
                }
                field("Paramertes Header ID"; Rec."Paramertes Header ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateAssembly)
            {
                Caption = 'Create Assembly';
                Image = AssemblyOrder;
                InFooterBar = true;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                trigger OnAction()
                var
                    Management: Codeunit Management;
                    ParameterHeaderLoc: Record "Parameter Header";
                    SalesLine: Record "Sales Line";
                begin
                    //Create Assembly
                    Clear(SalesLine);
                    SalesLine.SetRange("Document No.", Rec."Sales Order No.");
                    SalesLine.SetRange("Line No.", Rec."Sales Order Line No.");
                    if SalesLine.FindFirst() then begin
                        Clear(ParameterHeaderLoc);
                        if ParameterHeaderLoc.Get(SalesLine."Parameters Header ID") then begin
                            Management.CreateAssemblyOrder(Rec, ParameterHeaderLoc, ParameterHeaderLoc);
                            CurrPage.Close();
                        end;
                    end;
                end;
            }
            action(UpdateDocumentNo)
            {
                ApplicationArea = All;
                Caption = 'Update Document No.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    UpdateDocumentNoFromParameter(Rec);
                end;
            }
            action(UpdateAssemblytNo)
            {
                ApplicationArea = All;
                Caption = 'Update Assembly No.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    UpdateAssemblyNoFromParameter(Rec);
                end;
            }
        }

    }
    /* trigger OnOpenPage()
     var
         UserSetup: Record "User Setup";
     begin
         Clear(UserSetup);
         CanCreateAssemblyFromBatch := false;
         UserSetup.Get(UserId);
         if UserSetup."Create Assemb. From Batch" = true then
             CanCreateAssemblyFromBatch := true;

     end;*/

    procedure UpdateDocumentNoFromParameter(NeededRawMaterialPar: Record "Needed Raw Material")
    var
        NeededRawmMaterial: Record "Needed Raw Material";
        ParameterHeader: Record "Parameter Header";
    begin
        Clear(NeededRawmMaterial);
        //NeededRawmMaterial.SetRange(Batch, NeededRawMaterialPar.Batch);
        if NeededRawmMaterial.FindSet() then
            repeat
                if ParameterHeader.Get(NeededRawmMaterial."Paramertes Header ID") then begin
                    NeededRawmMaterial."Sales Order No." := ParameterHeader."Sales Line Document No.";
                    NeededRawmMaterial.Modify();
                end;
            until NeededRawmMaterial.Next() = 0;
        Message('Done');
    end;

    procedure UpdateAssemblyNoFromParameter(NeededRawMaterialPar: Record "Needed Raw Material")
    var
        NeededRawmMaterial: Record "Needed Raw Material";
        ParameterHeader: Record "Parameter Header";
        SalesLine: Record "Sales Line";
    begin
        Clear(NeededRawmMaterial);
        //NeededRawmMaterial.SetRange(Batch, NeededRawMaterialPar.Batch);
        if NeededRawmMaterial.FindSet() then
            repeat
                if ParameterHeader.Get(NeededRawmMaterial."Paramertes Header ID") then begin
                    if SalesLine.get(SalesLine."Document Type"::Order, NeededRawmMaterial."Sales Order No.", NeededRawmMaterial."Sales Order Line No.") then begin
                        SalesLine.CalcFields("Assembly No.");
                        NeededRawmMaterial."Assembly Order No." := SalesLine."Assembly No.";
                        NeededRawmMaterial.Modify();
                    end;
                end;
            until NeededRawmMaterial.Next() = 0;
        Message('Done');
    end;

    var
        CanCreateAssemblyFromBatch: Boolean;
}

