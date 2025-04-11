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
                    DocAttachement: Record "Record Link";
                    Looks: Record "Look";
                    SharepointSetup: Record "Sharepoint Connector Setup";
                    SharepointSiteLink: Text[1000];
                    SharepointFrontPic: Text[100];
                    SharepointSidesPic: Text[100];
                    SharepointBackPic: Text[100];
                    LinkID: Integer;
                    UserChoice: Integer;
                begin
                    // Define SharePoint paths
                    SharepointSiteLink := '/sites/Designs2/Shared Documents/Looks/';
                    SharepointFrontPic := '/Default/front.png';
                    SharepointSidesPic := '/Default/sides.png';
                    SharepointBackPic := '/Default/back.png';

                    // Get SharePoint setup
                    SharepointSetup.Get();

                    // Prompt the user to select which images to add
                    UserChoice := Dialog.STRMENU(
                        'Front,Sides,Back,Thumbnail,All',
                        1
                    );

                    // Check if the Look record exists
                    if Looks.Get(Rec.Code) then begin
                        DocAttachement.SetRange("Record ID", Looks.RecordId);

                        // Add links based on user selection
                        case UserChoice of
                            1:
                                begin // Front
                                    DocAttachement.SetRange(Description, 'Front');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := Looks.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec.Code + SharepointFrontPic, 'Front');
                                end;
                            2:
                                begin // Sides
                                    DocAttachement.SetRange(Description, 'Sides');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := Looks.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec.Code + SharepointSidesPic, 'Sides');
                                end;
                            3:
                                begin // Back
                                    DocAttachement.SetRange(Description, 'Back');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := Looks.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec.Code + SharepointBackPic, 'Back');
                                end;
                            4:
                                begin // Front
                                    DocAttachement.SetRange(Description, 'Thumbnail');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := Looks.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec.Code + SharepointFrontPic, 'Thumbnail');
                                end;
                            5:
                                begin // All
                                      // Front
                                    DocAttachement.SetRange(Description, 'Front');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := Looks.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec.Code + SharepointFrontPic, 'Front');
                                    // Thumbnail
                                    DocAttachement.SetRange(Description, 'Thumbnail');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := Looks.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec.Code + SharepointFrontPic, 'Thumbnail');

                                    // Sides
                                    DocAttachement.SetRange(Description, 'Sides');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := Looks.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec.Code + SharepointSidesPic, 'Sides');

                                    // Back
                                    DocAttachement.SetRange(Description, 'Back');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := Looks.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec.Code + SharepointBackPic, 'Back');
                                end;
                        end;

                        // Save changes to the Look record
                        Looks.Modify();
                    end;
                end;
            }
        }
    }
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
        /* RecordRef.Open(50290);
         FieldRef := RecordRef.Field(1);
         FieldRef.Value := Rec.Code;
         if RecordRef.Find('=') then begin
             DocAttachement.setrange("Record ID", RecordRef.RecordId);
             if not DocAttachement.FindFirst() then begin
                 LinkID := RecordRef.AddLink('', 'Back');
                 LinkID := RecordRef.AddLink('', 'Front');
                 LinkID := RecordRef.AddLink('', 'Sides');
                 //Message('Text000', LinkID);
             end;
         end;*/
        Front := '';
        /* if Look.FindLast() then
             if Rec.Code = '' then begin
                 SalesSetup.Get();
                 SalesSetup.TestField("Look Nos.");
                 Noseries.SetFilter("Series Code", Look."No. Series");
                 if Noseries.FindFirst() then begin
                     if Noseries."Last No. Used" <> '' then begin
                         Noseries."Last No. Used" := Look.Code;
                         Noseries.Modify();
                     end;
                 end;
                 NoSeriesMgt.InitSeries(SalesSetup."Look Nos.", xRec."No. Series", 0D, rec.code, rec."No. Series");
             end;*/

        //display front image
        RecordRef.Close();
        RecordRef.Open(50292);
        FieldRef := RecordRef.Field(1);
        FieldRef.Value := rec.Code;
        if RecordRef.Find('=') then begin
            DocAttachement.setrange("Record ID", RecordRef.RecordId);
            DocAttachement.SetFilter(Description, 'Front');
            if DocAttachement.FindFirst() then begin
                SharepointSetup.Get();
                Front := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
                //Message(Front);
            end;
            DocAttachement.setrange("Record ID", RecordRef.RecordId);
            DocAttachement.SetFilter(Description, 'Back');
            if DocAttachement.FindFirst() then begin
                SharepointSetup.Get();
                Back := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
                //Message(Front);
            end;
            DocAttachement.setrange("Record ID", RecordRef.RecordId);
            DocAttachement.SetFilter(Description, 'Sides');
            if DocAttachement.FindFirst() then begin
                SharepointSetup.Get();
                Sides := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
                //Message(Front);
            end;
            /*  DocAttachement.setrange("Record ID", RecordRef.RecordId);
              DocAttachement.SetFilter(Description, 'Add-1');
              if DocAttachement.FindFirst() then begin
                  Add1 := DocAttachement.URL1;
                  //Message(Front);
              end;
              DocAttachement.setrange("Record ID", RecordRef.RecordId);
              DocAttachement.SetFilter(Description, 'Add-2');
              if DocAttachement.FindFirst() then begin
                  Add2 := DocAttachement.URL1;
                  //Message(Front);
              end;
              DocAttachement.setrange("Record ID", RecordRef.RecordId);
              DocAttachement.SetFilter(Description, 'Add-3');
              if DocAttachement.FindFirst() then begin
                  Add3 := DocAttachement.URL1;
                  //Message(Front);
              end;*/
        end;



        //add pic to Fronty image
        if Front <> '' then begin
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


        /*  if Add1 <> '' then begin
              Add1FileName := FileMgt.GetFileName(Add1);
              Add1Instr := SharepointMgt.OpenFileLooks(Add1, Rec);
              Rec."Add 1".ImportStream(Add1Instr, Add1FileName);
              rec.Modify();
          end;
          if Add2 <> '' then begin
              Add2FileName := FileMgt.GetFileName(Add2);
              Add2Instr := SharepointMgt.OpenFileLooks(Add2, Rec);
              Rec."Add 2".ImportStream(Add2Instr, Add2FileName);
              rec.Modify();
          end;
          if Add3 <> '' then begin
              Add3FileName := FileMgt.GetFileName(Add3);
              Add3Instr := SharepointMgt.OpenFileLooks(Add3, Rec);
              Rec."Add 3".ImportStream(Add3Instr, Add3FileName);
              rec.Modify();
          end;
  */
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
