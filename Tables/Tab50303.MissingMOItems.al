table 50303 "Missing MO Items"
{
    Caption = 'Missing MO Items';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Assembly Order No."; Code[25])
        {
            Caption = 'Assembly Order No.';
        }
        field(2; "Assembly Order Line No."; Integer)
        {
            Caption = 'Assembly Order Line No.';
        }
        field(3; Item; Code[25])
        {
            Caption = 'Item';
            TableRelation = Item."No.";
        }
        field(4; "Item Description"; Text[150])
        {
            Caption = 'Item Description';
        }
        field(5; "Missing Item Count"; Integer)
        {
            Caption = 'Missing Item Count';
        }
        field(6; "Missing Qty."; Decimal)
        {
            Caption = 'Missing Qty';
        }
        field(7; "Manufacturing Order No."; Code[20])
        {
            Caption = 'Manufacturing Order No.';
        }
        field(8; "Base UOM"; Code[10])
        {
            Caption = 'Base UOM';
        }
        field(9; "Projected Qty."; Decimal)
        {
            Caption = 'Project Qty';
        }
        //item inventory
        field(10; "Item Inventory"; Decimal)
        {
            Caption = 'Item Inventory';
        }
        field(11; "Gross Requirement Qty."; Decimal)
        {
            Caption = 'Gross Requirement Qty';
        }
        field(12; "Planned Order Recpt. Qty."; Decimal)
        {
            Caption = 'Planned Order Recpt. Qty';
        }
        field(13; "Scheduled Receipt Qty."; Decimal)
        {
            Caption = 'Scheduled Receipt Qty';
        }
        field(14; "Planned Order Releases Qty."; Decimal)
        {
            Caption = 'Planned Order Releases Qty';
        }
        field(15; "Required Quantity"; Decimal)
        {
            Caption = 'Required Quantity';
        }
    }
    keys
    {
        key(PK; "Assembly Order No.", "Assembly Order Line No.", Item, "Manufacturing Order No.")
        {
            Clustered = true;
        }
    }
}
