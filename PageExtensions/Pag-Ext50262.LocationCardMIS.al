pageextension 50262 "Location Card MIS" extends "Location Card"
{
    layout
    {
        addlast(General)
        {
            field("Shipping Location"; Rec."Shipping Location")
            {
                Caption = 'Shipping Location';
                ApplicationArea = All;
            }
            field("Shipping Zone Code"; Rec."Shipping Zone Code")
            {
                Caption = 'Shipping Zone Code';
                ApplicationArea = All;
            }
        }
    }
}
