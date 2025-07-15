page 50246 "Branding Picture"
{
    Caption = 'Branding Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Branding;

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = Basic, Suite, Invoicing;
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the branding.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Camera;
                /*Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;*/
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable AND (HideActions = FALSE);

                trigger OnAction()
                begin
                    TakeNewPicture;
                end;
            }
            /* action(ImportPicture)
             {
                 ApplicationArea = All;
                 Caption = 'Import';
                 Image = Import;
                 ToolTip = 'Import a picture file.';
                 Visible = HideActions = FALSE;

                 trigger OnAction()
                 begin
                     ImportFromDevice;
                 end;
             }*/
            action("Import Picture")
            {
                ApplicationArea = All;
                ToolTip = 'Import a picture file.';
                Caption = 'Import';
                Image = Import;

                trigger OnAction()
                var
                    FileName: Text;
                    PictureStream: InStream;
                    FileFilter: Text;
                    DialogCaption: Label 'Select a picture to upload';
                begin
                    Rec.TestField(Code);
                    //if Rec.Picture.HASVALUE then if not CONFIRM(OverrideImageQst) then exit;
                    if UploadIntoStream(DialogCaption, '', FileFilter, FileName, PictureStream) then begin
                        Clear(Rec.Picture);
                        Rec.Picture.ImportStream(PictureStream, FileName);
                        Rec.Modify(TRUE);
                    end;
                end;
            }

            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';
                Visible = HideActions = FALSE;

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    /* Rec.TestField("Code");
                     Rec.TestField(Name);

                     ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                     ExportPath := TemporaryPath + Rec."Code" + Format(Rec.Picture.MediaId);
                     Rec.Picture.ExportFile(ExportPath + '.' + DummyPictureEntity.GetDefaultExtension);

                     FileManagement.ExportImage(ExportPath, ToFile);*/
                    ExporItemPicture();
                end;
            }



            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = FALSE;

                trigger OnAction()
                begin
                    DeleteItemPicture;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Camera: Codeunit Camera;
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        HideActions: Boolean;
        MustSpecifyDescriptionErr: Label 'You must add a description to the item before you can import a picture.';
        MimeTypeTok: Label 'image/jpeg', Locked = true;

    procedure TakeNewPicture()
    begin
        Rec.Find();
        Rec.TestField(Code);
        Rec.TestField(Name);

        OnAfterTakeNewPicture(Rec, DoTakeNewPicture());
    end;

    local procedure DoTakeNewPicture(): Boolean
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        if Rec.Picture.Count() > 0 then
            if not Confirm(OverrideImageQst) then
                exit(false);

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec.Picture);
            Rec.Picture.ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true);
            exit(true);
        end;

        exit(false);
    end;


    procedure IsCameraAvailable(): Boolean
    begin
        exit(Camera.IsAvailable());
    end;

    procedure SetHideActions()
    begin
        HideActions := true;
    end;

    procedure DeleteItemPicture()
    begin
        Rec.TestField("Code");

        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec.Picture);
        Rec.Modify(true);

        OnAfterDeleteBrandingPicture(Rec);
    end;

    local procedure ExporItemPicture()
    var
        index: Integer;
        Media: Record "Tenant Media";
        InStream: InStream;
        Base64: Codeunit "Base64 Convert";
        output: Text[250];
        Mime: Text[250];
        FileName: Text[250];
    begin
        if Rec.Picture.count = 0 then begin
            output := 'No Content';
            Mime := '';
            FileName := '';
        end else
            for index := 1 to Rec.Picture.COUNT do begin
                if Media.Get(Rec.Picture.Item(index)) then begin
                    Media.CalcFields(Content);
                    if Media.Content.HasValue() then begin
                        Media.Content.createInStream(InStream, TextEncoding::WINDOWS);
                        output := Base64.ToBase64(InStream);
                        Mime := Media."Mime Type";
                        FileName := Rec."Code" + '' + Rec.Name + GetImgFileExt(Mime);
                    end;
                end;
            end;
    end;

    procedure GetImgFileExt(var "Mime Type": Text[250]): Text
    begin
        case "Mime Type" of
            'image / jpeg':
                exit('.jpg');
            'image/png':
                exit('.png');
            'image/bmp':
                exit('.bmp');
            'image/gif':
                exit('.gif');
            'image/tiff':
                exit('.tiff');
            'image/wmf':
                exit('.wmf');
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDeleteBrandingPicture(var Branding: Record Branding)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterTakeNewPicture(var Branding: Record Branding; IsPictureAdded: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnImportFromDeviceOnAfterModify(var Branding: Record Branding)
    begin
    end;

}

