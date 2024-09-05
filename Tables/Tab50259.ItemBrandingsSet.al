table 50259 "Item Brandings Set"
{
    Caption = 'Item Brandings Set';
    DataPerCompany = false;

    fields
    {
        field(1; "Item Branding Set ID"; Integer)
        {
            Caption = 'Item Branding Set ID';

            Editable = false;
        }
        field(2; "Item Branding Code"; Code[50])
        {
            Caption = 'Item Branding Code';

            TableRelation = Branding.Code;
            Editable = false;
        }
        field(3; "Brandings Count In Set"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Brandings Set" where("Item Branding Set ID" = field("Item Branding Set ID")));
            Editable = false;
        }
        field(8; "Company Name"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Unique Combination"; Text[2048])
        {
            Caption = 'Unique Combination';
        }
    }
    keys
    {
        key(PK; "Item Branding Set ID", "Item Branding Code", "Company Name")
        {
            Clustered = true;
        }
    }
}
