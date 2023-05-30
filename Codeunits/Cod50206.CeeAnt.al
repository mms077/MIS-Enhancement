codeunit 50206 CeeAnt
{
    procedure GetCreditLineLanguageDescription(var DocumentNo: Code[20]; var LineNo: Integer; var SelectedLanguage: code[10]): Text[100]
    var
        L_RecCreditLine: Record "Sales Cr.Memo Line";
        L_RecItem: Record Item;
        LineItemDesc: text[100];
    begin
        L_RecCreditLine.reset();
        L_RecCreditLine.get(DocumentNo, LineNo);
        LineItemDesc := L_RecCreditLine.Description;//Getting the description of the line
        if L_RecCreditLine.Type.AsInteger() = 2 then begin//checking if line type is an item
            Case G_CULanguage.GetLanguageId(SelectedLanguage) of
                1036:
                    begin//If company information language Selected is French
                        L_RecItem.reset();
                        if L_RecItem.get(L_RecCreditLine."No.") then
                            exit(L_RecItem."Description 2");//Return Description 2
                    end
                else
                    exit(LineItemDesc);
            end;
        end
        else
            exit(LineItemDesc);
    End;

    procedure GetSizeValue(var SizeCode: Code[50]; var SelectedLanguage: Code[10]): Code[20]
    var
        L_RecSizes: Record "Size";
    begin
        L_RecSizes.Reset();
        if SizeCode <> '' then begin
            L_RecSizes.SetRange(Code, SizeCode);
            if L_RecSizes.FindFirst() then
                CASE G_CULanguage.GetLanguageId(SelectedLanguage) OF
                    1036://If company information language Selected is French
                        exit(L_RecSizes.ER);//Return size ER Values
                    2057://If company information language Selected is English
                        exit(L_RecSizes.code);//Return size INTL Values
                    /* Example if language is Arabic:
                    1025:
                        exit(L_RecItem.ArabicDescription) */
                    else
                        exit(L_RecSizes.code);//Return size INTL if no case found
                end;
        end
        else
            exit('');
    end;




    procedure GetSalesInvoiceLineLanguageDescription(var DocumentNo: Code[20]; var LineNo: Integer; var SelectedLanguage: Code[10]): Text[100]
    var
        L_RecSalesInvoiceLine: Record "Sales Invoice Line";
        L_RecItem: Record Item;
        LineItemDesc: text[100];
    begin
        L_RecSalesInvoiceLine.reset();
        L_RecSalesInvoiceLine.get(DocumentNo, LineNo);
        LineItemDesc := L_RecSalesInvoiceLine.Description;//Getting the description of the line
        if L_RecSalesInvoiceLine.Type.AsInteger() = 2 then begin//checking if line type is an item
            Case G_CULanguage.GetLanguageId(SelectedLanguage) of
                1036:
                    begin//If company information language Selected is French
                        L_RecItem.reset();
                        if L_RecItem.get(L_RecSalesInvoiceLine."No.") then
                            exit(L_RecItem."Description 2");//Return Description 2
                    end
                else
                    exit(LineItemDesc);
            end;
        end
        else
            exit(LineItemDesc);
    end;

    var
        G_CULanguage: Codeunit Language;
}
