table 50316 "Packing List Header"
{
    DataClassification = CustomerContent;
    Caption = 'Packing List Header';

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type") // Assuming Sales Order initially, could be extended
        {
            Caption = 'Document Type';
            DataClassification = SystemMetadata;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = if ("Document Type" = const(Order)) "Sales Header"."No." where("Document Type" = const(Order));
            // Add other relations if Document Type expands (e.g., Transfer Header)
            DataClassification = SystemMetadata;
        }
        field(10; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"In Progress",Packed,Shipped,"Requires Manual Packing";
            OptionCaption = 'Open,In Progress,Packed,Shipped,Requires Manual Packing';
            DataClassification = SystemMetadata;
        }
        field(11; "No. of Boxes Calculated"; Integer)
        {
            Caption = 'No. of Boxes Calculated';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(12; "Generation DateTime"; DateTime)
        {
            Caption = 'Generation Date/Time';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(13; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = SystemMetadata;
        }
        field(14; "Bins Created"; Boolean)
        {
            Caption = 'Bins Created';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Document Type", "Document No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        PackingListLine: Record "Packing List Line";
    begin
        PackingListLine.SetRange("Document Type", Rec."Document Type");
        PackingListLine.SetRange("Document No.", Rec."Document No.");
        PackingListLine.DeleteAll(true);
    end;
}