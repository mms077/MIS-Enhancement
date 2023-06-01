table 50268 "Parameter Header Positions"
{
    Caption = 'Parameter Header Positions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Parameter Header ID"; Integer)
        {
            Caption = 'Parameter Header ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Position Code"; Code[50])
        {
            Caption = 'Position Code';
            DataClassification = ToBeClassified;
            TableRelation = Position.Code;
            Editable = false;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
            Editable = false;
        }
        field(4; Include; Boolean)
        {

        }
    }
    keys
    {
        key(PK; "Parameter Header ID", "Position Code", "Customer No.")
        {
            Clustered = true;
        }
    }
}
