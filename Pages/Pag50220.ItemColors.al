page 50220 "Item Colors"
{
    ApplicationArea = All;
    Caption = 'Item Colors';
    PageType = List;
    SourceTable = "Item Color";
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
                field("Color ID"; Rec."Color ID")
                {
                    ApplicationArea = All;
                }
                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                }
                field("Tonality Code"; Rec."Tonality Code")
                {
                    ApplicationArea = All;
                }
                field("French Description"; Rec."French Description")
                {
                    ApplicationArea = All;
                }
                field("Arabic Description"; Rec."Arabic Description")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(ItemColorPicture; "Item Color Picture")
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
                SubPageLink = "Table ID" = CONST(50220),
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
    actions
    {
        area(Processing)
        {
            action("Item Design Section Colors")
            {
                ApplicationArea = All;
                Image = AllocatedCapacity;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Item Design Section Colors";
                RunPageLink = "Item No." = field("Item No."), "Item Color ID" = field("Color ID");
                trigger OnAction()

                begin
                    FillItemDesignSectionColor();
                end;
            }
        }
    }
    procedure FillItemDesignSectionColor()
    var
        DesignDetail: Record "Design Detail";
        DesignSectionTemp: Record "Design Section" temporary;
        Item: Record Item;
        Design: Record Design;
        RMCategoryDesSec: Record "RM Category Design Section";
        RawMaterial: Record "Raw Material";
        ItemDesignSectionColor: Record "Item Design Section Color";
        ItemDesignSectionRM: Record "Item Design Section RM";
    begin
        Clear(DesignDetail);
        Clear(Item);
        Item.Get(Rec."Item No.");
        Design.Get(Item."Design Code");
        //Get All Related Design Section
        DesignDetail.SetCurrentKey("Design Section Code");
        DesignDetail.SetRange("Design Code", Design.Code);
        if DesignDetail.FindSet() then
            repeat
                DesignSectionTemp.Init();
                DesignSectionTemp.Code := DesignDetail."Design Section Code";
                if DesignSectionTemp.Insert() then;
            until DesignDetail.Next() = 0;
        DesignSectionTemp.SetFilter("Design Type Filter", Design.Type);
        if DesignSectionTemp.FindFirst() then
            repeat
                DesignSectionTemp.CalcFields("Related RM Categories Count");
                #region [1 Raw Material Category has multiple Raw Materials]
                if DesignSectionTemp."Related RM Categories Count" = 1 then begin
                    Clear(RMCategoryDesSec);
                    RMCategoryDesSec.SetRange("Design Section Code", DesignSectionTemp.Code);
                    if RMCategoryDesSec.Findfirst() then begin
                        Clear(RawMaterial);
                        RawMaterial.SetRange("Raw Material Category", RMCategoryDesSec."RM Category Code");
                        if RawMaterial.FindSet() then
                            if RawMaterial.Count > 1 then begin
                                //If there is one raw material having same color as the item color then skip the creation of design section
                                RawMaterial.SetRange("Color ID", Rec."Color ID");
                                if not RawMaterial.FindFirst() then begin
                                    //Check If the Design Section exist in item design section color
                                    if CheckItemDesignSectionColorExist(DesignSectionTemp.Code, Rec) = false then begin
                                        Clear(ItemDesignSectionColor);
                                        ItemDesignSectionColor.Init();
                                        ItemDesignSectionColor."Item No." := Rec."Item No.";
                                        ItemDesignSectionColor."Item Color ID" := Rec."Color ID";
                                        ItemDesignSectionColor."Design Section Code" := DesignSectionTemp.Code;
                                        if ItemDesignSectionColor.Insert(true) then;
                                    end;
                                end;
                            end;
                        //If Raw Material Count is 1 no need to insert
                    end;
                end;
                #endregion

                #region [Multiple Raw Material Category]
                if DesignSectionTemp."Related RM Categories Count" > 1 then begin
                    Clear(RMCategoryDesSec);
                    RMCategoryDesSec.SetRange("Design Section Code", DesignSectionTemp.Code);
                    if RMCategoryDesSec.Findfirst() then begin
                        Clear(ItemDesignSectionRM);
                        if ItemDesignSectionRM.Get(Rec."Item No.", RMCategoryDesSec."Design Section Code") then begin
                            Clear(RawMaterial);
                            RawMaterial.SetRange("Raw Material Category", ItemDesignSectionRM."Raw Material Category");
                            if RawMaterial.FindSet() then
                                if RawMaterial.Count > 1 then begin
                                    //If there is one raw material having same color as the item color then skip the creation of design section
                                    RawMaterial.SetRange("Color ID", Rec."Color ID");
                                    if not RawMaterial.FindFirst() then begin
                                        //Check If the Design Section exist in item design section color
                                        if CheckItemDesignSectionColorExist(DesignSectionTemp.Code, Rec) = false then begin
                                            Clear(ItemDesignSectionColor);
                                            ItemDesignSectionColor.Init();
                                            ItemDesignSectionColor."Item No." := Rec."Item No.";
                                            ItemDesignSectionColor."Item Color ID" := Rec."Color ID";
                                            ItemDesignSectionColor."Design Section Code" := DesignSectionTemp.Code;
                                            if ItemDesignSectionColor.Insert(true) then;
                                        end;
                                        //If Raw Material Count is 1 no need to insert
                                    end;
                                end;
                        end;
                    end;
                end;
            #endregion
            until DesignSectionTemp.Next() = 0;
        DesignSectionTemp.DeleteAll();
    end;

    procedure CheckItemDesignSectionColorExist(DesignSectionCode: code[50];
        ItemColorPar: Record "Item Color"): Boolean
    var
        ItemDesignSectionColor: Record "Item Design Section Color";
    begin
        Clear(ItemDesignSectionColor);
        ItemDesignSectionColor.SetRange("Item No.", ItemColorPar."Item No.");
        ItemDesignSectionColor.SetRange("Item Color ID", ItemColorPar."Color ID");
        ItemDesignSectionColor.SetRange("Design Section Code", DesignSectionCode);
        if ItemDesignSectionColor.FindFirst() then
            exit(true)
        else
            exit(false);
    end;
}
