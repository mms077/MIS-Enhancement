page 50202 "Branding"
{
    ApplicationArea = All;
    Caption = 'Brandings';
    PageType = List;
    SourceTable = Branding;
    UsageCategory = Lists;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
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
                field("Customer No."; Rec."Customer No.")
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
                field("Item Description"; Rec."Item Description")
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
                /*field(Length; Rec.Length)
                {
                    ApplicationArea = All;
                }*/
                field("Size UOM Code"; Rec."Size UOM Code")
                {
                    ApplicationArea = All;
                }
                /*field("Visual Support File"; Rec."Visual Support File")
                 {
                     ApplicationArea = All;
                 }*/
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(BrandingPicture; "Branding Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Code" = FIELD("Code"), "Customer No." = field("Customer No.");
            }
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50202),
                              "No." = FIELD(Code),
                              "Link Code" = FIELD("Customer No.");
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

    actions
    {
        area(Processing)
        {
            action("Branding Details")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Branding SubForm";
                RunPageLink = "Branding Code" = field(Code);
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("Company Name", CompanyName);
        Rec.FilterGroup(0);
    end;
}
