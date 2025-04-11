page 50293 "Scan Cutting Sheet"
{
    Caption = 'Scan Cutting Sheet';
    PageType = StandardDialog;
    SourceTable = "Assembly Header";
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(AssemblyGrpNo; AssemblyGrpNo)
                {
                    Caption = 'Assembly Group No.';
                    ApplicationArea = all;
                    //Editable = false;
                }
                field(User; User)
                {
                    Caption = 'User';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnValidate()
                    var
                        MasterItemCU: Codeunit MasterItem;
                        AssemblyHeader: Record "Assembly Header";
                        Txt001: Label 'No Assembly found in the group %1';
                        ScanOption: Option "In","Out";
                        Txt0001: Label 'Scan In 👍';
                        Txt0002: Label 'Scan Out 👍';
                    begin
                        //add event to validate on it if the MO is not released it should give an error
                        OnBeforeScanCuttingSheet(AssemblyGrpNo);
                        AssemblyHeader.SetRange("ER - Manufacturing Order No.", AssemblyGrpNo);
                        if AssemblyHeader.FindSet() then
                            repeat
                                //Check if the user is responsible for scanning
                                MasterItemCU.CheckUserResponibility(AssemblyHeader."No.", User);
                                Commit();
                                //Enter Scan In or Scan Out details
                                ScanOption := MasterItemCU.CreateCuttingSheetScanningEntry(AssemblyHeader."No.", User);
                            until AssemblyHeader.Next() = 0
                        else
                            Error('No Assembly found in this group', AssemblyGrpNo);

                        if ScanOption = ScanOption::"In" then
                            Message(Txt0001)
                        else
                            Message(Txt0002);
                        //CurrPage.Close();
                    end;
                }
                field(User2; User)
                {
                    Caption = 'User';
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        MasterItemCU: Codeunit MasterItem;
                        AssemblyHeader: Record "Assembly Header";
                        ScanActivities: Record "Scan Activities"; // Replace with the actual table name for scan activities
                        Dashboard: Record "Cutting Sheets Dashboard"; // Replace with the actual table name for the dashboard
                        Txt001: Label 'No Assembly found in the group %1';
                        Txt0001: Label 'Scan In 👍';
                        Txt0002: Label 'Scan Out 👍';
                        ScanOption: Option "In","Out";
                        Design: Record Design;
                        Item: Record Item;
                        WorkflowActivitiesER: Record "Workflow Activities - ER";
                        MO: Record "ER - Manufacturing Order";
                        MaxSequenceNo: Integer;
                        Txt003: Label 'The current sequence number %1 exceeds the maximum sequence number %2 in the scan activities.';
                    begin
                        Clear(ScanActivities);
                        MO.Get(AssemblyGrpNo);
                        // Validate if the MO is not released
                        OnBeforeScanCuttingSheet(AssemblyGrpNo);
                        AssemblyHeader.SetRange("ER - Manufacturing Order No.", AssemblyGrpNo);
                        if AssemblyHeader.FindSet() then
                            repeat
                                // Check if the user is responsible for scanning
                                MasterItemCU.CheckUserResponibility(AssemblyHeader."No.", User);

                                // Follow the sequence of scan activities
                                Item.Get(AssemblyHeader."Item No.");
                                Design.Get(Item."Design Code");
                                ScanActivities.SetRange("Design Code", Design.Code); // Adjust the filter as needed
                                if ScanActivities.FindLast() then
                                    MaxSequenceNo := ScanActivities."Sequence No."
                                else
                                    MaxSequenceNo := 0; // No scan activities found
                                if MO."Current Sequence No." > MaxSequenceNo then begin
                                    Message(Txt003, MO."Current Sequence No.", MaxSequenceNo);
                                    MO.Status := MO.Status::Closed;
                                    MO.Modify();
                                    exit;
                                    CurrPage.Close();
                                end;
                                Clear(ScanActivities);
                                ScanActivities.SetRange("Design Code", Design.Code);
                                ScanActivities.SetRange("Sequence No.", MO."Current Sequence No.");
                                if ScanActivities.FindSet() then begin
                                    WorkflowActivitiesER.SetFilter("Activity Name", ScanActivities."Activity Name");
                                    if WorkflowActivitiesER.FindFirst() then begin
                                        ScanOption := MasterItemCU.CreateCuttingSheetScanningEntry3(WorkflowActivitiesER, AssemblyHeader."No.", User);
                                    end;

                                end;
                                Commit();
                            until AssemblyHeader.Next() = 0
                        else
                            Error(Txt001, AssemblyGrpNo);

                        if ScanOption = ScanOption::"In" then
                            Message(Txt0001)
                        else
                            Message(Txt0002);
                        //CurrPage.Close();
                    end;
                }
            }
        }

    }

    procedure InitGlobalVariables(UserPar: Code[50]; AssemblyGrpNoPar: Code[50])
    begin
        User := UserPar;
        AssemblyGrpNo := AssemblyGrpNoPar;
    end;

    procedure GetAssemblyNo(): Code[20]
    begin
        exit(AssemblyGrpNo);
    end;

    procedure GetUserName(): Code[50]
    begin
        exit(User);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeScanCuttingSheet(AssemblyGrpNoPar: Code[50])
    begin
    end;

    var
        AssemblyGrpNo: Code[20];
        User: Code[50];
}
