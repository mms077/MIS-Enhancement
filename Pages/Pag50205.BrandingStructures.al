page 50205 "Branding Structures"
{
    ApplicationArea = All;
    Caption = 'Branding Structures';
    PageType = List;
    SourceTable = "Branding Structure";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Branding Detail ID"; Rec."Branding Detail Line No.")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    LookupPageId = "Branding Details";
                }
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
