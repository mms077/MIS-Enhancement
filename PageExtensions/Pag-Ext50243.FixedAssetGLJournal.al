pageextension 50243 "Fixed Asset G/L Journal" extends "Fixed Asset G/L Journal"
{
    layout
    {
        addafter(Amount)
        {
            field("Amount (LCY)"; Rec."Amount (LCY)")
            {
                ApplicationArea = all;
            }
        }
    }
}
