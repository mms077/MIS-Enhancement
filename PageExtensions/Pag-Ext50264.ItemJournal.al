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

            action("AdjustLocations2023")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Image = AdjustEntries;
                trigger OnAction()
                var
                    AdjustLocCU: Codeunit AdjustLocationsGF2023;
                begin
                    AdjustLocCU.Run();
                end;
            }
            action("AdjustLocations2024")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Image = AdjustEntries;
                trigger OnAction()
                var
                    AdjustLocCU: Codeunit AdjustLocationsGF2024;
                begin
                    AdjustLocCU.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}