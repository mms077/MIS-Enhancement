page 50226 "Measurements"
{
    ApplicationArea = All;
    Caption = 'Measurements';
    PageType = List;
    SourceTable = "Measurement";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Show On Label"; Rec."Show On Label")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Categories")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Measurement Categories";
                RunPageLink = "Measurement Code" = field(Code);
            }
        }
    }
}