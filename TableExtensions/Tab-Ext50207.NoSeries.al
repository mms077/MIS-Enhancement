tableextension 50207 "No. Series" extends "No. Series"
{
    fields
    {
        field(50200; "Item Category"; Code[20])
        {
            Caption = 'Item Category';

            TableRelation = "Item Category".Code;
        }
    }
}
