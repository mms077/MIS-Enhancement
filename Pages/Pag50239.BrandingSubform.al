page 50239 "Branding Subform"
{
    Caption = 'Branding Details';
    PageType = List;
    SourceTable = "Branding Detail";
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
                }
                field("Branding Code"; Rec."Branding Code")
                {
                    ApplicationArea = All;
                }*/
                field("Item Color ID"; Rec."Item Color ID")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Clear(ItemColorPage);
                        Branding.SetRange(Code, Rec."Branding Code");
                        if Branding.FindFirst() then begin
                            itemColorRec.SetRange("Item No.", Branding."Item No.");
                            if itemColorRec.FindSet() then begin
                                ItemColorPage.SetTableView(itemColorRec);
                                //ItemColorPage.Editable(true);
                                ItemColorPage.LookupMode(true);
                                if ItemColorPage.RunModal() = Action::LookupOK then begin
                                    ItemColorPage.GetRecord(itemColorRec);
                                    Rec.Validate("Item Color ID", itemColorRec."Color ID");
                                end;
                            end;
                        end;
                    end;
                }
                field("Item Color Name"; Rec."Item Color Name")
                {
                    ApplicationArea = All;
                }
                /*field("Image File"; Rec."Image File")
                {
                    ApplicationArea = All;
                }
                field("Film File"; Rec."Film File")
                {
                    ApplicationArea = All;
                }*/

            }
        }
        area(factboxes)
        {
            part(ItemPicture; "Branding Details Image")
            {
                ApplicationArea = All;
                Caption = 'Image File';
                SubPageLink = "Line No." = FIELD("Line No."),
                              "Branding Code" = FIELD("Branding Code");
            }
            part(Control1906127307; "Doc. Attachment List Factbox")
            {
                Caption = 'Film File';
                ApplicationArea = Suite;
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
    actions
    {
        area(Processing)
        {
            action("Branding Structure")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Branding Detail Form";
                RunPageLink = "Line No." = field("Line No."), "Branding Code" = field("Branding Code");
            }

        }
    }
    var
        Branding: Record Branding;
        ItemColorPage: Page "Item Colors";
        itemColorRec: Record "Item Color";
}
