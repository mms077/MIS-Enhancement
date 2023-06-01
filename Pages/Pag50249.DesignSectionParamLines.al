page 50249 "Design Section Param Lines"
{
    Caption = 'Design Section Colors Parameters';
    PageType = ListPart;
    SourceTable = "Design Section Param Lines";
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Design Section Code"; Rec."Design Section Code")
                {
                    ApplicationArea = All;
                }
                field("Design Section Name"; Rec."Design Section Name")
                {
                    ApplicationArea = All;
                }
                field("Color ID"; Rec."Color ID")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Clear(ItemDesignSectionColorPage);
                        Clear(ItemDesignSectionColorRec);
                        Clear(DesignSectionParameterHeader);
                        DesignSectionParameterHeader.Get(Rec."Header ID");
                        ItemDesignSectionColorRec.SetRange("Item No.", DesignSectionParameterHeader."Item No.");
                        ItemDesignSectionColorRec.SetRange("Design Section Code", Rec."Design Section Code");
                        ItemDesignSectionColorRec.SetRange("Item Color ID", DesignSectionParameterHeader."Item Color ID");
                        if ItemDesignSectionColorRec.FindSet() then begin
                            ItemDesignSectionColorPage.SetTableView(ItemDesignSectionColorRec);
                            ItemDesignSectionColorPage.LookupMode(true);
                            if ItemDesignSectionColorPage.RunModal() = Action::LookupOK then begin
                                ItemDesignSectionColorPage.GetRecord(ItemDesignSectionColorRec);
                                Rec.Validate("Color ID", ItemDesignSectionColorRec."Color ID");
                            end;
                        end;
                    end;
                }
                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                }
                field("Has Raw Material"; Rec."Has Raw Material")
                {
                    ApplicationArea = all;
                }
                field("Raw Material Code"; Rec."Raw Material Code")
                {
                    ApplicationArea = all;
                }

            }
        }

    }
    var
        ItemDesignSectionColorPage: Page "Item Design Section Colors";
        ItemDesignSectionColorRec: Record "Item Design Section Color";
        DesignSectionParameterHeader: Record "Parameter Header";

}
