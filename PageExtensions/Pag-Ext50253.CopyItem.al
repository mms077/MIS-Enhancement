pageextension 50253 CopyItem extends "Copy Item"
{
    layout
    {
        addlast(content)
        {
            group(ER)
            {
                field(Cuts; Rec.Cuts)
                {
                    Caption = 'Item Cuts';
                    ApplicationArea = all;
                    ToolTip = 'Specifies if the selected data type is also copied to the new item.';
                }
                field(Colors; Rec.Colors)
                {
                    Caption = 'Item Colors';
                    ApplicationArea = all;
                    ToolTip = 'Specifies if the selected data type is also copied to the new item.';
                }
                field("Design Section RM"; Rec."Design Section RM")
                {
                    Caption = 'Item Design Section RM';
                    ApplicationArea = all;
                    ToolTip = 'Specifies if the selected data type is also copied to the new item.';
                }
                field(Sizes; Rec.Sizes)
                {
                    Caption = 'Item Sizes';
                    ApplicationArea = all;
                    ToolTip = 'Specifies if the selected data type is also copied to the new item.';
                }
                field(Fits; Rec.Fits)
                {
                    Caption = 'Item Fits';
                    ApplicationArea = all;
                    ToolTip = 'Specifies if the selected data type is also copied to the new item.';
                }
                field(Features; Rec.Features)
                {
                    Caption = 'Item Features';
                    ApplicationArea = all;
                    ToolTip = 'Specifies if the selected data type is also copied to the new item.';
                }
            }
        }
    }
}
