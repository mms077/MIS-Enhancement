page 50356 "Scan Activities List"
{
    //ApplicationArea = All;
    Caption = 'Scan Activities';
    PageType = List;
    SourceTable = "Scan Activities";
    UsageCategory = Lists;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Sales Line Unit Ref."; Rec."Sales Line Unit Ref.") { ApplicationArea = all; }
                field("Sales Line  Ref."; Rec."Sales Line  Ref.") { ApplicationArea = all; }
                field("Assembly No."; Rec."Assembly No.") { ApplicationArea = all; }
                field("ER - Manufacturing Order No."; rec."ER - Manufacturing Order No.") { ApplicationArea = all; }
                field("Item No."; Rec."Item No.") { ApplicationArea = all; }
                field(Design; Rec.Design) { ApplicationArea = all; }
                field("Item Category"; Rec."Item Category") { ApplicationArea = all; }
                field("Variant Code"; Rec."Variant Code") { ApplicationArea = all; }
                field("Source No."; Rec."Source No.") { ApplicationArea = all; }
                field("Scan Activity Name"; Rec."Scan Activity Name") { ApplicationArea = all; }
                field("In/Out"; Rec."In/Out") { ApplicationArea = all; }
                field("Starting Time"; Rec."Starting Time") { ApplicationArea = all; }
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
