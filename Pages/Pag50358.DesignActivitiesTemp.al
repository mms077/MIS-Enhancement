page 50358 "Design Activities Temp"
{
    //ApplicationArea = All;
    Caption = 'Design Activities';
    PageType = CardPart;
    SourceTable = "Scan Design Stages- ER Temp";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Activity Code"; Rec."Activity Code") { ApplicationArea = all; }
                field("Activity Name"; Rec."Activity Name") { ApplicationArea = all; Editable = false; }
                field(Done; Rec.Done) { ApplicationArea = all; }
                field("Sequence No."; Rec."Sequence No.") { ApplicationArea = all; Editable = true; }
                field("Stage Type"; Rec."Stage Type") { ApplicationArea = all; Editable = true; }

                field("Allow Non-Sequential Scanning"; Rec."Allow Non-Sequential Scanning") { ApplicationArea = all; Editable = true; }
                field(Scanned; Rec.Scanned) { ApplicationArea = all; Editable = true; }
                //field(Done; Rec.Done) { ApplicationArea = all; }
                /* field("To Scan"; Rec."To Scan")
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
                         if (Rec."To Scan") and (rec."Sequence No." <> 1) then begin
                             //check scanning conditions


                             // Check all mandatory activities before the current Activity Id
                             if (Rec.Done = '❌') and not (Rec."Allow Non-Sequential Scanning") then begin
                                 Clear(DesignActivities);
                                 DesignActivities.Setfilter("Design Code", Rec."Design Code");
                                 DesignActivities.SetRange("Sequence No.", 1, Rec."Sequence No." - 1); // Activities before the current one
                                 DesignActivities.SetRange("Stage Type", DesignActivities."Stage Type"::Mandatory); // Only mandatory activities
                                 if DesignActivities.FindSet() then begin
                                     repeat
                                         if DesignActivities.Done = '❌' then
                                             Error('All mandatory activities before this one must be completed before scanning.');
                                     until DesignActivities.Next() = 0;
                                 end;
                             end;
                         end;

                     end;
                 }*/
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
