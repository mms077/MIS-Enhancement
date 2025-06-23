table 50308 "Scan Activities"
{
    Caption = 'Scan Activities';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Sales Line Unit Id."; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Sales Line Id"; Guid)
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
        field(6; "Design Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Design.Code;
        }


        field(7; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code;
            Editable = false;
        }

        field(8; "Source No."; Code[20])
        {
            Caption = 'Source No.';

            Editable = false;
        }
        field(9; "Activity Code"; Text[100])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "Scan Design Stages- ER"."Activity Name";
        }
        field(10; "Activity Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Scan Design Stages- ER"."Activity Name";
        }
        field(11; "Activity Remark"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Scan Design Stages- ER"."Activity Name";
        }
        field(12; "Activity Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","In","Out";
        }
        field(13; "Activity Date"; DateTime)
        {
            Editable = false;
        }
        field(14; "Activity Time"; Time)
        {
            Editable = false;
        }
        field(15; "Sequence No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Activity Environment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Sales Line Unit Id.", "Sales Line Id", "Activity Type", "Activity Code")
        {
            Clustered = true;
        }
        // Key(FK; "Current Sequence No.")
        // {

        // }
    }
}
