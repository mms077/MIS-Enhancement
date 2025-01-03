table 50201 "RM per Sales Quote"
{
    Caption = 'RM per Sales Quote';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Sales Quote No."; Code[20])
        {
            Caption = 'Sales Quote No.';
            Editable = false;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = "Item"."No.";
            Editable = false;
        }
        field(3; "Variant Code"; Code[20])
        {
            Caption = 'Variant';
            Editable = false;
        }
        field(4; BUOM; Code[20])
        {
            Caption = 'BUOM';
            Editable = false;
        }
        field(5; "Required Qty."; Decimal)
        {
            Caption = 'Required Qty.';
            Editable = false;
        }
        field(6; "Available Qty."; Decimal)
        {
            Caption = 'Available Qty.';
            Editable = false;
            trigger OnValidate()
            begin
                "Missing Qty." := Rec."Required Qty." - Rec."Available Qty.";
                if "Missing Qty." > 0 then
                    Rec."Req Qty is Missing" := true
                else
                    Rec."Req Qty is Missing" := false;
            end;
        }
        field(7; "Missing Qty."; Decimal)
        {
            Caption = 'Missing Qty.';
            Editable = false;
            DecimalPlaces = 2;
        }
        field(8; "Req Qty is Missing"; Boolean)
        {
            Caption = 'Req Qty is Missing';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Sales Quote No.", "Item No.", "Variant Code")
        {
            Clustered = true;
        }
        key(Missing; "Req Qty is Missing")
        {

        }
    }
}
