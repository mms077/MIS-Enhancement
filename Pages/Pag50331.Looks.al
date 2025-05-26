page 50331 Looks
{
    ApplicationArea = All;
    Caption = 'Looks';
    PageType = List;
    SourceTable = Look;
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
                field(Name; Rec.Description)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        FieldRef: FieldRef;
                        LinkID: Integer;
                        DocAttachement: Record "Record Link";
                        RecordRef: RecordRef;
                        Text000: Label 'The link with ID %1 has been added.';
                        RecordLinkMgt: Codeunit "Record Link Management";
                    begin
                        //create links for every look
                        /* RecordRef.Open(50290);
                         FieldRef := RecordRef.Field(1);
                         FieldRef.Value := Rec.Code;
                         if RecordRef.Find('=') then begin
                             DocAttachement.setrange("Record ID", RecordRef.RecordId);
                             if not DocAttachement.FindFirst() then begin
                                 LinkID := RecordRef.AddLink('', 'Back');
                                 LinkID := RecordRef.AddLink('', 'Front');
                                 LinkID := RecordRef.AddLink('', 'Sides');
                                 Message(Text000, LinkID);
                             end;
                         end;*/
                    end;
                }

                field(Gender; rec.Gender) { ApplicationArea = all; }
                field("Dress Code"; rec."Dress Code") { ApplicationArea = all; }
            }

        }
        area(factboxes)
        {
            part(ItemPicture; "Look Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Code" = FIELD("Code");
            }

            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50292),
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
                RunObject = page "Look Form";
                RunPageLink = Code = field(Code);
            }
            action("Look Version")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Look Version";
                RunPageLink = "Look Code" = field(Code);
            }
            action("Design Book")
            {
                ApplicationArea = All;
                Image = Design;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = report "Design Book";
                Caption = 'Look Book';
            }
            action("Add Link")
            {
                ApplicationArea = All;
                Image = Link;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    TempLinkOptions: Record "Temp Link Options" temporary;
                    DocAttachement: Record "Record Link";
                    Looks: Record "Look";
                    SharepointSetup: Record "Sharepoint Connector Setup";
                    SharepointSiteLink: Text[1000];
                    SharepointFrontPic: Text[100];
                    SharepointSidesPic: Text[100];
                    SharepointBackPic: Text[100];
                    SharepointThumbnPic: Text[100];
                    LinkID: Integer;
                begin
                    SharepointSetup.Get();
                    // Define SharePoint paths
                    SharepointSiteLink := '/sites/Designs2/Shared Documents/Looks/';
                    SharepointFrontPic := '/Default/front.png';
                    SharepointSidesPic := '/Default/sides.png';
                    SharepointBackPic := '/Default/back.png';
                    SharepointThumbnPic := '/Default/Thumbnail.png';
                    // Populate the temporary table with link options
                    AddLinkOption(TempLinkOptions, 1, 'Front');
                    AddLinkOption(TempLinkOptions, 2, 'Sides');
                    AddLinkOption(TempLinkOptions, 3, 'Back');
                    AddLinkOption(TempLinkOptions, 4, 'Thumbnail');
                    AddLinkOption(TempLinkOptions, 5, 'All');

                    // Open the wizard page
                    if Page.RunModal(Page::"Temp Link Options", TempLinkOptions) = Action::LookupOK then begin
                        if Looks.Get(Rec.Code) then begin
                            DocAttachement.SetRange("Record ID", Looks.RecordId);

                            // Process selected options
                            if TempLinkOptions.FindSet() then
                                repeat
                                    if TempLinkOptions.Selected then begin
                                        case TempLinkOptions.ID of
                                            1:
                                                AddLinkURL(DocAttachement, Looks, SharepointSetup, SharepointSiteLink, Rec.Code, SharepointFrontPic, 'Front');
                                            2:
                                                AddLinkURL(DocAttachement, Looks, SharepointSetup, SharepointSiteLink, Rec.Code, SharepointSidesPic, 'Sides');
                                            3:
                                                AddLinkURL(DocAttachement, Looks, SharepointSetup, SharepointSiteLink, Rec.Code, SharepointBackPic, 'Back');
                                            4:
                                                AddLinkURL(DocAttachement, Looks, SharepointSetup, SharepointSiteLink, Rec.Code, SharepointThumbnPic, 'Thumbnail');
                                            5:
                                                begin
                                                    AddLinkURL(DocAttachement, Looks, SharepointSetup, SharepointSiteLink, Rec.Code, SharepointFrontPic, 'Front');
                                                    AddLinkURL(DocAttachement, Looks, SharepointSetup, SharepointSiteLink, Rec.Code, SharepointSidesPic, 'Sides');
                                                    AddLinkURL(DocAttachement, Looks, SharepointSetup, SharepointSiteLink, Rec.Code, SharepointBackPic, 'Back');
                                                    AddLinkURL(DocAttachement, Looks, SharepointSetup, SharepointSiteLink, Rec.Code, SharepointThumbnPic, 'Thumbnail');
                                                end;
                                        end;
                                    end;
                                until TempLinkOptions.Next() = 0;

                            // Save changes to the Look record
                            Looks.Modify();
                        end else
                            Error('Look record not found.');
                    end else
                        Message('No options were selected.');
                end;
            }
        }
    }
    procedure AddLinkOption(var TempLinkOptions: Record "Temp Link Options" temporary; ID: Integer; Name: Text[100])
    begin
        TempLinkOptions.ID := ID;
        TempLinkOptions.Name := Name;
        TempLinkOptions.Insert();
    end;

    procedure AddLinkURL(var DocAttachement: Record "Record Link"; var Looks: Record "Look"; SharepointSetup: Record "Sharepoint Connector Setup"; SharepointSiteLink: Text[1000]; RecCode: Code[20]; PicturePath: Text[100]; Description: Text[100])
    var
        LinkURL: Text[1000];
    begin
        DocAttachement.SetRange(Description, Description);
        LinkURL := SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + RecCode + PicturePath;

        if not DocAttachement.FindFirst() then begin
            Looks.AddLink(LinkURL, Description);
            //Message('Link added for %1.', Description);
        end else
            Message('Link for %1 already exists.', Description);
    end;




    trigger OnAfterGetCurrRecord()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DocAttachement: Record "Record Link";
        RecordRef: RecordRef;
        FieldRef: FieldRef;
        RecordLinkMgt: Codeunit "Record Link Management";
        CustomerLookVersion: Record "Customer Look Version";
        Front: Text[1000];
        Thumbnail: Text[1000];
        Back: Text[1000];
        Sides: Text[1000];
        Noseries: Record "No. Series Line";
        SharepointMgt: Codeunit "Sharepoint Management";
        index: Integer;
        Media: Record "Tenant Media";
        InStream: InStream;
        FileMgt: Codeunit "File Management";
        Look: Record Look;
        LinkID: Integer;
        Add1: Text[1000];
        Add2: Text[1000];
        Add3: Text[1000];
        SharepointSetup: Record "Sharepoint Connector Setup";
        SharepointURL: text[1000];
    begin

        Front := '';

        //display front image
        RecordRef.Close();
        RecordRef.Open(50292);
        FieldRef := RecordRef.Field(1);
        FieldRef.Value := rec.Code;
        if RecordRef.Find('=') then begin
            DocAttachement.SetRange("Record ID", RecordRef.RecordId);
            DocAttachement.SetFilter(Description, 'Thumbnail');
            if DocAttachement.FindFirst() then begin
                SharepointSetup.Get();
                Front := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
            end;

            if front = '' then begin
                DocAttachement.SetRange("Record ID", RecordRef.RecordId);
                DocAttachement.SetFilter(Description, 'Front');
                if DocAttachement.FindFirst() then begin
                    SharepointSetup.Get();
                    Front := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
                end;
            end;
            DocAttachement.setrange("Record ID", RecordRef.RecordId);
            DocAttachement.SetFilter(Description, 'Back');
            if DocAttachement.FindFirst() then begin
                SharepointSetup.Get();
                Back := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
            end;
            DocAttachement.setrange("Record ID", RecordRef.RecordId);
            DocAttachement.SetFilter(Description, 'Sides');
            if DocAttachement.FindFirst() then begin
                SharepointSetup.Get();
                Sides := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
            end;
        end;

        //add pic to Fronty image
        if Front <> '' then begin
            Clear(rec."Front Picture");
            Rec.Modify();
            Commit();
            frontFileName := FileMgt.GetFileName(Front);
            FrontInStr := SharepointMgt.OpenFileLooks(Front, Rec);
            Rec."Front Picture".ImportStream(FrontInStr, FrontFileName);
            rec.Modify();
        end;
        //add pic to Back image
        if Back <> '' then begin
            BackFileName := FileMgt.GetFileName(Back);
            BackInStr := SharepointMgt.OpenFileLooks(back, Rec);
            Rec."Back Picture".ImportStream(backInStr, BackFileName);
            rec.Modify();
        end;
        //add pic to sdies image
        if Sides <> '' then begin
            SidesFileName := FileMgt.GetFileName(Sides);
            SidesInStr := SharepointMgt.OpenFileLooks(Sides, Rec);
            Rec."Sides Picture".ImportStream(SidesInStr, SidesFileName);
            rec.Modify();
        end;

    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        Look: Record Look;
    begin
        Look.Reset();
        Look.SetRange("Dress Code", ''); // Filter for records with an empty Dress Code
        if Look.FindFirst() then
            Error('One or more records are missing a Dress Code. Please ensure all records have a Dress Code before closing the page.');
    end;


    var
        User: Record User;
        Base64Convert: Codeunit "Base64 Convert";
        LargeText: Text;

        LookTemp: Record Look;
        TempPic: InStream;
        D: Codeunit image;
        ItemFromPictureBuffer: Record "Item From Picture Buffer";
        f: Page "Item From Picture";
        text: Text;
        FrontInStr: InStream;
        BackInStr: InStream;
        SidesInStr: InStream;
        Add1Instr: InStream;
        Add2Instr: InStream;
        Add3Instr: InStream;

        FrontOs: OutStream;
        FrontFileName: Text[250];
        BackFileName: Text[250];
        SidesFileName: Text[250];
        Add1FileName: Text[250];
        Add2FileName: Text[250];
        Add3FileName: Text[250];

}
