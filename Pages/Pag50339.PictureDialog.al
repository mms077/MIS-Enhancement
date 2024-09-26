page 50339 "Picture URL Dialog"
{
    PageType = StandardDialog;
    Caption = 'Picture URL Dialog';

    layout
    {
        area(content)
        {
            field(Code; code)
            {
                ApplicationArea = All;
                Caption = 'Code';
                Editable = false;
            }
            field(LookDesc; LookDesc)
            {
                ApplicationArea = All;
                Caption = 'Look Description';
                Editable = false;
            }
            field(PictureURL; PictureURL)
            {
                ApplicationArea = All;
                Caption = 'Picture URL';
                ExtendedDatatype = URL;
            }
        }
    }

    var
        Code: Code[20];
        LookDesc: Text[100];
        PictureURL: Text;

    procedure SetLookInfo(NewCode: Code[20]; NewLookDesc: Text[100])
    begin
        Code := NewCode;
        LookDesc := NewLookDesc;
    end;

    procedure ImportItemPictureFromURL()
    var
        Look: Record Look;
        Client: HttpClient;
        Content: HttpContent;
        Response: HttpResponseMessage;
        InStr: InStream;
        TempBlob: Codeunit "Temp Blob";

    begin
      /*  Client.Get(PictureURL, Response);
        Response.Content.ReadAs(InStr);

        Clear(Look.Picture);
        Look.Get(Code);
        Look.Picture.ImportStream(InStr, 'Demo picture for item ' + Format(Look.Code));
        Look.Modify(true);
*/
    end;


}