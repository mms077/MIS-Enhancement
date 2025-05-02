table 50306 "Packing List Line"
{
    DataClassification = CustomerContent;
    Caption = 'Packing List Line';

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
            DataClassification = SystemMetadata;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Packing List Header"."Document No." where("Document Type" = field("Document Type"));
            DataClassification = SystemMetadata;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(10; "Source Document Line No."; Integer)
        {
            Caption = 'Source Document Line No.';
            DataClassification = SystemMetadata;
            // Could add relation back to Sales Line if needed, but might slow down inserts
            // TableRelation = if ("Document Type" = const(Order)) "Sales Line"."Line No." where ("Document Type" = const(Order), "Document No." = field("Document No."));
        }
        field(11; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            DataClassification = SystemMetadata;
        }
        field(12; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
            DataClassification = SystemMetadata;
        }
        field(13; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(20; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 2 : 5;
            Editable = false; // Copied from Item
            DataClassification = SystemMetadata;
        }
        field(21; "Unit Length"; Decimal)
        {
            Caption = 'Unit Length';
            DecimalPlaces = 2 : 5;
            Editable = false; // Copied from Item
            DataClassification = SystemMetadata;
        }
        field(22; "Unit Width"; Decimal)
        {
            Caption = 'Unit Width';
            DecimalPlaces = 2 : 5;
            Editable = false; // Copied from Item
            DataClassification = SystemMetadata;
        }
        field(23; "Unit Height"; Decimal)
        {
            Caption = 'Unit Height';
            DecimalPlaces = 2 : 5;
            Editable = false; // Copied from Item
            DataClassification = SystemMetadata;
        }
        field(30; "Box No."; Integer)
        {
            Caption = 'Box No.';
            DataClassification = SystemMetadata;
        }
        field(31; "Box Size Code"; Code[20])
        {
            Caption = 'Box Size Code';
            TableRelation = "Box Size";
            DataClassification = SystemMetadata;
        }
        field(32; "Grouping Criteria Value"; Text[250])
        {
            Caption = 'Grouping Criteria Value';
            Editable = false;
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(BoxKey; "Document Type", "Document No.", "Box No.")
        {
            // Key for easily finding lines belonging to a specific box
        }
        key(SourceLineKey; "Document Type", "Document No.", "Source Document Line No.")
        {
            // Optional key for relating back to source document lines
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Item No.", Description, "Variant Code", "Box No.", "Box Size Code") { }
    }

    trigger OnInsert()
    var
        Item: Record Item;
    begin
        // Auto-populate description and dimensions from Item
        if Rec."Item No." <> '' then begin
            if Item.Get(Rec."Item No.") then begin
                if Rec.Description = '' then
                    Rec.Description := Item.Description;
                // Assuming Item fields 50201, 50202, 50203 exist as per requirement
                Rec."Unit Width" := Item."Width"; // Field 50201
                Rec."Unit Length" := Item."Length"; // Field 50202
                Rec."Unit Height" := Item."Height"; // Field 50203
                Rec."Unit Volume" := Rec."Unit Length" * Rec."Unit Width" * Rec."Unit Height";
            end;
        end;
    end;
}