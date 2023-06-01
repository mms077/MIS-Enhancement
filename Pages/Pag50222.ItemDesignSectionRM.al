page 50222 "Item Design Section RM"
{
    ApplicationArea = All;
    Caption = 'Item Design Section RM';
    PageType = List;
    SourceTable = "Item Design Section RM";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }*/
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = all;
                }
                field("Section Group"; Rec."Section Group")
                {
                    ApplicationArea = all;
                }
                field("Design Section Code"; Rec."Design Section Code")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Item: Record Item;
                        DesignDetail: Record "Design Detail";
                        DesignSectionFilter: Text[2048];
                        PreviousDesignSection: Code[100];
                        DesignSectionPage: Page "Design Sections";
                        DesignSectionRec: Record "Design Section";
                    begin
                        Clear(DesignSectionFilter);
                        Clear(PreviousDesignSection);
                        if Item.Get(Rec."Item No.") then begin
                            Clear(DesignDetail);
                            DesignDetail.SetCurrentKey("Design Section Code");
                            DesignDetail.SetRange("Design Code", Item."Design Code");
                            if DesignDetail.FindSet() then begin
                                repeat
                                    if PreviousDesignSection <> DesignDetail."Design Section Code" then begin
                                        DesignSectionFilter := DesignSectionFilter + DesignDetail."Design Section Code" + '|';
                                    end;
                                    PreviousDesignSection := DesignDetail."Design Section Code";
                                until DesignDetail.Next() = 0;
                                Clear(DesignSectionRec);
                                DesignSectionFilter := DELCHR("DesignSectionFilter", '>', '|');
                                DesignSectionRec.SetFilter(Code, DesignSectionFilter);
                                DesignSectionRec.SetRange(Composition, DesignSectionRec.Composition::Fabrics);
                                if DesignSectionRec.FindSet() then begin
                                    DesignSectionPage.SetTableView(DesignSectionRec);
                                    DesignSectionPage.LookupMode(true);
                                    if DesignSectionPage.RunModal() = Action::LookupOK then begin
                                        DesignSectionPage.GetRecord(DesignSectionRec);
                                        Rec.Validate("Design Section Code", DesignSectionRec.Code);
                                    end;
                                end else begin
                                    DesignSectionPage.SetTableView(DesignSectionRec);
                                    DesignSectionPage.LookupMode(true);
                                    if DesignSectionPage.RunModal() = Action::LookupOK then begin
                                        DesignSectionPage.GetRecord(DesignSectionRec);
                                        Rec.Validate("Design Section Code", DesignSectionRec.Code);
                                    end;
                                end;
                            end;
                        end;
                    end;
                }
                field("Design Section Name"; Rec."Design Section Name")
                {
                    ApplicationArea = all;
                }
                field("Raw Material Category"; Rec."Raw Material Category")
                {
                    ApplicationArea = All;
                    /*trigger OnLookup(var Text: Text): Boolean
                    var
                        Fabric: Record "RM Category Design Section";
                        FabricFilter: Text[2048];
                        PreviousFabric: Code[100];
                        RawMaterialCategories: Page "RM Categories Design Sections";
                        FabricRec: Record "RM Category Design Section";
                    begin
                        Clear(FabricFilter);
                        Clear(PreviousFabric);
                        Clear(Fabric);
                        Rec.CalcFields("Design Code", "Design Type");
                        Fabric.SetCurrentKey("RM Category Code");
                        Fabric.SetRange("Design Section Code", Rec."Design Section Code");
                        Fabric.SetRange("Design Type", Rec."Design Type");
                        if Fabric.FindSet() then begin
                            repeat
                                if PreviousFabric <> Fabric."Design Section Code" then begin
                                    FabricFilter := FabricFilter + Fabric."Design Section Code" + '|';
                                end;
                                PreviousFabric := Fabric."Design Section Code";
                            until Fabric.Next() = 0;
                            Clear(FabricRec);
                            FabricFilter := DELCHR("FabricFilter", '>', '|');
                            FabricRec.SetFilter("Design Section Code", FabricFilter);
                            FabricRec.SetRange("Design Type", Rec."Design Type");
                            if FabricRec.FindSet() then begin
                                RawMaterialCategories.SetTableView(FabricRec);
                                RawMaterialCategories.LookupMode(true);
                                if RawMaterialCategories.RunModal() = Action::LookupOK then begin
                                    RawMaterialCategories.GetRecord(FabricRec);
                                    Rec.Validate("Raw Material Category", FabricRec."RM Category Code");
                                end;
                            end;
                        end;
                    end;*/
                }
                field("RM Category Name"; Rec."RM Category Name")
                {
                    ApplicationArea = all;
                }
                field("Design Code"; Rec."Design Code")
                {
                    ApplicationArea = all;
                }
                field("Design Type"; Rec."Design Type")
                {
                    ApplicationArea = all;
                }
                field("Avlbl. In Design Details"; Rec."Avlbl. In Design Details")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(EditInExcelTEST)
            {
                Caption = 'Edit in Excel (Filtered)';
                Image = Excel;
                ToolTip = 'Send the data to an Excel file for analysis or editing.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    EditInExcel: Codeunit "Edit in Excel";
                    ODataFilter: Text;
                    Filters: Label 'Item_No eq ''%1''';
                begin
                    ODataFilter := StrSubstNo(Filters, Rec."Item No.");
                    EditInExcel.EditPageInExcel(CurrPage.ObjectId(true), CurrPage.ObjectId(false), ODataFilter);
                end;
            }
        }
    }
}
