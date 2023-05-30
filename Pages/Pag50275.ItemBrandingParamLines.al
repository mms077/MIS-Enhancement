page 50275 "Item Branding Param Lines"
{
    Caption = 'Item Branding Parameters';
    PageType = ListPart;
    SourceTable = "Item Branding Param Lines";
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Include; Rec.Include)
                {
                    ApplicationArea = all;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = all;
                }
            }
        }

    }
}
