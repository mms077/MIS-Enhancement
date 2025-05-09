table 50305 "Design Activities"
{
    Caption = 'Design Activities';
    DataPerCompany = false;

    fields
    {
        // field(1; "Activity Code"; Code[50])
        // {
        //     Caption = 'Activity Code';
        //     TableRelation = "Workflow Activities - ER"."Workflow User Group Code";
        //     trigger OnValidate()
        //     var
        //         myInt: Integer;
        //         WorkflowActivitiesER: Record "Workflow Activities - ER";
        //     begin
        //         // Populate Activity Name based on Activity Code
        //         if "Activity Code" <> '' then
        //             if not WorkflowActivitiesER.Get("Activity Code") then
        //                 Error('Activity Code "%1" does not exist.', "Activity Code")
        //             else
        //                 "Activity Name" := WorkflowActivitiesER."Activity Name";
        //     end;
        // }
        field(2; "Activity Id"; Integer)
        {
            Caption = 'Activity Id';
            Editable = true;
            TableRelation = "Scan Design Stages- ER".Index;
        }
        field(3; "Activity Name"; Text[100])
        {

            FieldClass = FlowField;
            CalcFormula = lookup("Scan Design Stages- ER"."Activity Name" where(Index = field("Activity Id")));
            Editable = false;
        }
        field(4; "Design Code"; Code[50])
        {
            Caption = 'Design Code';
            TableRelation = Design.Code;
        }
        field(5; "Sequence No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Stage Type"; Option)
        {
            Caption = 'Stage Type';
            OptionMembers = " ",Mandatory,Optional;
            DataClassification = ToBeClassified;
        }
        field(7; "Allow Non-Sequential Scanning"; Boolean)
        {
            Caption = 'Allow Non-Sequential Scanning';
            DataClassification = ToBeClassified;
        }
        field(8; "Done"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "To Scan"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Unit Ref"; code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Scan Design Stages- ER Temp"."Unit Ref");
        }

    }

    keys
    {
        key(PK; "Design Code", "Activity Id", "Sequence No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        WorkflowActivitiesER: Record "Workflow Activities - ER";

    begin

    end;
}