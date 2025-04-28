table 50303 "Grouping Criteria"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Grouping Criteria";
    fields
    {
        field(1; "Field Number"; Integer)
        {
            Caption = 'Field Number';
            DataClassification = ToBeClassified;
            TableRelation = Field."No." where(TableNo = const(37)); // Relates to fields in the Sales Order Line table
        }

        field(2; "Field Name"; Text[100])
        {
            Caption = 'Field Name';
            DataClassification = ToBeClassified;
            Editable = false; // Automatically populated based on Field Number
        }
    }

    keys
    {
        key(PK; "Field Number") { Clustered = true; }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Field Number", "Field Name")
        {
            Caption = 'Grouping Criteria';
        }
    }
}