page 50326 "Item Features Set"
{
    ApplicationArea = All;
    Caption = 'Item Features Set';
    PageType = List;
    SourceTable = "Item Features Set";
    UsageCategory = Lists;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Feature Set ID"; Rec."Item Feature Set ID")
                {
                    ApplicationArea = All;
                }
                field("Item Feature Name"; Rec."Item Feature Name")
                {
                    ApplicationArea = All;
                }
                field("Value"; Rec."Value")
                {
                    ApplicationArea = All;
                }
                field("Color Id"; Rec."Color Id")
                {
                    ApplicationArea = All;
                }
                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                }
                field("Features Count"; Rec."Features Count")
                {
                    ApplicationArea = All;
                }
                field("Unique Combination"; Rec."Unique Combination")
                {
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
