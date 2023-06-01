table 50237 "Needed Raw Material"
{
    Caption = 'Needed Raw Material';


    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';

            AutoIncrement = true;
        }
        field(2; "RM Code"; Code[20])
        {
            Caption = 'RM Code';

            TableRelation = "Raw Material".Code;
        }
        field(3; "Raw Material Category"; Code[50])
        {
            Caption = 'Raw Material Category';

            TableRelation = "Raw Material Category".Code;
        }
        field(4; "Color ID"; Integer)
        {
            Caption = 'Color ID';

            TableRelation = Color.ID;
        }
        field(5; "Tonality Code"; Code[50])
        {
            Caption = 'Tonality Code';

            TableRelation = Tonality.Code;
        }
        field(6; "Design Detail Line No."; Integer)
        {
            Caption = 'Design Detail Line No.';

        }
        field(7; "Design Detail Design Code"; Code[50])
        {
            Caption = 'Design Detail Design Code';

        }

        field(8; "Design Detail Design Sec. Code"; Code[50])
        {
            Caption = 'Design Detail Design Section Code';

        }
        field(9; "Design Detail Size Code"; Code[10])
        {
            Caption = 'Design Detail Size Code';

            TableRelation = Size.Code;
        }
        field(10; "Design Detail Fit Code"; Code[10])
        {
            Caption = 'Design Detail Fit Code';

        }
        field(11; "Design Detail Quantity"; Decimal)
        {
            Caption = 'Design Detail Quantity';

        }
        field(12; "Design Detail Section Code"; Code[50])
        {
            Caption = 'Design Detail Section Code';

        }
        field(13; "Design Detail UOM Code"; Code[10])
        {
            Caption = 'Design Detail UOM Code';

            TableRelation = "Unit of Measure".Code;
            Editable = false;
        }
        field(14; Batch; Integer)
        {
            Caption = 'Batch';
        }
        field(15; "Sales Line Quantity"; Decimal)
        {
            Caption = 'Sales Line Quantity';

        }
        field(16; "Sales Line Item No."; Code[20])
        {
            Caption = 'Sales Line Item No.';

            TableRelation = Item."No.";
        }
        field(17; "Sales Line Location Code"; Code[10])
        {
            Caption = 'Sales Line Location Code';

            TableRelation = Location.Code;
        }
        field(18; "Sales Line UOM Code"; Code[10])
        {
            Caption = 'Sales Line UOM Code';

            TableRelation = "Unit of Measure".Code;
        }
        field(19; "Assembly Order No."; Code[20])
        {
            Caption = 'Assembly Order No.';

        }
        field(20; "Assembly Order Line No."; Integer)
        {
            Caption = 'Assembly Order Line No.';

        }
        field(21; "Sales Order No."; Code[50])
        {
            Caption = 'Sales Order No.';

        }
        field(22; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';

        }
        field(23; "Assembly Line Quantity"; Decimal)
        {
            Caption = 'Assembly Quantity';

        }
        field(24; "Assembly Line UOM Code"; Code[10])
        {
            Caption = 'Assembly Line UOM Code';

            TableRelation = "Unit of Measure".Code;
        }
        field(25; "Paramertes Header ID"; Integer)
        {
            Caption = 'Paramertes Header ID';

            TableRelation = "Parameter Header".ID;
            Editable = false;
        }
        field(26; "Raw Material Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Raw Material".Name where(Code = field("RM Code")));
            Editable = false;
        }
        field(27; "RM Variant Code"; Code[50])
        {
            Caption = 'RM Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("RM Code"));
            Editable = false;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
