pageextension 50264 "Item Journal" extends "Item Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Post and &Print")
        {

            action("AdjustLocations")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Image = AdjustEntries;
                trigger OnAction()
                var
                    AdjustLocCU: Codeunit AdjustLocations;
                begin
                    AdjustLocCU.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}