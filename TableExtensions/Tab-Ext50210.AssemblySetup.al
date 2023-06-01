tableextension 50210 "Assembly Setup" extends "Assembly Setup"
{
    fields
    {
        field(50200; "Workflow User Group Code"; Code[20])
        {
            Caption = 'Workflow User Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group".Code;
        }
    }
}
