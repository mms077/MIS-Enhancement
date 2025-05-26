page 50369 "Daily Transfer Lines Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Daily Transfer Line";
    Caption = 'Daily Transfer Lines';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the line number.';
                    Visible = false;
                    Editable = false;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source location for this transfer line.';
                    Editable = false;
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the destination location for this transfer line.';
                    Editable = false;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the serial number for this transfer line.';
                    Editable = false;
                }
                field("Transfer Order No."; Rec."Transfer Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related transfer order number.';
                    Editable = false;
                }
                field("Transfer Line No."; Rec."Transfer Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related transfer order line number.';
                    Editable = false;
                }
                field("Warning"; Rec."Warning")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows warnings for this line.';
                    Style = Attention;
                    StyleExpr = Rec."Warning" <> '';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DeleteLine)
            {
                ApplicationArea = All;
                Caption = 'Delete Line';
                Image = Delete;
                ToolTip = 'Delete the selected line.';

                trigger OnAction()
                begin
                    if Confirm('Do you want to delete this line?') then begin
                        Rec.Delete(true);
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        DailyTransferMgt: Codeunit "Daily Transfer Management";
    begin
        Rec."Line No." := DailyTransferMgt.GetNextLineNo(Rec."No.");
    end;
}
