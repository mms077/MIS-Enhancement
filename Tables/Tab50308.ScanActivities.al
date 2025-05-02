table 50308 "Scan Activities"
{
    Caption = 'Scan Activities';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Sales Line Unit Ref."; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Sales Line  Ref."; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Assembly No."; Code[20])
        {
            Caption = 'Assembly No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "ER - Manufacturing Order No."; Code[50])
        {
            Caption = 'ER - Manufacturing Order No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Assembly Header"."ER - Manufacturing Order No." where("No." = field("Assembly No.")));
            Editable = false;
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Design"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Design.Code;
        }
        field(7; "Item Category"; Code[50])
        {
            Caption = 'Item Category';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Item Category Code" where("No." = field("Item No.")));
            Editable = false;
        }


        field(8; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code;
            Editable = false;
        }



        field(9; "Source No."; Code[20])
        {
            Caption = 'Source No.';

            Editable = false;
        }
        field(10; "Scan Activity Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Scan Design Stages- ER"."Activity Name";
        }
        field(11; "In/Out"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","In","Out";
        }
        field(12; "Starting Time"; DateTime)
        {
            Editable = false;
        }
        field(13; "Sequence No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Sales Line Unit Ref.")
        {
            Clustered = true;
        }
        // Key(FK; "Current Sequence No.")
        // {

        // }
    }
}
