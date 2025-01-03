page 50238 RMperSalesQuote
{
    ApplicationArea = All;
    Caption = 'RMperSalesQuote';
    PageType = List;
    SourceTable = "RM per Sales Quote";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Sales Quote No."; Rec."Sales Quote No.")
                {
                    ToolTip = 'Specifies the value of the Sales Quote No. field.', Comment = '%';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant field.', Comment = '%';
                }
                field(BUOM; Rec.BUOM)
                {
                    ToolTip = 'Specifies the value of the BUOM field.', Comment = '%';
                }
                field("Required Qty."; Rec."Required Qty.")
                {
                    ToolTip = 'Specifies the value of the Required Qty. field.', Comment = '%';
                }
                field("Available Qty."; Rec."Available Qty.")
                {
                    ToolTip = 'Specifies the value of the Available Qty. field.', Comment = '%';
                }
                field("Missing Qty."; Rec."Missing Qty.")
                {
                    ToolTip = 'Specifies the value of the Missing Qty. field.', Comment = '%';
                }
                field("Req Qty is Missing"; Rec."Req Qty is Missing")
                {
                    ToolTip = 'Specifies the value of the Req Qty is Missing field.', Comment = '%';
                }
            }
        }
    }
}
