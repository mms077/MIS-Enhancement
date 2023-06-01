table 50224 "Item Size"
{
    Caption = 'Item Size';
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
        field(3; "Item Size Code"; Code[50])
        {
            Caption = 'Item Size Code';

            TableRelation = Size.Code;
        }
        /*field(4; "Pattern File"; Text[100])
         {
             Caption = 'Pattern File';

         }*/
        field(5; "Size Name"; Text[100])
        {
            Caption = 'Size Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.Name where(Code = field("Item Size Code")));
            Editable = false;
        }
        field(4; Gender; Option)
        {
            Caption = 'Gender';

            OptionMembers = " ","Male","Female","Unisex";
            OptionCaption = ' ,Male,Female,Unisex';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.Gender where(Code = field("Item Size Code")));
        }
        field(6; ER; Code[20])
        {
            Caption = 'ER';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.ER where(Code = field("Item Size Code")));
        }
        field(7; DE; Code[20])
        {
            Caption = 'DE';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.DE where(Code = field("Item Size Code")));
        }
        field(8; IT; Code[20])
        {
            Caption = 'IT';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.IT where(Code = field("Item Size Code")));
        }
        field(9; INTL; Code[20])
        {
            Caption = 'INTL';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.INTL where(Code = field("Item Size Code")));
        }
        field(10; UK; Code[20])
        {
            Caption = 'UK';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.UK where(Code = field("Item Size Code")));
        }
        field(11; US; Code[20])
        {
            Caption = 'US';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.US where(Code = field("Item Size Code")));
        }
        field(12; RU; Code[20])
        {
            Caption = 'RU';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.RU where(Code = field("Item Size Code")));
        }
        field(13; FR; Code[20])
        {
            Caption = 'FR';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.FR where(Code = field("Item Size Code")));
        }
    }
    keys
    {
        key(PK; "Item No.", ID, "Item Size Code")
        {
            Clustered = true;
        }

    }
    fieldgroups
    {
        fieldgroup(DropDown; "Item Size Code", "Size Name")
        {

        }
    }
    trigger OnInsert()
    var
        LastItemSize: Record "Item Size";
    //GlobalSyncSetup: Record "Global Sync Setup";
    begin
        /*Clear(GlobalSyncSetup);
        if GlobalSyncSetup.Get(CompanyName) then
            if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/
        Clear(LastItemSize);
        LastItemSize.SetCurrentKey(ID);
        if LastItemSize.FindLast() then
            Rec.ID := LastItemSize.ID + 1
        else
            Rec.ID := 1;
    end;
    //end;
}
