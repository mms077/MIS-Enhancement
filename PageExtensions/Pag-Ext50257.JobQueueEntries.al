pageextension 50257 "Job Queue Entries" extends "Job Queue Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Restart)
        {
            action("Set Job Queue Ready")

            {
                ApplicationArea = All;
                Image = ChangeTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Job Queue Selection";
            }
        }
    }

    var
        myInt: Integer;
}