tableextension 50208 "User Setup - ER" extends "User Setup"
{
    fields
    {
        field(50300; "Delete Design"; Boolean)
        {
            Caption = 'Delete Design';

        }
        field(50301; "Modify Assembly"; Boolean)
        {
            Caption = 'Modify Assembly';

        }
        field(50302; "Delete Item"; Boolean)
        {
            Caption = 'Delete Item';

        }
        field(50303; "Modify Payment Terms"; Boolean)
        {
            Caption = 'Modify Payment Terms';
        }
        field(50304; "Show Cost"; Boolean)
        {
            Caption = 'Show Cost';
        }
        field(50305; "Show Sales Price"; Boolean)
        {
            Caption = 'Show Sales Price';
        }
        field(50306; "Release Sales Documents"; Boolean)
        {

        }
        field(50307; "Delete Raw Material"; Boolean)
        {

        }
        /*field(50308; "Ledger Editor Access"; Boolean)
        {

        }*/
        field(50309; "Reset No. Of Copies"; Boolean)
        {

        }
        field(50310; "Delete Variant"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50311; "Delete MO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50312; "Adjust ACY Rate"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        /*field(50312; "Create Assemb. From Batch"; boolean)
        {
        }*/
        field(50313; "Can Edit Print ER- Commercial"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50314; "Bypass Missing RM"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
