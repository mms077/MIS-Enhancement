pageextension 50262 "Location Card MIS" extends "Location Card"
{
    layout
    {
        addafter("Use As In-Transit")
        {
            field("Shipping Location"; Rec."Shipping Location")
            {
                ApplicationArea = All;
                Caption = 'Shipping Location';
                ToolTip = 'Check this box if the location is a shipping location.';
            }
        }
    }
}
