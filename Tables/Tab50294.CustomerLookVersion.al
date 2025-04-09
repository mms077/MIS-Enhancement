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

            trigger OnLookup()
            var
                Customer: Record Customer;
                TempCustomer: Record Customer temporary;
                Companies: Record "Company Information";
                CurrentCompanyName: Text[30];
            begin
                // Get the name of the current company
                CurrentCompanyName := CurrentCompany;

                // Loop through all companies to collect customers
                if Companies.FindSet() then
                    repeat
                        if Companies.Name = CurrentCompanyName then begin
                            // Query customers in the current company
                            if Customer.FindSet() then
                                repeat
                                    TempCustomer := Customer; // Copy the customer to the temporary table
                                    TempCustomer.Insert();
                                until Customer.Next() = 0;
                        end else begin
                            // Switch to the other company and query customers
                            Customer.ChangeCompany(Companies.Name);
                            if Customer.FindSet() then
                                repeat
                                    TempCustomer := Customer; // Copy the customer to the temporary table
                                    TempCustomer.Insert();
                                until Customer.Next() = 0;
                        end;
                    until Companies.Next() = 0;

                // Open the temporary customer list for selection
                if Page.RunModal(Page::"Customer List", TempCustomer) = Action::LookupOK then begin
                    Rec."Customer No." := TempCustomer."No.";
                end;
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
