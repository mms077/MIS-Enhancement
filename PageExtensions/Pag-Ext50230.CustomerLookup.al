pageextension 50230 "Customer Lookup" extends "Customer Lookup"
{
    layout
    {
        addafter(Name)
        {
            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = all;
            }
        }
    }
}