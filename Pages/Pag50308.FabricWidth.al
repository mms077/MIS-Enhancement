page 50308 "Fabric Width"
{
    ApplicationArea = All;
    Caption = 'Fabric Width';
    PageType = List;
    SourceTable = "Fabric Width";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Width; Rec.Width)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
