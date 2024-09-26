table 50295 "Item Look Version"
{
    Caption = 'Item Look Version';
    DataPerCompany = false;

    fields
    {
      
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
               
            end;
        }
        field(3; "Look Code"; Code[50])
        {
            Caption = 'Look Code';
            Editable = false;
            TableRelation = Look.Code;

        }

        field(4; "Look Version Code"; Code[50])
        {
            Caption = 'Look Version Code';
            Editable = false;
            TableRelation = "Look Version".Code;

        }
        field(5; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }




        field(6; "Category"; Code[50])
        {
            Caption = 'Category';

            TableRelation = "Item Category".Code;

        }

        field(7; "Design"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Design.Code;
        }
        field(8; "Type"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Design Type".Name;
            ValidateTableRelation = false;
        }
        field(9; "Created"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }
    keys
    {
        key(PK;  "Look Code", "Look Version Code")
        {
            Clustered = true;
        }
    }

}
