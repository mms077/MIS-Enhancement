tableextension 50200 Item extends Item
{
    fields
    {
        modify("Base Unit of Measure")
        {

            trigger OnAfterValidate()
            var
                MasterItemCU: Codeunit MasterItem;
            begin
                Rec.CalcFields(IsRawMaterial);
                if (Rec.IsRawMaterial = true) and (Rec."Base Unit of Measure" <> '') then begin
                    MasterItemCU.CreateItemReference(Rec."No.", Rec."No." + '-' + Rec."Base Unit of Measure", '', Rec."Base Unit of Measure");
                end;
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                DashPosition: Integer;
                DerivedCategoryCode: Text[20];
                NoSeries: Record "No. Series";
                ItemCategory: Record "Item Category";
            begin
                DashPosition := Text.StrPos(Rec."No.", '-');
                if DashPosition <> 0 then begin
                    DerivedCategoryCode := CopyStr(Rec."No.", 1, DashPosition - 1);
                    if ItemCategory.Get(DerivedCategoryCode) then
                        Rec.Validate("Item Category Code", DerivedCategoryCode);
                end;
                CheckItemNoLength(Rec);
            end;
        }
        modify("Description")
        {
            trigger OnAfterValidate()
            begin
                CheckItemDescriptionLength(Rec.Description);
            end;
        }
        modify("Description 2")
        {
            Caption = 'French Name';
            trigger OnAfterValidate()
            begin
                CheckItemDescriptionLength(Rec."Description 2");
            end;
        }
        modify(Type)
        {
            trigger OnAfterValidate()
            begin
                //Reserve always if the type is inventory
                if Rec.Type = Rec.Type::Inventory then begin
                    Rec.Validate(Reserve, Reserve::Always);
                    Rec.Validate("Replenishment System", "Replenishment System"::Purchase);
                    Rec.Modify(true);
                end;
            end;
        }
        modify("Item Category Code")
        {
            trigger OnAfterValidate()
            var
                DefaultDimension: Record "Default Dimension";
                CUManagement: Codeunit Management;
            begin
                CreateItemCategoryDimension();
            end;
        }
        field(50200; Weight; Decimal)
        {
            Caption = 'Weight';

        }
        field(50201; Width; Decimal)
        {
            Caption = 'Width';

        }
        field(50202; Length; Decimal)
        {
            Caption = 'Length';

        }
        field(50203; Height; Decimal)
        {
            Caption = 'Height';

        }
        field(50204; "Brand Code"; Code[50])
        {
            Caption = 'Brand Code';

            TableRelation = Brand.Code;
        }
        field(50206; "Hs Code"; Code[50])
        {
            Caption = 'Hs Code';

        }
        field(50207; Tariff; Code[50])
        {
            Caption = 'Tariff';

        }
        field(50208; Personalizable; Boolean)
        {
            Caption = 'Personalizable';

        }
        field(50209; "Design Code"; Code[50])
        {
            Caption = 'Design';

            TableRelation = Design.Code;
            trigger OnValidate()
            var
                Design: Record Design;
            begin
                Rec.CalcFields("Design Name");
                if StrLen(Rec."Design Name") > 45 then
                    Rec.Description := CopyStr(Rec."Design Name", 1, 45)
                else
                    Rec.Description := Rec."Design Name";
                if Rec."Design Code" <> '' then begin
                    Design.Get(Rec."Design Code");
                    Rec.Validate("Item Category Code", Design.Category);
                end;
            end;
        }
        field(50210; "Design Name"; Text[100])
        {
            Caption = 'Design Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Design.Name where("Code" = field("Design Code")));
            Editable = false;
        }
        field(50211; "Brand Name"; Text[100])
        {
            Caption = 'Brand Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Brand.Name where("Code" = field("Brand Code")));
            Editable = false;
        }
        field(50212; "Fabric Code"; Code[50])
        {
            Caption = 'Fabric Code';

            TableRelation = "Raw Material Category".Code;
        }
        field(50213; "Fabric Name"; Text[100])
        {
            Caption = 'Fabric Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Raw Material Category".Name where("Code" = field("Fabric Code")));
            Editable = false;
        }
        field(50214; "Zone"; Code[50])
        {
            //TableRelation = "Lookup InfoR" where(Type = const(Zone));
        }
        field(50215; "Flagged"; Boolean)
        {

        }

        field(50216; "IsRawMaterial"; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Raw Material" where(Code = field("No.")));
        }
        field(50217; "Arabic Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CheckItemDescriptionLength(Rec."Arabic Name");
            end;
        }
        field(50218; "Cost Amount (Actual) 2023"; Decimal)
        {
            Caption = 'Cost Amount (Actual) 2023';
            FieldClass = FlowField;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("Item No." = field("No."),
                                                                        "Posting Date" = filter('01/01/2020' .. '31/12/2023'),
                                                                        "Variant Code" = field("Variant Filter"),
                                                                        "Location Code" = field("Location Filter"),
                                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter")));
            Editable = false;
        }
        field(50219; "Cost Amount (Actual) ACY 2023"; Decimal)
        {
            Caption = 'Cost Amount (Actual) ACY 2023';
            FieldClass = FlowField;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual) (ACY)" where("Item No." = field("No."),
                                                                              "Posting Date" = filter('01/01/2020' .. '31/12/2023'),
                                                                              "Variant Code" = field("Variant Filter"),
                                                                              "Location Code" = field("Location Filter"),
                                                                              "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = field("Global Dimension 2 Filter")));
            Editable = false;
        }
        field(50220; "Cost Amount (Actual) 2024"; Decimal)
        {
            Caption = 'Cost Amount (Actual) 2024';
            FieldClass = FlowField;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)" where("Item No." = field("No."),
                                                                        "Posting Date" = filter('01/01/2024' .. '31/12/2024'),
                                                                        "Variant Code" = field("Variant Filter"),
                                                                        "Location Code" = field("Location Filter"),
                                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter")));
            Editable = false;
        }
        field(50221; "Cost Amount (Actual) ACY 2024"; Decimal)
        {
            Caption = 'Cost Amount (Actual) ACY 2024';
            FieldClass = FlowField;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual) (ACY)" where("Item No." = field("No."),
                                                                              "Posting Date" = filter('01/01/2024' .. '31/12/2024'),
                                                                              "Variant Code" = field("Variant Filter"),
                                                                              "Location Code" = field("Location Filter"),
                                                                              "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = field("Global Dimension 2 Filter")));
            Editable = false;
        }

    }
    trigger OnDelete()
    var
        UserSetup: Record "User Setup";
        Txt001: Label 'You should have Delete Item permission to delete the record';
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.CanDeleteItem(UserId) = false then
            Error(Txt001);
    end;

    trigger OnAfterDelete()
    var
        RawMaterial: Record "Raw Material";
    begin
        RawMaterial.Reset();
        RawMaterial.SetRange("Code", Rec."No.");
        RawMaterial.DeleteAll(true);
    end;

    trigger OnAfterInsert()
    begin
        CheckItemNoLength(Rec);
        CheckItemDescriptionLength(Rec.Description);

        //Reserve always if the type is inventory
        if Rec.Type = Rec.Type::Inventory then begin
            Rec.Validate(Reserve, Reserve::Always);
            Rec.Validate("Replenishment System", "Replenishment System"::Purchase);
            Rec.Modify(true);
        end;
    end;

    trigger OnModify()
    begin
        /*CheckItemNoLength(Rec);
        CheckItemDescriptionLength(Rec);*/
    end;

    trigger OnRename()
    var
        ItemVersion: Record "Item Version";
    begin
        // Update all related Item Version records
        ItemVersion.SetRange("Item No.", xRec."No."); // Filter by the old Item No.
        if ItemVersion.FindSet() then
            repeat
                ItemVersion."Item No." := Rec."No."; // Update to the new Item No.
                ItemVersion.Modify();
            until ItemVersion.Next() = 0;
    end;

    procedure CheckItemNoLength(ItemPar: Record Item)
    var
        Txt001: Label 'Item No. should be less than or equal 15 characters';
    begin
        //Prevent item No. to be more than 15 Characters
        if StrLen(ItemPar."No.") > 15 then
            Error(Txt001);
    end;

    procedure CheckItemDescriptionLength(DescriptionPar: Text[250])
    var
        Txt001: Label 'Item Description should be less than or equal 45 characters';
    begin
        //Prevent item description to be more than 45 Characters
        if (StrLen(DescriptionPar) > 45) then
            Error(Txt001);
    end;

    procedure CreateItemCategoryDimension()
    var
        DefaultDimension: Record "Default Dimension";
        CUManagement: Codeunit Management;
    begin
        if CUManagement.IsCompanyFullProduction() then begin
            Clear(DefaultDimension);
            DefaultDimension.SetRange("Table ID", 27);
            DefaultDimension.SetRange("No.", Rec."No.");
            DefaultDimension.SetFilter("Dimension Code", 'ITEMCAT');
            //Modify the existing
            if DefaultDimension.FindFirst() then begin
                DefaultDimension.Validate("Dimension Value Code", Rec."Item Category Code");
                DefaultDimension.Validate("Value Posting", DefaultDimension."Value Posting"::"Same Code");
                DefaultDimension.Modify(false);
            end else begin
                //Create new one without validation
                DefaultDimension.Init();
                DefaultDimension."Table ID" := 27;
                DefaultDimension."No." := Rec."No.";
                DefaultDimension."Dimension Code" := 'ITEMCAT';
                DefaultDimension."Dimension Value Code" := Rec."Item Category Code";
                DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::"Same Code";
                DefaultDimension.Insert(false);
            end;
        end;
    end;
}


