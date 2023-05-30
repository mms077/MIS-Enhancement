pageextension 50241 "Company Information" extends "Company Information"
{
    layout
    {
        addafter("Address 2")
        {
            field(Capital; Rec.Capital)
            {
                ApplicationArea = all;
            }
            field("CR No."; Rec."CR No.")
            {
                ApplicationArea = All;
            }
        }

        addafter("Giro No.")
        {
            field("RIB."; Rec."RIB")
            {
                Caption = 'RIB';
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}

