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
                field(User; User)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        MasterItemCU: Codeunit MasterItem;
                        AssemblyHeader: Record "Assembly Header";
                        ScanDesignStages: Record "Scan Design Stages- ER";
                        Dashboard: Record "Cutting Sheets Dashboard";
                        Txt001: Label 'No Assembly found in the group %1';
                        ScanOption: Option "In","Out";
                        Item: Record Item;
                        WorkflowActivitiesER: Record "Workflow Activities - ER";
                        MO: Record "ER - Manufacturing Order";
                        MaxSequenceNo: Integer;
                        Txt003: Label 'The current sequence number %1 exceeds the maximum sequence number %2 in the scan activities.';
                        SalesLine: Record "Sales Line";
                        SalesUnit: Record "Sales Line Unit Ref.";
                        ProcessedAssemblies: Dictionary of [Code[20], Boolean];
                        DesignActivities: Record "Scan Design Stages- ER";
                        Status: Text[10];
                        FoundMissing: Boolean;
                        Token: Text;
                    begin
                        Rec.DeleteAll();
                    end;
                }


                field(UnitRef; UnitRef)
                {
                    ApplicationArea = All;
                    Caption = 'Scanning Reference';
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        MasterItemCU: Codeunit MasterItem;
                        WorkFlowMember: Record "Workflow User Memb-Scan";
                        AssemblyHeader: Record "Assembly Header";
                        ScanDesignStages: Record "Scan Design Stages- ER";
                        Dashboard: Record "Cutting Sheets Dashboard";
                        Txt001: Label 'No Assembly found in the group %1';
                        ScanOption: Option "In","Out";
                        Item: Record Item;
                        WorkflowActivitiesER: Record "Workflow Activities - ER";
                        MO: Record "ER - Manufacturing Order";
                        MaxSequenceNo: Integer;
                        Txt003: Label 'The current sequence number %1 exceeds the maximum sequence number %2 in the scan activities.';
                        SalesLine: Record "Sales Line";
                        SalesUnit: Record "Sales Line Unit Ref.";
                        ProcessedAssemblies: Dictionary of [Code[20], Boolean];
                        DesignActivities: Record "Scan Design Stages- ER Temp";
                        DesignActivity: Record "Design Activities";
                        Status: Text[10];
                        FoundMissing: Boolean;
                        Token: Text;
                        ReservationEntry: Record "Reservation Entry";
                        ScanStages: Record "Scan Design Stages- ER";
                    begin
                        DeleteExistingScans();
                        Clear(ScanDesignStages);
                        Clear(MO);
                        Clear(ScanStages);
                        if UnitRef <> '' then begin
                            Rec."Unit Ref" := UnitRef;
                            CurrPage.Update(true);
                            if MO.Get(UnitRef) then begin
                                //fill existing scan
                                Token := GenerateToken();
                                FillExistingScanHistoryForMO(UnitRef, Token);
                                Clear(AssemblyHeader);
                                AssemblyHeader.SetFilter("ER - Manufacturing Order No.", MO."No.");
                                if AssemblyHeader.FindFirst() then begin
                                    ResetDesignActivitiesDone;
                                    ResetScanActivitiesToView;
                                    rec.DeleteAll();

                                    Clear(WorkFlowMember);
                                    WorkFlowMember.SetFilter(Name, User);
                                    if WorkFlowMember.FindSet() then
                                        repeat
                                            DesignActivity.SetFilter("Activity Code", WorkFlowMember."Activity Code");
                                            DesignActivity.SetFilter("Design Code", GetItemDesign(AssemblyHeader."Item No."));
                                            if DesignActivity.FindSet() then
                                                repeat
                                                    if ScanStages.Get(DesignActivity."Activity Code") then begin
                                                        if (AssemblyHeader."Source No." = '') and (ScanStages."Sales Related Stage") then
                                                            break;
                                                    end;
                                                    Rec.Init();
                                                    Rec."Activity Code" := WorkFlowMember."Activity Code";
                                                    WorkFlowMember.CalcFields("Activity Name");
                                                    Rec."Activity Name" := WorkFlowMember."Activity Name";
                                                    Rec.Done := '❌';
                                                    Rec."Design Code" := GetItemDesign(AssemblyHeader."Item No.");
                                                    Rec."Sequence No." := DesignActivity."Sequence No.";
                                                    Rec."Allow Non-Sequential Scanning" := DesignActivity."Allow Non-Sequential Scanning";
                                                    Rec."Stage Type" := DesignActivity."Stage Type";
                                                    Rec.Scanned := false;
                                                    Rec."User Name" := User;
                                                    Rec.Insert();
                                                until DesignActivity.Next() = 0;
                                        until WorkFlowMember.Next() = 0;
                                    // i need here to go through every line and check on sales unit ref if for example coloring on table Scan Design Stages- ER List is 1 to check in salesunit line if the scan out is {1} to fill the done field on the line by ✅
                                    Clear(DesignActivities);
                                    Clear(ScanDesignStages);
                                    //rec.CalcFields("Design Code");
                                    DesignActivities.SetFilter("Design Code", Rec."Design Code");
                                    if DesignActivities.FindSet() then begin
                                        repeat
                                            // Get the ScanDesignStages record for the current activity
                                            ScanDesignStages.setfilter("Activity Code", DesignActivities."Activity Code");
                                            if ScanDesignStages.FindFirst() then begin

                                                // Initialize as ✅ first
                                                Status := '✅';
                                                FoundMissing := false; // Boolean flag to track if any SalesUnit is missing the index

                                                // Loop Sales Lines
                                                SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                                                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                                                SalesLine.SetRange("Line No.", AssemblyHeader."Source Line No.");
                                                if SalesLine.FindSet() then begin
                                                    repeat
                                                        // Loop Sales Units for the Sales Line
                                                        SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                                                        if SalesUnit.FindFirst() then begin
                                                            repeat
                                                                // Check if Scan Out contains the index
                                                                if STRPOS(SalesUnit."Scan Out", Format(ScanDesignStages."Activity Code")) = 0 then begin
                                                                    // Found a missing index -> mark as ❌
                                                                    Status := '❌';
                                                                    FoundMissing := true;
                                                                    break; // exit SalesUnit loop
                                                                end;
                                                            until SalesUnit.Next() = 0;

                                                            if FoundMissing then
                                                                break; // exit SalesLine loop
                                                        end else begin
                                                            // No SalesUnit found for this SalesLine, set status to ❓
                                                            Status := '❓';
                                                        end;
                                                    until SalesLine.Next() = 0;
                                                end else begin

                                                    SalesUnit.SetFilter("Sales Line Ref.", AssemblyHeader."Assembly Reference");
                                                    if SalesUnit.FindFirst() then begin
                                                        // Assume not found
                                                        Status := '❌';
                                                        repeat
                                                            // If any SalesUnit contains the activity code, mark as ✅ and exit loop
                                                            if STRPOS(SalesUnit."Scan Out", Format(DesignActivities."Activity Code")) <> 0 then begin
                                                                Status := '✅';
                                                                break; // found, no need to check further
                                                            end;
                                                        until SalesUnit.Next() = 0;
                                                    end else begin
                                                        // No SalesUnit found for this SalesLine, set status to ❓
                                                        Status := '❓';
                                                    end;


                                                end;

                                                // After processing all, set the status
                                                DesignActivities.Done := Status;
                                                if DesignActivities.Done = '✅' then
                                                    DesignActivities.Scanned := true;
                                                DesignActivities.Modify();

                                            end;
                                        until DesignActivities.Next() = 0;
                                    end;

                                end
                            end else begin
                                Clear(AssemblyHeader);
                                AssemblyHeader.SetFilter("No.", UnitRef);
                                if AssemblyHeader.FindFirst() then begin
                                    Rec."Unit Ref" := UnitRef;
                                    CurrPage.Update(true);
                                    ResetDesignActivitiesDone;
                                    ResetScanActivitiesToView;
                                    Rec.DeleteAll();
                                    Token := GenerateToken();
                                    FillExistingScanHistoryforAssembly(UnitRef, Token);
                                    Clear(WorkFlowMember);
                                    WorkFlowMember.SetFilter(Name, User);
                                    if WorkFlowMember.FindSet() then
                                        repeat
                                            DesignActivity.SetFilter("Activity Code", WorkFlowMember."Activity Code");
                                            DesignActivity.SetFilter("Design Code", GetItemDesign(AssemblyHeader."Item No."));
                                            if DesignActivity.FindSet() then
                                                repeat
                                                    Rec.Init();
                                                    Rec."Activity Code" := WorkFlowMember."Activity Code";
                                                    WorkFlowMember.CalcFields("Activity Name");
                                                    Rec."Activity Name" := WorkFlowMember."Activity Name";
                                                    Rec.Done := '❌';
                                                    Rec."Design Code" := GetItemDesign(AssemblyHeader."Item No.");
                                                    Rec."Sequence No." := DesignActivity."Sequence No.";
                                                    Rec."Allow Non-Sequential Scanning" := DesignActivity."Allow Non-Sequential Scanning";
                                                    Rec."Stage Type" := DesignActivity."Stage Type";
                                                    Rec.Scanned := false;
                                                    Rec."User Name" := User;
                                                    Rec.Insert();
                                                until DesignActivity.Next() = 0;
                                        until WorkFlowMember.Next() = 0;

                                    Clear(DesignActivities);
                                    Clear(ScanDesignStages);
                                    //rec.CalcFields("Design Code");
                                    DesignActivities.SetFilter("Design Code", Rec."Design Code");
                                    if DesignActivities.FindSet() then begin
                                        repeat
                                            // Get the ScanDesignStages record for the current activity
                                            ScanDesignStages.setfilter("Activity Code", DesignActivities."Activity Code");
                                            if ScanDesignStages.FindFirst() then begin

                                                // Initialize as ✅ first
                                                Status := '✅';
                                                FoundMissing := false; // Boolean flag to track if any SalesUnit is missing the index

                                                // Loop Sales Lines
                                                SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                                                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                                                SalesLine.SetRange("Line No.", AssemblyHeader."Source Line No.");
                                                if SalesLine.FindSet() then begin
                                                    repeat
                                                        // Loop Sales Units for the Sales Line
                                                        SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                                                        if SalesUnit.FindFirst() then begin
                                                            repeat
                                                                // Check if Scan Out contains the index
                                                                if STRPOS(SalesUnit."Scan Out", Format(ScanDesignStages."Activity Code")) = 0 then begin
                                                                    // Found a missing index -> mark as ❌
                                                                    Status := '❌';
                                                                    FoundMissing := true;
                                                                    break; // exit SalesUnit loop
                                                                end;
                                                            until SalesUnit.Next() = 0;

                                                            if FoundMissing then
                                                                break; // exit SalesLine loop
                                                        end;
                                                    until SalesLine.Next() = 0;
                                                end else begin
                                                    // Loop Sales Units for the Sales Line
                                                    SalesUnit.SetFilter("Sales Line Ref.", AssemblyHeader."Assembly Reference");
                                                    if SalesUnit.FindFirst() then begin
                                                        repeat
                                                            // Check if Scan Out contains the index
                                                            if STRPOS(SalesUnit."Scan Out", Format(ScanDesignStages."Activity Code")) = 0 then begin
                                                                // Found a missing index -> mark as ❌
                                                                Status := '❌';
                                                                FoundMissing := true;
                                                                break; // exit SalesUnit loop
                                                            end;
                                                        until SalesUnit.Next() = 0;

                                                        if FoundMissing then
                                                            break; // exit SalesLine loop
                                                    end;
                                                end;

                                                // After processing all, set the status
                                                DesignActivities.Done := Status;
                                                if DesignActivities.Done = '✅' then
                                                    DesignActivities.Scanned := true;
                                                DesignActivities.Modify();
                                            end;
                                        until DesignActivities.Next() = 0;
                                    end;
                                end else begin
                                    Status := '✅';
                                    FoundMissing := false;

                                    //MasterItemCU.CheckUserResponibilityScanning(GetActivitySelected, User);

                                    Clear(SalesUnit);
                                    // Loop for each quantity in the Sales Line
                                    SalesUnit.SetFilter("Sales Line Ref.", UnitRef);
                                    if SalesUnit.FindFirst() then begin
                                        Token := GenerateToken();
                                        FillExistingScanHistoryforSalesLineRef(UnitRef, Token);
                                        repeat
                                            // Check if Scan Out contains the index
                                            if STRPOS(SalesUnit."Scan Out", Format(ScanDesignStages."Activity Code")) = 0 then begin
                                                // Found a missing index -> mark as ❌
                                                Status := '❌';
                                                FoundMissing := true;
                                                break; // exit SalesUnit loop
                                            end;
                                        until SalesUnit.Next() = 0;

                                        // After processing all, set the status
                                        DesignActivities.Done := Status;
                                        if DesignActivities.Done = '✅' then
                                            DesignActivities.Scanned := true;
                                        DesignActivities.Modify();

                                    end else begin

                                        Rec."Unit Ref" := UnitRef;
                                        CurrPage.Update(true);
                                        ResetDesignActivitiesDone;
                                        ResetScanActivitiesToView;
                                        Rec.DeleteAll();
                                        Clear(SalesUnit);
                                        SalesUnit.SetFilter("Serial No.", UnitRef);
                                        if SalesUnit.FindFirst() then begin
                                            // SalesUnit.SetFilter("Sales Line Unit", UnitRef);
                                            // if SalesUnit.FindFirst() then begin
                                            Token := GenerateToken();
                                            FillExistingScanHistoryforSalesLineUnit(UnitRef, Token);

                                            Clear(SalesLine);
                                            SalesLine.SetFilter("Sales Line Reference", SalesUnit."Sales Line Ref.");
                                            if SalesLine.FindFirst() then begin
                                                // Rec."Item No." := SalesLine."No.";
                                                // Rec."Design Code" := GetItemDesign(Rec."Item No.");
                                                // Rec.Modify();
                                                Clear(WorkFlowMember);
                                                WorkFlowMember.SetFilter(Name, User);
                                                if WorkFlowMember.FindSet() then
                                                    repeat
                                                        DesignActivity.SetFilter("Activity Code", WorkFlowMember."Activity Code");
                                                        DesignActivity.SetFilter("Design Code", GetItemDesign(SalesLine."No."));
                                                        if DesignActivity.FindSet() then
                                                            repeat
                                                                Rec.Init();
                                                                Rec."Activity Code" := WorkFlowMember."Activity Code";
                                                                WorkFlowMember.CalcFields("Activity Name");
                                                                Rec."Activity Name" := WorkFlowMember."Activity Name";
                                                                Rec.Done := '❌';
                                                                Rec."Design Code" := GetItemDesign(SalesLine."No.");
                                                                Rec."Sequence No." := DesignActivity."Sequence No.";
                                                                Rec."Allow Non-Sequential Scanning" := DesignActivity."Allow Non-Sequential Scanning";
                                                                Rec."Stage Type" := DesignActivity."Stage Type";
                                                                Rec.Scanned := false;
                                                                Rec."User Name" := User;
                                                                Rec.Insert();
                                                            until DesignActivity.Next() = 0;
                                                    until WorkFlowMember.Next() = 0;
                                                Clear(DesignActivities);
                                                Clear(ScanDesignStages);
                                                //rec.CalcFields("Design Code");
                                                DesignActivities.SetFilter("Design Code", Rec."Design Code");
                                                if DesignActivities.FindSet() then begin
                                                    repeat
                                                        // Get the ScanDesignStages record for the current activity
                                                        ScanDesignStages.setfilter("Activity Code", DesignActivities."Activity Code");
                                                        if ScanDesignStages.FindFirst() then begin
                                                            // Default to ❌
                                                            Status := '❌';
                                                            // Loop Sales Units for the Sales Line
                                                            SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                                                            if SalesUnit.FindFirst() then begin
                                                                repeat
                                                                    // If any SalesUnit's Scan Out contains the activity code, mark as ✅ and break
                                                                    if STRPOS(SalesUnit."Scan Out", Format(ScanDesignStages."Activity Code")) <> 0 then begin
                                                                        Status := '✅';
                                                                        break;
                                                                    end;
                                                                until SalesUnit.Next() = 0;
                                                            end else begin
                                                                // No SalesUnit found for this SalesLine, set status to ❓
                                                                Status := '❓';
                                                            end;
                                                        end;
                                                        // After processing all, set the status
                                                        DesignActivities.Done := Status;
                                                        if DesignActivities.Done = '✅' then
                                                            DesignActivities.Scanned := true;
                                                        DesignActivities.Modify();
                                                    until DesignActivities.Next() = 0;
                                                end;
                                            end;
                                        end;
                                    end;

                                end;
                            end;
                        end
                    end;

                }



                field(Activity_Remark; Activity_Remark)
                {
                    Caption = 'Activity Remark';

                }
                field(Activity; ActivityCode)
                {
                    ApplicationArea = All;
                    Caption = 'Activity Code';
                    TableRelation = "Workflow User Memb-Scan"."Activity Code" where(Name = field("User Name"));
                    trigger OnValidate()
                    var
                        MasterItemCU: Codeunit MasterItem;
                        AssemblyHeader: Record "Assembly Header";
                        Txt001: Label 'No Assembly found in the group %1';
                        ScanOption: Option "In","Out";
                        WorkflowActivitiesER: Record "Workflow Activities - ER";
                        MO: Record "ER - Manufacturing Order";
                        SalesLine: Record "Sales Line";
                        SalesLineUnitToken: JsonToken;
                        SalesUnit: Record "Sales Line Unit Ref.";
                        ProcessedAssemblies: Dictionary of [Code[20], Boolean]; // To track processed assemblies
                        DesignActivities: Record "Design Activities";
                        ScanActivities: Record "Scan Activities";
                        ProcessedSourceNos: Dictionary of [Code[20], Boolean]; // To track processed Source Nos
                        AuthToken: Text;
                        ScanDesignStagesER: Record "Scan Design Stages- ER";
                        RequestSucsessed: Boolean;
                        ActivitiesArray: JsonArray;
                        i: Integer;
                        ActivityObj: JsonObject;
                        ActivityType: Text;
                        ActivityTypeToken: JsonToken;
                        ActivityToken: JsonToken;
                        SalesLineUnitId: Code[20];
                        InScan: Record "Scan Activities";
                        OutScan: Record "Scan Activities";
                        DeletedCount: Integer;
                    // ScanActivities: Record "Scan Activities";
                    begin

                        CheckIfScanningActivityAllowed;
                        //check if on "Scan Design Stages- ER"; is scanned to give an error already scanned
                        CheckIfActivityScanned;
                        if (UnitRef = '') or (User = '') then
                            Error('Please fill Mandatory Fields');
                        //check if its assemble to stock so he cannot scan for example packaging stage
                        CheckIfitsAssembleToStock;
                        AuthToken := '';
                        Clear(ProcessedSourceNos);
                        Clear(ActivitiesArray);
                        DesignCode := '';
                        Clear(MO);
                        // CASE 1: Manufacturing Order
                        if MO.Get(UnitRef) then begin
                            Clear(AssemblyHeader);
                            AssemblyHeader.SetFilter("ER - Manufacturing Order No.", MO."No.");
                            if AssemblyHeader.FindFirst() then begin
                                repeat
                                    if not ProcessedSourceNos.ContainsKey(AssemblyHeader."Source No.") then begin
                                        ProcessedSourceNos.Add(AssemblyHeader."Source No.", true);
                                        MasterItemCU.CheckUserResponibilityScanning(GetActivitySelected, User);
                                        Clear(SalesLine);
                                        SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                                        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                                        SalesLine.SetRange("Line No.", AssemblyHeader."Source Line No.");
                                        if SalesLine.FindSet() then begin
                                            repeat
                                                SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                                                if SalesUnit.FindFirst() then begin
                                                    repeat
                                                        IF (STRPOS(SalesUnit."Scan In", ActivityCode) = 0) or (STRPOS(SalesUnit."Scan Out", ActivityCode) = 0) then
                                                            HandleScanActivity(SalesLine, SalesUnit, AssemblyHeader, MO, Rec, ActivitiesArray);
                                                    until SalesUnit.Next() = 0;
                                                end;
                                            until SalesLine.Next() = 0;
                                        end else begin

                                            SalesUnit.SetFilter("Sales Line Ref.", AssemblyHeader."Assembly Reference");
                                            if SalesUnit.FindFirst() then begin
                                                repeat
                                                    IF (STRPOS(SalesUnit."Scan In", ActivityCode) = 0) or (STRPOS(SalesUnit."Scan Out", ActivityCode) = 0) then
                                                        HandleScanActivity(SalesLine, SalesUnit, AssemblyHeader, MO, Rec, ActivitiesArray);
                                                until SalesUnit.Next() = 0;
                                            end;

                                        end;


                                    end;
                                until AssemblyHeader.Next() = 0;
                            end;

                        end
                        // CASE 2: Assembly Header
                        else begin
                            Clear(AssemblyHeader);
                            AssemblyHeader.SetFilter("No.", UnitRef);
                            if AssemblyHeader.FindFirst() then begin
                                if not ProcessedSourceNos.ContainsKey(AssemblyHeader."Source No.") then begin
                                    ProcessedSourceNos.Add(AssemblyHeader."Source No.", true);
                                    MasterItemCU.CheckUserResponibilityScanning(GetActivitySelected, User);
                                    Clear(SalesLine);
                                    SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                                    SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                                    SalesLine.SetRange("Line No.", AssemblyHeader."Source Line No.");
                                    if SalesLine.FindSet() then begin
                                        repeat
                                            SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference Text");
                                            if SalesUnit.FindFirst() then begin
                                                repeat
                                                    IF (STRPOS(SalesUnit."Scan In", ActivityCode) = 0) or (STRPOS(SalesUnit."Scan Out", ActivityCode) = 0) then
                                                        HandleScanActivity(SalesLine, SalesUnit, AssemblyHeader, MO, Rec, ActivitiesArray);
                                                until SalesUnit.Next() = 0;
                                            end;
                                        until SalesLine.Next() = 0;
                                    end else begin
                                        SalesUnit.SetFilter("Sales Line Ref.", AssemblyHeader."Assembly Reference");
                                        if SalesUnit.FindFirst() then begin
                                            repeat
                                                IF (STRPOS(SalesUnit."Scan In", ActivityCode) = 0) or (STRPOS(SalesUnit."Scan Out", ActivityCode) = 0) then
                                                    HandleScanActivity(SalesLine, SalesUnit, AssemblyHeader, MO, Rec, ActivitiesArray);
                                            until SalesUnit.Next() = 0;
                                        end;
                                    end;
                                end
                            end
                            // CASE 3: Sales Line Ref
                            else begin
                                MasterItemCU.CheckUserResponibilityScanning(GetActivitySelected, User);
                                Clear(SalesUnit);
                                SalesUnit.SetFilter("Sales Line Ref.", UnitRef);
                                if SalesUnit.FindFirst() then begin
                                    repeat
                                        IF (STRPOS(SalesUnit."Scan In", ActivityCode) = 0) or (STRPOS(SalesUnit."Scan Out", ActivityCode) = 0) then begin
                                            GetSalesLineFromSalesUnit(SalesUnit, SalesLine);
                                            HandleScanActivity(SalesLine, SalesUnit, AssemblyHeader, MO, Rec, ActivitiesArray);
                                        end;
                                    until SalesUnit.Next() = 0;
                                end
                                // CASE 4: Sales Line Unit Ref
                                else begin
                                    MasterItemCU.CheckUserResponibilityScanning(GetActivitySelected, User);
                                    Clear(SalesUnit);
                                    SalesUnit.SetFilter("Serial No.", UnitRef);
                                    if SalesUnit.FindFirst() then begin
                                        IF (STRPOS(SalesUnit."Scan In", ActivityCode) = 0) or (STRPOS(SalesUnit."Scan Out", ActivityCode) = 0) then begin
                                            GetSalesLineFromSalesUnit(SalesUnit, SalesLine);
                                            HandleScanActivity(SalesLine, SalesUnit, AssemblyHeader, MO, Rec, ActivitiesArray);
                                        end;
                                    end

                                end;
                            end;
                        end;


                        // Batch API call
                        if ActivitiesArray.Count > 0 then begin
                            AuthToken := '';
                            AuthToken := GenerateToken();
                            RequestSucsessed := FillBatchRequest(AuthToken, ActivitiesArray);
                            if RequestSucsessed then begin
                                // i need here to fetch in scan activities to delete every out scan has an in scan to delete thme both for example if we have just in to skip it
                                if not RequestSucsessed then
                                    Error('API Error: Scanning not completed. Please check the API response.');
                                DeletedCount := 0;
                                // Loop through all "In" scan activities
                                ScanActivities.SetRange("Activity Type", ScanActivities."Activity Type"::"In");
                                if ScanActivities.FindSet() then
                                    repeat
                                        // Try to find a matching "Out" scan for the same Sales Line Unit and Activity Code
                                        OutScan.Reset();
                                        OutScan.SetRange("Activity Type", OutScan."Activity Type"::"Out");
                                        OutScan.SetRange("Serial No.", ScanActivities."Serial No.");
                                        OutScan.SetRange("Activity Code", ScanActivities."Activity Code");
                                        if OutScan.FindFirst() then begin
                                            // Delete both "In" and "Out" scans
                                            ScanActivities.Delete();
                                            OutScan.Delete();
                                            DeletedCount += 2;
                                        end;
                                    until ScanActivities.Next() = 0;
                                User := '';
                                UnitRef := '';
                                ActivityCode := '';
                                Activity_Remark := '';
                                ResetScanActivitiesToView;
                                Rec."User Name" := '';
                                Rec.Modify();


                            end
                        end;
                    end;

                }
            }
            part(DesignActivityStagesPart; "Design Activities Temp")
            {
                Editable = true;
            }
        }
        area(FactBoxes)
        {
            part(ExistingScansPart; "Existing Scans")
            {
                //SubPageLink = "Unit Ref" = field("Unit Ref");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {

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

    local procedure ResetDesignActivitiesDone()
    var
        DesignActivities: Record "Scan Design Stages- ER";
    begin
        Clear(DesignActivities);
        if DesignActivities.FindSet() then
            repeat
                DesignActivities.Done := '❌';
                DesignActivities.Scanned := false;
                DesignActivities.Modify();
            until DesignActivities.Next() = 0;
    end;

    local procedure ResetScanActivitiesToView()
    var
        DesignActivities: Record "Scan Design Stages- ER";
    begin
        Clear(DesignActivities);
        if DesignActivities.FindSet() then
            repeat
                DesignActivities."To View" := false;
                // DesignActivities.Done := '';
                DesignActivities.Modify();
            until DesignActivities.Next() = 0;
    end;


    local procedure GetActivitySelected(): Code[50]
    var

    begin
        if ActivityCode <> '' then
            exit(ActivityCode);

    end;

    local procedure GetActivityName(ActivityCode: Code[50]): Text[250]
    var
        ScanDesignStagesER: Record "Scan Design Stages- ER";
    begin
        Clear(ScanDesignStagesER);
        ScanDesignStagesER.Get(ActivityCode);
        exit(ScanDesignStagesER."Activity Name");
    end;

    local procedure UpdateScanInField(SalesUnitRef: Record "Sales Line Unit Ref.")
    var
        ScanDesignStagesER: Record "Scan Design Stages- ER";
        SequenceNo: Integer;
        CurrentScanIn: Text;
    begin
        Clear(ScanDesignStagesER);
        //rec.CalcFields("Activity Selected");
        ScanDesignStagesER.SetFilter("Activity Code", ActivityCode);
        if ScanDesignStagesER.FindFirst() then begin
            // Get the current value of "Scan In"
            CurrentScanIn := SalesUnitRef."Scan In";

            // Append the current activity index to "Scan In"
            if CurrentScanIn = '' then
                CurrentScanIn := '{' + Format(ScanDesignStagesER."Activity Code") + '}'
            else
                CurrentScanIn := StrSubstNo('%1,%2', CurrentScanIn.TrimEnd('}'), Format(ScanDesignStagesER."Activity Code")) + '}';

            // Update the "Scan In" field
            SalesUnitRef."Scan In" := CurrentScanIn;
            SalesUnitRef.Modify();

        end;

    end;

    local procedure UpdateScanOutField(SalesUnitRef: Record "Sales Line Unit Ref.")
    var
        //   DesignActivitiesTemp: Record "Design Activities Temp";
        ScanDesignStagesER: Record "Scan Design Stages- ER";
        SequenceNo: Integer;
        CurrentScanOut: Text;
    begin
        Clear(ScanDesignStagesER);
        // rec.CalcFields("Activity Selected");
        ScanDesignStagesER.SetFilter("Activity Code", ActivityCode);
        if ScanDesignStagesER.FindFirst() then begin

            // Get the current value of "Scan Out"
            CurrentScanOut := SalesUnitRef."Scan Out";

            // Append the current activity index to "Scan Out"
            if CurrentScanOut = '' then
                CurrentScanOut := '{' + Format(ScanDesignStagesER."Activity Code") + '}'
            else
                CurrentScanOut := StrSubstNo('%1,%2', CurrentScanOut.TrimEnd('}'), Format(ScanDesignStagesER."Activity Code")) + '}';

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

    // Batch request procedure
    local procedure FillBatchRequest(Token: Text; ActivitiesArray: JsonArray): Boolean
    var
        RootObject: JsonObject;
        txt: Text;
        HttpClient: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        ResponseMsg: Text;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
    begin
        RootObject.Add('data', ActivitiesArray);
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
                Message('Batch Response: %1', ResponseMsg);
                exit(true);
            end else begin
                Error('HTTP Error: %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase());
                exit(false);
            end;
        end else begin
            Error('Failed to send the HTTP request.');
            exit(false);
        end;
    end;


    local procedure FillExistingScanHistoryForMO(Filter: Text; AccessToken: text)
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
        DateText: Text;
        ActivityDate: Date;
        Seconds: Integer;
        TimeValue: Time;
    begin
        DeleteExistingScans;
        // Set the MO number filter
        clear(CleanedResponse);
        // Build the API URL
        APIUrl := StrSubstNo('https://portal.emilerassam.com/api/core/scan/?filter=mo_no eq ''%1''&orderby=activity_date desc', Filter);

        Clear(HttpClient);
        // Add the Authorization header
        HttpClient.DefaultRequestHeaders.Add('Authorization', AccessToken);

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
                                ScanHistory."Unit Ref" := UnitRef;
                                ScanHistory."ER - Manufacturing Order No." := Filter;
                                if JsonObject.Get('sales_line_unit_id', JsonToken) then
                                    ScanHistory."Serial No." := JsonToken.AsValue().AsText();
                                if JsonObject.Get('sales_line_id', JsonToken) then
                                    ScanHistory."Sales Line Id" := JsonToken.AsValue().AsText();

                                if JsonObject.Get('assembly_no', JsonToken) then
                                    ScanHistory."Assembly No." := JsonToken.AsValue().AsText();
                                // if JsonObject.Get('mo_no', JsonToken) then
                                //     ScanHistory."ER - Manufacturing Order No." := JsonToken.AsValue().AsText();
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



                                if JsonObject.Get('activity_date', JsonToken) then begin
                                    if JsonToken.IsValue() then begin
                                        Evaluate(scanHistory."Activity Date", CopyStr(JsonToken.AsValue().AsText(), 1, 10));
                                    end;
                                end;

                                if JsonObject.Get('activity_time', JsonToken) then
                                    ScanHistory."Activity Time" := JsonToken.AsValue().AsText();
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




    local procedure CreateTime(Hour: Integer; Minute: Integer; Second: Integer): Integer
    begin
        // Returns a Time value for the given hour, minute, and second
        exit((Hour * 3600 + Minute * 60 + Second) * 1000);
    end;

    local procedure FillExistingScanHistoryforAssembly(Filter: Text; AccessToken: text)
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
        Milliseconds: BigInteger;
        ActivityTime: Time;
    begin
        DeleteExistingScans;
        // Set the MO number filter
        clear(CleanedResponse);
        // Build the API URL
        APIUrl := StrSubstNo('https://portal.emilerassam.com/api/core/scan/?filter=assembly_no eq ''%1''&orderby=activity_date desc', Filter);


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
                                ScanHistory."Unit Ref" := UnitRef;
                                ScanHistory."Assembly No." := Filter;
                                if JsonObject.Get('sales_line_unit_id', JsonToken) then
                                    ScanHistory."Serial No." := JsonToken.AsValue().AsText();
                                if JsonObject.Get('sales_line_id', JsonToken) then
                                    ScanHistory."Sales Line Id" := JsonToken.AsValue().AsText();

                                // if JsonObject.Get('assembly_no', JsonToken) then
                                //     ScanHistory."Assembly No." := JsonToken.AsValue().AsText();
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



    local procedure FillExistingScanHistoryforSalesLineRef(Filter: Text; AccessToken: Text)
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
        APIUrl := StrSubstNo('https://portal.emilerassam.com/api/core/scan/?filter=sales_line_id eq ''%1''&orderby=activity_date desc', Filter);


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
                                ScanHistory."Unit Ref" := UnitRef;
                                ScanHistory."Sales Line Id" := Filter;
                                if JsonObject.Get('sales_line_unit_id', JsonToken) then
                                    ScanHistory."Serial No." := JsonToken.AsValue().AsText();
                                // if JsonObject.Get('sales_line_id', JsonToken) then
                                //     ScanHistory."Sales Line Id" := JsonToken.AsValue().AsText();

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
                                    ScanHistory."Activity Time" := JsonToken.AsValue().AsText();

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
                                ScanHistory."Unit Ref" := UnitRef;
                                ScanHistory."Serial No." := Filter;
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

    procedure HandleScanActivity(SalesLine: Record "Sales Line"; SalesUnit: Record "Sales Line Unit Ref."; AssemblyHeader: Record "Assembly Header"; MO: Record "ER - Manufacturing Order"; Rec: Record "Scan Design Stages- ER Temp"; var ActivitiesArray: JsonArray)
    var
        ScanActivities: Record "Scan Activities";
        SalesRecSetup: Record "Sales & Receivables Setup";
    begin
        // call a function that return the stages scanned
        //if the activity code needed to be scanned is contained in scan in i need to exit this function
        SalesRecSetup.get;
        Clear(ScanActivities);
        ScanActivities.SetFilter("Serial No.", SalesUnit."Serial No.");
        ScanActivities.SetFilter("Sales Line Id", SalesUnit."Sales Line Ref.");
        ScanActivities.SetRange("Activity Type", ScanActivities."Activity Type"::"In");
        ScanActivities.setrange("Activity Code", ActivityCode); // <-- Add this line to filter by Activity Code

        if ScanActivities.FindFirst() then begin
            //  if ScanActivities."Activity Code" = ActivityCode then begin
            InsertActivity(ScanActivities."Activity Type"::Out, SalesLine, SalesUnit, AssemblyHeader, MO, Rec, ActivityCode);
            AddActivityToArray(ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec, Activity_Remark, ActivitiesArray);
            UpdateScanOutField(SalesUnit);
            //check if activity code is packaging to post assemblies
            if ActivityCode = SalesRecSetup."Packaging Stage" then
                PostRelatedAssemblies(UnitRef);
        end else begin
            InsertActivity(ScanActivities."Activity Type"::"In", SalesLine, SalesUnit, AssemblyHeader, MO, Rec, ActivityCode);
            AddActivityToArray(ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec, Activity_Remark, ActivitiesArray);
            UpdateScanInField(SalesUnit);
        end;
    end;

    procedure GetSalesLineFromSalesUnit(SalesUnit: Record "Sales Line Unit Ref."; var SalesLine: Record "Sales Line")
    begin
        Clear(SalesLine);
        SalesLine.SetRange("Sales Line Reference", SalesUnit."Sales Line Ref.");
        if not SalesLine.FindFirst() then
            Error('Related Sales Line not found.');
    end;

    procedure InsertActivity(ActivityType: Option; SalesLine: Record "Sales Line"; SalesUnit: Record "Sales Line Unit Ref."; AssemblyHeader: Record "Assembly Header"; MO: Record "ER - Manufacturing Order"; Rec: Record "Scan Design Stages- ER Temp"; ActivityCode: Code[20])
    var
        ScanActivities: Record "Scan Activities";
        EnvironmentInfo: Codeunit "Environment Information";
    begin
        Clear(ScanActivities);
        ScanActivities.Init();
        ScanActivities."Serial No." := SalesUnit."Serial No.";
        ScanActivities."Sales Line Id" := SalesUnit."Sales Line Ref.";
        ScanActivities."Activity Type" := ActivityType;
        ScanActivities."Assembly No." := AssemblyHeader."No.";
        ScanActivities."ER - Manufacturing Order No." := MO."No.";
        ScanActivities."Item No." := SalesLine."No.";
        ScanActivities."Design Code" := GetItemDesign(SalesUnit."item No.");
        ScanActivities."Variant Code" := AssemblyHeader."Variant Code";
        if SalesUnit."Document No." <> '' then
            ScanActivities."Source No." := SalesUnit."Document No."
        else
            ScanActivities."Source No." := SalesUnit."Assembly No.";
        ScanActivities."Activity Code" := ActivityCode;
        ScanActivities."Activity Name" := GetActivitySelected;
        ScanActivities."Activity Remark" := '';
        ScanActivities."Activity Date" := CurrentDateTime;
        ScanActivities."Activity Time" := Time;
        // need to check if its prod environment to fill prod and else to fill test
        if EnvironmentInfo.IsProduction() then
            ScanActivities."Activity Environment" := 'prod'
        else
            ScanActivities."Activity Environment" := 'test';
        ScanActivities.Insert();
    end;

    procedure FillAndProcessAPI(
     SalesLine: Record "Sales Line";
     SalesUnit: Record "Sales Line Unit Ref.";
     AssemblyHeader: Record "Assembly Header";
     MO: Record "ER - Manufacturing Order";
     Rec: Record "Scan Design Stages- ER Temp") Result: Boolean
    var
        AuthToken: Text;
        ScanActivities: Record "Scan Activities";
        ActivitiesArray: JsonArray;
        RequestSucceeded: Boolean;
    begin

        clear(ActivitiesArray);
        // Gather all scan activities related to this SalesUnit and SalesLine
        ScanActivities.SetFilter("Serial No.", SalesUnit."Serial No.");
        ScanActivities.SetFilter("Sales Line Id", SalesLine."Sales Line Reference Text");

        if ScanActivities.FindSet() then
            repeat
                AddActivityToArray(ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec, Activity_Remark, ActivitiesArray);
            until ScanActivities.Next() = 0;

        // Send all collected activities in one API batch request
        AuthToken := GenerateToken();
        RequestSucceeded := FillBatchRequest(AuthToken, ActivitiesArray);

        exit(RequestSucceeded);
    end;

    // Helper to add a single activity to the array
    local procedure AddActivityToArray(ScanRec: Record "Scan Activities"; SalesUnitRec: Record "Sales Line Unit Ref."; AssemblyHeaderRec: Record "Assembly Header"; MO: Record "ER - Manufacturing Order"; SalesLineRec: Record "Sales Line"; Rec: Record "Scan Design Stages- ER Temp"; ActivityRemark: Text; var ActivitiesArray: JsonArray)
    var
        ScanDetails: JsonObject;
        TimeText: Text;
        FullDateTimeText: Text;
        EnvironmentInfo: Codeunit "Environment Information";
    begin
        ScanDetails.Add('sales_line_unit_id', SalesUnitRec."Serial No.");
        ScanDetails.Add('sales_line_id', SalesLineRec."Sales Line Reference Text");
        ScanDetails.Add('assembly_no', AssemblyHeaderRec."No.");
        ScanDetails.Add('mo_no', MO."No.");
        ScanDetails.Add('item_code', AssemblyHeaderRec."Item No.");

        ScanDetails.Add('design_code', Rec."Design Code");
        ScanDetails.Add('variant_code', AssemblyHeaderRec."Variant Code");
        ScanDetails.Add('so_no', SalesLineRec."Document No.");
        ScanDetails.Add('activity_code', ActivityCode);
        ScanDetails.Add('activity_name', GetActivityName(ActivityCode));
        ScanDetails.Add('activity_remark', ActivityRemark);
        if ScanRec."Activity Type" = ScanRec."Activity Type"::"In" then
            ScanDetails.Add('activity_type', 'In')
        else
            ScanDetails.Add('activity_type', 'Out');
        FullDateTimeText := Format(CurrentDateTime, 0, '<Year4>-<Month,2>-<Day,2> <Hours24,2>:<Minutes,2>:<Seconds,2>');
        // TimeText := CopyStr(FullDateTimeText, 12, 8); // Extract time part: HH:MM:SS

        ScanDetails.Add('activity_date', FullDateTimeText);
        if EnvironmentInfo.IsProduction() then
            ScanDetails.Add('activity_env', 'prod')
        else
            ScanDetails.Add('activity_env', 'test');
        //ScanDetails.Add('activity_time', TimeText);
        ActivitiesArray.Add(ScanDetails);
    end;



    local procedure CheckIfActivityScanned()
    var
        DesignActivities: Record "Scan Design Stages- ER Temp";
    begin
        // Check if the selected activity is already scanned for this UnitRef

        DesignActivities.SetRange("Design Code", Rec."Design Code");
        DesignActivities.SetRange("Activity Code", ActivityCode);
        if DesignActivities.FindFirst() then begin
            if DesignActivities.Scanned then
                Error('This activity is already scanned for this design.');
        end;
    end;

    local procedure CheckIfScanningActivityAllowed()
    var
        myInt: Integer;
        DesignActivitiesToScan: Record "Scan Design Stages- ER Temp";
        DesignActivitiesRecs: Record "Scan Design Stages- ER Temp";
    begin

        // Set all other lines to false
        Clear(DesignActivitiesToScan);

        DesignActivitiesToScan.SetFilter("Design Code", rec."Design Code");
        DesignActivitiesToScan.SetFilter("Activity Code", ActivityCode);
        if DesignActivitiesToScan.FindFirst() then begin
            if DesignActivitiesToScan.Scanned then
                Error('Already Scanned!');

            if not DesignActivitiesToScan."Allow Non-Sequential Scanning" then begin

                if (DesignActivitiesToScan."Sequence No." > 1) then begin
                    // Check all previous activities (not just mandatory)
                    Clear(DesignActivitiesRecs);
                    DesignActivitiesRecs.SetFilter("Design Code", DesignActivitiesToScan."Design Code");
                    DesignActivitiesRecs.SetRange("Sequence No.", 1, DesignActivitiesToScan."Sequence No." - 1); // All previous activities
                    DesignActivitiesRecs.SetRange("Stage Type", DesignActivitiesRecs."Stage Type"::Mandatory);
                    if DesignActivitiesRecs.FindSet() then begin
                        repeat
                            if DesignActivitiesRecs.Scanned = false then
                                Error('All previous activities in the sequence must be completed before scanning this one.');
                        until DesignActivitiesRecs.Next() = 0;
                    end;
                end;
            end;
            if (DesignActivitiesToScan."Sequence No." > 1) then begin
                //check scanning conditions


                // Check all mandatory activities before the current Activity Id
                if (DesignActivitiesToScan.Done = '❌') and not (DesignActivitiesToScan."Allow Non-Sequential Scanning") then begin
                    Clear(DesignActivitiesRecs);
                    DesignActivitiesRecs.Setfilter("Design Code", DesignActivitiesToScan."Design Code");
                    DesignActivitiesRecs.SetRange("Sequence No.", 1, DesignActivitiesToScan."Sequence No." - 1); // Activities before the current one
                    DesignActivitiesRecs.SetRange("Stage Type", DesignActivitiesToScan."Stage Type"::Mandatory); // Only mandatory activities
                    if DesignActivitiesRecs.FindSet() then begin
                        repeat
                            if DesignActivitiesRecs.Scanned = false then
                                Error('All mandatory activities before this one must be completed before scanning.');
                        until DesignActivitiesRecs.Next() = 0;
                    end;
                end;
            end
            else begin
                if DesignActivitiesToScan."Stage Type" = DesignActivitiesToScan."Stage Type"::" " then begin
                    Clear(DesignActivitiesRecs);
                    DesignActivitiesRecs.Setfilter("Design Code", DesignActivitiesToScan."Design Code");
                    DesignActivitiesRecs.SetRange("Sequence No.", 1, DesignActivitiesToScan."Sequence No." - 1); // Activities before the current one
                                                                                                                 //DesignActivitiesRecs.SetRange("Stage Type", DesignActivitiesToScan."Stage Type"::Mandatory); // Only mandatory activities
                    if DesignActivitiesRecs.FindSet() then begin
                        repeat
                            if DesignActivitiesRecs.Scanned = false then
                                Error('All Activities before this one must be completed.');
                        until DesignActivitiesRecs.Next() = 0;
                    end;
                end;
            end;
        end;
    end;

    local procedure PostRelatedAssemblies(Filter: code[50])
    var
        myInt: Integer;
        ManufacturingOrder: Record "ER - Manufacturing Order";
        AssemblyHeader: Record "Assembly Header";
        SalesLine: Record "Sales Line";
        SalesUnit: Record "Sales Line Unit Ref.";
        ReservationEntry: Record "Reservation Entry";
    begin
        Clear(ManufacturingOrder);
        Clear(AssemblyHeader);
        Clear(ReservationEntry);
        if ManufacturingOrder.Get(Filter) then begin
            AssemblyHeader.SetFilter("ER - Manufacturing Order No.", ManufacturingOrder."No.");
            if AssemblyHeader.FindFirst() then
                repeat
                    if AssemblyHeader.Status <> AssemblyHeader.Status::Released then
                        CODEUNIT.Run(CODEUNIT::"Release Assembly Document", AssemblyHeader);
                    CODEUNIT.Run(CODEUNIT::"Assembly-Post", AssemblyHeader);
                until AssemblyHeader.Next() = 0;
        end else begin
            Clear(AssemblyHeader);
            if AssemblyHeader.get(AssemblyHeader."Document Type"::Order, Filter) then begin
                if AssemblyHeader.Status <> AssemblyHeader.Status::Released then
                    CODEUNIT.Run(CODEUNIT::"Release Assembly Document", AssemblyHeader);
                CODEUNIT.Run(CODEUNIT::"Assembly-Post", AssemblyHeader);
            end else begin
                Clear(SalesLine);
                SalesLine.SetFilter("Sales Line Reference", Filter);
                if SalesLine.FindFirst() then begin
                    Clear(AssemblyHeader);
                    AssemblyHeader.SetFilter("Source No.", SalesLine."Document No.");
                    AssemblyHeader.setrange("Source Line No.", SalesLine."Line No.");
                    if AssemblyHeader.FindFirst() then begin
                        if AssemblyHeader.Status <> AssemblyHeader.Status::Released then
                            CODEUNIT.Run(CODEUNIT::"Release Assembly Document", AssemblyHeader);
                        CODEUNIT.Run(CODEUNIT::"Assembly-Post", AssemblyHeader);
                    end;
                end else begin
                    SalesUnit.SetFilter("Serial No.", Filter);
                    if SalesUnit.FindFirst() then begin

                    end;

                end;

            end;
        end;
    end;

    local procedure CheckIfitsAssembleToStock()
    var
        ScanDesignStagesER: Record "Scan Design Stages- ER";
        Mo: Record "ER - Manufacturing Order";
        AssemblyHeader: Record "Assembly Header";
        ReservationEntry: Record "Reservation Entry";
        SalesHeader: Record "Sales Header";
    begin
        Clear(ScanDesignStagesER);
        ScanDesignStagesER.Get(ActivityCode);
        if ScanDesignStagesER."Sales Related Stage" then begin
            // i need to check if its MO or assembly or sales ref or assm ref or serial 
            clear(Mo);
            if MO.Get(UnitRef) then begin
                Clear(AssemblyHeader);
                AssemblyHeader.SetFilter("ER - Manufacturing Order No.", MO."No.");
                if AssemblyHeader.FindFirst() then begin
                    repeat
                        if AssemblyHeader."Source No." = '' then
                            Error('Cannot scan for this Manufacturing Order because it contains at least one assembly that is not Assemble to Order.');
                    until AssemblyHeader.Next() = 0;
                end;
            end else begin
                AssemblyHeader.SetFilter("No.", UnitRef);
                if AssemblyHeader.FindFirst() then begin
                    if AssemblyHeader."Source No." = '' then
                        Error('Cannot scan this Assembly Order because it is not Assemble to Order.');

                end else begin
                    Clear(ReservationEntry);
                    ReservationEntry.SetFilter("Serial No.", UnitRef);
                    if ReservationEntry.FindFirst() then begin
                        SalesHeader.SetFilter("No.", ReservationEntry."Source ID");
                        if not SalesHeader.FindFirst() then begin
                            Error('Cannot scan this Assembly Order because it is not Assemble to Order.');
                        end;

                    end else begin
                        Clear(AssemblyHeader);
                        AssemblyHeader.SetFilter("Assembly Reference Text", UnitRef);
                        if AssemblyHeader.FindFirst() then begin
                            if AssemblyHeader."Source No." = '' then
                                Error('Cannot scan this Assembly Order because it is not Assemble to Order.');
                        end;
                    end;
                end;
            end;
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        DeleteExistingScans();
        rec.DeleteAll();
    end;

    var
        UnitRef: Code[100];
        Activity_Remark: Text[1000];
        User: Code[50];
        ActivityCode: Code[50];
        DesignCode: code[50];
        rep: Codeunit ReportManagement;
        UserActivities: Code[50];
}