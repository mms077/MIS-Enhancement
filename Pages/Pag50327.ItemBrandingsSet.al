page 50327 "Item Brandings Set"
{
    ApplicationArea = All;
    Caption = 'Item Brandings Set';
    PageType = List;
    SourceTable = "Item Brandings Set";
    UsageCategory = Lists;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Branding Set ID"; Rec."Item Branding Set ID")
                {
                    ApplicationArea = All;
                }
                field("Item Branding Code"; Rec."Item Branding Code")
                {
                    ApplicationArea = All;
                }
                field("Brandings Count In Set"; Rec."Brandings Count In Set")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
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
