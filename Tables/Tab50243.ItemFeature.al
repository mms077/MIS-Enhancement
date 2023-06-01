table 50243 "Item Feature"
{
    Caption = 'Item Feature';
    DataPerCompany = false;

    fields
    {
        /*field(2; "Design Detail Line No."; Integer)
        {
            Caption = 'Design Detail Line No.';
            
            Editable = false;
        }
        field(3; "Design Detail Design Code"; Code[50])
        {
            Caption = 'Design Detail Design Code';
            
            Editable = false;
        }*/
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';

            Editable = false;
            TableRelation = Item."No.";
        }
        field(4; "Feature Name"; Text[100])
        {
            Caption = 'Feature Name';

            TableRelation = "Feature".Name;
        }
        field(5; "Value"; Text[100])
        {
            Caption = 'Value';

            TableRelation = "Item Feature Possible Values"."Possible Value" where("Feature Name" = field("Feature Name"));
        }
    }
    keys
    {
        key(PK; "Item No.", "Feature Name", "Value")
        {
            Clustered = true;
        }
    }
}
