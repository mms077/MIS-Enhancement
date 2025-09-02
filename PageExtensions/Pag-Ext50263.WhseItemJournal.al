pageextension 50263 "Whse. Item Journal" extends "Whse. Item Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Register and &Print")
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