page 50333 "Look Version"
{
    //ApplicationArea = All;
    Caption = 'Look Version';
    PageType = List;
    SourceTable = "Look Version";
    // UsageCategory = Lists;

    layout  
    {
        area(content)
        {
            repeater(General)
            {

                field("Look Code"; Rec."Look Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Code; Rec.code)
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        FieldRef: FieldRef;
                        LinkID: Integer;
                        DocAttachement: Record "Record Link";
                        RecordRef: RecordRef;
                        Text000: Label 'The link with ID %1 has been added.';
                        RecordLinkMgt: Codeunit "Record Link Management";
                    begin

                    end;
                }

                field("Front Picture"; Rec."Front Picture")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

            }

        }
        area(factboxes)
        {
            part(ItemPicture; "look version Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Code" = FIELD("Code");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50296),
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
            action("Look Version Deatils")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "version Form";
                RunPageLink = Code = field(Code);
                Visible = false;

            }
            action("Assign Customer")
            {
                ApplicationArea = All;
                Image = Customer;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Customer Look Version";
                RunPageLink = "Look Version Code" = field(Code), "Look Code" = field("Look Code");
            }
            action("Assign Item")
            {
                ApplicationArea = All;
                Image = Item;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                //RunObject = page "Item Look version";
                // RunPageLink = "Look Version Code" = field(Code), "Look Code" = field("Look Code");
                trigger OnAction()
                var
                    myInt: Integer;
                    ItemLookVersion: Page "Item Look version";
                    ItemLookVersionRec: Record "Item Version";
                    LookDetails: Record "Look Detail";
                begin
                    //fill category design and type
                    /*    LookDetails.SetFilter("Look Code", Rec."Look Code");
                        if LookDetails.FindFirst() then
                            repeat
                                ItemLookVersionRec.Init();
                                ItemLookVersionRec."Look Code" := rec."Look Code";
                                ItemLookVersionRec."Look Version Code" := rec.Code;
                                ItemLookVersionRec.Category := LookDetails.Category;
                                ItemLookVersionRec.Type := LookDetails.Type;
                                ItemLookVersionRec.Design := LookDetails.Design;
                                ItemLookVersionRec.Insert(true);
                            until LookDetails.Next() = 0;
    */
                    ItemLookVersionRec.SetFilter("Look Code", Rec."Look Code");
                    ItemLookVersionRec.SetFilter("Look Version Code", Rec.Code);
                    if ItemLookVersionRec.FindSet() then begin
                        ItemLookVersion.SetTableView(ItemLookVersionRec);
                        ItemLookVersion.run();
                    end;
                end;
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
                    LookVersion: Record "Look Version";
                    SharepointSetup: Record "Sharepoint Connector Setup";
                    SharepointSiteLink: Text[1000];
                    SharepointFrontPic: Text[100];
                    SharepointSidesPic: Text[100];
                    SharepointBackPic: Text[100];
                    SharepointAdd1Pic: Text[100];
                    SharepointAdd2Pic: Text[100];
                    SharepointAdd3Pic: Text[100];
                    LinkID: Integer;
                    UserChoice: Integer;
                begin
                    // Define SharePoint paths
                    SharepointSiteLink := '/sites/Designs2/Shared Documents/Looks/';
                    SharepointFrontPic := '/front.png';
                    SharepointSidesPic := '/sides.png';
                    SharepointBackPic := '/back.png';
                    SharepointAdd1Pic := '/add1.png';
                    SharepointAdd2Pic := '/add2.png';
                    SharepointAdd3Pic := '/add3.png';

                    // Get SharePoint setup
                    SharepointSetup.Get();

                    // Prompt the user to select which images to add
                    UserChoice := Dialog.STRMENU(
                        'Front,Sides,Back,Add-1,Add-2,Add-3,All',
                        7
                    );

                    // Check if the LookVersion record exists
                    if LookVersion.Get(Rec.Code, Rec."Look Code") then begin
                        DocAttachement.SetRange("Record ID", LookVersion.RecordId);

                        // Add links based on user selection
                        case UserChoice of
                            1:
                                begin // Front
                                    DocAttachement.SetRange(Description, 'Front');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := LookVersion.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec."Look Code" + '/' + Rec."Code" + SharepointFrontPic, 'Front');
                                end;
                            2:
                                begin // Sides
                                    DocAttachement.SetRange(Description, 'Sides');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := LookVersion.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec."Look Code" + '/' + Rec."Code" + SharepointSidesPic, 'Sides');
                                end;
                            3:
                                begin // Back
                                    DocAttachement.SetRange(Description, 'Back');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := LookVersion.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec."Look Code" + '/' + Rec."Code" + SharepointBackPic, 'Back');
                                end;
                            4:
                                begin // Add-1
                                    DocAttachement.SetRange(Description, 'Add-1');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := LookVersion.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec."Look Code" + '/' + Rec."Code" + SharepointAdd1Pic, 'Add-1');
                                end;
                            5:
                                begin // Add-2
                                    DocAttachement.SetRange(Description, 'Add-2');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := LookVersion.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec."Look Code" + '/' + Rec."Code" + SharepointAdd2Pic, 'Add-2');
                                end;
                            6:
                                begin // Add-3
                                    DocAttachement.SetRange(Description, 'Add-3');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := LookVersion.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec."Look Code" + '/' + Rec."Code" + SharepointAdd3Pic, 'Add-3');
                                end;
                            7:
                                begin // All
                                      // Front
                                    DocAttachement.SetRange(Description, 'Front');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := LookVersion.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec."Look Code" + '/' + Rec."Code" + SharepointFrontPic, 'Front');

                                    // Sides
                                    DocAttachement.SetRange(Description, 'Sides');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := LookVersion.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec."Look Code" + '/' + Rec."Code" + SharepointSidesPic, 'Sides');

                                    // Back
                                    DocAttachement.SetRange(Description, 'Back');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := LookVersion.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec."Look Code" + '/' + Rec."Code" + SharepointBackPic, 'Back');

                                    // Add-1
                                    DocAttachement.SetRange(Description, 'Add-1');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := LookVersion.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec."Look Code" + '/' + Rec."Code" + SharepointAdd1Pic, 'Add-1');

                                    // Add-2
                                    DocAttachement.SetRange(Description, 'Add-2');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := LookVersion.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec."Look Code" + '/' + Rec."Code" + SharepointAdd2Pic, 'Add-2');

                                    // Add-3
                                    DocAttachement.SetRange(Description, 'Add-3');
                                    if not DocAttachement.FindFirst() then
                                        LinkID := LookVersion.AddLink(SharepointSetup."Sharepoint URL Http" + SharepointSiteLink + Rec."Look Code" + '/' + Rec."Code" + SharepointAdd3Pic, 'Add-3');
                                end;
                        end;

                        // Save changes to the LookVersion record
                        LookVersion.Modify();
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LookVersion: Record "Look Version";
        Noseries: Record "No. Series Line";
        DocAttachement: Record "Record Link";
        RecordRef: RecordRef;
        FieldRef: FieldRef;
        LinkID: Integer;
        Front: Text[1000];
        Back: Text[1000];
        Sides: Text[1000];
        InStr: InStream;
        Os: OutStream;
        SharepointMgt: Codeunit "Sharepoint Management";
        Media: Record "Tenant Media";
        InStream: InStream;
        FileName: Text[250];
        FileMgt: Codeunit "File Management";
        Add1: Text[1000];
        Add2: Text[1000];
        Add3: Text[1000];
        SharepointSetup: Record "Sharepoint Connector Setup";
        Int: Integer;
    begin
        Front := '';
        Back := '';
        Sides := '';
        Add1 := '';
        Add2 := '';
        Add3 := '';

        /* if LookVersion.FindLast() then
             if Rec.Code = '' then begin
                 SalesSetup.Get();
                 SalesSetup.TestField("Look Version Nos.");
                 Noseries.SetFilter("Series Code", LookVersion."No. Series");
                 if Noseries.FindFirst() then begin
                     Noseries."Last No. Used" := LookVersion.Code;
                     Noseries.Modify();
                     NoSeriesMgt.InitSeries(SalesSetup."Look Version Nos.", xRec."No. Series", 0D, rec.code, rec."No. Series");
                 end;

             end;*/


        //display front image

        DocAttachement.setrange("Record ID", rec.RecordId);
        DocAttachement.SetFilter(Description, 'Front');
        if DocAttachement.FindFirst() then begin
            SharepointSetup.Get();
            Front := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
            //Message(Front);
        end;
        DocAttachement.setrange("Record ID", rec.RecordId);
        DocAttachement.SetFilter(Description, 'Back');
        if DocAttachement.FindFirst() then begin
            SharepointSetup.Get();
            Back := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
            //Message(Front);
        end;
        DocAttachement.setrange("Record ID", rec.RecordId);
        DocAttachement.SetFilter(Description, 'Sides');
        if DocAttachement.FindFirst() then begin
            SharepointSetup.Get();
            Sides := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
            //Message(Front);
        end;
        DocAttachement.setrange("Record ID", Rec.RecordId);
        DocAttachement.SetFilter(Description, 'Add-1');
        if DocAttachement.FindFirst() then begin
            SharepointSetup.Get();
            Add1 := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
            //Message(Front);
        end;
        DocAttachement.setrange("Record ID", Rec.RecordId);
        DocAttachement.SetFilter(Description, 'Add-2');
        if DocAttachement.FindFirst() then begin
            SharepointSetup.Get();
            Add2 := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
            //Message(Front);
        end;
        DocAttachement.setrange("Record ID", Rec.RecordId);
        DocAttachement.SetFilter(Description, 'Add-3');
        if DocAttachement.FindFirst() then begin
            SharepointSetup.Get();
            Add3 := DELSTR(DocAttachement.URL1, 1, STRLEN(SharepointSetup."Sharepoint URL Http"));
            //Message(Front);
        end;




        //add pic to Fronty image
        if Front <> '' then begin
            frontFileName := FileMgt.GetFileName(Front);
            FrontInStr := SharepointMgt.OpenFileLookVersion(Front, Rec);
            Clear(rec."Front Picture");
            Rec."Front Picture".ImportStream(FrontInStr, FrontFileName);
            rec.Modify();
        end;
        //add pic to Back image
        if Back <> '' then begin
            BackFileName := FileMgt.GetFileName(Back);
            BackInStr := SharepointMgt.OpenFileLookVersion(back, Rec);
            Clear(rec."Back Picture");
            Rec."Back Picture".ImportStream(backInStr, BackFileName);
            rec.Modify();
        end;
        //add pic to sdies image
        if Sides <> '' then begin
            SidesFileName := FileMgt.GetFileName(Sides);
            SidesInStr := SharepointMgt.OpenFileLookVersion(Sides, Rec);
            Clear(rec."Sides Picture");
            Rec."Sides Picture".ImportStream(SidesInStr, SidesFileName);
            rec.Modify();
        end;

        //add pic to add1 image
        if Add1 <> '' then begin
            Add1FileName := FileMgt.GetFileName(Add1);
            Add1Instr := SharepointMgt.OpenFileLookVersion(Add1, Rec);
            Clear(rec."Add 1");
            Rec."Add 1".ImportStream(Add1Instr, Add1FileName);
            rec.Modify();
        end;
        //add pic to add2 image
        if Add2 <> '' then begin
            Add2FileName := FileMgt.GetFileName(Add2);
            Add2Instr := SharepointMgt.OpenFileLookVersion(Add2, Rec);
            Clear(rec."Add 2");
            Rec."Add 2".ImportStream(Add2Instr, Add2FileName);
            rec.Modify();
        end;
        //add pic to add3 image
        if Add3 <> '' then begin
            Add3FileName := FileMgt.GetFileName(Add3);
            Add3Instr := SharepointMgt.OpenFileLookVersion(Add3, Rec);
            Clear(rec."Add 3");
            Rec."Add 3".ImportStream(Add3Instr, Add3FileName);
            rec.Modify();
        end;



    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
        LookDetails: Record "Look Detail";
        ItemLookVer: Record "Item Look Version";
    begin


    end;

    var
        User: Record User;
        User2: Record User;
        UserCreater: Code[50];
        UserModifier: Code[50];
        d: Codeunit "Temp Blob";
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
