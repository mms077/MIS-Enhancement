pageextension 50222 "Payment Terms" extends "Payment Terms"
{
    layout
    {
        addafter(Description)
        {
            field("Prepayment %"; Rec."Prepayment %")
            {
                ApplicationArea = all;
            }
        }
    }
}
