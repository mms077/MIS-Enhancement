tableextension 50232 "Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50301; "IC Source No."; Code[50])
        {
            Caption = 'IC Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
            ValidateTableRelation = false;
            /*trigger OnValidate()
            begin
                Rec.Validate("IC Company Name", CompanyName);
            end;*/
        }
        field(50302; "IC Company Name"; Text[30])
        {
            Caption = 'IC Company Name';
            DataClassification = ToBeClassified;
            TableRelation = Company.Name;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                if Rec."IC Source No." = '' then
                    Rec.Validate("IC Source No.", "Sell-to Customer No.");
            end;
        }
        field(50304; "Lines Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Line" where("Document No." = field("No."), "Document Type" = field("Document Type")));
            Editable = false;
        }
        field(50305; "Purchase to Stock"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50306; "IC Customer SO No."; Code[20])
        {
            trigger OnValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                Rec."IC Customer Project Code" := Rec.GetICProjectCode();
                Rec.Modify();
            end;
        }
        field(50307; "IC Customer Project Code"; Code[20])
        {

        }
    }
    procedure GetICProjectCode(): Code[20]
    var
        Customer: Record Customer;
        ICSalesHeader: Record "Sales Header";
    begin
        Clear(ICSalesHeader);
        if (Rec."IC Company Name" <> '') and (Rec."IC Customer SO No." <> '') then begin
            ICSalesHeader.ChangeCompany(Rec."IC Company Name");
            if ICSalesHeader.get(ICSalesHeader."Document Type"::Order, Rec."IC Customer SO No.") then
                exit(ICSalesHeader."Cust Project")
            //Could not find the SO
            else
                exit('');
        end else
            exit('');
    end;
}
