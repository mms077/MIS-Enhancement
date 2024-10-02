tableextension 50258 "Aged Report Entity" extends "Aged Report Entity"
{
    fields
    {

        field(50200; "Period 1 ACY"; Decimal)
        {
            Caption = 'Period 1 ACY';
        }
        field(50201; "Period 2 ACY"; Decimal)
        {
            Caption = 'Period 2 ACY';
        }
        field(50202; "Period 3 ACY"; Decimal)
        {
            Caption = 'Period 3 ACY';
        }
        field(50203; BalanceACY; Decimal)
        {
            Caption = 'Balance ACY';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}