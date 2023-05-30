report 50204 "Activities Time Spent"
{
    ApplicationArea = All;
    Caption = 'Activities Time Spent';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Reports Layouts/ActivitiesTimeSpent.rdlc';
    dataset
    {
        dataitem("ER - Manufacturing Order"; "ER - Manufacturing Order")
        {
            RequestFilterFields = "No.";
            column(ER_Manufacturing_Order_No; "No.")
            {
            }
            dataitem(CuttingSheetScanningDetails; "Cutting Sheet Scanning Details")
            {
                column(ID; ID)
                {
                }
                column(AssemblyNo; "Assembly No.")
                {
                }
                column(ScanType; "Scan Type")
                {
                }
                column(Sequence_No_; "Sequence No.")
                {
                }
                column(Username; Username)
                {
                }
                column(SystemCreatedAt; SystemCreatedAt)
                {
                }
                column(SystemCreatedBy; SystemCreatedBy)
                {
                }
                column(WorkflowActivitiesER; WorkflowActivitiesER."Activity Name")
                {
                }
                column(SequenceDuration; SequenceDuration)
                {
                }
                column(TotalDuration; TotalDuration)
                {
                }
                //CuttingSheetScanningDetails Triggers
                trigger OnPreDataItem()
                begin
                    CuttingSheetScanningDetails.SetCurrentKey("Assembly No.", "Sequence No.", "Scan Type");
                    CuttingSheetScanningDetails.SetFilter("Assembly No.", AssemblyFilter);
                    CuttingSheetScanningDetails.FindSet();
                    SameSequence := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    CuttingSheetScanningDetailsLoc: Record "Cutting Sheet Scanning Details";
                    StartTime: DateTime;
                    EndTime: DateTime;
                begin
                    Clear(StartTime);
                    Clear(EndTime);
                    Clear(SequenceDuration);
                    CuttingSheetScanningDetailsLoc.SetRange("Assembly No.", CuttingSheetScanningDetails."Assembly No.");
                    CuttingSheetScanningDetailsLoc.SetRange("Sequence No.", CuttingSheetScanningDetails."Sequence No.");
                    if CuttingSheetScanningDetailsLoc.FindSet() then
                        repeat
                            if CuttingSheetScanningDetailsLoc."Scan Type" = CuttingSheetScanningDetailsLoc."Scan Type"::"Scan In" then
                                StartTime := CuttingSheetScanningDetailsLoc.SystemCreatedAt;
                            if CuttingSheetScanningDetailsLoc."Scan Type" = CuttingSheetScanningDetailsLoc."Scan Type"::"Scan Out" then
                                EndTime := CuttingSheetScanningDetailsLoc.SystemCreatedAt;
                        until CuttingSheetScanningDetailsLoc.Next() = 0;
                    if (Format(StartTime) <> '') and (Format(EndTime) <> '') then
                        SequenceDuration := EndTime - StartTime;
                    if SameSequence <> CuttingSheetScanningDetails."Sequence No." then
                        TotalDuration := TotalDuration + SequenceDuration;

                    Clear(WorkflowActivitiesER);
                    WorkflowActivitiesER.SetRange("Workflow User Group Code", SalesReceivableSetup."Cutting Sheet Workflow Group");
                    WorkflowActivitiesER.SetRange("Workflow User Group Sequence", CuttingSheetScanningDetails."Sequence No.");
                    if WorkflowActivitiesER.FindFirst() then;
                    SameSequence := CuttingSheetScanningDetails."Sequence No.";
                end;
            }
            trigger OnAfterGetRecord()
            var
                AssemblyHeaderLoc: Record "Assembly Header";
                LoopFilter: Text[2500];
            begin
                Clear(AssemblyHeaderLoc);
                AssemblyHeaderLoc.SetRange("ER - Manufacturing Order No.", "ER - Manufacturing Order"."No.");
                if AssemblyHeaderLoc.FindSet() then
                    repeat
                        LoopFilter := LoopFilter + AssemblyHeaderLoc."No." + '|';
                    until AssemblyHeaderLoc.Next() = 0;
                AssemblyFilter := DELCHR("LoopFilter", '>', '|');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnInitReport()
    begin
        SalesReceivableSetup.get();
    end;

    var
        SalesReceivableSetup: Record "Sales & Receivables Setup";
        WorkflowActivitiesER: Record "Workflow Activities - ER";
        AssemblyFilter: Text[2500];
        SequenceDuration: Duration;
        SameSequence: Integer;
        TotalDuration: Duration;
}
