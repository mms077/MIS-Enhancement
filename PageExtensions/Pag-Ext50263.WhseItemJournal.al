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

            action("AdjustLocations2023")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Image = AdjustEntries;
                trigger OnAction()
                var
                    AdjustLocCU: Codeunit AdjustLocations2023;
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
                    AdjustLocCU: Codeunit AdjustLocations2024;
                begin
                    AdjustLocCU.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}