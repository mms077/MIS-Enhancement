table 50217 "Image Detail"
{
    Caption = 'Image Detail';
    DataPerCompany = false;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
        }
        field(2; "Record ID"; Integer)
        {
            Caption = 'Record ID';

        }
        field(3; "Type ID"; Integer)
        {
            Caption = 'Type ID';

            TableRelation = "Image Type".ID;
        }
        field(4; "Color ID"; Integer)
        {
            Caption = 'Color ID';

            TableRelation = Color.ID;
        }
        field(5; "Value"; Text[100])
        {
            Caption = 'Value';

        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        LastImageDetail: Record "Image Detail";
    //GlobalSyncSetup: Record "Global Sync Setup";
    begin
        /*Clear(GlobalSyncSetup);
        if GlobalSyncSetup.Get(CompanyName) then
            if GlobalSyncSetup."Sync Type" = GlobalSyncSetup."Sync Type"::Parent then begin*/
        Clear(LastImageDetail);
        if LastImageDetail.FindLast() then
            Rec."ID" := LastImageDetail.ID + 1
        else
            Rec."ID" := 1;
    end;
    //end;
}
