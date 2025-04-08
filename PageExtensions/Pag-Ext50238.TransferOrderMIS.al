pageextension 50238 "Transfer Order MIS" extends "Transfer Order"
{
    layout
    {
        addafter(Status)
        {
            field("Related SO"; Rec."Related SO")
            {
                ApplicationArea = All;
                ToolTip = 'The related sales order.';
                Caption = 'Related SO';
            }
        }
    }
}
