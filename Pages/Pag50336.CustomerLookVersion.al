page 50336 "Customer Look Version"
{
    ApplicationArea = All;
    Caption = 'Customer Look Version';
    PageType = List;
    SourceTable = "Customer Look Version";
    UsageCategory = Lists;
    //DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;

                }
                field("Is Printable"; rec."Is Printable") { ApplicationArea = all; }
                field(code; Rec.code) { ApplicationArea = all; Visible = false; }

                field("Look Code"; Rec."Look Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Look Version Code"; Rec."Look Version Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }

            }

        }
        area(factboxes)
        {
            /* part(ItemPicture; "Design Picture")
             {
                 ApplicationArea = All;
                 Caption = 'Picture';
                 SubPageLink = "Code" = FIELD();
             }
             part("Attached Documents"; "Document Attachment Factbox")
             {
                 ApplicationArea = All;
                 Caption = 'Attachments';
                 SubPageLink = "Table ID" = CONST(50292),
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

    actions
    {
        area(Processing)
        {
            action("Look Version Position")
            {
                ApplicationArea = All;
                Image = Position;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Look Version Positions";
                RunPageLink = "Look Code" = field("Look Code"), "Look Version Code" = field("Look Version Code"), "Customer No." = field("Customer No.");
                trigger OnAction()
                begin

                end;
            }

        }
    }
    trigger OnAfterGetRecord()
    begin

    end;




    var
        User: Record User;
        User2: Record User;
        UserCreater: Code[50];
        UserModifier: Code[50];
}
