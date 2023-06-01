pageextension 50203 "No. Series" extends "No. Series"
{
    layout
    {
        addafter("Manual Nos.")
        {
            field("Item Category"; Rec."Item Category")
            {
                ApplicationArea = all;
            }
        }
    }
}
