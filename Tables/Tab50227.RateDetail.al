table 50227 "Rate Detail"
{
    Caption = 'Rate Detail';
    DataPerCompany = false;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
        }
        field(2; "Rate Code"; Code[50])
        {
            Caption = 'Rate Code';

            TableRelation = Rate.Code;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';

            TableRelation = Item."No.";
        }
        field(4; "Value"; Decimal)
        {
            Caption = 'Value';

        }
        field(5; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';

            TableRelation = Currency.Code;

        }
    }
    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        LastRateDetail: Record "Rate Detail";
        GlobalSyncSetup: Record "Global Sync Setup";
    begin
        /*Clear(GlobalSyncSetup);
        if GlobalSyncSetup.Get(CompanyName) then
            if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/
        Clear(LastRateDetail);
        if LastRateDetail.FindLast() then
            Rec.ID := LastRateDetail.ID + 1
        else
            Rec.ID := 1;
    end;
    //end;
}
