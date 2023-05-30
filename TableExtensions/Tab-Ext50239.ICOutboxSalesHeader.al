tableextension 50239 "IC Outbox Sales Header" extends "IC Outbox Sales Header"
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
    }
}
