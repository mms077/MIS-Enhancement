page 50298 "Workflow User Names - ER"
{
    ApplicationArea = All;
    Caption = 'Workflow User Names - ER';
    PageType = List;
    SourceTable = "Workflow User Names - ER";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
