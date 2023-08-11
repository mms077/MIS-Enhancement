page 50329 "Job Queue Selection"
{
    PageType = List;
    //ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Job Queue Selection";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Job Queue Id"; rec."Job Queue Id")
                {
                    ApplicationArea = All;
                }
                field("Job Queue Description"; rec."Job Queue Description")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Set Job Queue Status Ready")
            {
                ApplicationArea = All;
                Image = ChangeTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction();
                var
                    SetJobQueueReady: Codeunit "Set Job Queue Ready";
                begin
                    SetJobQueueReady.Run();
                end;
            }
        }
    }
}