table 50303 Dress
{
    Caption = 'Dress';
    DataPerCompany = false;
    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
            Editable = true;

        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';


        }





    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        // if Code = '' then begin
        //     SalesSetup.Get();
        //     SalesSetup.TestField("Dress Nos.");
        //     rec.Code := NoSeriesMgt.GetNextNo(SalesSetup."Dress Nos.");
        // end;
    end;

}
