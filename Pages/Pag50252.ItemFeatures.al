page 50252 "Item Features"
{
    ApplicationArea = Basic;
    Caption = 'Item Features';
    PageType = List;
    SourceTable = "Item Feature";
    UsageCategory = Lists;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field("Design Detail Line No."; Rec."Design Detail Line No.")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Design Code"; Rec."Design Detail Design Code")
                {
                    ApplicationArea = All;
                }*/
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Feature Name"; Rec."Feature Name")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        FeatureTypeRec: Record "Feature Type";
                        FeaturesTypesPage: Page "Features Types";
                        Design: Record Design;
                        Item: Record Item;
                    begin
                        Clear(FeaturesTypesPage);
                        Clear(FeatureTypeRec);
                        Item.Get(Rec."Item No.");
                        if Design.Get(Item."Design Code") then begin
                            FeatureTypeRec.SetRange("Type", Design.Type);
                            if FeatureTypeRec.FindSet() then begin
                                FeaturesTypesPage.SetTableView(FeatureTypeRec);
                                FeaturesTypesPage.LookupMode(true);
                                if FeaturesTypesPage.RunModal() = Action::LookupOK then begin
                                    FeaturesTypesPage.GetRecord(FeatureTypeRec);
                                    Rec.Validate("Feature Name", FeatureTypeRec."Feature Name");
                                end;
                            end;
                        end;
                    end;
                }
                field("Value"; Rec."Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
