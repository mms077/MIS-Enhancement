page 50343 "Look Version Positions"
{
    ApplicationArea = All;
    Caption = 'Look Version Positions';
    PageType = List;
    SourceTable = "Look Version Positions";
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
                    ApplicationArea = all;
                    Visible = false;
                }


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
                field(Position; rec.Position) { ApplicationArea = all; }

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
