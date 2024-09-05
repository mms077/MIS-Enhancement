page 50325 "Design Sections Set"
{
    ApplicationArea = All;
    Caption = 'Design Sections Set';
    PageType = List;
    SourceTable = "Design Sections Set";
    UsageCategory = Lists;
    Editable = false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Design Section Set ID"; Rec."Design Section Set ID")
                {
                    ApplicationArea = All;
                }
                field("Design Section Code"; Rec."Design Section Code")
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
                field("Design Sections Count"; Rec."Design Sections Count")
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
    actions
    {
        area(Processing)

        {
            action(UpdateUniqueCombination)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    CUMasterItem: Codeunit MasterItem;
                begin
                    CUMasterItem.UpdateUniqueCombination();
                    Message('Done');
                end;
            }

        }
    }
}
