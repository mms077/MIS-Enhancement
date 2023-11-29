page 50229 "Raw Materials"
{
    ApplicationArea = All;
    Caption = 'Raw Materials';
    PageType = List;
    SourceTable = "Raw Material";
    UsageCategory = Lists;
    DeleteAllowed = false;
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
                field("Color ID"; Rec."Color ID")
                {
                    ApplicationArea = All;
                }
                field("UOM Code"; Rec."UOM Code")
                {
                    ApplicationArea = All;
                }
                field("Tonality Code"; Rec."Tonality Code")
                {
                    ApplicationArea = All;
                }
                field("Fabric Code"; Rec."Raw Material Category")
                {
                    ApplicationArea = All;
                }
                /*field("Design Section Code"; Rec."Design Section Code")
                {
                    ApplicationArea = All;
                }*/
            }

        }

    }
}
