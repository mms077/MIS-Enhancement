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
                    Caption = 'Scanning Reference';
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
                        DesignActivities: Record "Design Activities";
                        Status: Text[10];
                        FoundMissing: Boolean;
                        Token: Text;
                    //StageIndex:Integer;
                    begin
                        if UnitRef <> '' then
                            Rec."Unit Ref" := UnitRef;
                        //make to scan false
                        ResetDesignActivitiesToScan;
                        rec.DeleteAll();
                        DesignCode := '';
                        // Logic to refresh the subpage when UnitRef changes
                        Clear(ScanDesignStages);
                        Clear(MO);
                        if UnitRef <> '' then begin

                            if MO.Get(UnitRef) then begin
                                //fill existing scan
                                Token := GenerateToken();
                                FillExistingScanHistoryForMO(UnitRef, Token);
                                Clear(AssemblyHeader);
                                AssemblyHeader.SetFilter("ER - Manufacturing Order No.", MO."No.");
                                if AssemblyHeader.FindFirst() then begin
                                    // i need to fill the ScanDesignStages rec from "Scan Design Stages- ER" table
                                    Rec.TRANSFERFIELDS(ScanDesignStages);
                                    Rec.Insert();
                                    Rec."Item No." := AssemblyHeader."Item No.";
                                    Rec."Design Code" := GetItemDesign(Rec."Item No.");
                                    Rec.Modify();
                                    // i need here to go through every line and check o nsales unit ref if for example coloring on table Scan Design Stages- ER List is 1 to check in salesunit line if the scan out is {1} to fill the done field on the line by ✅
                                    Clear(DesignActivities);
                                    Clear(ScanDesignStages);
                                    DesignActivities.SetFilter("Design Code", Rec."Design Code");
                                    if DesignActivities.FindSet() then begin
                                        repeat
                                            // Get the ScanDesignStages record for the current activity
                                            ScanDesignStages.SetRange(Index, DesignActivities."Activity Id");
                                            if ScanDesignStages.FindFirst() then begin
                                                // Initialize as ✅ first
                                                Status := '✅';
                                                FoundMissing := false; // Boolean flag to track if any SalesUnit is missing the index

                                                // Loop Sales Lines
                                                SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                                                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                                                if SalesLine.FindSet() then begin
                                                    repeat
                                                        // Loop Sales Units for the Sales Line
                                                        SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                                                        if SalesUnit.FindSet() then begin
                                                            repeat
                                                                // Check if Scan Out contains the index
                                                                if STRPOS(SalesUnit."Scan Out", Format(ScanDesignStages.Index)) = 0 then begin
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
                                                end;

                                                // After processing all, set the status
                                                DesignActivities.Done := Status;
                                                DesignActivities.Modify();
                                            end;
                                        until DesignActivities.Next() = 0;
                                    end;
                                end
                            end else begin
                                Clear(AssemblyHeader);
                                AssemblyHeader.SetRange("No.", UnitRef);
                                if AssemblyHeader.FindSet() then begin
                                    Token := GenerateToken();
                                    FillExistingScanHistoryforAssembly(UnitRef, Token);
                                    Rec.TRANSFERFIELDS(ScanDesignStages);
                                    Rec.Insert();
                                    Rec."Item No." := AssemblyHeader."Item No.";
                                    Rec."Design Code" := GetItemDesign(Rec."Item No.");
                                    Rec.Modify();
                                    // i need here to go through every line and check o nsales unit ref if for example coloring on table Scan Design Stages- ER List is 1 to check in salesunit line if the scan out is {1} to fill the done field on the line by ✅
                                    Clear(DesignActivities);
                                    Clear(ScanDesignStages);
                                    DesignActivities.SetFilter("Design Code", Rec."Design Code");
                                    if DesignActivities.FindSet() then begin
                                        repeat
                                            // Get the ScanDesignStages record for the current activity
                                            ScanDesignStages.SetRange(Index, DesignActivities."Activity Id");
                                            if ScanDesignStages.FindFirst() then begin
                                                // Initialize as ✅ first
                                                Status := '✅';
                                                FoundMissing := false; // Boolean flag to track if any SalesUnit is missing the index

                                                // Loop Sales Lines
                                                SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                                                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                                                if SalesLine.FindSet() then begin
                                                    repeat
                                                        // Loop Sales Units for the Sales Line
                                                        SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                                                        if SalesUnit.FindSet() then begin
                                                            repeat
                                                                // Check if Scan Out contains the index
                                                                if STRPOS(SalesUnit."Scan Out", Format(ScanDesignStages.Index)) = 0 then begin
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
                                                end;

                                                // After processing all, set the status
                                                DesignActivities.Done := Status;
                                                DesignActivities.Modify();
                                            end;
                                        until DesignActivities.Next() = 0;
                                    end
                                end

                                else begin
                                    Status := '✅';
                                    FoundMissing := false;

                                    MasterItemCU.CheckUserResponibilityScanning(GetSequenceSelected(GetItemDesign(Rec."Item No.")), User, GetActivitySelected(GetItemDesign(Rec."Item No.")));

                                    Clear(SalesUnit);
                                    // Loop for each quantity in the Sales Line
                                    SalesUnit.SetFilter("Sales Line Ref.", UnitRef);
                                    if SalesUnit.FindFirst() then begin
                                        Token := GenerateToken();
                                        FillExistingScanHistoryforSalesLineRef(UnitRef, Token);
                                        repeat
                                            // Check if Scan Out contains the index
                                            if STRPOS(SalesUnit."Scan Out", Format(ScanDesignStages.Index)) = 0 then begin
                                                // Found a missing index -> mark as ❌
                                                Status := '❌';
                                                FoundMissing := true;
                                                break; // exit SalesUnit loop
                                            end;
                                        until SalesUnit.Next() = 0;



                                    end else begin
                                        Status := '✅';
                                        FoundMissing := false;
                                        SalesUnit.SetFilter("Sales Line Unit", UnitRef);
                                        if SalesUnit.FindFirst() then begin
                                            Token := GenerateToken();
                                            FillExistingScanHistoryforSalesLineUnit(UnitRef, Token);
                                            Clear(SalesLine);
                                            SalesLine.SetFilter("Sales Line Reference", SalesUnit."Sales Line Ref.");
                                            if SalesLine.FindFirst() then begin
                                                Rec."Item No." := SalesLine."No.";
                                                Rec."Design Code" := GetItemDesign(Rec."Item No.");
                                                Rec.Modify();
                                                // Check if Scan Out contains the index
                                                if STRPOS(SalesUnit."Scan Out", Format(ScanDesignStages.Index)) = 0 then begin
                                                    // Found a missing index -> mark as ❌
                                                    Status := '❌';
                                                    FoundMissing := true;
                                                end;
                                            end;
                                        END;
                                    END;
                                end;
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
                        AuthToken: Text;
                        ScanDesignStagesER: Record "Scan Design Stages- ER";
                        RequestSucsessed: Boolean;
                    begin

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

                                            MasterItemCU.CheckUserResponibilityScanning(GetSequenceSelected(GetItemDesign(Rec."Item No.")), User, GetActivitySelected(GetItemDesign(Rec."Item No.")));
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
                                                                RequestSucsessed := false;
                                                                AuthToken := GenerateToken();
                                                                RequestSucsessed := FillRequest(AuthToken, ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec, Activity_Remark);
                                                                // Delete both "In" and "Out" activities after API call
                                                                if RequestSucsessed then begin
                                                                    Clear(ScanActivities);
                                                                    ScanActivities.SetFilter("Sales Line Unit Id.", SalesUnit."Sales Line Unit");
                                                                    ScanActivities.SetFilter("Sales Line Id", SalesLine."Sales Line Reference");
                                                                    if ScanActivities.FindSet() then begin
                                                                        ScanActivities.DeleteAll();
                                                                        UpdateScanOutField(SalesUnit);
                                                                    end;
                                                                end;
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
                                                                RequestSucsessed := false;
                                                                AuthToken := GenerateToken();
                                                                RequestSucsessed := FillRequest(AuthToken, ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec, Activity_Remark);
                                                                // fill scanIn in SalesUnit in order to know which stage are done
                                                                if RequestSucsessed then
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

                                            MasterItemCU.CheckUserResponibilityScanning(GetSequenceSelected(GetItemDesign(Rec."Item No.")), User, GetActivitySelected(GetItemDesign(Rec."Item No.")));
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
                                                                FillRequest(AuthToken, ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec, Activity_Remark);
                                                                // Delete both "In" and "Out" activities after API call
                                                                Clear(ScanActivities);
                                                                ScanActivities.SetFilter("Sales Line Unit Id.", SalesUnit."Sales Line Unit");
                                                                ScanActivities.SetFilter("Sales Line Id", SalesLine."Sales Line Reference");
                                                                if ScanActivities.FindSet() then begin
                                                                    ScanActivities.DeleteAll();
                                                                    UpdateScanOutField(SalesUnit);

                                                                end;
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
                                                                FillRequest(AuthToken, ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec, Activity_Remark);
                                                                // fill scanIn in SalesUnit in order to know which stage are done

                                                                UpdateScanInField(SalesUnit)
                                                            end;
                                                        until SalesUnit.Next() = 0;
                                                    end;
                                                until SalesLine.Next() = 0;
                                            end
                                        end;
                                    until AssemblyHeader.Next() = 0;
                                end

                                else begin


                                    MasterItemCU.CheckUserResponibilityScanning(GetSequenceSelected(GetItemDesign(Rec."Item No.")), User, GetActivitySelected(GetItemDesign(Rec."Item No.")));

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
                                                //call api to insert 
                                                AuthToken := GenerateToken();
                                                FillRequest(AuthToken, ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec, Activity_Remark);
                                                // Delete both "In" and "Out" activities after API call
                                                Clear(ScanActivities);
                                                ScanActivities.SetFilter("Sales Line Unit Id.", SalesUnit."Sales Line Unit");
                                                ScanActivities.SetFilter("Sales Line Id", SalesLine."Sales Line Reference");
                                                if ScanActivities.FindSet() then begin
                                                    ScanActivities.DeleteAll();
                                                    UpdateScanOutField(SalesUnit);

                                                end;
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
                                                FillRequest(AuthToken, ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec, Activity_Remark);
                                                // fill scanIn in SalesUnit in order to know which stage are done

                                                UpdateScanInField(SalesUnit)
                                            end;
                                        until SalesUnit.Next() = 0;
                                    end else begin


                                        MasterItemCU.CheckUserResponibilityScanning(GetSequenceSelected(GetItemDesign(Rec."Item No.")), User, GetActivitySelected(GetItemDesign(Rec."Item No.")));

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
                                                    FillRequest(AuthToken, ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec, Activity_Remark);
                                                    // Delete both "In" and "Out" activities after API call
                                                    Clear(ScanActivities);
                                                    ScanActivities.SetFilter("Sales Line Unit Id.", SalesUnit."Sales Line Unit");
                                                    ScanActivities.SetFilter("Sales Line Id", SalesLine."Sales Line Reference");
                                                    if ScanActivities.FindSet() then begin
                                                        ScanActivities.DeleteAll();
                                                        UpdateScanOutField(SalesUnit);

                                                    end;
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
                                                    FillRequest(AuthToken, ScanActivities, SalesUnit, AssemblyHeader, MO, SalesLine, Rec, Activity_Remark);
                                                    // fill scanIn in SalesUnit in order to know which stage are done

                                                    UpdateScanInField(SalesUnit);
                                                end;
                                            end;
                                        end;

                                    end;
                                end;
                            end;
                        end;
                    end;
                }
                field(Activity_Remark; Activity_Remark)
                {
                    Caption = 'Activity Remark';

                }
            }
            part(DesignActivityStagesPart; "Design Activities Temp")
            {

                SubPageLink = "Design Code" = field("Design Code");
                SubPageView = sorting("Sequence No.");
                Editable = true;
            }
        }
        area(FactBoxes)
        {
            part(ExistingScansPart; "Existing Scans")
            {
                SubPageLink = "Unit Ref" = field("Unit Ref");
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

    local procedure ResetDesignActivitiesToScan()
    var
        DesignActivities: Record "Design Activities";
    begin
        Clear(DesignActivities);
        if DesignActivities.FindSet() then
            repeat
                DesignActivities."To Scan" := false;
                DesignActivities.Done := '';
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

    local procedure GetActivitySelected(DesignCode: code[50]): Integer
    var
        myInt: Integer;
        DesignActivities: Record "Design Activities";
    begin
        Clear(DesignActivities);
        DesignActivities.SetFilter("Design Code", DesignCode);
        DesignActivities.SetRange("To Scan", true);
        if DesignActivities.FindFirst() then
            exit(DesignActivities."Activity Id");

    end;

    local procedure UpdateScanInField(SalesUnitRef: Record "Sales Line Unit Ref.")
    var
        ScanDesignStagesER: Record "Scan Design Stages- ER";
        SequenceNo: Integer;
        CurrentScanIn: Text;
    begin
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
     //   DesignActivitiesTemp: Record "Design Activities Temp";
        ScanDesignStagesER: Record "Scan Design Stages- ER";
        SequenceNo: Integer;
        CurrentScanOut: Text;
    begin
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


    local procedure FillRequest(Token: Text; ScanRec: Record "Scan Activities"; SalesUnitRec: Record "Sales Line Unit Ref."; AssemblyHeaderRec: Record "Assembly Header"; MO: Record "ER - Manufacturing Order"; SalesLineRec: Record "Sales Line"; Rec: Record "Scan Design Stages- ER Temp"; ActivityRemark: Text): Boolean
    var

        ScanDetails: JsonObject;
        txt: Text;
        HttpClient: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        ResponseMsg: Text;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        FileName: Text;
        RootObject: JsonObject;
        DataArray: JsonArray;
    begin

        Clear(ScanDetails);
        Clear(RootObject);
        Clear(DataArray);
        Clear(txt);

        // Build the JSON object (1 item)
        ScanDetails.Add('sales_line_unit_id', SalesUnitRec."Sales Line Unit" + 'r3wqty2wsss42ws7w7');
        ScanDetails.Add('sales_line_id', SalesLineRec."Sales Line Reference");
        ScanDetails.Add('assembly_no', AssemblyHeaderRec."No.");
        ScanDetails.Add('mo_no', MO."No.");
        ScanDetails.Add('item_code', AssemblyHeaderRec."Item No.");
        ScanDetails.Add('design_code', Rec."Design Code");
        ScanDetails.Add('variant_code', AssemblyHeaderRec."Variant Code");
        ScanDetails.Add('so_no', SalesLineRec."Document No.");
        ScanDetails.Add('activity_code', '');
        ScanDetails.Add('activity_name', '');
        ScanDetails.Add('activity_remark', ActivityRemark);
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
                exit(true); // Return true for success
            end else begin
                Error('HTTP Error: %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase());
                exit(false); // Return false for failure
            end;
        end else begin
            Error('Failed to send the HTTP request.');
            exit(false); // Return false for failure
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
    begin
        DeleteExistingScans;
        // Set the MO number filter
        clear(CleanedResponse);
        // Build the API URL
        APIUrl := StrSubstNo('https://portal.emilerassam.com/api/core/scan/?filter=mo_no eq ''%1''&orderby=activity_date desc', Filter);


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
                                    ScanHistory."Sales Line Unit Id." := JsonToken.AsValue().AsText();
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
                                    ScanHistory."Sales Line Unit Id." := JsonToken.AsValue().AsText();
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
                                    ScanHistory."Sales Line Unit Id." := JsonToken.AsValue().AsText();
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

    var
        UnitRef: Code[100];
        Activity_Remark: Text[1000];
        User: Code[50];
        DesignCode: code[50];
        rep: Codeunit ReportManagement;
}