table 50308 "Temp Grouped Line RecIds"
{
    TableType = Temporary;
    Caption = 'Temporary Grouped Line RecordIds';

    fields
    {
        field(1; "Grouping Value"; Text[250])
        {
            Caption = 'Grouping Value';
            DataClassification = SystemMetadata;
        }
        field(2; "Line RecordId"; RecordId)
        {
            Caption = 'Line RecordId';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Grouping Value", "Line RecordId") // Composite key
        {
            Clustered = true;
        }
        key(GroupKey; "Grouping Value")
        {
            // Key for finding distinct groups and filtering
        }
    }
}