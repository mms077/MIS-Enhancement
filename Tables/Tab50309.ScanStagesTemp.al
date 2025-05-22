table 50309 "Scan Design Stages- ER Temp"
{
    Caption = 'Design Scan Stages - ER';
    DataClassification = ToBeClassified;
    //TableType = Temporary;

    fields
    {
        field(1; "Activity Code"; code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Workflow User Group Code"; Code[20])
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
            // FieldClass = FlowField;
            //CalcFormula = Lookup("Item"."Design Code" WHERE("No." = FIELD("Item No.")));
            Editable = false;
        }
        field(5; "Item No."; code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Activity Selected"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Design Activities"."Activity Name" where("To Scan" = filter(true)));
        }
        field(8; "Unit Ref"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "To View"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "To Scan"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(11; Done; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Scanned"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "User Name"; text[250])
        {
            DataClassification = ToBeClassified;
        }
         field(14; "Sequence No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Stage Type"; Option)
        {
            Caption = 'Stage Type';
            OptionMembers = " ",Mandatory,Optional;
            DataClassification = ToBeClassified;
        }
        field(16; "Allow Non-Sequential Scanning"; Boolean)
        {
            Caption = 'Allow Non-Sequential Scanning';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Activity Code")
        {
            Clustered = true;
        }
    }
}
