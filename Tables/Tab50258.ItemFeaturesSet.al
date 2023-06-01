table 50258 "Item Features Set"
{
    Caption = 'Item Features Set';
    DataPerCompany = false;

    fields
    {
        field(1; "Item Feature Set ID"; Integer)
        {
            Caption = 'Item Feature Set ID';

            Editable = false;
        }
        field(2; "Item Feature Name"; Text[100])
        {
            Caption = 'Item Feature Name';

            TableRelation = Feature."Name";
            Editable = false;
        }
        field(5; "Value"; Text[100])
        {
            Caption = 'Value';
            Editable = false;
        }
        field(6; "Color Id"; Integer)
        {
            TableRelation = Color.ID;
            Editable = false;
        }
        field(7; "Features Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Features Set" where("Item Feature Set ID" = field("Item Feature Set ID")));
            Editable = false;
        }
        field(8; "Color Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Color".Name where(ID = field("Color Id")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Item Feature Set ID", "Item Feature Name", Value, "Color Id")
        {
            Clustered = true;
        }
    }
}
