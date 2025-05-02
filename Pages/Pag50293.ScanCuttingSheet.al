page 50293 "Scan Cutting Sheet"
{
    Caption = 'Scan Cutting Sheet';
    PageType = StandardDialog;
    SourceTable = "Assembly Header";
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(ScanRef; ScanRef)
                {
                    Caption = 'MO/Assembly/SalesUnit';
                    ApplicationArea = all;
                    //Editable = false;
                }
                field(User; User)
                {
                    Caption = 'User';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnValidate()
                    var
                        MasterItemCU: Codeunit MasterItem;
                        AssemblyHeader: Record "Assembly Header";
                        Txt001: Label 'No Assembly found in the group %1';
                        ScanOption: Option "In","Out";
                        Txt0001: Label 'Scan In 👍';
                        Txt0002: Label 'Scan Out 👍';
                    begin
                        //add event to validate on it if the MO is not released it should give an error

                        AssemblyHeader.SetRange("ER - Manufacturing Order No.", ScanRef);
                        if AssemblyHeader.FindSet() then
                            repeat
                                //Check if the user is responsible for scanning
                                MasterItemCU.CheckUserResponibility(AssemblyHeader."No.", User);
                                Commit();
                                //Enter Scan In or Scan Out details
                                ScanOption := MasterItemCU.CreateCuttingSheetScanningEntry(AssemblyHeader."No.", User);
                            until AssemblyHeader.Next() = 0
                        else
                            Error('No Assembly found in this group', ScanRef);

                        if ScanOption = ScanOption::"In" then
                            Message(Txt0001)
                        else
                            Message(Txt0002);
                        //CurrPage.Close();
                    end;
                }
                field(User2; User)
                {
                    Caption = 'User';
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        MasterItemCU: Codeunit MasterItem;
                        AssemblyHeader: Record "Assembly Header";
                        DesignActivities: Record "design Activities"; // Replace with the actual table name for scan activities
                        Dashboard: Record "Cutting Sheets Dashboard"; // Replace with the actual table name for the dashboard
                        Txt001: Label 'No Assembly found in the group %1';
                        Txt0001: Label 'Scan In 👍';
                        Txt0002: Label 'Scan Out 👍';
                        ScanOption: Option "In","Out";
                        Design: Record Design;
                        Item: Record Item;
                        WorkflowActivitiesER: Record "Workflow Activities - ER";
                        MO: Record "ER - Manufacturing Order";
                        MaxSequenceNo: Integer;
                        Txt003: Label 'The current sequence number %1 exceeds the maximum sequence number %2 in the scan activities.';
                        SalesLine: Record "Sales Line";
                        SalesUnit: Record "Sales Line Unit Ref.";
                        ProcessedAssemblies: Dictionary of [Code[20], Boolean]; // To track processed assemblies

                    begin
                        //add event to validate on it if the MO is not released it should give an error
                        OnBeforeScanCuttingSheet(ScanRef);
                        AssemblyHeader.SetRange("ER - Manufacturing Order No.", ScanRef);
                        if AssemblyHeader.FindSet() then
                            repeat

                                //Check if the user is responsible for scanning
                                MasterItemCU.CheckUserResponibility(AssemblyHeader."No.", User);
                                Commit();
                                //Enter Scan In or Scan Out details
                                ScanOption := MasterItemCU.CreateCuttingSheetScanningEntry(AssemblyHeader."No.", User);

                            until AssemblyHeader.Next() = 0
                        else
                            Error('No Assembly found in this group', ScanRef);

                        if ScanOption = ScanOption::"In" then
                            Message(Txt0001)
                        else
                            Message(Txt0002);

                        Clear(DesignActivities);
                        Clear(MO);
                        if MO.Get(ScanRef) then begin
                            Clear(AssemblyHeader);
                            AssemblyHeader.SetFilter("ER - Manufacturing Order No.", MO."No.");
                            if AssemblyHeader.FindFirst() then
                                repeat
                                    // Check if the assembly has already been processed
                                    if not ProcessedAssemblies.ContainsKey(AssemblyHeader."No.") then begin
                                        ProcessedAssemblies.Add(AssemblyHeader."No.", true); // Mark as processed
                                        SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                                        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                                        if SalesLine.FindFirst() then begin
                                            SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                                            if SalesUnit.FindFirst() then begin
                                                repeat
                                                // Perform the scan for every unit

                                                until SalesUnit.Next() = 0;
                                            end;
                                        end;
                                    END;
                                until AssemblyHeader.Next() = 0;

                        end else begin
                            Clear(AssemblyHeader);
                            AssemblyHeader.SetRange("No.", ScanRef);
                            if AssemblyHeader.FindSet() then begin
                                repeat
                                    // Check if the assembly has already been processed
                                    if not ProcessedAssemblies.ContainsKey(AssemblyHeader."No.") then begin
                                        ProcessedAssemblies.Add(AssemblyHeader."No.", true); // Mark as processed
                                        SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                                        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                                        if SalesLine.FindFirst() then begin
                                            SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                                            if SalesUnit.FindFirst() then begin
                                                repeat
                                                // Perform the scan for every unit

                                                until SalesUnit.Next() = 0;
                                            end;
                                        end;
                                    end;
                                until AssemblyHeader.Next() = 0;
                            end else begin
                                SalesUnit.SetFilter("Sales Line Unit", ScanRef);
                                if SalesUnit.FindFirst() then begin

                                    // Perform the scan for every unit
                                END;
                            END;
                        end;
                    end;

                }
            }
        }

    }

    procedure InitGlobalVariables(UserPar: Code[50]; AssemblyGrpNoPar: Code[50])
    begin
        User := UserPar;
        ScanRef := AssemblyGrpNoPar;
    end;

    procedure GetAssemblyNo(): Code[20]
    begin
        exit(ScanRef);
    end;

    procedure GetUserName(): Code[50]
    begin
        exit(User);
    end;


    local procedure OnBeforeScanCuttingSheet(AssemblyGrpNoPar: Code[50])
    var
        DesignActivities: Record "Design Activities"; // Replace with the actual table name for scan activities
        Design: Record Design;
        IsDone: Boolean;
        Item: Record Item;
        TempStages: Record "Scan Design Stages- ER Temp" temporary;
        SalesLine: Record "Sales Line";
        SalesLineUnitRef: Record "Sales Line Unit Ref.";
    begin
        // Fetch the design related to the assembly group
        AssemblyHeader.setfilter("ER - Manufacturing Order No.", ScanRef);
        if AssemblyHeader.FindSet() then begin
            Item.Get(AssemblyHeader."Item No.");
            Design.Get(Item."Design Code");
            Clear(SalesLine);
            SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
            SalesLine.Setrange("Document Type", SalesLine."Document Type"::Order);
            if SalesLine.FindFirst() then begin
                Clear(SalesLineUnitRef);

                // Retrieve scan stages for the design
                DesignActivities.SetRange("Design Code", Design.Code);
                if DesignActivities.FindSet() then begin
                    repeat
                       // IsDone := DesignActivities."Is Done"; // Adjust field name as needed

                        // Insert into the temporary table
                        TempStages.Init();
                        TempStages."Activity Name" := DesignActivities."Activity Name";
                        TempStages."Is Done" := IsDone;
                        TempStages.Insert();
                    until DesignActivities.Next() = 0;
                end;
            end;
        end;
    end;

    var

        TxtStages: Label 'Scan Stages for Design %1:\n%2';
        TxtStageLine: Label '%1 - %2';
        StagesText: Text;
        AssemblyHeader: Record "Assembly Header";
        ScanRef: Code[1000];
        User: Code[50];
}
