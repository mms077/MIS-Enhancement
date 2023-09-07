table 50289 "Job Queue Selection"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; id; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Job Queue Id"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Queue Entry"."Object ID to Run";
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                myInt: Integer;
                JobQEntry: Record "Job Queue Entry";
            begin
                JobQEntry.SetFilter("Object ID to Run", Rec."Job Queue Id");
                if JobQEntry.FindFirst() then
                    Rec."Job Queue Description" := JobQEntry.Description;

            end;
        }
        field(3; "Job Queue Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            //TableRelation = "Job Queue Entry"."Object Caption to Run";
        }
    }

    keys
    {
        key(Key1; "Job Queue Id", "Job Queue Description")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        JobQ: Record "Job Queue Selection";

    trigger OnInsert()
    begin
        Clear(JobQ);
        if JobQ.FindLast() then
            Rec.ID := JobQ.ID + 1
        else
            Rec.ID := 1;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}