page 50215 "Raw Material Categories"
//page 50215 Fabrics
{
    ApplicationArea = All;
    Caption = 'Raw Material Categories';
    PageType = List;
    SourceTable = "Raw Material Category";
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
                /*field("Design Section Code"; Rec."Design Section Code")
                {
                    ApplicationArea = All;
                }*/
                field("Related Design Sections Count"; Rec."Related Design Sections Count")
                {
                    ApplicationArea = All;
                }
                field("Related Raw Materials Count"; Rec."Related Raw Materials Count")
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
            action("Related Design Sections")
            {
                ApplicationArea = All;
                Caption = 'Related Design Sections';
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "RM Categories Design Sections";
                RunPageLink = "RM Category Code" = field("Code");
            }
            action("Related Raw Materials")
            {
                ApplicationArea = All;
                Caption = 'Related Raw Materials';
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Raw Materials";
                RunPageLink = "Raw Material Category" = field("Code");
            }
        }
    }
}
