page 50253 "Item Feature Possible Values"
{
    ApplicationArea = All;
    Caption = 'Item Feature Possible Values';
    PageType = List;
    SourceTable = "Item Feature Possible Values";
    UsageCategory = Lists;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Feature Name"; Rec."Feature Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Possible Value"; Rec."Possible Value")
                {
                    ApplicationArea = All;
                }
                field("Possible Value Local"; Rec."Possible Value Local")
                {
                    ApplicationArea = All;
                }
                field(Instructions; Rec.Instructions)
                {
                    ApplicationArea = all;
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = all;
                }
                field("Has Color"; Rec."Has Color")
                {
                    ApplicationArea = all;
                }
                field("Affect Plotting"; Rec."Affect Plotting")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(FeaturePicture; "Possible Value Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Possible Value" = FIELD("Possible Value"), "Feature Name" = field("Feature Name");
            }
            /*part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(502151),
                              "No." = FIELD(Code);
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = true;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }*/
        }
    }
}
