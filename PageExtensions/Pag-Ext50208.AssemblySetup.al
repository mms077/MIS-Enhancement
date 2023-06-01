pageextension 50208 "Assembly Setup" extends "Assembly Setup"
{
    layout
    {
        addafter("Posted Assembly Order Nos.")
        {
            field("Workflow User Group Code"; Rec."Workflow User Group Code")
            {
                ApplicationArea = all;
            }
        }

    }
}
