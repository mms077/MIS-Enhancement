page 50262 "Design Details Fits Values"
{
    Caption = 'Design Details Fits Values';
    PageType = ListPart;
    SourceTable = "Design Details Fits Values";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field("Design Code"; Rec."Design Code")
                {
                    ApplicationArea = All;
                }*/
                field("Fit Code"; Rec."Fit Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
