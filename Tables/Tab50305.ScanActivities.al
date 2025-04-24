table 50305 "Scan Activities"
{
    Caption = 'Scan Activities';
    DataPerCompany = false;

    fields
    {
        field(1; "Activity Code"; Code[50])
        {
            Caption = 'Activity Code';
            TableRelation = "Workflow Activities - ER"."Workflow User Group Code";
            trigger OnValidate()
            var
                myInt: Integer;
                WorkflowActivitiesER: Record "Workflow Activities - ER";
            begin
                // Populate Activity Name based on Activity Code
                if "Activity Code" <> '' then
                    if not WorkflowActivitiesER.Get("Activity Code") then
                        Error('Activity Code "%1" does not exist.', "Activity Code")
                    else
                        "Activity Name" := WorkflowActivitiesER."Activity Name";
            end;
        }
        field(2; "Activity Name"; Text[100])
        {
            Caption = 'Activity Name';
            Editable = true;
            TableRelation = "Scan Design Stages- ER"."Activity Name";
        }
        field(3; "Design Code"; Code[50])
        {
            Caption = 'Design Code';
            TableRelation = Design.Code;
        }
        field(4; "Sequence No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Stage Type"; Option)
        {
            Caption = 'Stage Type';
            OptionMembers = " ",Mandatory,Optional;
            DataClassification = ToBeClassified;
        }
        field(6; "Allow Non-Sequential Scanning"; Boolean)
        {
            Caption = 'Allow Non-Sequential Scanning';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Design Code", "Activity Name") // Primary key based on Design Code and Activity Name
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        WorkflowActivitiesER: Record "Workflow Activities - ER";

    begin
        // // Ensure that the combination of Design Code and Activity Name is unique
        // if Rec.Get(Rec."Design Code", Rec."Activity Name") then
        //     Error('The combination of Design Code "%1" and Activity Name "%2" already exists.', Rec."Design Code", Rec."Activity Name");


    end;
}