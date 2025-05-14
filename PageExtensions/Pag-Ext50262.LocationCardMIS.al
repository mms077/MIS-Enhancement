pageextension 50262 "Location Card MIS" extends "Location Card"
{
    layout
    {
        addlast(General)
        {
            field("Shipping Zone Code"; Rec."Shipping Zone Code")
            {
                Caption = 'Shipping Zone Code';
                ApplicationArea = All;
            }
        }
    }
}
