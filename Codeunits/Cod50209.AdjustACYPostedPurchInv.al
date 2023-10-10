codeunit 50209 "Adjust Acy PostedPurchInv"

{
    Permissions = tabledata "G/L Entry" = rimd, tabledata "Value Entry" = rimd;
    trigger OnRun()
    var

    begin

    end;

    procedure AdjustAcyPostedPurchInvoice(DocumentNo: Code[50]; SourceCode: Code[50]; Rate: Decimal)
    var
        myInt: Integer;
        GlEntry: Record "G/L Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        GlSetup: Record "General Ledger Setup";
        ValueEntries: Record "Value Entry";
    begin
        GlSetup.get();
        Clear(PurchInvHeader);
        if PurchInvHeader.Get(DocumentNo) then begin
            if PurchInvHeader."Currency Code" = GlSetup."Additional Reporting Currency" then begin
                //adjust GlEntry
                GlEntry.Reset();
                GlEntry.SetFilter("Document No.", DocumentNo);
                GlEntry.SetFilter("Source Code", SourceCode);
                if GlEntry.FindFirst() then begin
                    repeat
                        GlEntry."Additional-Currency Amount" := GlEntry.Amount / Rate;
                        //check if credit amount 
                        if GlEntry.Amount < 0 then
                            GlEntry."Credit Amount" := GlEntry.Amount / Rate
                        else
                            //check if debit amount 
                            if GlEntry.Amount > 0 then
                                GlEntry."Debit Amount" := GlEntry.Amount / Rate;
                        GlEntry.Modify();
                    until GlEntry.Next() = 0;
                end;
                //adjust Value entry
                ValueEntries.Reset();
                ValueEntries.SetFilter("Document No.", DocumentNo);
                if ValueEntries.FindFirst() then begin
                    repeat
                        ValueEntries."Cost Posted to G/L (ACY)" := ValueEntries."Cost Posted to G/L" / Rate;
                        ValueEntries."Cost Amount (Actual) (ACY)" := ValueEntries."Cost Amount (Actual)" / Rate;
                        ValueEntries.Modify();
                    until ValueEntries.Next() = 0;
                end;
                Message('The ACY Rate Adjusted Successfully');
            end else
                Error('The Current Currency is Different than Additional Currency');

        end;
    end;


    var
        myInt: Integer;
}