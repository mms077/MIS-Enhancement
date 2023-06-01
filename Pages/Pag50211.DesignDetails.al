page 50211 "Design Details"
{
    ApplicationArea = All;
    Caption = 'Design Details';
    PageType = List;
    SourceTable = "Design Detail";
    UsageCategory = Lists;
    DelayedInsert = true;
    //DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Design Code"; Rec."Design Code")
                {
                    ApplicationArea = All;
                    TableRelation = Design.Code;
                }
                field("Size Code"; Rec."Size Code")
                {
                    ApplicationArea = All;
                    TableRelation = Size.Code;
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
                    TableRelation = Fit.Code;
                }
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                    TableRelation = Section.Code;
                }
                field("Section Group"; Rec."Section Group")
                {
                    ApplicationArea = all;
                }
                field("Section Composition"; Rec."Section Composition")
                {
                    ApplicationArea = all;
                }
                field("Design Section Code"; Rec."Design Section Code")
                {
                    ApplicationArea = All;
                    TableRelation = "Design Section".Code;
                }
                field("UOM Code"; Rec."UOM Code")
                {
                    ApplicationArea = All;
                    TableRelation = "Unit of Measure".Code;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Length (cm)"; Rec."Length (cm)")
                {
                    ApplicationArea = All;
                }
                field("Width (cm)"; Rec."Width (cm)")
                {
                    ApplicationArea = all;
                }
                field("Section Perimeter (cm2)"; Rec."Section Perimeter (cm)")
                {
                    ApplicationArea = all;
                }
                field("Section Surface (cm2)"; Rec."Section Surface (cm2)")
                {
                    ApplicationArea = all;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        MandatoryFields();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        MandatoryFields();
    end;

    procedure MandatoryFields()
    begin
        Rec.TestField("Size Code");
        Rec.TestField("Fit Code");
        Rec.TestField("Section Code");
        Rec.TestField("Design Section Code");
    end;
}
