table 50238 "Item Design Section Color"
{
    Caption = 'Item Design Section Color';
    DataPerCompany = false;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';

            TableRelation = Item."No.";
        }
        field(3; "Color ID"; Integer)
        {
            Caption = 'Color ID';

            TableRelation = Color.ID;
        }
        field(4; "Tonality Code"; Code[50])
        {
            Caption = 'Tonality Code';

            TableRelation = Tonality.Code;
        }
        field(5; "Color Name"; Text[100])
        {
            Caption = 'Color Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Color.Name where(ID = field("Color ID")));
            Editable = false;
        }
        field(6; "Design Section Code"; Code[50])
        {
            Caption = 'Design Section Code';

            TableRelation = "Design Section".Code;
        }
        field(7; "Item Color ID"; Integer)
        {
            Caption = 'Item Color ID';

            TableRelation = "Color".ID;
        }
        field(8; "Design Section Color Count"; Integer)
        {
            Caption = 'Design Section Color Count';
            FieldClass = FlowField;
            CalcFormula = count("Item Design Section Color"
            where("Design Section Code" = field("Design Section Code"), "Item No." = field("Item No."), "Item Color ID" = field("Item Color ID")));
            Editable = false;
        }
        field(9; "Design Section Name"; Text[100])
        {
            Caption = 'Design Section Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Design Section".Name where(Code = field("Design Section Code")));
            Editable = false;
        }
        field(10; Picture; MediaSet)
        {
            Caption = 'Picture';

        }
        field(11; "Default"; Boolean)
        {

        }
    }
    keys
    {
        key(PK; "Item No.", "Item Color ID", "Design Section Code", "Color ID", "Tonality Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        LastItemDesignSectionColor: Record "Item Design Section Color";
    //GlobalSyncSetup: Record "Global Sync Setup";
    begin
        /*Clear(GlobalSyncSetup);
        if GlobalSyncSetup.Get(CompanyName) then
            if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/
        Clear(LastItemDesignSectionColor);
        LastItemDesignSectionColor.SetCurrentKey(ID);
        LastItemDesignSectionColor.SetRange("Item No.", Rec."Item No.");
        if LastItemDesignSectionColor.FindLast() then
            Rec.ID := LastItemDesignSectionColor.ID + 1
        else
            Rec.ID := 1;
    end;
    //end;
}
