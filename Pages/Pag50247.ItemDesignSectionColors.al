page 50247 "Item Design Section Colors"
{
    ApplicationArea = All;
    Caption = 'Item Design Section Colors';
    PageType = List;
    SourceTable = "Item Design Section Color";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }*/
                field("Design Section Code"; Rec."Design Section Code")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Item: Record Item;
                        DesignDetail: Record "Design Detail";
                        DesignSectionFilter: Text[2048];
                        PreviousDesignSection: Code[100];
                        DesignSectionPage: Page "Design Sections";
                        DesignSectionRec: Record "Design Section";
                    begin
                        Clear(DesignSectionFilter);
                        Clear(PreviousDesignSection);
                        if Item.Get(Rec."Item No.") then begin
                            Clear(DesignDetail);
                            DesignDetail.SetCurrentKey("Design Section Code");
                            DesignDetail.SetRange("Design Code", Item."Design Code");
                            if DesignDetail.FindSet() then begin
                                repeat
                                    if PreviousDesignSection <> DesignDetail."Design Section Code" then begin
                                        DesignSectionFilter := DesignSectionFilter + DesignDetail."Design Section Code" + '|';
                                    end;
                                    PreviousDesignSection := DesignDetail."Design Section Code";
                                until DesignDetail.Next() = 0;
                                Clear(DesignSectionRec);
                                DesignSectionFilter := DELCHR("DesignSectionFilter", '>', '|');
                                DesignSectionRec.SetFilter(Code, DesignSectionFilter);
                                if DesignSectionRec.FindSet() then begin
                                    DesignSectionPage.SetTableView(DesignSectionRec);
                                    DesignSectionPage.LookupMode(true);
                                    if DesignSectionPage.RunModal() = Action::LookupOK then begin
                                        DesignSectionPage.GetRecord(DesignSectionRec);
                                        Rec.Validate("Design Section Code", DesignSectionRec.Code);
                                    end;
                                end;
                            end;
                        end;
                    end;
                }

                field("Design Section Name"; Rec."Design Section Name")
                {
                    ApplicationArea = all;
                }
                field("Color ID"; Rec."Color ID")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ColorPage: Page Colors;
                        RawMaterial: Record "Raw Material";
                        ColorTemp: Record Color temporary;
                        Color: Record Color;
                        ColorFilterText: Text[10000];
                        ItemDesignSecRM: Record "Item Design Section RM";
                    begin
                        Clear(ItemDesignSecRM);
                        ItemDesignSecRM.SetRange("Item No.", Rec."Item No.");
                        ItemDesignSecRM.SetRange("Design Section Code", Rec."Design Section Code");
                        if ItemDesignSecRM.FindFirst() then begin
                            Clear(RawMaterial);
                            RawMaterial.SetCurrentKey("Color ID");
                            RawMaterial.SetFilter("Raw Material Category", ItemDesignSecRM."Raw Material Category");
                            if RawMaterial.FindSet() then begin
                                repeat
                                    ColorTemp.Init();
                                    ColorTemp.ID := RawMaterial."Color ID";
                                    if ColorTemp.Insert() then;
                                until RawMaterial.Next() = 0;
                                if ColorTemp.FindSet() then
                                    repeat
                                        ColorFilterText := ColorFilterText + Format(ColorTemp.ID) + '|';
                                    until ColorTemp.Next() = 0;
                                ColorFilterText := DELCHR("ColorFilterText", '>', '|');
                                Clear(Color);
                                Color.SetFilter("ID", ColorFilterText);
                            end;
                        end;
                        if Color.FindSet() then begin
                            ColorPage.SetTableView(Color);
                            ColorPage.LookupMode(true);
                            if ColorPage.RunModal() = Action::LookupOK then begin
                                ColorPage.GetRecord(Color);
                                Rec.Validate("Color ID", Color."ID");
                            end;
                        end;
                    end;
                }
                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                }
                field("Tonality Code"; Rec."Tonality Code")
                {
                    ApplicationArea = All;
                }
                /*field("Design Section Color Count"; Rec."Design Section Color Count")
                {
                    ApplicationArea = All;
                }*/
                field(Default; Rec.Default)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(ItemColorPicture; "Item Design Sec. Color Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = ID = field(ID),
                 "Item No." = field("Item No."),
                "Color ID" = field("Color ID");
            }
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50238),
                              "Line No." = FIELD(ID);
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
}
