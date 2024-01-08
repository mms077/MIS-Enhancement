pageextension 50261 "Gen. Product Posting Groups" extends "Gen. Product Posting Groups"
{
    layout
    {
        addafter("Auto Insert Default"){
            field("Design Mandatory";rec."Design Mandatory"){
                ApplicationArea = All;
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