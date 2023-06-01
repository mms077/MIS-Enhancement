page 50310 "Document Attachments"
{
    ApplicationArea = All;
    Caption = 'Document Attachments';
    PageType = List;
    SourceTable = "Document Attachment";
    UsageCategory = Lists;

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
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                }
                field("Document Reference ID"; Rec."Document Reference ID")
                {
                    ApplicationArea = All;
                }
                field("Attached By"; Rec."Attached By")
                {
                    ApplicationArea = All;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                }
                field("Document Flow Purchase"; Rec."Document Flow Purchase")
                {
                    ApplicationArea = All;
                }
                field("Document Flow Sales"; Rec."Document Flow Sales")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Report Config. Code"; Rec."VAT Report Config. Code")
                {
                    ApplicationArea = All;
                }
                field("Link Code"; Rec."Link Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
