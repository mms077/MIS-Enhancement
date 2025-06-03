page 50209 "Assembly Unit Link List"
{
    ApplicationArea = All;
    Caption = 'Assembly Unit Link List';
    PageType = List;
    SourceTable = "Assembly Unit Link";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Sales Line Unit"; Rec."Sales Line Unit")
                {
                    ToolTip = 'Specifies the value of the Sales Line Unit field.', Comment = '%';
                }
            }
        }
    }
}
