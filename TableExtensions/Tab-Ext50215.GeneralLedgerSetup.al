tableextension 50215 "General Ledger Setup" extends "General Ledger Setup"
{
    fields
    {
        field(50200; "Company Type"; Option)
        {
            OptionMembers = " ","Full Production","Only From SF","No Production";
            Caption = 'Company Type';
            DataClassification = ToBeClassified;
        }
        field(50201; "MOF Receipt"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'MOF Receipt';
        }
        field(50202; "Default VAT %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Default VAT %';
            MinValue = 0;
            MaxValue = 100;
        }
    }
}
