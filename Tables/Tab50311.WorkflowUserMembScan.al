table 50311 "Workflow User Memb-Scan"
{
    Caption = 'Workflow User Group Member-ER';
    ReplicateData = true;

    fields
    {
        field(1; "Workflow User Group Code"; Code[20])
        {
            Caption = 'Workflow User Group Code';
            TableRelation = "Workflow User Group Scan".Code;
        }
        field(2; "Name"; Code[100])
        {
            Caption = 'Name';
        }
        field(3; "Activity Code"; Code[50])
        {
            Caption = 'Activity Code';
            TableRelation = "Scan Design Stages- ER"."Activity Code";
        }
        field(4; "Activity Name"; text[250])
        {
            Caption = 'Activity Name';
            // TableRelation = "Scan Design Stages- ER"."Activity Name";
            FieldClass = FlowField;
            CalcFormula = lookup("Scan Design Stages- ER"."Activity Name" where("Activity Code" = field("Activity Code")));
        }
    }

    keys
    {
        key(Key1; "Workflow User Group Code", Name, "Activity Code")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "Activity Name")
        {

        }
    }
}

