table 50302 "MO Stock Avl. Warning Log"
{
    Caption = 'MO Stock Avl. Warning Log';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Manufacturing Order No."; Code[20])
        {
            Caption = 'Manufacturing Order No.';
            TableRelation = "ER - Manufacturing Order"."No.";
        }
        field(2; User; Code[20])
        {
            Caption = 'User';
        }
        field(3; "Number of unique items"; Integer)
        {
            Caption = 'Number of unique items';
        }
    }
    keys
    {
        key(PK; "Manufacturing Order No.")
        {
            Clustered = true;
        }
    }
}
