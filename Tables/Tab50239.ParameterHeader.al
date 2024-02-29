table 50239 "Parameter Header"
{
    Caption = 'Parameter Header';

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';

            AutoIncrement = true;
            Editable = false;
        }

        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';

            TableRelation = Item."No.";
            trigger OnValidate()
            var
                GenLedgSetup: Record "General Ledger Setup";
            begin
                Rec.CalcFields("Item Description");
                GetDefaultUOM(Rec."Item No.");
                GetRelatedInfo(Rec."Item No.");
                GenLedgSetup.Get();
                if GenLedgSetup."Company Type" = GenLedgSetup."Company Type"::"Full Production" then
                    OnBeforeSettingLineLocation(Rec)//Setting the location code based on the assembly location code from WMS
                else begin
                    if GenLedgSetup."IC SQ Location" <> '' then
                        Rec.Validate("Sales Line Location Code", GenLedgSetup."IC SQ Location")
                    else
                        Error('The field (IC SQ Location) is not filled in the General Ledger Setup.');
                end;
            end;
        }
        field(15; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
        }
        field(3; "Item Size"; Code[50])
        {
            Caption = 'Item Size';
            trigger OnValidate()
            begin
                Rec.CalcFields("Item Size Name");
            end;

        }
        field(4; "Item Fit"; Code[50])
        {
            Caption = 'Item Fit';
            trigger OnValidate()
            begin
                Rec.CalcFields("Item Fit Name");
            end;

        }
        field(5; "Item Color ID"; Integer)
        {
            Caption = 'Item Color ID';

            trigger OnValidate()
            begin
                Rec.CalcFields("Item Color Name");
            end;
        }
        field(16; "Item Color Name"; Text[100])
        {
            Caption = 'Item Color Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Color.Name where(ID = field("Item Color ID")));
            Editable = false;
        }
        field(6; "Item Fabric Code"; Code[50])
        {
            Caption = 'Item Fabric';

        }
        field(7; "Sales Line No."; Integer)
        {
            Caption = 'Sales Line No.';
        }
        field(8; "Sales Line Document No."; Code[50])
        {
            Caption = 'Sales Line Document No.';
        }
        field(9; "Sales Line Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Sales Line Document Type';
        }
        field(10; "Item Cut"; Code[50])
        {
            Caption = 'Item Cut';
            trigger OnValidate()
            begin
                Rec.CalcFields("Item Cut Name");
            end;
        }
        field(11; "Tonality Code"; Code[50])
        {
            Caption = 'Tonality Code';

            Editable = false;
        }
        field(12; "Sales Line Quantity"; Decimal)
        {
            Caption = 'Sales Line Quantity';

        }
        field(13; "Sales Line UOM"; Code[10])
        {
            Caption = 'Sales Line UOM';

            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(14; "Sales Line Location Code"; Code[50])
        {
            Caption = 'Sales Line Location Code';
            TableRelation = Location.Code where("Use As In-Transit" = const(false));
        }
        field(17; "Design Sections Set ID"; Integer)
        {
            Caption = 'Design Sections Set ID';
            Editable = false;
            TableRelation = "Design Sections Set"."Design Section Set ID";
        }
        field(18; "Variance Combination Text"; Text[2048])
        {
            Editable = false;
        }
        field(19; "Customer No."; Code[20])
        {
            Editable = false;
            TableRelation = Customer."No.";
        }
        /*field(20; Picture; MediaSet)
        {

        }*/
        field(21; "Item Features Set ID"; Integer)
        {
            Caption = 'Item Features Set ID';
            Editable = false;
            TableRelation = "Item Features Set"."Item Feature Set ID";
        }
        field(22; "Item Brandings Set ID"; Integer)
        {
            Caption = 'Item Brandings Set ID';
            Editable = false;
            TableRelation = "Item Brandings Set"."Item Branding Set ID";
        }

        //To reference the Parameter Headers created based on Staff Size in Item Wizard Creation
        field(23; "Staff Sizes Parameter Header"; Integer)
        {
            Editable = false;
        }

        field(24; "Allocation Code"; Code[50])
        {
            Editable = false;
        }
        field(25; "Quantity To Assign"; Decimal)
        {
            Editable = false;
        }
        field(26; "Allocation Type"; Option)
        {
            OptionMembers = " ","Department","Position","Staff";
        }
        field(27; "Department Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Position Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Item Size Name"; Text[100])
        {
            Caption = 'Item Size Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.Name where(Code = field("Item Size")));
            Editable = false;
        }
        field(30; "Item Fit Name"; Text[100])
        {
            Caption = 'Item Fit Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Fit.Name where(Code = field("Item Fit")));
            Editable = false;
        }
        field(31; "Item Cut Name"; Text[100])
        {
            Caption = 'Item Cut Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Cut.Name where(Code = field("Item Cut")));
            Editable = false;
        }
        field(32; "Create Variant"; Boolean)
        {
            Editable = false;
        }
        field(33; "Sales Line Unit Price"; Decimal)
        {
            Editable = false;
        }
        field(34; "Sales Line Amount"; Decimal)
        {
            Editable = false;
        }
        field(35; "Sales Line Line Amount"; Decimal)
        {
            Editable = false;
        }
        field(36; "Sales Line Amount Incl. VAT"; Decimal)
        {
            Editable = false;
        }
        field(37; "Extra Charge %"; Decimal)
        {
            Editable = false;
        }
        field(38; "Extra Charge Amount"; Decimal)
        {
            Editable = false;
        }
        field(39; "Sales Line Discount %"; Decimal)
        {
            Editable = false;
        }
        field(40; "Sales Line Discount Amount"; Decimal)
        {
            Editable = false;
        }
        field(41; "Par Level"; Integer)
        {
            Caption = 'Par Level';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    procedure GetDefaultUOM(ItemNo: Code[20])
    var
        ItemUOM: Record "Item Unit of Measure";
    begin
        ItemUOM.SetRange("Item No.", ItemNo);
        if ItemUOM.FindSet() then;
        if ItemUOM.Count = 1 then
            Rec.Validate("Sales Line UOM", ItemUOM.Code);
    end;

    procedure GetRelatedInfo(ItemNo: Code[20])
    var
        ItemFit: Record "Item Fit";
        ItemCut: Record "Item Cut";
    begin
        Clear(ItemFit);
        Clear(ItemCut);
        ItemFit.SetRange("Item No.", ItemNo);
        ItemFit.SetRange(Default, true);
        if ItemFit.FindFirst() then
            Rec.Validate("Item Fit", ItemFit."Fit Code");

        ItemCut.SetRange("Item No.", ItemNo);
        ItemCut.SetRange(Default, true);
        if ItemCut.FindFirst() then
            Rec.Validate("Item Cut", ItemCut."Cut Code");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSettingLineLocation(var ParameHeader: Record "Parameter Header")
    begin
    end;
}
