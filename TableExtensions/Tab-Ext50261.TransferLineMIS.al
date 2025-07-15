tableextension 50261 "Transfer Line MIS" extends "Transfer Line"
{
    fields
    {
        field(50200; "Related SO"; Code[20])
        {
            Caption = 'Related SO';
            DataClassification = ToBeClassified;
        }
        field(50201; "SO Line No."; Integer)
        {
            Caption = 'SO Line No.';
            DataClassification = ToBeClassified;
        }
    }
}
