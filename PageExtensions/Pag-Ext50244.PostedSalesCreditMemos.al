pageextension 50244 "Posted Sales Credit Memos" extends "Posted Sales Credit Memos"
{
    actions
    {
        addfirst(Reporting)
        {
            action(CreditNote)
            {
                ApplicationArea = All;
                Caption = 'Credit Note';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = CreditMemo;
                trigger OnAction()
                var
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                begin
                    Clear(SalesCreditMemoHeader);
                    SalesCreditMemoHeader.SetRange("No.", Rec."No.");
                    if SalesCreditMemoHeader.FindFirst() then
                        report.run(50215, true, false, SalesCreditMemoHeader);
                end;
            }
            action(ARCreditNote)
            {
                ApplicationArea = All;
                Caption = 'Arabic Credit Note';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = CreditMemo;
                trigger OnAction()
                var
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                begin
                    Clear(SalesCreditMemoHeader);
                    SalesCreditMemoHeader.SetRange("No.", Rec."No.");
                    if SalesCreditMemoHeader.FindFirst() then
                        report.run(50231, true, false, SalesCreditMemoHeader);
                end;
            }
            action(ReturnInvoice)
            {
                ApplicationArea = All;
                Caption = 'Return Invoice';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = ReturnOrder;
                trigger OnAction()
                var
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                begin
                    Clear(SalesCreditMemoHeader);
                    SalesCreditMemoHeader.SetRange("No.", Rec."No.");
                    if SalesCreditMemoHeader.FindFirst() then
                        report.run(50214, true, false, SalesCreditMemoHeader);
                end;
            }
            action(ArabicReturnInvoice)
            {
                ApplicationArea = All;
                Caption = 'Arabic Return Invoice';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = ReturnOrder;
                trigger OnAction()
                var
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                begin
                    Clear(SalesCreditMemoHeader);
                    SalesCreditMemoHeader.SetRange("No.", Rec."No.");
                    if SalesCreditMemoHeader.FindFirst() then
                        report.run(50230, true, false, SalesCreditMemoHeader);
                end;
            }
        }
    }
}
