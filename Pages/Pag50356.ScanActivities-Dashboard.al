page 50356 "Scan Activities List"
{
    //ApplicationArea = All;
    Caption = 'Scan Activities';
    PageType = List;
    SourceTable = "Scan Activities";
    UsageCategory = Lists;
    ModifyAllowed = false;
    DeleteAllowed = true;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Serial No."; Rec."Serial No.") { ApplicationArea = all; }
                field("Sales Line  Ref."; Rec."Sales Line Id") { ApplicationArea = all; }
                field("Assembly No."; Rec."Assembly No.") { ApplicationArea = all; }
                field("ER - Manufacturing Order No."; rec."ER - Manufacturing Order No.") { ApplicationArea = all; }
                field("Item No."; Rec."Item No.") { ApplicationArea = all; }
                field(Design; Rec."Design Code") { ApplicationArea = all; }
                //field("Item Category"; Rec."Item Category") { ApplicationArea = all; }
                field("Variant Code"; Rec."Variant Code") { ApplicationArea = all; }
                field("Source No."; Rec."Source No.") { ApplicationArea = all; }
                field("Scan Activity Name"; Rec."Activity Name") { ApplicationArea = all; }
                field("In/Out"; Rec."Activity Type") { ApplicationArea = all; }
                field("Starting Time"; Rec."Activity Date") { ApplicationArea = all; }
                field("Activity Time"; Rec."Activity Time") { ApplicationArea = all; }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Details")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Cutting Sheet Scanning Details";
                RunPageLink = "Assembly No." = field("Assembly No.");
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
    begin

    end;

    trigger OnOpenPage()
    begin

    end;



}
