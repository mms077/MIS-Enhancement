table 50204 "Branding Detail"
{
    Caption = 'Branding Detail';


    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';

            Editable = false;
        }
        field(2; "Branding Code"; Code[50])
        {
            Caption = 'Branding Code';

            TableRelation = Branding.Code;
            Editable = false;
        }
        field(3; "Item Color ID"; Integer)
        {
            Caption = 'Item Color ID';

            TableRelation = "Color".ID;

        }
        field(4; "Image File"; MediaSet)
        {
            Caption = 'Image File';
        }
        field(5; "Film File"; Text[150])
        {
            Caption = 'Film File';

        }
        field(6; "Item No."; Text[100])
        {
            Caption = 'Item No.';
            FieldClass = FlowField;
            CalcFormula = lookup(Branding."Item No." where(Code = field("Branding Code")));
            Editable = false;
        }
        field(7; "Item Color Name"; Text[100])
        {
            Caption = 'Item Color Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Color.Name where(ID = field("Item Color ID")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Branding Code", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Item Color ID", "Item Color Name", "Branding Code")
        {

        }
    }
    trigger OnInsert()
    begin
        DenyDuplicates();
    end;

    trigger OnModify()
    begin
        DenyDuplicates();
    end;

    procedure DenyDuplicates()
    var
        BrandingDetail: Record "branding detail";
        Txr001: Label 'These Branding Details values are already exist for this branding';
    begin
        BrandingDetail.SetRange("Branding Code", Rec."Branding Code");
        if BrandingDetail.FindSet() then
            repeat
                if BrandingDetail."Item Color ID" = Rec."Item Color ID" then
                    Error(Txr001);
            until BrandingDetail.Next() = 0;

    end;
}
