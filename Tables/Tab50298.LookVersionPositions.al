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
        field(4; "Position"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Departments"."Department Code" where("Customer No." = field("Customer No."));

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
