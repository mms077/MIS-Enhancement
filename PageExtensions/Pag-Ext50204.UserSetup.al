pageextension 50204 "User Setup - ER" extends "User Setup"
{
    layout
    {
        addafter(PhoneNo)
        {
            field("Delete Design"; Rec."Delete Design")
            {
                ApplicationArea = all;
                ToolTip = 'Delete design';
            }
            field("Modify Assembly"; Rec."Modify Assembly")
            {
                ApplicationArea = all;
                ToolTip = 'Modify assembly';
            }
            /*field("Create Assemb. From Batch"; Rec."Create Assemb. From Batch")
            {
                ApplicationArea = All;
                Caption = 'Create Assembly From Batch';
            }*/
            field("Delete Itemy"; Rec."Delete Item")
            {
                ApplicationArea = all;
                ToolTip = 'Delete Item';
            }
            field("Delete Raw Material"; Rec."Delete Raw Material")
            {
                ApplicationArea = all;
            }
            field("Delete MO"; Rec."Delete MO")
            {
                ApplicationArea = all;
            }
            field("Delete Variant"; Rec."Delete Variant")
            {
                ApplicationArea = all;
            }
            field("Modify Payment Terms"; Rec."Modify Payment Terms")
            {
                ApplicationArea = all;
                ToolTip = 'Modify Payment Terms field';
            }
            field("Show Cost"; Rec."Show Cost")
            {
                ApplicationArea = all;
            }
            field("Show Sales Price"; Rec."Show Sales Price")
            {
                ApplicationArea = all;
            }
            field("Release Sales Documents"; Rec."Release Sales Documents")
            {
                ApplicationArea = all;
            }
            field("Reset No. Of Copies"; Rec."Reset No. Of Copies")
            {
                ApplicationArea = all;
                ToolTip = 'Allow reset the No. Of Copies in ER-Manufaturing Order';
            }
        }
    }
}

