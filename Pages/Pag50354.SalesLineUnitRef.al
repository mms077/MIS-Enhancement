page 50354 "Sales Line Unit Ref. List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Line Unit Ref.";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                //  field("Sales Line Ref."; Rec."Sales Line Ref.") { ApplicationArea = all; Editable = false; }
                field("Sales Line Unit"; Rec."Sales Line Unit")
                {
                    ApplicationArea = all;
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        TargetRec: Record "Scan Activities-History";
                        Token: Text;
                    begin
                        Token := GenerateToken();
                        FillExistingScanHistoryforSalesLineUnit(Rec."Sales Line Unit", Token);
                        if TargetRec.FindSet() then
                            PAGE.Run(PAGE::"Existing Scans", TargetRec);
                    end;
                }
                field("Item No."; Rec."Item No.") { ApplicationArea = all; }

                field("Variant Code"; Rec."Variant Code") { ApplicationArea = all; }
                field(Description; Rec.Description) { ApplicationArea = all; }
                field(Quantity; Rec.Quantity) { ApplicationArea = all; }
                field("Unit of Measure Code"; Rec."Unit of Measure Code") { ApplicationArea = all; }
                field("Scan In"; Rec."Scan In") { ApplicationArea = all; }
                field("Scan Out"; Rec."Scan Out") { ApplicationArea = all; }
                field("Serial No."; "Serial No.") { ApplicationArea = all; Editable = false; }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
    procedure GenerateToken(): Text
    var
        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        BodyContent: JsonObject;
        HtpContent: HttpContent;
        HtpContentHeaders: HttpHeaders;
        JsonResponse: JsonObject;
        Jtoken: JsonToken;
        Txt: Text;
        HttpResponseMsg: Text;
        //Token: Text;
        JsonValue: JsonValue;
        DataObject: JsonObject;
        AuthToken: Text;
        //  APISetup: Record "MT5 API Setup";
        CleanedResp: Text;
    BEGIN

        BodyContent.Add('grant_type', 'client_credentials');
        BodyContent.Add('user_id', 'bcapi');
        BodyContent.add('user_secret', 'EmileRassam@123456');
        BodyContent.add('apikey', 'a3c95511a8d07ded55d580f48036f679');
        BodyContent.WriteTo(txt);

        HtpContent.Clear();
        HtpContent.GetHeaders(HtpContentHeaders);
        HtpContent.WriteFrom(txt);
        HtpContentHeaders.Remove('Content-Type');
        HtpContentHeaders.Add('Content-Type', 'application/json');

        HttpRequest.Method := 'POST';
        HttpRequest.SetRequestUri('https://portal.emilerassam.com/api/system/connect/');
        HttpRequest.Content(HtpContent);


        IF HttpClient.Send(HttpRequest, HttpResponse) then begin
            Clear(AuthToken);
            if not HttpResponse.IsSuccessStatusCode then
                exit;
            HttpResponse.Content.ReadAs(HttpResponseMsg);
            CleanedResp := '';

            CleanedResp := CleanStringTokenResponse(HttpResponseMsg);
            //  JsonResponse.ReadFrom(HttpResponseMsg);
            JsonResponse.ReadFrom(CleanedResp);
            //  JsonResponse.ReadFrom(HttpResponseMsg);
            if JsonResponse.Get('data', Jtoken) then begin
                // if Jtoken.IsValue then
                DataObject := JToken.AsObject();
                if DataObject.Get('token', JToken) then begin
                    AuthToken := 'Bearer ' + JToken.AsValue().AsText();
                    //AuthToken := JToken.AsValue().AsText();
                    exit(AuthToken);

                end;
            end;
        end;
    End;

    procedure CleanStringTokenResponse(InputText: Text): Text
    var
        ResultText: Text;
        TextLength: Integer;
    begin
        ResultText := InputText;

        // Remove leading and trailing double quotes
        TextLength := StrLen(ResultText);
        if (TextLength >= 2) and (CopyStr(ResultText, 1, 1) = '"') and (CopyStr(ResultText, TextLength, 1) = '"') then
            ResultText := CopyStr(ResultText, 2, TextLength - 2);

        // Remove all slashes
        while StrPos(ResultText, '\') > 0 do
            ResultText := DelStr(ResultText, StrPos(ResultText, '\'), 1);

        exit(ResultText);
    end;

    local procedure FillExistingScanHistoryforSalesLineUnit(Filter: Text; AccessToken: Text)
    var
        APIUrl: Text;
        HttpClient: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        JsonResponse: JsonObject;
        JsonArray: JsonArray;
        JsonValue: JsonValue;
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        ScanHistory: Record "Scan Activities-History";
        CleanedResponse: Text;
    begin
        DeleteExistingScans;
        // Set the MO number filter
        clear(CleanedResponse);
        // Build the API URL
        APIUrl := StrSubstNo('https://portal.emilerassam.com/api/core/scan/?filter=sales_line_unit_id eq ''%1''&orderby=activity_date desc', Filter);


        // Add the Authorization header
        HttpClient.DefaultRequestHeaders.Add('Authorization', StrSubstNo(AccessToken));

        // Add the Accept header
        HttpClient.DefaultRequestHeaders.Add('Accept', 'application/json');
        // Send the GET request
        if HttpClient.Get(APIUrl, HttpResponse) then begin
            if HttpResponse.IsSuccessStatusCode then begin
                // Read the response content
                HttpResponse.Content.ReadAs(ResponseText);

                CleanedResponse := CleanJsonString(ResponseText);
                // Parse the JSON response
                JsonResponse.ReadFrom(CleanedResponse);
                if JsonResponse.Get('data', JsonToken) then begin
                    if JsonToken.IsArray then begin
                        JsonArray := JsonToken.AsArray();
                        // Loop through the array and insert records into the history scanned table
                        foreach JsonToken in JsonArray do begin
                            if JsonToken.IsObject then begin
                                JsonObject := JsonToken.AsObject();
                                ScanHistory.Init();
                                ScanHistory."Unit Ref" := Filter;
                                ScanHistory."Sales Line Unit Id." := Filter;
                                // if JsonObject.Get('sales_line_unit_id', JsonToken) then
                                //     ScanHistory."Sales Line Unit Id." := JsonToken.AsValue().AsText();
                                if JsonObject.Get('sales_line_id', JsonToken) then
                                    ScanHistory."Sales Line Id" := JsonToken.AsValue().AsText();

                                if JsonObject.Get('assembly_no', JsonToken) then
                                    ScanHistory."Assembly No." := JsonToken.AsValue().AsText();
                                if JsonObject.Get('mo_no', JsonToken) then
                                    ScanHistory."ER - Manufacturing Order No." := JsonToken.AsValue().AsText();
                                if JsonObject.Get('item_code', JsonToken) then
                                    ScanHistory."Item No." := JsonToken.AsValue().AsText();
                                // Extract Design Code
                                if JsonObject.Get('design_code', JsonToken) then
                                    ScanHistory."Design Code" := JsonToken.AsValue().AsText();
                                if JsonObject.Get('variant_code', JsonToken) then
                                    ScanHistory."Variant Code" := JsonToken.AsValue().AsText();
                                if JsonObject.Get('so_no', JsonToken) then
                                    ScanHistory."Source No." := JsonToken.AsValue().AsText();
                                if JsonObject.Get('activity_code', JsonToken) then
                                    Evaluate(ScanHistory."Activity Code", JsonToken.AsValue().AsText());
                                if JsonObject.Get('activity_name', JsonToken) then
                                    ScanHistory."Activity Name" := JsonToken.AsValue().AsText();
                                if JsonObject.Get('activity_remark', JsonToken) then
                                    ScanHistory."Activity Remark" := JsonToken.AsValue().AsText();
                                // Correctly map the JSON value to the option field
                                if JsonObject.Get('activity_type', JsonToken) then begin
                                    case JsonToken.AsValue().AsText() of
                                        'In':
                                            ScanHistory."Activity Type" := ScanHistory."Activity Type"::"In";
                                        'Out':
                                            ScanHistory."Activity Type" := ScanHistory."Activity Type"::"Out";
                                        else
                                            Error('Invalid activity type: %1', JsonToken.AsValue().AsText());
                                    end;
                                end;

                                // Extract Activity Date (get only the date part)
                                if JsonObject.Get('activity_date', JsonToken) then
                                    Evaluate(ScanHistory."Activity Date", CopyStr(JsonToken.AsValue().AsText(), 1, 10));


                                if JsonObject.Get('activity_time', JsonToken) then
                                    Evaluate(ScanHistory."Activity Time", JsonToken.AsValue().AsText());

                                // Insert the record
                                ScanHistory.Insert();
                            end;
                        end;
                    end else
                        Error('Failed to parse the data array from the API response.');
                end else
                    Error('Failed to get the data array from the API response.');

            end else
                Error('HTTP Error: %1 - %2', HttpResponse.HttpStatusCode, HttpResponse.ReasonPhrase());
        end else
            Error('Failed to send the HTTP GET request.');
    end;

    local procedure DeleteExistingScans()
    var
        myInt: Integer;
        ScanHistory: Record "Scan Activities-History";
    begin
        if ScanHistory.FindSet() then
            ScanHistory.DeleteAll();
    end;

    procedure CleanJsonString(InputText: Text): Text
    var
        CleanText: Text;
        TextLength: Integer;
    begin
        // Remove all backslashes
        CleanText := DelChr(InputText, '=', '\');

        // Remove quotes from start and end ONLY if present
        TextLength := StrLen(CleanText);
        if (TextLength >= 2) and (CopyStr(CleanText, 1, 1) = '"') and (CopyStr(CleanText, TextLength, 1) = '"') then
            CleanText := CopyStr(CleanText, 2, TextLength - 2);

        exit(CleanText);
    end;

}