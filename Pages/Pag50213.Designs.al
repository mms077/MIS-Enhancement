page 50213 Designs
{
    ApplicationArea = All;
    Caption = 'Designs';
    PageType = List;
    SourceTable = Design;
    UsageCategory = Lists;
    //DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Items Count"; Rec."Items Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
                field("Name Local"; Rec."Name Local")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Type"; Rec.Type)
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DesignTypeRec: Record "Design Type";
                        DesignTypePage: Page "Design Types";
                    begin
                        Clear(DesignTypePage);
                        Clear(DesignTypeRec);
                        DesignTypeRec.SetRange(Category, Rec.Category);
                        if DesignTypeRec.FindSet() then begin
                            DesignTypePage.SetTableView(DesignTypeRec);
                            DesignTypePage.LookupMode(true);
                            if DesignTypePage.RunModal() = Action::LookupOK then begin
                                DesignTypePage.GetRecord(DesignTypeRec);
                                Rec.Validate(Type, DesignTypeRec.Name);
                            end;
                        end;
                    end;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Created By"; UserCreater)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Created By';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = all;
                    Caption = 'Created At';
                }
                field("Modified By"; UserModifier)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Modified By';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = all;
                    Caption = 'Modified At';
                }
                field("Has Picture"; Rec."Has Picture")
                {
                    ApplicationArea = All;
                    Caption = 'Has Picture';
                }
            }

        }
        area(factboxes)
        {
            part(ItemPicture; "Design Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Code" = FIELD("Code");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50213),
                              "No." = FIELD(Code);
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
            action("Details")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Design Form";
                RunPageLink = Code = field(Code);
            }
            action("Plotting")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Design Plotting List";
                RunPageLink = "Design Code" = field(Code);
                trigger OnAction()
                begin
                    FillPlottingCombination;
                end;
            }
            /*action("Design Features")
            {
                Caption = 'Features';
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Design Details Features";
                RunPageLink = "Design Code" = field("Code");
            }*/
            action("CreateItem")
            {
                ApplicationArea = All;
                Image = Item;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    CreateItemFromDesign;
                end;
            }
            action("Update Has Picture")
            {
                ApplicationArea = All;
                Image = UpdateXML;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    UpdateHasPicture();
                end;
            }
            action("Add Design activities")
            {
                ApplicationArea = All;
                Image = Add;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Design Activities";
                RunPageLink = "Design Code" = field(Code);
                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if User.Get(Rec.SystemCreatedBy) then
            UserCreater := User."User Name";
        if User2.Get(Rec.SystemModifiedBy) then
            UserModifier := User2."User Name";
    end;

    procedure FillPlottingCombination()
    var
        DesignDetail: Record "Design Detail";
        DesignDetailBuffer: Record "Design Detail" temporary;
        DesignPloting: Record "Design Plotting";
        PreviousSizeCode: Code[10];
        PreviousFitCode: Code[10];
        lineNumber: Integer;
    begin
        //Fill the buffer with unique fit size combination
        Clear(DesignDetail);
        DesignDetail.SetCurrentKey("Size Code");
        DesignDetail.SetRange("Design Code", Rec.Code);
        if DesignDetail.FindFirst() then begin
            repeat
                if (DesignDetail."Size Code" <> PreviousSizeCode)
                OR (DesignDetail."Fit Code" <> PreviousFitCode) then begin
                    lineNumber := lineNumber + 10000;
                    DesignDetailBuffer.Init();
                    DesignDetailBuffer."Line No." := lineNumber;
                    DesignDetailBuffer."Fit Code" := DesignDetail."Fit Code";
                    DesignDetailBuffer."Size Code" := DesignDetail."Size Code";
                    DesignDetailBuffer.Insert();
                    PreviousFitCode := DesignDetail."Fit Code";
                    PreviousSizeCode := DesignDetail."Size Code";
                end;
            until DesignDetail.Next() = 0;

            //fill the design plotting base on the buffer
            if DesignDetailBuffer.FindSet() then
                repeat
                    //Check if the Design Ploting line is not existing
                    if not DesignPloting.Get(Rec.Code, DesignDetailBuffer."Size Code", DesignDetailBuffer."Fit Code") then begin
                        DesignPloting.Init();
                        DesignPloting."Design Code" := Rec.Code;
                        DesignPloting.Size := DesignDetailBuffer."Size Code";
                        DesignPloting.Fit := DesignDetailBuffer."Fit Code";
                        DesignPloting.Insert(true);
                    end;
                until DesignDetailBuffer.Next() = 0;
        end;
    end;

    procedure CreateItemFromDesign()
    var
        Item: Record Item;
        NoSeriesManagement: Codeunit "No. Series";
        NoSeries: Record "No. Series";
        Txt0001: Label 'The design must have a category';
        Txt0002: Label 'There is no No. Series related to this category';
        NewNumber: Code[20];
    begin
        if Rec.Category = '' then
            Error(Txt0001);
        NoSeries.SetRange("Item Category", Rec.Category);
        if NoSeries.FindFirst() then begin
            NewNumber := NoSeriesManagement.GetNextNo(NoSeries.Code, 0D, true);
            Clear(Item);
            Item.Init();
            Item.Validate("No.", NewNumber);
            Item.Validate("Design Code", Rec.Code);
            //will be filled by Validate No.
            //Item."Item Category Code" := Rec.Category;
            Item.Insert(true);
            //To prevent Deadlock during posting Shipments
            Commit();
            Page.Run(30, Item);
        end
        else
            Error(Txt0002);
    end;

    Procedure UpdateHasPicture()
    var
        Design: Record Design;
    begin
        if Design.FindSet() then
            repeat
                if Design.Picture.Count = 0 then
                    Design."Has Picture" := false
                else
                    Design."Has Picture" := true;
                Design.Modify(false);
            until Design.Next() = 0;
        Message('Done');
    end;

    var
        User: Record User;
        User2: Record User;
        UserCreater: Code[50];
        UserModifier: Code[50];
}
