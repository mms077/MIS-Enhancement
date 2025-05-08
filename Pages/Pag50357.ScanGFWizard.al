page 50357 "Scan Unit Ref"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Scan Design Stages- ER Temp";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(UnitRef; UnitRef)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        MasterItemCU: Codeunit MasterItem;
                        AssemblyHeader: Record "Assembly Header";
                        ScanDesignStages: Record "Scan Design Stages- ER"; // Replace with the actual table name for scan activities
                        Dashboard: Record "Cutting Sheets Dashboard"; // Replace with the actual table name for the dashboard
                        Txt001: Label 'No Assembly found in the group %1';
                        Txt0001: Label 'Scan In 👍';
                        Txt0002: Label 'Scan Out 👍';
                        ScanOption: Option "In","Out";
                        Item: Record Item;
                        WorkflowActivitiesER: Record "Workflow Activities - ER";
                        MO: Record "ER - Manufacturing Order";
                        MaxSequenceNo: Integer;
                        Txt003: Label 'The current sequence number %1 exceeds the maximum sequence number %2 in the scan activities.';
                        SalesLine: Record "Sales Line";
                        SalesUnit: Record "Sales Line Unit Ref.";
                        ProcessedAssemblies: Dictionary of [Code[20], Boolean]; // To track processed assemblies
                        DesignActivities: Record "Design Activities";
                    //  ScanActivities: Record "Scan Activities";
                    begin
                        //make to scan false
                        ResetDesignActivitiesToScan;
                        rec.DeleteAll();
                        DesignCode := '';
                        // Logic to refresh the subpage when UnitRef changes
                        Clear(ScanDesignStages);
                        Clear(MO);
                        if UnitRef <> '' then begin
                            if MO.Get(UnitRef) then begin
                                Clear(AssemblyHeader);
                                AssemblyHeader.SetFilter("ER - Manufacturing Order No.", MO."No.");
                                if AssemblyHeader.FindFirst() then begin
                                    // i need to fill the ScanDesignStages rec from "Scan Design Stages- ER" table
                                    Rec.TRANSFERFIELDS(ScanDesignStages);
                                    Rec.Insert();
                                    Rec."Item No." := AssemblyHeader."Item No.";
                                    Rec."Design Code" := GetItemDesign(Rec."Item No.");
                                    Rec.Modify();
                                    CurrPage.Update();

                                end;
                            end else begin
                                Clear(AssemblyHeader);
                                AssemblyHeader.SetRange("No.", UnitRef);
                                if AssemblyHeader.FindSet() then begin

                                    Rec."Item No." := AssemblyHeader."Item No.";
                                    Rec."Design Code" := GetItemDesign(Rec."Item No.");
                                    Rec.Modify();
                                    CurrPage.Update();

                                end else begin
                                    SalesUnit.SetFilter("Sales Line Unit", UnitRef);
                                    if SalesUnit.FindFirst() then begin
                                        Clear(SalesLine);
                                        SalesLine.SetFilter("Sales Line Reference", SalesUnit."Sales Line Ref.");
                                        if SalesLine.FindFirst() then begin
                                            Rec."Item No." := SalesLine."No.";
                                            Rec."Design Code" := GetItemDesign(Rec."Item No.");
                                            Rec.Modify();
                                            CurrPage.Update();
                                        end;
                                    END;
                                END;
                            end;
                        end;
                    end;
                }

                field(User; User)
                {
                    ApplicationArea = All;
                    trigger OnValidate()


                    var
                        MasterItemCU: Codeunit MasterItem;
                        AssemblyHeader: Record "Assembly Header";
                        //ScanDesignStages: Record "Scan Design Stages- ER"; // Replace with the actual table name for scan activities
                        Dashboard: Record "Cutting Sheets Dashboard"; // Replace with the actual table name for the dashboard
                        Txt001: Label 'No Assembly found in the group %1';
                        Txt0001: Label 'Scan In 👍';
                        Txt0002: Label 'Scan Out 👍';
                        ScanOption: Option "In","Out";
                        Item: Record Item;
                        WorkflowActivitiesER: Record "Workflow Activities - ER";
                        MO: Record "ER - Manufacturing Order";
                        MaxSequenceNo: Integer;
                        Txt003: Label 'The current sequence number %1 exceeds the maximum sequence number %2 in the scan activities.';
                        SalesLine: Record "Sales Line";
                        SalesUnit: Record "Sales Line Unit Ref.";
                        ProcessedAssemblies: Dictionary of [Code[20], Boolean]; // To track processed assemblies
                        DesignActivities: Record "Design Activities";
                        ScanActivities: Record "Scan Activities";
                        ProcessedSourceNos: Dictionary of [Code[20], Boolean]; // To track processed Source Nos
                        QtyCounter: Integer;
                        AuthToken: Text;
                        ScanDesignStagesER: Record "Scan Design Stages- ER";
                    begin
                        // rec.DeleteAll();
                        QtyCounter := 1;
                        // Initialize the dictionary
                        Clear(ProcessedSourceNos);
                        if UnitRef = '' then
                            Error('You must fill Unit Ref First');
                        DesignCode := '';
                        // Logic to refresh the subpage when UnitRef changes
                        //Clear(ScanDesignStages);
                        Clear(MO);
                        if UnitRef <> '' then begin
                            if MO.Get(UnitRef) then begin
                                Clear(AssemblyHeader);
                                AssemblyHeader.SetFilter("ER - Manufacturing Order No.", MO."No.");
                                if AssemblyHeader.FindFirst() then begin
                                    repeat
                                        // Check if the Source No. has already been processed
                                        if not ProcessedSourceNos.ContainsKey(AssemblyHeader."Source No.") then begin
                                            // Mark the Source No. as processed
                                            ProcessedSourceNos.Add(AssemblyHeader."Source No.", true);

                                            MasterItemCU.CheckUserResponibilityScanning(AssemblyHeader."No.", User, GetSequenceSelected(GetItemDesign(Rec."Item No.")));
                                            Clear(SalesLine);
                                            SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                                            SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                                            if SalesLine.FindSet() then begin
                                                repeat
                                                    // Loop for each quantity in the Sales Line
                                                    SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                                                    if SalesUnit.FindFirst() then begin
                                                        repeat
                                                            Clear(ScanActivities);
                                                            ScanActivities.SetFilter("Sales Line Unit Id.", SalesUnit."Sales Line Unit");
                                                            ScanActivities.SetFilter("Sales Line Id", SalesLine."Sales Line Reference");
                                                            ScanActivities.setrange("Activity Type", ScanActivities."Activity Type"::"In");

                                                            // Check if an "In" activity exists
                                                            if ScanActivities.FindFirst() then begin
                                                                // Insert "Out" activity
                                                                Clear(ScanActivities);
                                                                ScanActivities.Init();
                                                                ScanActivities."Sales Line Unit Id." := SalesUnit."Sales Line Unit";
                                                                ScanActivities."Sales Line Id" := SalesLine."Sales Line Reference";
                                                                ScanActivities."Activity Type" := ScanActivities."Activity Type"::"Out"; // Insert "Out" activity
                                                                ScanActivities."Assembly No." := AssemblyHeader."No.";
                                                                ScanActivities."ER - Manufacturing Order No." := MO."No.";
                                                                ScanActivities."Item No." := SalesLine."No.";
                                                                ScanActivities."Design Code" := GetItemDesign(Rec."Item No.");
                                                                ScanActivities."Variant Code" := AssemblyHeader."Variant Code";
                                                                ScanActivities."Source No." := SalesLine."Document No.";
                                                                ScanActivities."Activity Code" := '';
                                                                ScanActivities."Activity Name" := GetActivityNameSelected(Rec."Design Code");
                                                                ScanActivities."Activity Remark" := '';
                                                                ScanActivities."Activity Date" := CurrentDateTime;
                                                                ScanActivities."Activity Time" := Time;
                                                                ScanActivities.Insert();
                                                                //call api to insert 
                                                                AuthToken := GenerateToken();
                                                                FillRequest(AuthToken, ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec);
                                                                // Delete both "In" and "Out" activities after API call
                                                                Clear(ScanActivities);
                                                                ScanActivities.SetFilter("Sales Line Unit Id.", SalesUnit."Sales Line Unit");
                                                                ScanActivities.SetFilter("Sales Line Id", SalesLine."Sales Line Reference");
                                                                if ScanActivities.FindSet() then
                                                                    ScanActivities.DeleteAll();
                                                                UpdateScanOutField(SalesUnit);
                                                            end else begin
                                                                // Insert "In" activity if no "In" exists
                                                                Clear(ScanActivities);
                                                                ScanActivities.Init();
                                                                ScanActivities."Sales Line Unit Id." := SalesUnit."Sales Line Unit";
                                                                ScanActivities."Sales Line Id" := SalesLine."Sales Line Reference";
                                                                ScanActivities."Activity Type" := ScanActivities."Activity Type"::"In"; // Insert "In" activity
                                                                ScanActivities."Assembly No." := AssemblyHeader."No.";
                                                                ScanActivities."ER - Manufacturing Order No." := MO."No.";
                                                                ScanActivities."Item No." := SalesLine."No.";
                                                                ScanActivities."Design Code" := GetItemDesign(Rec."Item No.");
                                                                ScanActivities."Variant Code" := AssemblyHeader."Variant Code";
                                                                ScanActivities."Source No." := SalesLine."Document No.";
                                                                ScanActivities."Activity Code" := '';
                                                                ScanActivities."Activity Name" := GetActivityNameSelected(Rec."Design Code");
                                                                ScanActivities."Activity Remark" := '';
                                                                ScanActivities."Activity Date" := CurrentDateTime;
                                                                ScanActivities."Activity Time" := Time;
                                                                ScanActivities.Insert();
                                                                //call api to insert 
                                                                AuthToken := GenerateToken();
                                                                FillRequest(AuthToken, ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec);
                                                                // fill scanIn in SalesUnit in order to know which stage are done

                                                                UpdateScanInField(SalesUnit)
                                                            end;
                                                        until SalesUnit.Next() = 0;
                                                    end;
                                                until SalesLine.Next() = 0;
                                            end;
                                        end;
                                    until AssemblyHeader.Next() = 0;
                                end
                            end else begin
                                Clear(AssemblyHeader);
                                AssemblyHeader.SetFilter("No.", UnitRef);
                                if AssemblyHeader.FindFirst() then begin
                                    repeat
                                        // Check if the Source No. has already been processed
                                        if not ProcessedSourceNos.ContainsKey(AssemblyHeader."Source No.") then begin
                                            // Mark the Source No. as processed
                                            ProcessedSourceNos.Add(AssemblyHeader."Source No.", true);

                                            MasterItemCU.CheckUserResponibilityScanning(AssemblyHeader."No.", User, GetSequenceSelected(GetItemDesign(Rec."Item No.")));
                                            Clear(SalesLine);
                                            SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                                            SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                                            if SalesLine.FindSet() then begin
                                                repeat

                                                    // Loop for each quantity in the Sales Line
                                                    SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                                                    if SalesUnit.FindFirst() then begin
                                                        repeat
                                                            Clear(ScanActivities);
                                                            ScanActivities.SetFilter("Sales Line Unit Id.", SalesUnit."Sales Line Unit");
                                                            ScanActivities.SetFilter("Sales Line Id", SalesLine."Sales Line Reference");
                                                            ScanActivities.setrange("Activity Type", ScanActivities."Activity Type"::"In");

                                                            // Check if an "In" activity exists
                                                            if ScanActivities.FindFirst() then begin
                                                                // Insert "Out" activity
                                                                Clear(ScanActivities);
                                                                ScanActivities.Init();
                                                                ScanActivities."Sales Line Unit Id." := SalesUnit."Sales Line Unit";
                                                                ScanActivities."Sales Line Id" := SalesLine."Sales Line Reference";
                                                                ScanActivities."Activity Type" := ScanActivities."Activity Type"::"Out"; // Insert "Out" activity
                                                                ScanActivities."Assembly No." := AssemblyHeader."No.";
                                                                ScanActivities."ER - Manufacturing Order No." := MO."No.";
                                                                ScanActivities."Item No." := SalesLine."No.";
                                                                ScanActivities."Design Code" := GetItemDesign(Rec."Item No.");
                                                                ScanActivities."Variant Code" := AssemblyHeader."Variant Code";
                                                                ScanActivities."Source No." := SalesLine."Document No.";
                                                                ScanActivities."Activity Code" := '';
                                                                ScanActivities."Activity Name" := GetActivityNameSelected(Rec."Design Code");
                                                                ScanActivities."Activity Remark" := '';
                                                                ScanActivities."Activity Date" := CurrentDateTime;
                                                                ScanActivities."Activity Time" := Time;
                                                                ScanActivities.Insert();
                                                            end else begin
                                                                // Insert "In" activity if no "In" exists
                                                                Clear(ScanActivities);
                                                                ScanActivities.Init();
                                                                ScanActivities."Sales Line Unit Id." := SalesUnit."Sales Line Unit";
                                                                ScanActivities."Sales Line Id" := SalesLine."Sales Line Reference";
                                                                ScanActivities."Activity Type" := ScanActivities."Activity Type"::"In"; // Insert "In" activity
                                                                ScanActivities."Assembly No." := AssemblyHeader."No.";
                                                                ScanActivities."ER - Manufacturing Order No." := MO."No.";
                                                                ScanActivities."Item No." := SalesLine."No.";
                                                                ScanActivities."Design Code" := GetItemDesign(Rec."Item No.");
                                                                ScanActivities."Variant Code" := AssemblyHeader."Variant Code";
                                                                ScanActivities."Source No." := SalesLine."Document No.";
                                                                ScanActivities."Activity Code" := '';
                                                                ScanActivities."Activity Name" := GetActivityNameSelected(Rec."Design Code");
                                                                ScanActivities."Activity Remark" := '';
                                                                ScanActivities."Activity Date" := CurrentDateTime;
                                                                ScanActivities."Activity Time" := Time;
                                                                ScanActivities.Insert();
                                                            end;
                                                        until SalesUnit.Next() = 0;
                                                    end;
                                                until SalesLine.Next() = 0;
                                            end
                                        end;
                                    until AssemblyHeader.Next() = 0;
                                end

                                else begin


                                    MasterItemCU.CheckUserResponibilityScanning(AssemblyHeader."No.", User, GetSequenceSelected(GetItemDesign(Rec."Item No.")));

                                    Clear(SalesUnit);
                                    // Loop for each quantity in the Sales Line
                                    SalesUnit.SetFilter("Sales Line Ref.", UnitRef);
                                    if SalesUnit.FindFirst() then begin
                                        repeat
                                            Clear(ScanActivities);
                                            ScanActivities.SetFilter("Sales Line Unit Id.", SalesUnit."Sales Line Unit");
                                            ScanActivities.SetFilter("Sales Line Id", SalesLine."Sales Line Reference");
                                            ScanActivities.setrange("Activity Type", ScanActivities."Activity Type"::"In");

                                            // Check if an "In" activity exists
                                            if ScanActivities.FindFirst() then begin
                                                // Insert "Out" activity
                                                Clear(ScanActivities);
                                                ScanActivities.Init();
                                                ScanActivities."Sales Line Unit Id." := SalesUnit."Sales Line Unit";
                                                ScanActivities."Sales Line Id" := SalesLine."Sales Line Reference";
                                                ScanActivities."Activity Type" := ScanActivities."Activity Type"::"Out"; // Insert "Out" activity
                                                ScanActivities."Assembly No." := AssemblyHeader."No.";
                                                ScanActivities."ER - Manufacturing Order No." := MO."No.";
                                                ScanActivities."Item No." := SalesLine."No.";
                                                ScanActivities."Design Code" := GetItemDesign(Rec."Item No.");
                                                ScanActivities."Variant Code" := AssemblyHeader."Variant Code";
                                                ScanActivities."Source No." := SalesLine."Document No.";
                                                ScanActivities."Activity Code" := '';
                                                ScanActivities."Activity Name" := GetActivityNameSelected(Rec."Design Code");
                                                ScanActivities."Activity Remark" := '';
                                                ScanActivities."Activity Date" := CurrentDateTime;
                                                ScanActivities."Activity Time" := Time;
                                                ScanActivities.Insert();
                                            end else begin
                                                // Insert "In" activity if no "In" exists
                                                Clear(ScanActivities);
                                                ScanActivities.Init();
                                                ScanActivities."Sales Line Unit Id." := SalesUnit."Sales Line Unit";
                                                ScanActivities."Sales Line Id" := SalesLine."Sales Line Reference";
                                                ScanActivities."Activity Type" := ScanActivities."Activity Type"::"In"; // Insert "In" activity
                                                ScanActivities."Assembly No." := AssemblyHeader."No.";
                                                ScanActivities."ER - Manufacturing Order No." := MO."No.";
                                                ScanActivities."Item No." := SalesLine."No.";
                                                ScanActivities."Design Code" := GetItemDesign(Rec."Item No.");
                                                ScanActivities."Variant Code" := AssemblyHeader."Variant Code";
                                                ScanActivities."Source No." := SalesLine."Document No.";
                                                ScanActivities."Activity Code" := '';
                                                ScanActivities."Activity Name" := GetActivityNameSelected(Rec."Design Code");
                                                ScanActivities."Activity Remark" := '';
                                                ScanActivities."Activity Date" := CurrentDateTime;
                                                ScanActivities."Activity Time" := Time;
                                                ScanActivities.Insert();
                                            end;
                                        until SalesUnit.Next() = 0;
                                    end else begin


                                        MasterItemCU.CheckUserResponibilityScanning(AssemblyHeader."No.", User, GetSequenceSelected(GetItemDesign(Rec."Item No.")));

                                        Clear(SalesUnit);
                                        // Loop for each quantity in the Sales Line
                                        SalesUnit.SetFilter("Sales Line Unit", UnitRef);
                                        if SalesUnit.FindFirst() then begin
                                            Clear(ScanActivities);
                                            ScanActivities.SetFilter("Sales Line Unit Id.", SalesUnit."Sales Line Unit");
                                            ScanActivities.SetFilter("Sales Line Id", SalesLine."Sales Line Reference");
                                            ScanActivities.setrange("Activity Type", ScanActivities."Activity Type"::"In");

                                            // Check if an "In" activity exists
                                            if ScanActivities.FindFirst() then begin
                                                // Insert "Out" activity
                                                Clear(ScanActivities);
                                                ScanActivities.Init();
                                                ScanActivities."Sales Line Unit Id." := SalesUnit."Sales Line Unit";
                                                ScanActivities."Sales Line Id" := SalesLine."Sales Line Reference";
                                                ScanActivities."Activity Type" := ScanActivities."Activity Type"::"Out"; // Insert "Out" activity
                                                ScanActivities."Assembly No." := AssemblyHeader."No.";
                                                ScanActivities."ER - Manufacturing Order No." := MO."No.";
                                                ScanActivities."Item No." := SalesLine."No.";
                                                ScanActivities."Design Code" := GetItemDesign(Rec."Item No.");
                                                ScanActivities."Variant Code" := AssemblyHeader."Variant Code";
                                                ScanActivities."Source No." := SalesLine."Document No.";
                                                ScanActivities."Activity Code" := '';
                                                ScanActivities."Activity Name" := GetActivityNameSelected(Rec."Design Code");
                                                ScanActivities."Activity Remark" := '';
                                                ScanActivities."Activity Date" := CurrentDateTime;
                                                ScanActivities."Activity Time" := Time;
                                                ScanActivities.Insert();
                                            end else begin
                                                // Insert "In" activity if no "In" exists
                                                Clear(ScanActivities);
                                                ScanActivities.Init();
                                                ScanActivities."Sales Line Unit Id." := SalesUnit."Sales Line Unit";
                                                ScanActivities."Sales Line Id" := SalesLine."Sales Line Reference";
                                                ScanActivities."Activity Type" := ScanActivities."Activity Type"::"In"; // Insert "In" activity
                                                ScanActivities."Assembly No." := AssemblyHeader."No.";
                                                ScanActivities."ER - Manufacturing Order No." := MO."No.";
                                                ScanActivities."Item No." := SalesLine."No.";
                                                ScanActivities."Design Code" := GetItemDesign(Rec."Item No.");
                                                ScanActivities."Variant Code" := AssemblyHeader."Variant Code";
                                                ScanActivities."Source No." := SalesLine."Document No.";
                                                ScanActivities."Activity Code" := '';
                                                ScanActivities."Activity Name" := GetActivityNameSelected(Rec."Design Code");
                                                ScanActivities."Activity Remark" := '';
                                                ScanActivities."Activity Date" := CurrentDateTime;
                                                ScanActivities."Activity Time" := Time;
                                                ScanActivities.Insert();
                                            end;
                                        end;
                                    end;

                                end;
                            end;
                        end;
                    end;
                }
            }
            part(DesignActivityStagesPart; "Design Activities Temp")
            {

                // SubPageLink updated to use a valid field from the Design Activities table
                SubPageLink = "Design Code" = field("Design Code");
                SubPageView = sorting("Sequence No.");
                Editable = true;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // action(ActionName)
            // {
            //     trigger OnAction()
            //     var
            //         Token: Text;
            //     begin
            //         Token := GenerateToken();
            //         FillRequest(Token);
            //     end;
            // }
        }
    }
    local procedure GetItemDesign(ItemNo: Code[20]): Code[50]
    var
        myInt: Integer;
        Item: Record Item;
    begin
        Clear(Item);
        Item.get(ItemNo);
        exit(Item."Design Code");
    end;

    local procedure ResetDesignActivitiesToScan()
    var
        DesignActivities: Record "Design Activities";
    begin
        Clear(DesignActivities);
        if DesignActivities.FindSet() then
            repeat
                DesignActivities."To Scan" := false;
                DesignActivities.Modify();
            until DesignActivities.Next() = 0;
    end;

    local procedure GetActivityNameSelected(DesignCode: code[50]): Text[100]
    var
        myInt: Integer;
        DesignActivities: Record "Design Activities";
    begin
        Clear(DesignActivities);
        DesignActivities.SetFilter("Design Code", DesignCode);
        DesignActivities.SetRange("To Scan", true);
        if DesignActivities.FindFirst() then
            exit(DesignActivities."Activity Name");

    end;

    local procedure GetSequenceSelected(DesignCode: code[50]): Integer
    var
        myInt: Integer;
        DesignActivities: Record "Design Activities";
    begin
        Clear(DesignActivities);
        DesignActivities.SetFilter("Design Code", DesignCode);
        DesignActivities.SetRange("To Scan", true);
        if DesignActivities.FindFirst() then
            exit(DesignActivities."Sequence No.");

    end;

    local procedure UpdateScanInField(SalesUnitRef: Record "Sales Line Unit Ref.")
    var
        DesignActivitiesTemp: Record "Design Activities Temp";
        ScanDesignStagesER: Record "Scan Design Stages- ER";
        SequenceNo: Integer;
        CurrentScanIn: Text;
    begin
        Clear(DesignActivitiesTemp);
        Clear(ScanDesignStagesER);
        rec.CalcFields("Activity Selected");
        ScanDesignStagesER.SetFilter("Activity Name", rec."Activity Selected");
        if ScanDesignStagesER.FindFirst() then begin
            // Get the current value of "Scan In"
            CurrentScanIn := SalesUnitRef."Scan In";

            // Append the current activity index to "Scan In"
            if CurrentScanIn = '' then
                CurrentScanIn := '{' + Format(ScanDesignStagesER."Index") + '}'
            else
                CurrentScanIn := StrSubstNo('%1,%2', CurrentScanIn.TrimEnd('}'), Format(ScanDesignStagesER."Index")) + '}';

            // Update the "Scan In" field
            SalesUnitRef."Scan In" := CurrentScanIn;
            SalesUnitRef.Modify();
           
        end;

    end;

    local procedure UpdateScanOutField(SalesUnitRef: Record "Sales Line Unit Ref.")
    var
        DesignActivitiesTemp: Record "Design Activities Temp";
        ScanDesignStagesER: Record "Scan Design Stages- ER";
        SequenceNo: Integer;
        CurrentScanOut: Text;
    begin
        Clear(DesignActivitiesTemp);
        Clear(ScanDesignStagesER);
        rec.CalcFields("Activity Selected");
        ScanDesignStagesER.SetFilter("Activity Name", rec."Activity Selected");
        if ScanDesignStagesER.FindFirst() then begin
        
                // Get the current value of "Scan Out"
                CurrentScanOut := SalesUnitRef."Scan Out";

                // Append the current activity index to "Scan Out"
                if CurrentScanOut = '' then
                    CurrentScanOut := '{' + Format(ScanDesignStagesER."Index") + '}'
                else
                    CurrentScanOut := StrSubstNo('%1,%2', CurrentScanOut.TrimEnd('}'), Format(ScanDesignStagesER."Index")) + '}';

                // Update the "Scan Out" field
                SalesUnitRef."Scan Out" := CurrentScanOut;
                SalesUnitRef.Modify();
             
            end;
        end;
   

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
            JsonResponse.ReadFrom('{"status": "success","message": "Connected.","data": {"token": "166044c5cf3a83e0c2d135aee14b91a0"}}');
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


    local procedure FillRequest(Token: Text; ScanRec: Record "Scan Activities"; SalesUnitRec: Record "Sales Line Unit Ref."; AssemblyHeaderRec: Record "Assembly Header"; MO: Record "ER - Manufacturing Order"; SalesLineRec: Record "Sales Line"; Rec: Record "Scan Design Stages- ER Temp")
    var

        ScanDetails: JsonObject;
        ItemCustomAttributes: JsonArray;
        CustomAttributes: JsonObject;
        txt: Text;
        Item: Record Item;
        HttpClient: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        ResponseMsg: Text;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        Authorization: Label 'Authorization';
        QueryFieldFilter: label 'searchCriteria%5BfilterGroups%5D%5B0%5D%5Bfilters%5D%5B0%5D%5Bfield%5D';
        QueryValueFilter: Label 'searchCriteria%5BfilterGroups%5D%5B0%5D%5Bfilters%5D%5B0%5D%5Bvalue%5D';
        QuestMark: Label '?';
        BSlach: Label '/';
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
        Result: Text;
        tempblob: Codeunit "Temp Blob";
        Payload: JsonObject;
        RootObject: JsonObject;
        DataArray: JsonArray;
    begin

        Clear(ScanDetails);
        Clear(RootObject);
        Clear(DataArray);
        Clear(txt);

        // Build the JSON object (1 item)
        ScanDetails.Add('sales_line_unit_id', SalesUnitRec."Sales Line Unit" + 'r3wqty2ws7w7');
        ScanDetails.Add('sales_line_id', SalesLineRec."Sales Line Reference");
        ScanDetails.Add('assembly_no', AssemblyHeaderRec."No.");
        ScanDetails.Add('mo_no', MO."No.");
        ScanDetails.Add('item_code', AssemblyHeaderRec."Item No.");
        ScanDetails.Add('design_code', GetActivityNameSelected(Rec."Design Code"));
        ScanDetails.Add('variant_code', AssemblyHeaderRec."Variant Code");
        ScanDetails.Add('so_no', SalesLineRec."Document No.");
        ScanDetails.Add('activity_code', '');
        ScanDetails.Add('activity_name', '');
        ScanDetails.Add('activity_remark', '');
        ScanDetails.Add('activity_type', Format(ScanRec."Activity Type"));
        ScanDetails.Add('activity_date', '2025-05-06 10:30:00');
        ScanDetails.Add('activity_time', 3); // Use integer here if the API expects a number



        // Add the ScanDetails object to the array
        DataArray.Add(ScanDetails);

        // Wrap it inside a 'data' array
        RootObject.Add('data', DataArray);

        // Convert RootObject to JSON text
        RootObject.WriteTo(txt);

        Content.Clear();
        Content.GetHeaders(ContentHeaders);
        Content.WriteFrom(txt);
        ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/json');

        Request.Content(Content);
        Request.Method('POST');

        HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('Authorization', Token);
        Request.SetRequestUri('https://portal.emilerassam.com/api/core/scan/');

        if HttpClient.Send(Request, Response) then begin
            if Response.HttpStatusCode = 200 then begin
                Response.Content.ReadAs(ResponseMsg);
                Message('Response: %1', ResponseMsg);
            end else
                Error('HTTP Error: %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase());
        end else
            Error('Failed to send the HTTP request.');


    end;



    var
        UnitRef: Code[50];
        User: Code[50];
        DesignCode: code[50];
        rep: Codeunit ReportManagement;
}