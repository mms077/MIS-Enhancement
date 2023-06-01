page 50251 "Features"
{
    ApplicationArea = All;
    Caption = 'Features';
    PageType = List;
    SourceTable = "Feature";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                }*/
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Name Local"; Rec."Name Local")
                {
                    ApplicationArea = All;
                }
                field("Cost"; Rec.Cost)
                {
                    ApplicationArea = All;
                }
                /*field("Instructions"; Rec.Instructions)
                {
                    ApplicationArea = All;
                }*/
                field("Has Color"; Rec."Has Color")
                {
                    ApplicationArea = all;
                }
                field("Sorting Number"; Rec."Sorting Number")
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
            action("Possible Values")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Item Feature Possible Values";
                RunPageLink = "Feature Name" = field(Name);
            }
            action("Feature Types")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Features Types";
                RunPageLink = "Feature Name" = field(Name);
            }
        }
    }
}
