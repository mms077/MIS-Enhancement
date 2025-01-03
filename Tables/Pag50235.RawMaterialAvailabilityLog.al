page 50235 "Raw Material Availability Log"
{
    ApplicationArea = All;
    Caption = 'Raw Material Availability Log';
    PageType = List;
    SourceTable = "Raw Material Availability Log";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("SQ Number"; Rec."SQ Number")
                {
                    ToolTip = 'Specifies the value of the SQ Number field.', Comment = '%';
                }
                field(User; Rec.User)
                {
                    ToolTip = 'Specifies the value of the User field.', Comment = '%';
                }
                field("Number of unique items"; Rec."Number of unique items")
                {
                    ToolTip = 'Specifies the value of the Number of unique items field.', Comment = '%';
                }
            }
        }
    }
}
