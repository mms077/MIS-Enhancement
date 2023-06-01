table 50221 "Item Cut"
{
    Caption = 'Item Cut';
    DataPerCompany = false;

    fields
    {
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';

            TableRelation = Item."No.";
        }
        field(3; "Cut Code"; Code[50])
        {
            Caption = 'Cut Code';

            TableRelation = Cut.Code;
        }
        field(4; "Cut Name"; Text[100])
        {
            Caption = 'Cut Name';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Cut.Name where(Code = field("Cut Code")));
        }
        field(5; "Default"; Boolean)
        {
            trigger OnValidate()
            var
                ItemCut: Record "Item Cut";
            begin
                Clear(ItemCut);
                ItemCut.SetRange("Item No.", Rec."Item No.");
                ItemCut.SetRange(Default, true);
                if ItemCut.FindSet() then
                    ItemCut.ModifyAll(Default, false);
            end;
        }
    }
    keys
    {
        key(PK; "Item No.", "Cut Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Cut Code", "Cut Name")
        {

        }
    }
}
