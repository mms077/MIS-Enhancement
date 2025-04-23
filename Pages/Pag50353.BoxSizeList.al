page 50353 "Box Size List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Box Size";
    Caption = 'Box Sizes';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code for the box size.';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description for the box size.';
                }
                field("Length"; Rec."Length")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the length of the box.';
                }
                field("Width"; Rec."Width")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the width of the box.';
                }
                field("Height"; Rec."Height")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the height of the box.';
                }
                field("Volume"; Rec."Volume")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the calculated volume of the box (Length * Width * Height).';
                }
                field("Is Oversize Box"; Rec."Is Oversize Box")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this code represents an oversize/manual packing scenario rather than a physical box.';
                }
            }
        }
    }
}