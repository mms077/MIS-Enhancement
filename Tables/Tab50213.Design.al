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

    trigger OnModify()
    begin
        if Rec.Picture.Count = 0 then
            Rec."Has Picture" := false
        else
            Rec."Has Picture" := true;
    end;
}
