page 50233 "RM per Sales Quote List"
{
    ApplicationArea = All;
    Caption = 'RM per Sales Quote List';
    PageType = List;
    SourceTable = "RM per Sales Quote";
    UsageCategory = Lists;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Sales Quote No."; Rec."Sales Quote No.")
                {
                    ToolTip = 'Specifies the value of the Sales Quote No. field.', Comment = '%';
                    StyleExpr = StyleExprTxt;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                    StyleExpr = StyleExprTxt;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant field.', Comment = '%';
                    StyleExpr = StyleExprTxt;
                }
                field(BUOM; Rec.BUOM)
                {
                    ToolTip = 'Specifies the value of the BUOM field.', Comment = '%';
                    StyleExpr = StyleExprTxt;
                }
                field("Required Qty."; Rec."Required Qty.")
                {
                    ToolTip = 'Specifies the value of the Required Qty. field.', Comment = '%';
                    StyleExpr = StyleExprTxt;
                }
                field("Available Qty."; Rec."Available Qty.")
                {
                    ToolTip = 'Specifies the value of the Available Qty. field.', Comment = '%';
                    StyleExpr = StyleExprTxt;
                }
                field("Missing Qty."; Rec."Missing Qty.")
                {
                    ToolTip = 'Specifies the value of the Missing Qty. field.', Comment = '%';
                    StyleExpr = StyleExprTxt;
                }
                field("Req Qty is Missing"; Rec."Req Qty is Missing")
                {
                    ToolTip = 'Specifies the value of the Req Qty is Missing field.', Comment = '%';
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Req Qty is Missing" then
            StyleExprTxt := 'Unfavorable'
        else
            StyleExprTxt := 'Standard';
    end;

    trigger OnOpenPage()
    begin
        Rec.FindFirst();
    end;

    var
        StyleExprTxt: Text[20];
}
