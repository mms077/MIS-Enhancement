page 50358 "Design Activities Temp"
{
    //ApplicationArea = All;
    Caption = 'Design Activities';
    PageType = CardPart;
    SourceTable = "Design Activities";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Activity Name"; Rec."Activity Name") { ApplicationArea = all; Editable = false; }

                field("Sequence No."; Rec."Sequence No.") { ApplicationArea = all; Editable = true; }
                field("Stage Type"; Rec."Stage Type") { ApplicationArea = all; Editable = true; }

                field("Allow Non-Sequential Scanning"; Rec."Allow Non-Sequential Scanning") { ApplicationArea = all; Editable = true; }
                field(Done; Rec.Done) { ApplicationArea = all; }
                field("To Scan"; Rec."To Scan")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        DesignActivities: Record "Design Activities";
                        PreviousActivity: Record "Design Activities";
                    begin
                        if rec."To Scan" then begin
                            // Set all other lines to false
                            Clear(DesignActivities);
                            DesignActivities.SetFilter("Design Code", rec."Design Code");
                            DesignActivities.SetFilter("Activity Name", '<>%1', rec."Activity Name");
                            if DesignActivities.FindSet() then begin
                                repeat
                                    DesignActivities."To Scan" := false;
                                    DesignActivities.Modify();
                                until DesignActivities.Next() = 0;
                            end;
                        end;
                        if Rec."To Scan" then begin
                            if rec.Done = '✅' then
                                Error('Already Scanned!');
                        end;
                        if (Rec."To Scan") and (rec."Sequence No." <> 1 )then begin
                            //check scanning conditions
                            // i need to check if the selected rec is ❌ and mandatory and allow non seq is false then check the rec before if its ✅ before
                            if (rec.Done = '❌') and (Rec."Stage Type" = Rec."Stage Type"::Mandatory) and not (Rec."Allow Non-Sequential Scanning") then begin
                                Clear(PreviousActivity);
                                if PreviousActivity.Get(Rec."Design Code", Rec."Activity Id" - 1, (Rec."Sequence No." - 1)) then begin
                                    if PreviousActivity.Done <> '✅' then
                                        Error('The previous activity must be completed before scanning this one.');
                                end else
                                    Error('Previous activity not found.');
                            end;



                            if (rec.Done = '❌') and (Rec."Stage Type" = Rec."Stage Type"::Mandatory) and not (Rec."Allow Non-Sequential Scanning") then begin
                                Clear(PreviousActivity);
                                if PreviousActivity.Get(Rec."Design Code", Rec."Activity Id" - 1, Rec."Sequence No." - 1) then begin
                                    if PreviousActivity.Done <> '✅' then
                                        if PreviousActivity."Stage Type" = PreviousActivity."Stage Type"::Mandatory then
                                            Error('The previous activity must be completed before scanning this one.');
                                end else
                                    Error('Previous activity not found.');
                            end;
                            // for non sequential i need the activities to be selected by sequemce instead if its non sequential
                        end;

                    end;
                }
            }

        }

    }

    actions
    {
        area(Processing)
        {

        }
    }
}
