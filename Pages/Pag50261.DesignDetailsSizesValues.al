page 50261 "Design Details Sizes Values"
{
    Caption = 'Design Details Sizes Values';
    PageType = ListPart;
    SourceTable = "Design Details Sizes Values";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field("Design Code"; Rec."Design Code")
                {
                    ApplicationArea = All;
                }*/
                field("Size Code"; Rec."Size Code")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Design: Record Design;
                        SizeCategoryPage: Page "Size Categories";
                        SizeCategoryRec: Record "Size Category";
                    begin
                        if Design.Get(Rec."Design Code") then begin
                            SizeCategoryRec.SetRange("Size Gender", Design.Gender);
                            SizeCategoryRec.SetRange("Category Code", Design.Category);
                            if SizeCategoryRec.FindSet() then begin
                                SizeCategoryPage.SetTableView(SizeCategoryRec);
                                SizeCategoryPage.LookupMode(true);
                                if SizeCategoryPage.RunModal() = Action::LookupOK then begin
                                    SizeCategoryPage.GetRecord(SizeCategoryRec);
                                    Rec.Validate("Size Code", SizeCategoryRec."Size Code");
                                end;
                            end;
                        end;
                    end;
                }
            }
        }
    }
}
