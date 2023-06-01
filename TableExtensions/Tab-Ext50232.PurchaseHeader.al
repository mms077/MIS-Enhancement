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
                Rec.Validate("IC Source No.", "Sell-to Customer No.");
            end;
        }
        field(50304; "Lines Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Line" where("Document No." = field("No."), "Document Type" = field("Document Type")));
            Editable = false;
        }
    }
}
