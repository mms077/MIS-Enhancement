table 50257 "Measurement Category"
{
    Caption = 'Measurement Category';
    DataClassification = ToBeClassified;
    DataPerCompany = false;
    fields
    {
        field(1; "Measurement Code"; Code[50])
        {
            Caption = 'Measurement Code';
            DataClassification = ToBeClassified;
            TableRelation = Measurement.Code;
        }
        field(2; "Category Code"; Code[50])
        {
            Caption = 'Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category".Code;
        }
    }
    keys
    {
        key(PK; "Measurement Code", "Category Code")
        {
            Clustered = true;
        }
    }
}
