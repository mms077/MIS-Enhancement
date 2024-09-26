table 50301 "Version Detail"
{
    Caption = 'Version Detail';
    DataPerCompany = false;

    fields
    {
        /* field(1; "Design ID"; Integer)
         {
             TableRelation = Design.ID;
             Editable = false;
         }*/
        field(2; "Line No."; Integer)
        {

            Editable = false;
        }
        field(3; "Category"; Code[50])
        {
            Caption = 'Category';

            TableRelation = "Item Category".Code;

        }
        field(4; "Version Code"; Code[50])
        {
            Caption = 'Version Code';

            TableRelation = "Look Version".Code;
            trigger OnValidate()
            var
                DesignSection: Record "Design Section";
            begin
                /*Clear(GlobalSyncSetup);
                if GlobalSyncSetup.Get(CompanyName) then
                    if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/

                //end;
            end;

        }
        field(5; "Design"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Design.Code;
        }
        field(6; "Type"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Design Type".Name;
            ValidateTableRelation = false;
        }
        field(7; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            trigger OnValidate()
            var
                myInt: Integer;
                Item: Record Item;
            begin
                if Item.get(Rec."Item No.") then
                    Rec."Item Description" := Item.Description;
            end;
        }
        field(8; "Item Description"; text[250])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Version Code", "Line No.")
        {
            Clustered = true;
        }


    }
    trigger OnInsert()
    var
        LastVersionDetail: Record "Version Detail";
    begin
        if Rec."Line No." = 0 then begin
            Clear(LastVersionDetail);
            LastVersionDetail.SetRange("Version Code", Rec."Version Code");
            if LastVersionDetail.FindLast() then
                Rec."Line No." := LastVersionDetail."Line No." + 1
            else
                Rec."Line No." := 1;
        end;


    end;

    trigger OnModify()
    begin

    end;



    var

}
