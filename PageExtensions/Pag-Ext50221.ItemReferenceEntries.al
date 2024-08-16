pageextension 50221 "Item Reference Entries" extends "Item Reference Entries"
{
    Editable = false;
    layout
    {
        addlast(Control1)
        {
            field("Unique Code"; Rec."Unique Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
