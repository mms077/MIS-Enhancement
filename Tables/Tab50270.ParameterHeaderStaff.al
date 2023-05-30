table 50270 "Parameter Header Staff"
{
    Caption = 'Parameter Header Staff';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Parameter Header ID"; Integer)
        {
            Caption = 'Parameter Header ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Staff Code"; Code[50])
        {
            Caption = 'Staff Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Staff Name"; Text[100])
        {
            Caption = 'Staff Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Position Code"; Code[50])
        {
            TableRelation = Position.Code;
            Editable = false;
        }
        field(5; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
            Editable = false;
        }
        field(6; Include; Boolean)
        {

        }
    }
    keys
    {
        key(PK; "Staff Code", "Position Code", "Customer No.", "Parameter Header ID")
        {
            Clustered = true;
        }
    }
}
