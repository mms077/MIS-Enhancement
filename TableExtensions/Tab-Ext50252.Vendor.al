tableextension 50252 Vendor extends Vendor
{
    fields
    {
        field(50201; "Payables Account"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Posting Group"."Payables Account" where(Code = field("Vendor Posting Group")));
        }
    }
}
