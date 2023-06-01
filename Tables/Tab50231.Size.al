table 50231 Size
{
    Caption = 'Size';
    DataPerCompany = false;

    fields
    {
        field(2; "Code"; Code[50])
        {
            Caption = 'Code';

        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';

        }
        field(4; Gender; Option)
        {
            Caption = 'Gender';

            OptionMembers = " ","Male","Female","Unisex";
            OptionCaption = ' ,Male,Female,Unisex';
        }
        /*field(5; "Category"; Code[20])
        {
            Caption = 'Category';
            TableRelation = "Item Category".Code;
        }*/
        field(6; ER; Code[20])
        {
            Caption = 'ER';
        }
        field(7; DE; Code[20])
        {
            Caption = 'DE';
        }
        field(8; IT; Code[20])
        {
            Caption = 'IT';
        }
        field(9; INTL; Code[20])
        {
            Caption = 'INTL';
        }
        field(10; UK; Code[20])
        {
            Caption = 'UK';
        }
        field(11; US; Code[20])
        {
            Caption = 'US';
        }
        field(12; RU; Code[20])
        {
            Caption = 'RU';
        }
        field(13; FR; Code[20])
        {
            Caption = 'FR';
        }
        field(14; "Report Description"; Text[8])
        {

        }
        field(15; "Extra Charge %"; Decimal)
        {

        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Name, Gender)
        {

        }
    }
}
