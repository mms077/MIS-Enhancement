table 50309 "Scan Design Stages- ER Temp"
{
    Caption = 'Scan Design Stages - ER';
    DataClassification = ToBeClassified;
    TableType = Temporary;

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
        field(4; "Design Code"; Code[50])
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
        field(7; "Activity Selected"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Design Activities"."Activity Name" where("To Scan" = filter(true)));
        }

    }
    keys
    {
        key(PK; Index)
        {
            Clustered = true;
        }
    }
}
