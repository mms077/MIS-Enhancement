table 50310 "Design Activities Temp"
{
    Caption = 'Design Activities';
    TableType = Temporary;
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
        field(7; "Done"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "To Scan"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                DesignActivities: Record "Design Activities";
            begin
                if "To Scan" then begin
                    // Set all other lines to false
                    Clear(DesignActivities);
                    DesignActivities.SetFilter("Design Code", rec."Design Code");
                    DesignActivities.SetFilter("Activity Name", '<>%1', rec."Activity Name");
                    if DesignActivities.FindSet() then begin
                        repeat
                            DesignActivities."To Scan" := false;
                            DesignActivities.Modify();
                        until DesignActivities.Next() = 0;
                    end;
                end;
            end;
        }
    }

    keys
    {
        key(PK; "Design Code", "Activity Name", "Sequence No.")
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