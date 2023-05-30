table 50211 "Design Detail"
{
    Caption = 'Design Detail';
    DataPerCompany = false;

    fields
    {
        /* field(1; "Design ID"; Integer)
         {
             TableRelation = Design.ID;
             Editable = false;
         }*/
        field(2; "Line No."; Integer)
        {

            Editable = false;
        }
        field(3; "Design Section Code"; Code[50])
        {
            Caption = 'Design Section Code';

            TableRelation = "Design Section".Code where("Section Code" = field("Section Code"));
            trigger OnValidate()
            var
                DesignSection: Record "Design Section";
            begin
                /*Clear(GlobalSyncSetup);
                if GlobalSyncSetup.Get(CompanyName) then
                    if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/
                Rec.CalcFields("UOM Code");
                PreventSimilarFields();
                PreventDifferentSectionGrpForSameDesignSection();
                //end;
            end;
        }
        field(4; "Size Code"; Code[50])
        {
            Caption = 'Size Code';

            TableRelation = Size.Code;
        }
        field(5; "Fit Code"; Code[50])
        {
            Caption = 'Fit Code';

            TableRelation = Fit.Code;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';

        }
        field(7; "Section Code"; Code[50])
        {
            Caption = 'Section Code';

            TableRelation = Section.Code;
        }
        field(8; "UOM Code"; Code[10])
        {
            Caption = 'UOM Code';
            FieldClass = FlowField;
            CalcFormula = lookup("Design Section"."UOM Code" where(Code = field("Design Section Code")));
            TableRelation = "Unit of Measure".Code;
            Editable = false;
        }
        field(9; "Design Name"; Text[100])
        {
            Caption = 'Design Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Design.Name where("Code" = field("Design Code")));
        }
        field(10; "Size Name"; Text[100])
        {
            Caption = 'Size Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Size.Name where("Code" = field("Size Code")));
        }
        field(11; "Fit Name"; Text[100])
        {
            Caption = 'Fit Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Fit.Name where("Code" = field("Fit Code")));
        }
        field(12; "Section Name"; Text[100])
        {
            Caption = 'Section Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Section.Name where("Code" = field("Section Code")));
        }
        field(13; "Design Section Name"; Text[100])
        {
            Caption = 'Design Section Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Design Section".Name where("Code" = field("Design Section Code")));
        }
        field(14; "Design Code"; Code[50])
        {
            TableRelation = Design.Code;
            //Editable = false;
        }
        field(15; "Section Number"; Integer)
        {
            Caption = 'Section Number';
        }
        field(16; "Length (cm)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(17; "Width (cm)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(18; "Section Perimeter (cm)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(19; "Section Surface (cm2)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(20; "Section Composition"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Section".Composition where(Code = field("Section Code")));
            OptionMembers = Others,Fabrics,Accessories;
            OptionCaption = 'Others,Fabrics,Accessories';
            Editable = false;
        }
        field(21; "Section Group"; Code[50])
        {
            TableRelation = "Section Group"."Group Code" where("Section Code" = field("Section Code"));
            trigger OnValidate()
            begin
                PreventDifferentSectionGrpForSameDesignSection();
            end;
        }
    }
    keys
    {
        key(PK; "Design Code", "Line No.")
        {
            Clustered = true;
        }
        key(FK; "Fit Code", "Size Code", "Section Number", "Design Section Code")
        {

        }
        key(FK2; "Section Code", "Design Code", "Size Code", "Fit Code")
        {

        }
        key(FK3; "Design Section Code")
        {

        }
    }
    trigger OnInsert()
    var
        LastDesignDetail: Record "Design Detail";
    begin
        /*Clear(GlobalSyncSetup);
        if GlobalSyncSetup.Get(CompanyName) then
            if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/
        if Rec."Line No." = 0 then begin
            Clear(LastDesignDetail);
            LastDesignDetail.SetRange("Design Code", Rec."Design Code");
            if LastDesignDetail.FindLast() then
                Rec."Line No." := LastDesignDetail."Line No." + 1
            else
                Rec."Line No." := 1;
        end;
        PreventSimilarFields();
        PreventDifferentSectionGrpForSameDesignSection();
        //end;
    end;

    trigger OnModify()
    begin
        /*Clear(GlobalSyncSetup);
        if GlobalSyncSetup.Get(CompanyName) then
            if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/
        PreventSimilarFields();
        PreventDifferentSectionGrpForSameDesignSection();
        //end;
    end;

    procedure PreventDifferentSectionGrpForSameDesignSection()
    var
        DesignDetail: Record "Design Detail";
        Txt001: Label 'You cannot use same design section for different section group, check %1';
    begin
        if (Rec."Design Section Code" <> '') and (Rec."Section Group" <> '') then begin
            Clear(DesignDetail);
            DesignDetail.SetRange("Design Code", Rec."Design Code");
            DesignDetail.SetRange("Design Section Code", Rec."Design Section Code");
            DesignDetail.SetFilter("Section Group", '<>%1', Rec."Section Group");
            if DesignDetail.FindFirst() then
                repeat
                    if (DesignDetail."Section Group" <> '') and (DesignDetail."Line No." <> Rec."Line No.") then
                        Error(Txt001, Rec."Design Section Code");
                until DesignDetail.Next() = 0;
        end;
    end;

    procedure PreventSimilarFields()
    var
        DesignDetail: Record "Design Detail";
        Txt001: Label 'You cannot use same design section - Size - Fit - for the same design twice , check Design Section %1';
    begin
        if (Rec."Design Section Code" <> '') then begin
            Clear(DesignDetail);
            DesignDetail.SetRange("Design Code", Rec."Design Code");
            DesignDetail.SetRange("Size Code", Rec."Size Code");
            DesignDetail.SetRange("Fit Code", Rec."Fit Code");
            DesignDetail.SetRange("Design Section Code", Rec."Design Section Code");
            if DesignDetail.FindFirst() then
                repeat
                    if (DesignDetail."Line No." <> Rec."Line No.") then
                        Error(Txt001, Rec."Design Section Code");
                until DesignDetail.Next() = 0;
        end;
    end;

    var
    //GlobalSyncSetup: Record "Global Sync Setup";
}
