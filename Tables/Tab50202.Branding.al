table 50202 Branding
{
    Caption = 'Branding';
    DataPerCompany = false;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
            trigger OnValidate()
            var
                Branding: Record Branding;
            begin
                Branding.SetRange(Code, Rec.code);
                if Branding.FindFirst() then
                    Error('This Code is already used');
            end;

        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';

        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';

        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(5; "Branding Category Code"; Code[50])
        {
            Caption = 'Branding Category Code';

            TableRelation = "Branding Category".Code;
        }
        field(6; "Item No."; Code[20])
        {
            Caption = 'Item No.';

            TableRelation = Item."No." where(IsRawMaterial = const(false));
        }
        field(7; Height; Decimal)
        {
            Caption = 'Height';

        }
        field(8; Width; Decimal)
        {
            Caption = 'Width';

        }
        field(9; Length; Decimal)
        {
            Caption = 'Length';

        }
        field(10; "Size UOM Code"; Code[10])
        {
            Caption = 'Size UOM Code';

            TableRelation = "Unit of Measure".Code;
        }
        field(11; "Visual Support File"; Text[100])
        {
            Caption = 'Visual Support File';

        }
        field(12; Position; Code[50])
        {
            Caption = 'Position';

        }
        field(13; Picture; MediaSet)
        {
            Caption = 'Picture';

        }
        field(14; "Company Name"; Text[30])
        {
            TableRelation = Company.Name;

        }
        field(15; "Item Description"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; Code, "Customer No.")
        {
            Clustered = true;
        }

    }
    fieldgroups
    {
        fieldgroup(Brick; Code, Name, Description, Picture)
        {
        }
    }
    trigger OnInsert()
    begin
        Rec."Company Name" := CompanyName;
    end;
}
