table 50207 "Transfer Line Unit Link"
{
    Caption = 'Transfer Line Unit Link';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Sales Line Ref."; Guid)
        {
            Caption = 'Sales Line Ref.';
            TableRelation = "Sales Line".SystemId;
        }
        field(4; "Sales Line Unit"; Guid)
        {
            Caption = 'Sales Line Unit';
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.", "Sales Line Ref.", "Sales Line Unit")
        {
            Clustered = true;
        }
    }
}
