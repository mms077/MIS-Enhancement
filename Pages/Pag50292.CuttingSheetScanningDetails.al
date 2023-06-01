page 50292 "Cutting Sheet Scanning Details"
{
    ApplicationArea = All;
    Caption = 'Cutting Sheet Scanning Details';
    PageType = List;
    SourceTable = "Cutting Sheet Scanning Details";
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
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field("Assembly No."; Rec."Assembly No.")
                {
                    ApplicationArea = All;
                }
                field("Scan Type"; Rec."Scan Type")
                {
                    ApplicationArea = All;
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ApplicationArea = all;
                }
                field(Username; Rec.Username)
                {
                    ApplicationArea = all;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}