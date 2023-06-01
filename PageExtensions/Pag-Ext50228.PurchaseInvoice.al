pageextension 50228 "Purchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        addafter(Status)
        {
            field("Posting No. Series 2"; Rec."Posting No. Series")
            {
                ApplicationArea = all;
                Importance = Promoted;
            }
            field("IC Status"; Rec."IC Status")
            {
                ApplicationArea = all;
                Importance = Promoted;
                Editable = false;
            }
        }
    }
}
