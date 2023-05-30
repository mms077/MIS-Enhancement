tableextension 50234 "Purch. Rcpt. Header" extends "Purch. Rcpt. Header"
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
        field(50304; "Lines Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Line" where("Document No." = field("No.")));
            Editable = false;
        }
    }
}
