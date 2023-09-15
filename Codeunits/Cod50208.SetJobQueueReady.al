codeunit 50208 "Set Job Queue Ready"
{
    trigger OnRun()
    var
        JobQSelection: Record "Job Queue Selection";
        JobQueueManagement: Codeunit "Job Queue Management";
    begin
        if JobQSelection.FindFirst() then
            repeat
                JobQEntry.SetFilter("Object ID to Run", JobQSelection."Job Queue Id");
                JobQEntry.SetFilter(Status, '<>%1', JobQEntry.Status::Ready);
                if JobQEntry.FindFirst() then
                    repeat
                        JobQEntry.Status := JobQEntry.Status::"Ready";
                        JobQEntry.Modify();
                        JobQueueManagement.RunJobQueueEntryOnce(JobQEntry);
                    //Codeunit.run(Codeunit::"Job Queue Dispatcher", JobQEntry);
                    until JobQEntry.Next() = 0;
            until JobQSelection.Next() = 0;
    end;


    procedure RunJobQueueEntryOnce(var SelectedJobQueueEntry: Record "Job Queue Entry")
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueLogEntry: Record "Job Queue Log Entry";
        SuccessDispatcher: Boolean;
        SuccessErrorHandler: Boolean;
        Window: Dialog;
        CurrentLanguage: Integer;
        Dimensions: Dictionary of [Text, Text];
        TelemetrySubscribers: Codeunit "Telemetry Subscribers";
        RunOnceQst: label 'This will create a temporary non-recurrent copy of this job and will run it once in the foreground.\Do you want to continue?';
        ExecuteBeginMsg: label 'Executing job queue entry...';
        ExecuteEndSuccessMsg: label 'Job finished executing.\Status: %1', Comment = '%1 is a status value, e.g. Success';
        ExecuteEndErrorMsg: label 'Job finished executing.\Status: %1\Error: %2', Comment = '%1 is a status value, e.g. Success, %2=Error message';
        JobSomethingWentWrongMsg: Label 'Something went wrong and the job has stopped. Likely causes are system updates or routine maintenance processes. To restart the job, set the status to Ready.';
        JobQueueDelegatedAdminCategoryTxt: Label 'AL JobQueueEntries Delegated Admin', Locked = true;
        JobQueueStatusChangeTxt: Label 'The status for Job Queue Entry: %1 has changed.', Comment = '%1 is the Job Queue Entry Id', Locked = true;
        StaleJobQueueEntryTxt: Label 'Stale Job Queue Entry', Locked = true;
        StaleJobQueueLogEntryTxt: Label 'Stale Job Queue Log Entry', Locked = true;
        RunJobQueueOnceTxt: Label 'Running job queue once.', Locked = true;
        JobQueueWorkflowSetupErr: Label 'The Job Queue approval workflow has not been setup.';
        DelegatedAdminSendingApprovalLbl: Label 'Delegated admin sending approval', Locked = true;

    begin
        Window.Open(ExecuteBeginMsg);
        SelectedJobQueueEntry.CalcFields(XML);
        JobQueueEntry := SelectedJobQueueEntry;
        JobQueueEntry.ID := CreateGuid();
        JobQueueEntry."User ID" := copystr(UserId(), 1, MaxStrLen(JobQueueEntry."User ID"));
        JobQueueEntry."Recurring Job" := false;
        JobQueueEntry.Status := JobQueueEntry.Status::"Ready";
        JobQueueEntry."Job Queue Category Code" := '';
        clear(JobQueueEntry."Expiration Date/Time");
        clear(JobQueueEntry."System Task ID");
        JobQueueEntry.Insert(true);
        Commit();

        CurrentLanguage := GlobalLanguage();
        GlobalLanguage(1033);

        SetJobQueueTelemetryDimensions(JobQueueEntry, Dimensions);

        Session.LogMessage('0000FMG', RunJobQueueOnceTxt, Verbosity::Normal, DataClassification::OrganizationIdentifiableInformation, TelemetryScope::All, Dimensions);
        GlobalLanguage(CurrentLanguage);

        // Run the job queue
        SuccessDispatcher := Codeunit.run(Codeunit::"Job Queue Dispatcher", JobQueueEntry);

        // If JQ fails, run the error handler
        if not SuccessDispatcher then begin
            SuccessErrorHandler := Codeunit.run(Codeunit::"Job Queue Error Handler", JobQueueEntry);

            // If the error handler fails, save the error (Non-AL errors will automatically surface to end-user)
            // If it is unable to save the error (No permission etc), it should also just be surfaced to the end-user.
            if not SuccessErrorHandler then begin
                JobQueueEntry.SetError(GetLastErrorText());
                JobQueueEntry.InsertLogEntry(JobQueueLogEntry);
                JobQueueEntry.FinalizeLogEntry(JobQueueLogEntry, GetLastErrorCallStack());
                Commit();
            end;
        end;

        Window.Close();
        if JobQueueEntry.Find() then
            if JobQueueEntry.Delete() then;
        JobQueueLogEntry.SetRange(ID, JobQueueEntry.id);
        if JobQueueLogEntry.FindFirst() then
            if JobQueueLogEntry.Status = JobQueueLogEntry.Status::Success then
                Message(ExecuteEndSuccessMsg, JobQueueLogEntry.Status)
            else
                Message(ExecuteEndErrorMsg, JobQueueLogEntry.Status, JobQueueLogEntry."Error Message");
    end;

    internal procedure SetJobQueueTelemetryDimensions(var JobQueueEntry: Record "Job Queue Entry"; var Dimensions: Dictionary of [Text, Text])
    begin
        JobQueueEntry.CalcFields("Object Caption to Run");
        Dimensions.Add('Category', JobQueueEntriesCategoryTxt);
        Dimensions.Add('JobQueueId', Format(JobQueueEntry.ID, 0, 4));
        Dimensions.Add('JobQueueObjectName', Format(JobQueueEntry."Object Caption to Run"));
        Dimensions.Add('JobQueueObjectDescription', Format(JobQueueEntry.Description));
        Dimensions.Add('JobQueueObjectType', Format(JobQueueEntry."Object Type to Run"));
        Dimensions.Add('JobQueueObjectId', Format(JobQueueEntry."Object ID to Run"));
        Dimensions.Add('JobQueueStatus', Format(JobQueueEntry.Status));
        Dimensions.Add('JobQueueIsRecurring', Format(JobQueueEntry."Recurring Job"));
        Dimensions.Add('JobQueueEarliestStartDateTime', Format(JobQueueEntry."Earliest Start Date/Time", 0, 9)); // UTC time
        Dimensions.Add('JobQueueCompanyName', JobQueueEntry.CurrentCompany());
        Dimensions.Add('JobQueueScheduledTaskId', Format(JobQueueEntry."System Task ID", 0, 4));
        Dimensions.Add('JobQueueMaxNumberOfAttemptsToRun', Format(JobQueueEntry."Maximum No. of Attempts to Run"));
        Dimensions.Add('JobQueueNumberOfAttemptsToRun', Format(JobQueueEntry."No. of Attempts to Run"));
    end;

    var
        myInt: Integer;
        JobQEntry: Record "Job Queue Entry";
        JobQueueEntriesCategoryTxt: Label 'AL JobQueueEntries', Locked = true;

}
