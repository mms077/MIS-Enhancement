tableextension 50237 "IC Outbox Purchase Header" extends "IC Outbox Purchase Header"
{
    fields
    {
        field(50301; "IC Source No."; Code[50])
        {
            Caption = 'IC Customer No.';
            DataClassification = ToBeClassified;
        }
        field(50302; "IC Company Name"; Text[30])
        {
            Caption = 'IC Company Name';
            DataClassification = ToBeClassified;
            TableRelation = Company.Name;
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
