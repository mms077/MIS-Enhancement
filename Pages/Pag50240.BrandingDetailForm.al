page 50240 "Branding Detail Form"
{
    Caption = 'Branding Detail Form';
    PageType = Document;
    SourceTable = "Branding Detail";
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Branding Detail';
                Editable = false;
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Branding Code"; Rec."Branding Code")
                {
                    ApplicationArea = All;
                }
                field("Item Color ID"; Rec."Item Color ID")
                {
                    ApplicationArea = All;
                }
                field("Item Color Name"; Rec."Item Color Name")
                {
                    ApplicationArea = all;
                }
                field("Image File"; Rec."Image File")
                {
                    ApplicationArea = All;
                }
                field("Film File"; Rec."Film File")
                {
                    ApplicationArea = All;
                }
                /* field("Color Name"; Rec."Color Name")
                 {
                     ApplicationArea = All;
                 }*/
            }
            part(BrandingStructure; "Branding Detail Subform")
            {
                ApplicationArea = basic, suite;
                SubPageLink = "Branding Detail Line No." = field("Line No."), "Branding Code" = field("Branding Code");
                UpdatePropagation = Both;
            }
        }
    }
}
