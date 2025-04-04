table 50292 Look
{
    Caption = 'Look';
    DataPerCompany = false;
    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
            Editable = false;

        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';


        }
        field(3; "Front Picture"; MediaSet)
        {


        }
        field(4; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Gender; Option)
        {
            Caption = 'Gender';

            OptionMembers = " ","Male","Female","Unisex";
            OptionCaption = ' ,Male,Female,Unisex';
        }
        field(6; Content; BLOB)
        {
            Caption = 'Content';
            SubType = Bitmap;
        }
        field(7; "Back Picture"; MediaSet)
        {


        }
        field(8; "Sides Picture"; MediaSet)
        {


        }
        field(9; "Dress Code"; code[20])
        {

            TableRelation = Dress.Code;
        }
        /* field(9; "Add 1"; MediaSet)
         {


         }
         field(10; "Add 2"; MediaSet)
         {


         }
         field(11; "Add 3"; MediaSet)
         {


         }*/


    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if Code = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Look Nos.");
            rec.Code := NoSeriesMgt.GetNextNo(SalesSetup."Look Nos.");
        end;
    end;

}
