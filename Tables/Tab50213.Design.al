table 50213 Design
{
    Caption = 'Design';
    DataPerCompany = false;

    fields
    {
        field(2; "Code"; Code[50])
        {
            Caption = 'Code';

        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';

        }
        field(4; "Items Count"; Integer)
        {
            Caption = 'Items Count';
            FieldClass = FlowField;
            CalcFormula = count("Item" where("Design Code" = field("Code")));
        }
        field(5; Picture; MediaSet)
        {
            Caption = 'Picture';
        }
        field(6; "Name Local"; Text[100])
        {
            Caption = 'Name Local';
        }
        field(7; "Type"; Text[100])
        {
            Caption = 'Type';
            TableRelation = "Design Type".Name;
        }
        field(8; "Category"; Code[20])
        {
            Caption = 'Category';
            TableRelation = "Item Category".Code;
        }

        field(9; Gender; Option)
        {
            Caption = 'Gender';

            OptionMembers = " ","Male","Female","Unisex";
            OptionCaption = ' ,Male,Female,Unisex';
        }
        field(10; "Has Picture"; Boolean)
        {
            Caption = 'Has Picture';
            Editable = false;
        }
        field(11; "Gender Sort Order"; Integer)
        {
            Caption = 'Gender Sort Order';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Name)
        {

        }
        fieldgroup(Brick; "Code", "Name", "Items Count", "Type", "Category", "Picture")
        {
        }
    }
    var
        DesignDetail: Record "Design Detail";

    trigger OnDelete()
    var
        UserSetup: Record "User Setup";
        Txt001: Label 'You should have Delete Design permission to delete records';
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.CanDeleteDesign(UserId) then begin
            DesignDetail.SetRange("Design Code", "Code");
            if DesignDetail.FindSet() then
                DesignDetail.DeleteAll();
        end else
            Error(Txt001);
    end;

    trigger OnInsert()
    begin
        Rec."Gender Sort Order" := CalculateGenderSortOrder();
    end;

    procedure CalculateGenderSortOrder(): Integer
    begin
        case Gender of
            Gender::Unisex:
                exit(1);
            Gender::Male:
                exit(2);
            Gender::Female:
                exit(3);
            else
                exit(4);
        end;
    end;

    trigger OnModify()
    begin
        Rec."Gender Sort Order" := CalculateGenderSortOrder();

        if Rec.Picture.Count = 0 then
            Rec."Has Picture" := false
        else
            Rec."Has Picture" := true;
    end;

    trigger OnRename()
    var
        LookDetail: Record "Look Detail";
    begin
        // Update all related Look Detail records
        LookDetail.SetRange(Design, xRec.Code); // Filter by the old Design code
        if LookDetail.FindSet() then
            repeat
                LookDetail.Design := Rec.Code; // Update to the new Design code
                LookDetail.Modify();
            until LookDetail.Next() = 0;
    end;
}
