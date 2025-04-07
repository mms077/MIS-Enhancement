pageextension 50264 "IC Partner Card" extends "IC Partner Card"
{
    layout
    {
        addafter("Currency Code")
        {
            field("Default Shipping Location"; Rec."Default Shipping Location")
            {
                ApplicationArea = all;
            }
        }
    }
}
