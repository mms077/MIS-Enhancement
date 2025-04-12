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

    trigger OnDelete()
    var
        LookVersion: Record "Look Version";
        LookVersionPosition: Record "Look Version Positions";
        CustomerLookVersion: Record "Customer Look Version";
        LookDetail: Record "Look Detail";
    begin
        // Delete related Look Detail records
        LookDetail.SetRange("Look Code", Rec.Code);
        if LookDetail.FindSet() then
            LookDetail.DeleteAll();
        // Delete related Look Version records
        LookVersion.SetRange("Look Code", Rec.Code);
        if LookVersion.FindSet() then
            repeat
                // Delete related Look Version Position records
                LookVersionPosition.SetRange("Look Version Code", LookVersion.Code);
                if LookVersionPosition.FindSet() then
                    LookVersionPosition.DeleteAll();

                // Delete related Customer Look Version records
                CustomerLookVersion.SetRange("Look Version Code", LookVersion.Code);
                if CustomerLookVersion.FindSet() then
                    CustomerLookVersion.DeleteAll();

                // Delete the Look Version record
                LookVersion.Delete();
            until LookVersion.Next() = 0;
    end;

    
}
