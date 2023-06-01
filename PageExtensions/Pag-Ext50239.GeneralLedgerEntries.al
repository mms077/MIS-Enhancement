pageextension 50239 "General Ledger Entries" extends "General Ledger Entries"
{
    layout
    {
        /*addafter("Additional-Currency Amount")
        {
            field("Original Currency - ER"; Rec."Original Currency - ER")
            {
                ApplicationArea = all;
            }
            field("Original Amount - ER"; Rec."Original Amount - ER")
            {
                ApplicationArea = all;
            }
            field("Original Debit Amount - ER"; Rec."Original Debit Amount - ER")
            {
                ApplicationArea = all;
            }
            field("Original Credit Amount - ER"; Rec."Original Credit Amount - ER")
            {
                ApplicationArea = all;
            }
        }*/

    }
    actions
    {
        addfirst(Reporting)
        {
            action("Receipt Voucher")
            {
                image = PrintVoucher;
                ApplicationArea = All;
                Caption = 'Receipt Voucher';
                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                begin
                    GLEntry.reset;
                    GLEntry.SetRange("Document No.", Rec."Document No.");
                    if GLEntry.FindFirst() then report.run(50211, true, false, GLEntry);
                end;
            }
            action("Payment Voucher")
            {
                image = PrintVoucher;
                ApplicationArea = All;
                Caption = 'Payment Voucher';
                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                begin
                    GLEntry.reset;
                    GLEntry.SetRange("Document No.", Rec."Document No.");
                    if GLEntry.FindFirst() then report.run(50212, true, false, GLEntry);
                end;
            }
        }
    }
}