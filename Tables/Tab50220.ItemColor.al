table 50220 "Item Color"
{
    Caption = 'Item Color';
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
        field(6; Picture; MediaSet)
        {
            Caption = 'Picture';

        }
        field(7; "French Description"; Text[200])
        {
            Caption = 'French Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Color."French Description" where(ID = field("Color ID")));
            Editable = false;
        }
        field(8; "Arabic Description"; Text[200])
        {
            Caption = 'Arabic Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Color."Arabic Description" where(ID = field("Color ID")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Item No.", "ID", "Color ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Color ID", "Color Name", "Tonality Code")
        {

        }
        fieldgroup(Brick; "Item No.", "Color Name", Picture)
        {
        }
    }
    trigger OnInsert()
    var
        LastItemColor: Record "Item Color";
    //GlobalSyncSetup: Record "Global Sync Setup";
    begin
        /*Clear(GlobalSyncSetup);
        if GlobalSyncSetup.Get(CompanyName) then
            if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/
        Clear(LastItemColor);
        LastItemColor.SetCurrentKey(ID);
        if LastItemColor.FindLast() then
            Rec.ID := LastItemColor.ID + 1
        else
            Rec.ID := 1;
    end;
    //end;
}
