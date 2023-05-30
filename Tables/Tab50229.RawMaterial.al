table 50229 "Raw Material"
{
    Caption = 'Raw Material';
    DataPerCompany = false;

    fields
    {
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';

            TableRelation = Item."No.";
            trigger OnValidate()
            var
                RawMaterial: Record "Raw Material";
            begin
                RawMaterial.SetRange(Code, Rec.code);
                if RawMaterial.FindFirst() then
                    Error('This Code is already used');
            end;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';

        }
        field(4; "Color ID"; Integer)
        {
            Caption = 'Color ID';

            TableRelation = Color.ID;
        }
        field(5; "UOM Code"; Code[10])
        {
            Caption = 'UOM Code';

            TableRelation = "Unit Of Measure".Code;
        }
        field(6; "Tonality Code"; Code[50])
        {
            Caption = 'Tonality Code';

            TableRelation = Tonality.Code;
        }
        field(7; "Raw Material Category"; Code[50])
        {
            Caption = 'Raw Material Category';

            TableRelation = "Raw Material Category".Code;
        }
        field(8; "Design Section Code"; Code[50])
        {
            Caption = 'Design Section Code';

            TableRelation = "Design Section".Code;
        }
    }
    keys
    {
        key(PK; "Raw Material Category", "Color ID", "Tonality Code")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        UserSetup.TestField("Delete Raw Material", true);
    end;

    trigger OnInsert()
    begin
        //prevent blank code
        Rec.TestField("Code");
    end;

    trigger OnRename()
    begin
        //prevent blank code
        Rec.TestField("Code");
    end;

    trigger OnModify()
    begin
        //prevent blank code
        Rec.TestField("Code");
    end;
}
