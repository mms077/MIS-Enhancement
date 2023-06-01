/*page 50238 "Branding Form"
{
    Caption = 'Branding';
    PageType = Document;
    SourceTable = Branding;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Branding';
                Editable = false;
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Branding Category Code"; Rec."Branding Category Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Height; Rec.Height)
                {
                    ApplicationArea = All;
                }
                field(Width; Rec.Width)
                {
                    ApplicationArea = All;
                }
                //field(Length; Rec.Length)
                 //{
                   //  ApplicationArea = All;
                 //}
                field("Size UOM Code"; Rec."Size UOM Code")
                {
                    ApplicationArea = All;
                }
                field("Visual Support File"; Rec."Visual Support File")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
            }
            part(BrandingDetails; "Branding Subform")
            {
                ApplicationArea = basic, suite;
                SubPageLink = "Branding Code" = field(Code);
                UpdatePropagation = Both;
            }
        }
        area(factboxes)
        {
            part(ItemPicture; "Branding Details Image")
            {
                ApplicationArea = All;
                Caption = 'Image File';
                Provider = BrandingDetails;
                SubPageLink = "Line No." = FIELD("Line No."),
                              "Branding Code" = FIELD("Branding Code");
            }
            part(Control1906127307; "Document Attachment Factbox")
            {
                Caption = 'Film File';
                ApplicationArea = Suite;
                Provider = BrandingDetails;
                SubPageLink = "Table ID" = CONST(50204),
                "Line No." = FIELD("Line No."),
                              "No." = FIELD("Branding Code");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = true;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }
}*/