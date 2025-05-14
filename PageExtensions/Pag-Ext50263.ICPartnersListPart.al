pageextension 50263 "IC Partners List Part" extends "IC Partners List Part"
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
