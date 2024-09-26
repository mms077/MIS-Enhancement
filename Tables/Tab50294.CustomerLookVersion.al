table 50294 "Customer Look Version"
{
    Caption = 'Customer Look Version';
    DataPerCompany = false;

    fields
    {
        field(1; "Code"; Code[100])
        {
            Editable = false;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                rec.code := "Customer No." + '-' + rec."Look Version Code";
            end;
        }
        field(3; "Look Code"; Code[50])
        {
            Caption = 'Look Code';
            Editable = false;
            TableRelation = Look.Code;

        }

        field(4; "Look Version Code"; Code[50])
        {
            Caption = 'Look Version Code';
            Editable = false;
            TableRelation = "Look Version".Code;

        }
        field(5; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Is Printable"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                CustomerLookVer: Record "Customer Look Version";
            begin
                // every customer should have only one look version printable per look
                if Rec."Is Printable" then begin
                    CustomerLookVer.SetFilter("Look Version Code", '<>%1', rec."Look Version Code");
                    CustomerLookVer.SetFilter("Customer No.", Rec."Customer No.");
                    CustomerLookVer.SetFilter("Look Code", Rec."Look Code");
                    if CustomerLookVer.FindFirst() then
                        repeat
                            CustomerLookVer."Is Printable" := false;
                            CustomerLookVer.Modify(true);
                        until CustomerLookVer.Next() = 0;
                end;
            end;
        }

    }
    keys
    {
        key(PK; Code, "Look Code", "Look Version Code")
        {
            Clustered = true;
        }
    }

}
