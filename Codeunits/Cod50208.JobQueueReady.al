codeunit 50208 "Make Job Queue Status Ready"
{
    trigger OnRun()
    begin


    end;


    procedure MakeStatusReady()
    var
        myInt: Integer;
        JobQSelection: Record "Job Queue Selection";
    begin


        if JobQSelection.FindFirst() then
            repeat
                jobQEntry.SetFilter("Object ID to Run", JobQSelection."Job Queue Id");
                jobQEntry.SETFILTER(Status, '<>%1', jobQEntry.Status::Ready);

                if jobQEntry.FindFirst() then
                    repeat
                        jobQEntry.Status := jobQEntry.Status::Ready;
                        jobQEntry.Modify();
                    until jobQEntry.Next() = 0;
            until JobQSelection.Next() = 0;
    end;

    var
        myInt: Integer;
        jobQEntry: Record "Job Queue Entry";

}
