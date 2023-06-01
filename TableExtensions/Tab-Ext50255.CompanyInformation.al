tableextension 50255 "Company Information" extends "Company Information"
{
    fields
    {
        field(50200; "Capital"; Decimal)
        {
            Caption = 'Capital';
            DataClassification = ToBeClassified;
        }
        field(50201; "CR No."; Text[150])
        {
            Caption = 'CR No.';
            DataClassification = ToBeClassified;
        }
        
        field(50203;"RIB";Code[50])
        {
            Caption = 'RIB';
            DataClassification = ToBeClassified;
        }
    }
}
