tableextension 50240 "IC Inbox Transaction" extends "IC Inbox Transaction"
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
