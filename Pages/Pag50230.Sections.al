page 50230 Sections
{
    ApplicationArea = All;
    Caption = 'Sections';
    PageType = List;
    SourceTable = Section;
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

                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                }
                field(Composition; Rec.Composition)
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
            action("Section Groups")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Section Group";
                RunPageLink = "Section Code" = field(Code);
            }
        }
    }
}