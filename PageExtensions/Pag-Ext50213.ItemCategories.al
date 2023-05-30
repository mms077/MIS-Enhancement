pageextension 50213 "Item Categories" extends "Item Categories"
{
    layout
    {
        addafter(Description)
        {

            field("Ean Start"; Rec."Ean Start")
            {
                ApplicationArea = all;
            }
            field("Ean Ending"; Rec."Ean Ending")
            {
                ApplicationArea = all;
            }
            field("Ean Current"; Rec."Ean Current")
            {
                ApplicationArea = all;
            }
        }
    }
}
