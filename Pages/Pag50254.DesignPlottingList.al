page 50254 "Design Plotting List"
{
    ApplicationArea = All;
    Caption = 'Design Plotting List';
    PageType = List;
    SourceTable = "Design Plotting";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field("Design Code"; Rec."Design Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }*/
                field(Size; Rec.Size)
                {
                    ApplicationArea = All;
                }
                field(Fit; Rec.Fit)
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
            action("Plotting Files")
            {
                ApplicationArea = All;
                Image = Picture;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Plotting Files";
                RunPageLink = "Design Plotting ID" = field(ID);
            }
        }
    }
}
