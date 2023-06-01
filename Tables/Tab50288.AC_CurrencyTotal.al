table 50288 "AC Currency Total"
{
    Caption = 'AC Currency Total';
    DataClassification = ToBeClassified;
    LookupPageId = AC_CurrencyTotal;
    //DrillDownPageId=TempCurrencyTotal;

    //TableType = temporary;
    fields
    {
        field(1; CurrencyCode; Code[10])
        {
            Caption = 'CurrencyCode';
            DataClassification = ToBeClassified;
        }
        // field(2; Total; Decimal)
        // {
        //     Caption = 'Total';
        //     DataClassification = ToBeClassified;

        // }
        // field(13; Amount; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Ledger Entry Amount" = CONST(true),
        //                                                                   "Vendor No." = field("Vendor Filter"),//to be added
        //                                                                   "Currency Code" = field(CurrencyCode)
        //                                                                   "Posting Date" = FIELD("Date Filter")));//to be added
    }
    keys
    {
        key(PK; CurrencyCode)
        {
            Clustered = true;
        }
    }
}