page 50273 "Item Features Param Lines"
{
    Caption = 'Item Features Parameters';
    PageType = ListPart;
    SourceTable = "Item Features Param Lines";
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Feature Name"; Rec."Feature Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Value"; Rec."Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Color ID"; Rec."Color Id")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Instructions; Rec.Instructions)
                {
                    ApplicationArea = All;
                }

            }
        }

    }
}
