table 50269 "Parameter Header Staff Sizes"
{
    Caption = 'Parameter Header Staff Sizes';
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
            TableRelation = Staff.Code;
            Editable = false;
        }
        field(3; "Size Code"; Code[50])
        {
            Caption = 'Size Code';
            DataClassification = ToBeClassified;
            TableRelation = Size.Code;
            Editable = false;
        }
        field(4; "Fit Code"; Code[50])
        {
            Caption = 'Fit Code';
            DataClassification = ToBeClassified;
            TableRelation = Fit.Code;
            Editable = false;
        }
        field(5; "Cut Code"; Code[50])
        {
            Caption = 'Cut Code';
            DataClassification = ToBeClassified;
            TableRelation = Cut.Code;
            Editable = false;
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
            Editable = false;
        }
        field(7; Include; Boolean)
        {

        }
        field(8; Quantity; Decimal)
        {

        }
    }
    keys
    {
        key(PK; "Staff Code", "Size Code", "Fit Code", "Cut Code", "Customer No.", "Parameter Header ID")
        {
            Clustered = true;
        }
    }
}
