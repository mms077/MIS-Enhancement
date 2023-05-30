page 50263 "Design Details Sections Values"
{
    Caption = 'Design Details Sections Values';
    PageType = ListPart;
    SourceTable = "Design Details Sections Values";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field("Design Code"; Rec."Design Code")
                {
                    ApplicationArea = All;
                }
                field("Design Name"; Rec."Design Name")
                {
                    ApplicationArea = All;
                }*/
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                    LookupPageId = Sections;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SectionRec: Record Section;
                        SectionPage: Page Sections;
                    begin
                        Clear(SectionPage);
                        Clear(SectionRec);
                        SectionRec.SetCurrentKey(Number);
                        if SectionRec.FindSet() then begin
                            SectionPage.SetTableView(SectionRec);
                            SectionPage.LookupMode(true);
                            if SectionPage.RunModal() = Action::LookupOK then begin
                                SectionPage.GetRecord(SectionRec);
                                Rec.Validate("Section Code", SectionRec.Code);
                            end;
                        end;
                    end;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field("Design Section Code"; Rec."Design Section Code")
                {
                    ApplicationArea = All;
                }
                field("Design Section Name"; Rec."Design Section Name")
                {
                    ApplicationArea = All;
                }
                field("UOM Code"; Rec."UOM Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
