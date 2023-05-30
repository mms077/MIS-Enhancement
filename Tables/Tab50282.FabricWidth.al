table 50282 "Fabric Width"
{
    Caption = 'Fabric Width';
    DataClassification = ToBeClassified;
    DataPerCompany = false;
    fields
    {
        field(1; "Width"; Integer)
        {
            Caption = 'Width';
            DataClassification = ToBeClassified;
        }
        field(2; "ID"; Integer)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Width")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        LastFabricWidth: Record "Fabric Width";
        GlobalSyncSetup: Record "Global Sync Setup";
    begin
        /*Clear(GlobalSyncSetup);
        if GlobalSyncSetup.Get(CompanyName) then
            if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/
        Clear(LastFabricWidth);
        if LastFabricWidth.FindLast() then
            Rec.ID := LastFabricWidth.ID + 1
        else
            Rec.ID := 1;
    end;
    //end;
}
