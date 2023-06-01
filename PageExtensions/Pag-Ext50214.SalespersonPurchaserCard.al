pageextension 50214 "Salesperson/Purchaser Card" extends "Salesperson/Purchaser Card"
{
    layout
    {
        addafter("Phone No.")
        {

            field("Extension Number"; Rec."Extension Number")
            {
                ApplicationArea = all;
            }
        }
    }
}
