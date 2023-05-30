tableextension 50209 "Item Variant" extends "Item Variant"
{
    fields
    {
        field(50200; "Item Size"; Code[50])
        {
            Caption = 'Item Size';

            Editable = false;
        }
        field(50201; "Item Fit"; Code[50])
        {
            Caption = 'Item Fit';

            Editable = false;
        }
        field(50202; "Item Color ID"; Integer)
        {
            Caption = 'Item Color ID';

            Editable = false;
        }

        field(50203; "Item Cut Code"; Code[50])
        {
            Caption = 'Item Cut';

            Editable = false;
        }
        field(50204; "Tonality Code"; Code[50])
        {
            Caption = 'Tonality Code';

            Editable = false;
        }

        field(50205; "Design Sections Set ID"; Integer)
        {
            Caption = 'Design Sections Set ID';
            Editable = false;
            TableRelation = "Design Sections Set"."Design Section Set ID";
        }
        field(50206; "Variance Combination Text"; Text[100])
        {
            Editable = false;
        }
        field(50207; "Item Features Set ID"; Integer)
        {
            Caption = 'Item Features Set ID';
            Editable = false;
            TableRelation = "Item Features Set"."Item Feature Set ID";
        }
        field(50208; "Item Brandings Set ID"; Integer)
        {
            Caption = 'Item Brandings  Set ID';
            Editable = false;
            TableRelation = "Item Brandings Set"."Item Branding Set ID";
        }
        field(50209; Picture; MediaSet)
        {

        }
        field(50210; ID; Integer)
        {
            Editable = false;
        }
    }
    trigger OnDelete()
    begin
        CheckDeleteVariantPermission();
    end;

    procedure CheckDeleteVariantPermission()
    var
        UserSetup: Record "User Setup";
    begin
        Clear(UserSetup);
        UserSetup.Get(UserId);
        UserSetup.TestField("Delete Variant");
    end;
}
