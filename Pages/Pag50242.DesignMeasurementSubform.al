page 50242 "Design Measurement Subform"
{
    Caption = 'Design Measurements';
    PageType = ListPart;
    SourceTable = "Design Measurement";
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Design Code"; Rec."Design Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }*/
                field("Size Code"; Rec."Size Code")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Design: Record Design;
                        SizePage: Page Sizes;
                        SizeRec: Record "Size";
                    begin
                        if Design.Get(Rec."Design Code") then begin
                            SizeRec.SetRange("Gender", Design.Gender);
                            if SizeRec.FindSet() then begin
                                SizePage.SetTableView(SizeRec);
                                SizePage.LookupMode(true);
                                if SizePage.RunModal() = Action::LookupOK then begin
                                    SizePage.GetRecord(SizeRec);
                                    Rec.Validate("Size Code", SizeRec."Code");
                                end;
                            end;
                        end;
                    end;
                }
                field("Fit Code"; Rec."Fit Code")
                {
                    ApplicationArea = All;
                }
                field("Cut Code"; Rec."Cut Code")
                {
                    ApplicationArea = All;
                }
                field("Measurement Category Code"; Rec."Measurement Code")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        MeasurementCategoriesPage: Page "Measurement Categories";
                        MeasurementCategoriesRec: Record "Measurement Category";
                        Design: Record Design;
                    begin
                        Clear(MeasurementCategoriesPage);
                        if Design.Get(Rec."Design Code") then begin
                            MeasurementCategoriesRec.SetRange("Category Code", Design.Category);
                            if MeasurementCategoriesRec.FindSet() then begin
                                MeasurementCategoriesPage.SetTableView(MeasurementCategoriesRec);
                                MeasurementCategoriesPage.LookupMode(true);
                                if MeasurementCategoriesPage.RunModal() = Action::LookupOK then begin
                                    MeasurementCategoriesPage.GetRecord(MeasurementCategoriesRec);
                                    Rec.Validate("Measurement Code", MeasurementCategoriesRec."Measurement Code");
                                end;
                            end;
                        end;
                    end;
                }
                field("Measurement Name"; Rec."Measurement Name")
                {
                    ApplicationArea = all;
                }
                field("Value"; Rec."Value")
                {
                    ApplicationArea = All;
                }
                field("UOM Code"; Rec."UOM Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
