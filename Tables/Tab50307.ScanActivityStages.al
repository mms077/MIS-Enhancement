table 50307 "Scan Design Stages- ER"
{
    Caption = 'Scan Design Stages - ER';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Workflow User Group Code"; Code[20])
        {
            Caption = 'Workflow User Group Code';
            NotBlank = true;
            TableRelation = "Workflow User Group-ER".Code;
        }
        // field(2; "Workflow User Group Sequence"; Integer)
        // {
        //     Caption = 'Workflow User Group Sequence';
        //     NotBlank = true;
        // }
        field(3; "Activity Name"; Text[100])
        {
            Caption = 'Activity Name';
            NotBlank = true;
        }
        field(4; "Design Code Filter"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Item"."Design Code" WHERE("No." = FIELD("Item No.")));
            Editable = false;
        }
        field(5; "Item No."; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Index; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; Index)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Index, "Activity Name")
        {
    
        }
    }
}
