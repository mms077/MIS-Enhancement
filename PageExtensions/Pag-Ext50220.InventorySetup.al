pageextension 50265 "Inventory Setup Extension" extends "Inventory Setup"
{
    layout
    {
        addafter("Automatic Cost Adjustment")
        {
            group("Daily Transfer")
            {
                Caption = 'Daily Transfer';
                field("Daily Transfer Nos."; Rec."Daily Transfer Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for Daily Transfer documents.';
                }
            }
        }
    }
}
