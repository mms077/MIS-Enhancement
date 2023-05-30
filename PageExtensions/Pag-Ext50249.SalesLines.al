pageextension 50249 "Sales Lines" extends "Sales Lines"
{
    layout
    {
        addbefore("Document Type")
        {
            field("Parameters Header ID"; Rec."Parameters Header ID")
            {
                ApplicationArea = all;
            }
            field("Parent Parameter Header ID"; Rec."Parent Parameter Header ID")
            {
                ApplicationArea = all;
            }
        }
    }
}
