pageextension 50262 "Revaluation Journal Ext" extends "Revaluation Journal"
{
    actions
    {
        addafter("Calculate Inventory Value")
        {
            action("Revalue Items 2023")
            {
                ApplicationArea = All;
                Caption = 'Revalue Items 2023';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Revalues items from 2023 with specific pricing rules.';

                trigger OnAction()
                var
                    RevalJnlLine: Record "Item Journal Line";
                    RevalueItems2023: Report "Revalue Items 2023";
                begin
                    RevalJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    RevalJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");

                    // Pass template and batch name to the report
                    RevalueItems2023.RunModal();
                end;
            }
        }
    }
}
