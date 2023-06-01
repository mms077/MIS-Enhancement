table 50267 "Parameter Header Departments"
{
    Caption = 'Parameter Header Departments';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Parameter Header ID"; Integer)
        {
            Caption = 'Parameter Header ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Department Code"; Code[50])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
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
        key(PK; "Parameter Header ID", "Department Code", "Customer No.")
        {
            Clustered = true;
        }
    }
}
