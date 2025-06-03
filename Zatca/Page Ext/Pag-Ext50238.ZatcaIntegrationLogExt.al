pageextension 50238 "Zatca Integration Log Ext" extends "ZATCA Integration Logs"
{
    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        addafter(Print)
        {
            action("Print Doc")
            {
                Caption = 'Print';
                ApplicationArea = all;
                Image = Report;

                trigger OnAction()
                var
                    Invoice: Report "ZATCA Tax Invoice - ER";
                    CreditNote: Report "ZATCA Credit Note - ER";
                    ZatcaLog: Record "ZATCA Integration Logs";
                begin
                    ZatcaLog := Rec;
                    CurrPage.SetSelectionFilter(ZatcaLog);

                    if Rec."Transaction Type" = Rec."Transaction Type"::"Sales Invoice" then begin
                        Invoice.SetTableView(ZatcaLog);
                        Invoice.RunModal();
                    end;

                    if Rec."Transaction Type" = Rec."Transaction Type"::"Sales Credit Memo" then begin
                        CreditNote.SetTableView(ZatcaLog);
                        CreditNote.RunModal();
                    end;
                end;
            }
        }
    }
}
