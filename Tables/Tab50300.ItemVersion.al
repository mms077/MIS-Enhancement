table 50300 "Item Version"
{
    Caption = 'Item Version';
    DataPerCompany = false;

    fields
    {

        field(2; "Line No."; Integer)
        {

            Editable = false;
        }
        field(3; "Category"; Code[50])
        {
            Caption = 'Category';

            TableRelation = "Item Category".Code;

        }
        field(4; "Look Code"; Code[50])
        {
            Caption = 'Look Code';

            TableRelation = Look.Code;


        }
        field(5; "Design"; Code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Design.code where(Category = field(Category), Type = field(Type), Gender = field(Gender));

        }
        field(6; "Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Design Type".Name where(Category = field(Category));
            ValidateTableRelation = false;
        }
        field(7; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            // TableRelation = Item where("Design Code" = field(Design));
            trigger OnValidate()
            var
                myInt: Integer;
                Item: Record Item;
            begin
                if Item.get(Rec."Item No.") then
                    Rec."Item Description" := Item.Description;
            end;

            trigger OnLookup()
            var
                Item: Record Item;
                ItemPage: Page "Item List";
            begin
                Item.SetFilter("No.", Rec."Item No.");
                Item.SetFilter("Design Code", rec.Design);
                if Item.FindSet() then begin
                    Rec."Item Description" := Item.Description;
                    ItemPage.SetTableView(Item);
                    ItemPage.LookupMode(true);
                    if ItemPage.RunModal() = Action::LookupOK then begin
                        ItemPage.GetRecord(Item);
                        Rec.Validate("Item No.", Item."No.");
                    end;
                end;
            end;
        }
        /* field(8; "Look Version Code"; Code[50])
         {
             Caption = 'Look Version Code';
             Editable = false;
             TableRelation = "Look Version".Code;

         }*/
        field(9; "Item Description"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Gender; Option)
        {
            Caption = 'Gender';
            OptionMembers = " ","Male","Female","Unisex";
            OptionCaption = ' ,Male,Female,Unisex';
        }
        field(11; "Look Version code"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Look Version".Code;
        }
    }
    keys
    {
        key(PK; "Look Code", "Look Version Code", "Line No.")
        {
            Clustered = true;
        }


    }
    trigger OnInsert()
    var
        LastLookDetail: Record "Look Detail";
    begin
        if Rec."Line No." = 0 then begin
            Clear(LastLookDetail);
            LastLookDetail.SetRange("Look Code", Rec."Look Code");
            if LastLookDetail.FindLast() then
                Rec."Line No." := LastLookDetail."Line No." + 1
            else
                Rec."Line No." := 1;
        end;


    end;

    trigger OnModify()
    begin

    end;



    var

}
