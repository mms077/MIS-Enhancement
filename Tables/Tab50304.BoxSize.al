table 50304 "Box Size"
{
    DataClassification = CustomerContent;
    Caption = 'Box Size';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = SystemMetadata;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(10; "Length"; Decimal)
        {
            Caption = 'Length';
            DecimalPlaces = 2 : 5;
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                Rec.CalculateVolume();
            end;
        }
        field(11; "Width"; Decimal)
        {
            Caption = 'Width';
            DecimalPlaces = 2 : 5;
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                Rec.CalculateVolume();
            end;
        }
        field(12; "Height"; Decimal)
        {
            Caption = 'Height';
            DecimalPlaces = 2 : 5;
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                Rec.CalculateVolume();
            end;
        }
        field(13; "Volume"; Decimal)
        {
            Caption = 'Volume';
            DecimalPlaces = 2 : 5;
            Editable = false;
        }
        field(100; "Is Oversize Box"; Boolean)
        {
            Caption = 'Is Oversize Box';
            DataClassification = SystemMetadata;
            Description = 'Mark this if this code represents an oversize/manual packing scenario rather than a physical box.';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(VolumeKey; "Volume")
        {
            // Optional key for sorting by volume
        }
    }

    procedure CalculateVolume()
    begin
        Rec.Volume := Rec.Length * Rec.Width * Rec.Height;
    end;
}