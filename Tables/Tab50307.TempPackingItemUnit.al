table 50307 "Temp Packing Item Unit"
{
    TableType = Temporary;
    Caption = 'Temporary Packing Item Unit';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }
        field(2; "Source Line RecId"; RecordId)
        {
            Caption = 'Source Line RecordId';
            DataClassification = SystemMetadata;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = SystemMetadata;
        }
        field(4; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            DataClassification = SystemMetadata;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(10; "Length"; Decimal)
        {
            Caption = 'Length';
            DecimalPlaces = 2 : 5;
            DataClassification = SystemMetadata;
        }
        field(11; "Width"; Decimal)
        {
            Caption = 'Width';
            DecimalPlaces = 2 : 5;
            DataClassification = SystemMetadata;
        }
        field(12; "Height"; Decimal)
        {
            Caption = 'Height';
            DecimalPlaces = 2 : 5;
            DataClassification = SystemMetadata;
        }
        field(13; Volume; Decimal)
        {
            Caption = 'Volume';
            DecimalPlaces = 2 : 5;
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Entry No.") // Simple primary key for temporary data
        {
            Clustered = true;
        }
        key(SourceKey; "Source Line RecId")
        {
            // Optional key if needed for lookups
        }
    }
}