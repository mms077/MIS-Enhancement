table 50201 "Assembly Unit Link"
{
    Caption = 'Assembly Unit Link';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Assembly Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No';
        }
        field(3; "Sales Line Ref."; Guid)
        {
            Caption = 'Sales Line Ref.';
            TableRelation = "Sales Line".SystemId;
        }
        field(4; "Sales Line Unit"; Guid)
        {
            Caption = 'Sales Line Unit';
            TableRelation = "Sales Line Unit Ref."."Sales Line Unit";
        }
    }
    keys
    {
        key(PK; "Document Type", "No.", "Sales Line Ref.", "Sales Line Unit")
        {
            Clustered = true;
        }
    }
}
