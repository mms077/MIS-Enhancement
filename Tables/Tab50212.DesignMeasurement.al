table 50212 "Design Measurement"
{
    Caption = 'Design Measurement';
    DataPerCompany = false;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';

            Editable = false;
        }
        field(2; "Design Code"; Code[50])
        {
            Caption = 'Design Code';

            TableRelation = Design.Code;
            Editable = false;
            ;
        }
        field(3; "Fit Code"; Code[50])
        {
            Caption = 'Fit Code';

            TableRelation = Fit.Code;
        }
        field(4; "Size Code"; Code[50])
        {
            Caption = 'Size Code';

            TableRelation = Size.Code;
        }
        field(5; "Measurement Code"; Code[50])
        {
            Caption = 'Measurement Code';

            TableRelation = "Measurement Category"."Measurement Code";
        }
        field(6; "Value"; Decimal)
        {
            Caption = 'Value';

        }
        field(7; "UOM Code"; Code[10])
        {
            Caption = 'UOM Code';

            TableRelation = "Unit of Measure".Code;
        }
        field(8; "Cut Code"; Code[50])
        {
            Caption = 'Cut Code';

            TableRelation = Cut.Code;
        }
        field(9; "Measurement Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Measurement.Name where(Code = field("Measurement Code")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Line No.", "Design Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        LastDesignMeasurement: Record "Design Measurement";
    //GlobalSyncSetup: Record "Global Sync Setup";
    begin
        /*Clear(GlobalSyncSetup);
        if GlobalSyncSetup.Get(CompanyName) then
            if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/
        if Rec."Line No." = 0 then begin
            Clear(LastDesignMeasurement);
            LastDesignMeasurement.SetRange("Design Code", Rec."Design Code");
            if LastDesignMeasurement.FindLast() then
                Rec."Line No." := LastDesignMeasurement."Line No." + 1
            else
                Rec."Line No." := 1;
        end;
    end;
    //end;
}
