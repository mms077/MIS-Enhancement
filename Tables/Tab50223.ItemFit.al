table 50223 "Item Fit"
{
    Caption = 'Item Fit';
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
        field(3; "Fit Code"; Code[50])
        {
            Caption = 'Fit Code';

            TableRelation = Fit.Code;
        }
        field(4; "Fit Name"; Text[100])
        {
            Caption = 'Fit Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Fit.Name where(Code = field("Fit Code")));
            Editable = false;
        }
        field(5; "Default"; Boolean)
        {
            trigger OnValidate()
            var
                ItemFit: Record "Item Fit";
            begin
                Clear(ItemFit);
                ItemFit.SetRange("Item No.", Rec."Item No.");
                ItemFit.SetRange(Default, true);
                if ItemFit.FindSet() then
                    ItemFit.ModifyAll(Default, false);
            end;
        }
    }
    keys
    {
        key(PK; "Item No.", ID, "Fit Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Fit Code", "Fit Name")
        {

        }
    }
    trigger OnInsert()
    var
        LastItemFit: Record "Item Fit";
    //GlobalSyncSetup: Record "Global Sync Setup";
    begin
        /*Clear(GlobalSyncSetup);
        if GlobalSyncSetup.Get(CompanyName) then
            if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/
        Clear(LastItemFit);
        LastItemFit.SetCurrentKey(ID);
        if LastItemFit.FindLast() then
            Rec.ID := LastItemFit.ID + 1
        else
            Rec.ID := 1;
    end;
    //end;
}
