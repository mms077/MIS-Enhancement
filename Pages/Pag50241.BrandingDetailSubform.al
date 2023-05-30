page 50241 "Branding Detail Subform"
{
    Caption = 'Branding Structure';
    PageType = ListPart;
    SourceTable = "Branding Structure";
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
                /*field(ID; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Branding Detail Line No."; Rec."Branding Detail Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Branding Code"; Rec."Branding Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }*/
                field("Raw Material Code"; Rec."Raw Material Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
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
