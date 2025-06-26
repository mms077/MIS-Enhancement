tableextension 50263 "Inventory Setup Extension" extends "Inventory Setup"
{
    fields
    {
        field(50220; "Daily Transfer Nos."; Code[20])
        {
            Caption = 'Daily Transfer Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series".Code;
        }
    }
}
