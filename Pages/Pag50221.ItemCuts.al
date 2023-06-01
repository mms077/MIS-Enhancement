page 50221 "Item Cuts"
{
    ApplicationArea = All;
    Caption = 'Item Cuts';
    PageType = List;
    SourceTable = "Item Cut";
    UsageCategory = Lists;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }*/
                field("Cut Code"; Rec."Cut Code")
                {
                    ApplicationArea = All;
                }
                field("Cut Name"; Rec."Cut Name")
                {
                    ApplicationArea = All;
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
