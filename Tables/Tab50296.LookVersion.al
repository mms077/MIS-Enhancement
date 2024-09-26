table 50296 "Look Version"
{
    Caption = 'Look Version';
    DataPerCompany = false;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
            Editable = false;


        }
        field(2; "Look Code"; Code[50])
        {
            Caption = 'Look Code';
            Editable = false;
            TableRelation = Look.Code;

        }
        field(3; "Description"; Text[250])
        {
            Caption = 'Description';


        }

        field(4; "Picture"; MediaSet)
        {
            Caption = 'Image';

        }
        field(5; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Back Picture"; MediaSet)
        {


        }
        field(7; "Sides Picture"; MediaSet)
        {


        }
        field(8; "Front Picture"; MediaSet)
        {


        }

        field(9; "Add 1"; MediaSet)
        {


        }
        field(10; "Add 2"; MediaSet)
        {


        }
        field(11; "Add 3"; MediaSet)
        {


        }

    }
    keys
    {
        key(PK; "Code", "Look Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";
        // LookVersion: Record "Look Version";
        ItemAssign: Record "Item Version";
        ItemVersionRec: Record "Item Version";
        LookDetails: Record "Look Detail";
    begin
        if Code = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Look Version Nos.");
            rec.Code := NoSeriesMgt.GetNextNo(SalesSetup."Look Version Nos.");
        end;





        // fill Assign Item
        LookDetails.SetFilter("Look Code", Rec."Look Code");
        if LookDetails.FindSet() then
            repeat
                // If the record does not exist, insert a new one
                ItemVersionRec.Init();
                ItemVersionRec."Look Code" := rec."Look Code";
                ItemVersionRec."Look Version Code" := rec.Code;
                ItemVersionRec."Line No." := LookDetails."Line No.";
                ItemVersionRec.Category := LookDetails.Category;
                ItemVersionRec.Type := LookDetails.Type;
                ItemVersionRec.Design := LookDetails.Design;
                ItemVersionRec.Insert(true);

            until LookDetails.Next() = 0;
    end;
}
