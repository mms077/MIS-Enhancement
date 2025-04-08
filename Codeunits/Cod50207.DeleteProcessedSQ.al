codeunit 50207 DeleteProcessedSQ
{
    Permissions = TableData "Sales Header" = RIMD;

    trigger OnRun()
    begin
        DeleteProcessedSQ();
    end;

    local procedure HasBeenConvertedToOrder(QuoteNo: Code[20]): Boolean
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Quote No.", QuoteNo);
        exit(not SalesHeader.IsEmpty);
    end;

    local procedure DeleteProcessedSQ()
    var
        SalesQuote: Record "Sales Header";
    begin
        SalesQuote.SetRange("Document Type", SalesQuote."Document Type"::Quote);
        if SalesQuote.FindSet() then
            repeat
                if HasBeenConvertedToOrder(SalesQuote."No.") then
                    SalesQuote.Delete(true);
            until SalesQuote.Next() = 0;
    end;
}
