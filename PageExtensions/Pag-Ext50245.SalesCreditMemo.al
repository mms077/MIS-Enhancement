pageextension 50245 "Sales Credit Memo" extends "Sales Credit Memo"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("Cust Project"; Rec."Cust Project")
            {
                ApplicationArea = all;
            }
        }
    }
}
