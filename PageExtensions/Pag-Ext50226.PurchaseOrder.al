pageextension 50226 "Purchase Order" extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field("IC Status"; Rec."IC Status")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addbefore(Control94)
        {
            field("IC Company Name"; Rec."IC Company Name")
            {
                Caption = 'IC Company Name';
                ApplicationArea = all;
            }
            field("IC Source No."; Rec."IC Source No.")
            {
                ApplicationArea = all;
            }
        }
    }
}