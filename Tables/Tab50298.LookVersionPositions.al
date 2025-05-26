table 50298 "Look Version Positions"
{
    Caption = 'Look Version Positions';
    DataPerCompany = false;

    fields
    {

        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            ValidateTableRelation = false;

        }
        field(2; "Look Code"; Code[50])
        {
            Caption = 'Look Code';
            Editable = false;
            TableRelation = Look.Code;

        }

        field(3; "Look Version Code"; Code[50])
        {
            Caption = 'Look Version Code';
            Editable = false;
            TableRelation = "Look Version".Code;

        }
        field(4; "Position"; Code[50])
        {
            Caption = 'Position Code';
            DataClassification = ToBeClassified;
            TableRelation = "Department Positions"."Position Code" where("Customer No." = field("Customer No."));

            trigger OnValidate()
            var
                Positions: Record Position;
                DepartmentPosition: Record "Department Positions";
            begin
                if Positions.Get(Rec.Position) then begin
                    "Position Name" := Positions."Name"

                end else begin
                    "Position Name" := '';

                end;
            end;
        }
        field(5; "Position Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Customer No.", "Look Code", "Look Version Code")
        {
            Clustered = true;
        }
    }

}
