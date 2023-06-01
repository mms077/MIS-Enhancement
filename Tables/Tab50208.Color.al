table 50208 Color
{
    Caption = 'Color';
    DataPerCompany = false;

    fields
    {//Added ID because there was duplicates in color code
        field(1; ID; Integer)
        {
            Caption = 'ID';
        }
        field(2; "Code"; Code[50])
        {
            Caption = 'Code';

        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';

        }
        field(4; "French Description"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'French Description';
        }
        field(5; "Arabic Description"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Arabic Description';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, Code, Name, "French Description", "Arabic Description")
        {

        }
    }
    trigger OnInsert()
    var
        LastColor: Record Color;
    //GlobalSyncSetup: Record "Global Sync Setup";
    begin
        /*Clear(GlobalSyncSetup);
        if GlobalSyncSetup.Get(CompanyName) then
            if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/
        Clear(LastColor);
        if LastColor.FindLast() then
            Rec.ID := LastColor.ID + 1
        else
            Rec.ID := 1;
        //end;
    end;
}
