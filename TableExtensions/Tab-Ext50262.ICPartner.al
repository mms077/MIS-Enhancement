tableextension 50262 "IC Partner" extends "IC Partner"
{
    fields
    {
        field(50200; "Default Shipping Location"; Code[10])
        {
            Caption = 'Default Shipping Location';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code where("Shipping Location" = const(true));
        }
    }
}
