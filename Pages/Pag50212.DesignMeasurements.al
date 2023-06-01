page 50212 "Design Measurements"
{
    ApplicationArea = All;
    Caption = 'Design Measurements';
    PageType = List;
    SourceTable = "Design Measurement";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Design Code"; Rec."Design Code")
                {
                    ApplicationArea = All;
                }
                field("Fit Code"; Rec."Fit Code")
                {
                    ApplicationArea = All;
                }
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
                field("Cut Code"; Rec."Cut Code")
                {
                    ApplicationArea = All;
                }
                field("Measurement Category Code"; Rec."Measurement Code")
                {
                    ApplicationArea = All;
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
