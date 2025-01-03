page 50225 "MO Stock Avl. Warning Log List"
{
    ApplicationArea = All;
    Caption = 'MO Stock Avl. Warning Log List';
    PageType = List;
    SourceTable = "MO Stock Avl. Warning Log";
    UsageCategory = Administration;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Manufacturing Order No."; Rec."Manufacturing Order No.")
                {
                    ToolTip = 'Specifies the value of the Manufacturing Order No. field.', Comment = '%';
                }
                field(User; Rec.User)
                {
                    ToolTip = 'Specifies the value of the User field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
            }
        }
    }
}
