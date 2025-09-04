tableextension 50260 "Item Journal Line" extends "Item Journal Line"
{
    fields
    {
        field(50200; "Revalued 2024 Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
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