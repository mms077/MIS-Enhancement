page 50313 "Plotting File Measurements"
{
    ApplicationArea = All;
    Caption = 'Plotting File Measurements';
    PageType = List;
    SourceTable = "Plotting File Measurement";
    UsageCategory = Lists;
    //InsertAllowed = false;
    //DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Plotting File ID"; Rec."Plotting File ID")
                {
                    ApplicationArea = All;
                }
                field("Section"; Rec."Section")
                {
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = all;
                }
                field("Section Group"; Rec."Section Group")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }
                field("Fabric Width"; Rec."Fabric Width")
                {
                    ApplicationArea = all;
                }
                field("No. Of Pieces"; Rec."No. Of Pieces")
                {
                    ApplicationArea = all;
                }
                field("Efficiency %"; Rec."Efficiency %")
                {
                    ApplicationArea = all;
                }
                field("Estimate %"; Rec."Estimate %")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
