table 50205 "Branding Structure"
{
    Caption = 'Branding Structure';


    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(2; "Branding Detail Line No."; Integer)
        {
            Caption = 'Branding Detail Line No.';

            TableRelation = "Branding Detail"."Line No.";
        }
        field(3; "Raw Material Code"; Code[50])
        {
            Caption = 'Raw Material Code';

            TableRelation = "Item"."No." where(IsRawMaterial = const(true));
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';

        }
        field(5; "UOM Code"; Code[10])
        {
            Caption = 'UOM Code';

            TableRelation = "Unit of Measure".Code;
        }
        field(6; "Branding Code"; Code[50])
        {
            Caption = 'Branding Code';

            TableRelation = "Branding Detail"."Branding Code";
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Line No.", "Branding Code", "Branding Detail Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        LastBrandingStructure: Record "Branding Structure";
    begin
        Clear(LastBrandingStructure);
        if LastBrandingStructure.FindLast() then
            Rec."Line No." := LastBrandingStructure."Line No." + 1
        else
            Rec."Line No." := 1;
    end;
}
