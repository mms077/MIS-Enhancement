table 50293 "Look Detail"
{
    Caption = 'Look Detail';
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
            trigger OnValidate()
            var
                DesignSection: Record "Design Section";
            begin

            end;

        }
        field(5; "Design"; Code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Design.code where(Category = field(Category), Type = field(Type), Gender = field(Gender));
            trigger OnValidate()
            var
                DesignRec: Record Design;
            begin
                if not DesignRec.Get(Rec.Design) then
                    Error('The Design "%1" does not exist in the Design table. Please select a valid Design.', Rec.Design);
            end;

            trigger OnLookup()
            var
                Design: Record Design;
                Look: Record Look;
                DesignPage: Page "Designs"; // Replace "Designs" with the actual page ID or name
            begin
                  if Look.Get(Rec."Look Code") then begin
        Clear(Design);

        // Set filters for the Design table
        Design.SetRange(Category, Rec.Category);
        Design.SetRange(Type, Rec.Type);

        // Allow both Look.Gender and Unisex designs
        Design.SetFilter(Gender, '%1|%2', Look.Gender, Look.Gender::Unisex);

        // Set the sorting key to include Gender Sort Order
        Design.SetCurrentKey("Gender Sort Order");
        Design.SetAscending("Gender Sort Order", true);

        // Open the Design page in lookup mode
        DesignPage.SetTableView(Design);
        DesignPage.LookupMode(true); // Ensures the page is opened in lookup mode

        // Run the page and retrieve the selected record
        if DesignPage.RunModal() = Action::LookupOK then begin
            DesignPage.GetRecord(Design); // Retrieve the selected record from the page
            Rec.Design := Design.Code; 
                    end;
                end;
            end;


        }
        field(6; "Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Design Type".Name where(Category = field(Category));
            ValidateTableRelation = true;
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
        field(11; "Look Version code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Look Code", "Line No.")
        {
            Clustered = true;
        }


    }
    trigger OnInsert()
    var
        LastLookDetail: Record "Look Detail";
        LookVersion: Record "Look Version";
        ItemAssign: Record "Item Version";
        ItemVersionRec: Record "Item Version";
    begin
        if Rec."Line No." = 0 then begin
            Clear(LastLookDetail);
            LastLookDetail.SetRange("Look Code", Rec."Look Code");
            if LastLookDetail.FindLast() then
                Rec."Line No." := LastLookDetail."Line No." + 1
            else
                Rec."Line No." := 1;
        end;
        // fill Assign Item
        LookVersion.SetFilter("Look Code", Rec."Look Code");
        if LookVersion.FindSet() then
            repeat
                ItemAssign.SetFilter("Look Code", Rec."Look Code");
                ItemAssign.SetFilter("Look Version code", LookVersion.Code);
                ItemAssign.setrange("Line No.", rec."Line No.");
                if not ItemAssign.FindFirst() then begin
                    // If the record does not exist, insert a new one
                    ItemVersionRec.Init();
                    ItemVersionRec."Look Code" := rec."Look Code";
                    ItemVersionRec."Look Version Code" := LookVersion.Code;
                    ItemVersionRec."Line No." := rec."Line No.";
                    ItemVersionRec.Category := Rec.Category;
                    ItemVersionRec.Type := Rec.Type;
                    ItemVersionRec.Design := Rec.Design;
                    ItemVersionRec.Insert(true);
                end;
            until lookversion.Next() = 0;
    end;


    trigger OnModify()
    var
        ItemAssign: Record "Item Version";
        LookVersion: Record "Look Version";
    begin
        //modify Assign Item
        // Find the corresponding record in the Assign Item table
        LookVersion.SetFilter("Look Code", Rec."Look Code");
        if LookVersion.FindSet() then
            repeat
                ItemAssign.SetFilter("Look Code", Rec."Look Code");
                ItemAssign.SetFilter("Look Version Code", Rec."Look Version Code");
                ItemAssign.setrange("Line No.", rec."Line No.");
                if ItemAssign.FindFirst() then begin
                    repeat
                        // If the record exists, update it
                        ItemAssign.Category := Rec.Category;
                        ItemAssign.Type := Rec.Type;
                        ItemAssign.Design := rec.Design;
                        ItemAssign.Modify();
                    until ItemAssign.Next() = 0
                end;
            until lookversion.Next() = 0;
    end;


    trigger OnDelete()
    var
        myInt: Integer;
        ItemAssign: Record "Item Version";
        LookVersion: Record "Look Version";
    begin
        //delete assign item
        LookVersion.SetFilter("Look Code", Rec."Look Code");
        if LookVersion.FindSet() then
            repeat
                ItemAssign.SetFilter("Look Code", Rec."Look Code");
                ItemAssign.SetFilter("Look Version Code", Rec."Look Version Code");
                ItemAssign.setrange("Line No.", rec."Line No.");
                if ItemAssign.FindFirst() then begin
                    repeat
                        // If the record exists, delete it
                        ItemAssign.Delete();
                    until ItemAssign.Next() = 0;
                end;
            until lookversion.Next() = 0;
    end;

    var

}
