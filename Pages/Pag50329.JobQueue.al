page 50329 "Job Queue Selection"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Job Queue Selection";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Job Queue Id"; rec."Job Queue Id")
                {
                    ApplicationArea = All;

                }
                field("Job Queue Description"; rec."Job Queue Description") { ApplicationArea = all; }
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
            action("Make JobQueue Ready")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    jobQEntry: Record "Job Queue Entry";
                    MakeStatusReady: Codeunit "Make Job Queue Status Ready";
                begin
                    MakeStatusReady.Run();

                end;
            }
        }
    }
}