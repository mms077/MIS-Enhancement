page 50214 "Design Sections"
{
    ApplicationArea = All;
    Caption = 'Design Sections';
    PageType = List;
    SourceTable = "Design Section";
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
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                }
                field("UOM Code"; Rec."UOM Code")
                {
                    ApplicationArea = All;
                }
                field("Related RM Categories Count"; Rec."Related RM Categories Count")
                {
                    ApplicationArea = All;
                }
                field(Composition; Rec.Composition)
                {
                    ApplicationArea = All;
                }
                field("Unique Color"; Rec."Unique Color")
                {
                    ApplicationArea = all;
                }
                field("Show Picture On Report"; Rec."Show Picture On Report")
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
            action(RelatedRMCategories)
            {
                Caption = 'Related RM Categories';
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "RM Categories Design Sections";
                RunPageLink = "Design Section Code" = field("Code"), "Design Type" = field("Design Type Filter");
            }
        }
    }
}