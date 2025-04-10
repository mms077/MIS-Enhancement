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
                //Companies: Record "Company Information";
                CurrentCompanyId: Guid;
                Company: Record Company;
                Company2: Record Company;
            begin
                if Rec."Company Name" = '' then
                    Error('Please select a Company Name before looking up customers.');

                // Switch to the selected company
                Customer.ChangeCompany(Rec."Company Name");

                // Query customers in the selected company
                if Customer.FindSet() then
                    repeat
                        TempCustomer := Customer; // Copy the customer to the temporary table
                        TempCustomer.Insert();
                    until Customer.Next() = 0;

                // Open the temporary customer list for selection
                if Page.RunModal(Page::"Customer List", TempCustomer) = Action::LookupOK then begin
                    Rec."Customer No." := TempCustomer."No.";
                end;

                // Switch back to the current company
                Customer.ChangeCompany(CompanyName);
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
        field(7; "Company Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Company."Name";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."Customer No." <> '' then begin
                    // Clear the "Customer No." field if the company is changed
                    Rec."Customer No." := '';
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
