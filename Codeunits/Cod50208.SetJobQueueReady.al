codeunit 50208 "Set Job Queue Ready"
{
    trigger OnRun()
    var
        JobQSelection: Record "Job Queue Selection";
    begin
        if JobQSelection.FindFirst() then
            repeat
                JobQEntry.SetFilter("Object ID to Run", JobQSelection."Job Queue Id");
                JobQEntry.SetFilter(Status, '<>%1', JobQEntry.Status::Ready);
                if JobQEntry.FindFirst() then
                    repeat
                        JobQEntry.Status := JobQEntry.Status::"Ready";
                        JobQEntry.Modify(true);
                        Codeunit.run(Codeunit::"Job Queue Dispatcher", JobQEntry);
                    until JobQEntry.Next() = 0;
            until JobQSelection.Next() = 0;
    end;

    var
        myInt: Integer;
        JobQEntry: Record "Job Queue Entry";

}
