pageextension 50205 "Item Variants" extends "Item Variants"
{
    Editable = false;
    layout
    {
        addafter(Description)
        {
            field("Item Size"; Rec."Item Size")
            {
                ApplicationArea = all;
            }
            field("Item Fit"; Rec."Item Fit")
            {
                ApplicationArea = all;
            }
            field("Item Color ID"; Rec."Item Color ID")
            {
                ApplicationArea = all;
            }
            field("Item Cut Code"; Rec."Item Cut Code")
            {
                ApplicationArea = all;
            }
            field("Tonality Code"; Rec."Tonality Code")
            {
                ApplicationArea = all;
            }
            field("Design Sections Set ID"; Rec."Design Sections Set ID")
            {
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    DesignSectionSet: Record "Design Sections Set";
                    DesignSectionSetPage: Page "Design Sections Set";
                    ItemColorRec: Record "Item Color";
                begin
                    Clear(DesignSectionSet);
                    DesignSectionSet.SetRange("Design Section Set ID", Rec."Design Sections Set ID");
                    if DesignSectionSet.FindFirst() then begin
                        DesignSectionSetPage.SetTableView(DesignSectionSet);
                        DesignSectionSetPage.Run();
                    end;
                end;
            }
            field("Item FeaturesSet ID"; Rec."Item Features Set ID")
            {
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    ItemFeatureSet: Record "Item Features Set";
                    ItemFeatureSetPage: Page "Item Features Set";
                    ItemColorRec: Record "Item Color";
                begin
                    Clear(ItemFeatureSet);
                    ItemFeatureSet.SetRange("Item Feature Set ID", Rec."Item Features Set ID");
                    if ItemFeatureSet.FindFirst() then begin
                        ItemFeatureSetPage.SetTableView(ItemFeatureSet);
                        ItemFeatureSetPage.Run();
                    end;
                end;
            }
            field("Item Brandings Set ID"; Rec."Item Brandings Set ID")
            {
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    ItemBrandingSet: Record "Item Brandings Set";
                    ItemBrandingSetPage: Page "Item Brandings Set";
                    ItemColorRec: Record "Item Color";
                begin
                    Clear(ItemBrandingSet);
                    ItemBrandingSet.SetRange("Item Branding Set ID", Rec."Item Brandings Set ID");
                    if ItemBrandingSet.FindFirst() then begin
                        ItemBrandingSetPage.SetTableView(ItemBrandingSet);
                        ItemBrandingSetPage.Run();
                    end;
                end;
            }
            field("Variance Combination Text"; Rec."Variance Combination Text")
            {
                ApplicationArea = all;
            }
        }
        addfirst(factboxes)
        {
            part(Picture; "Variant Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Code" = FIELD("Code"), "Item No." = field("Item No.");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5401),
                              "Line No." = field(ID),
                              "No." = field(Code);
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }

    }
    actions
    {
        addafter(Translations)
        {
            action("Generate Item Variants")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = ItemVariant;
                trigger OnAction()
                var
                    Management: Codeunit Management;
                    State: Option "Start","Departments","Positions","Staff","Staff Sizes","Header Parameters 0","Header Parameters","Qty Assignment","Lines Parameters","Features Parameters","Branding Parameters";
                    SalesHeader: Record "Sales Header";
                    Process: Option "Old Way","Assignment","Just Create Variant";
                    SalesLine: Record "Sales Line";
                    ActionName:Option "Create Line","Load Line","Refresh Line";
                begin
                    Management.RunTheProcess(ActionName::"Create Line",State::Start, SalesHeader, Process::"Just Create Variant", SalesLine, Rec."Item No.")
                end;
            }
        }
        addfirst(Processing)
        {
            action(DeleteVariant)
            {
                ApplicationArea = All;
                Caption = 'Delete Variant';
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Delete;
                trigger OnAction()
                begin
                    Rec.Delete(true);
                end;
            }
        }
    }
}