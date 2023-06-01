tableextension 50202 Customer extends Customer
{
    fields
    {
        field(50200; "Branding Code"; Code[50])
        {
            Caption = 'Branding Code';
            FieldClass = FlowField;
            CalcFormula = lookup(Branding.Code where("Customer No." = field("No.")));
            TableRelation = Branding.Code;
            Editable = false;
        }
        field(50201; "Receivables Account"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Customer Posting Group"."Receivables Account" where(Code = field("Customer Posting Group")));
        }
        field(50202; "SIRET"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    fieldgroups
    {
        addlast(DropDown; "Name 2")
        {
        }
    }
}
