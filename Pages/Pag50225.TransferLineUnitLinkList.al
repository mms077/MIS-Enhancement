page 50225 "Transfer Line Unit Link List"
{
    ApplicationArea = All;
    Caption = 'Transfer Line Unit Link List';
    PageType = List;
    SourceTable = "Transfer Line Unit Link";
    UsageCategory = None;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Sales Line Unit"; Rec."Sales Line Unit")
                {
                    ToolTip = 'Specifies the value of the Sales Line Unit field.', Comment = '%';
                }
            }
        }
    }
}
