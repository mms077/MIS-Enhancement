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
                    trigger OnValidate()
                    var
                        MasterItemCU: Codeunit MasterItem;
                        AssemblyHeader: Record "Assembly Header";
                        Txt001: Label 'No Assembly found in the group %1';
                        ScanOption: Option "In","Out";
                        Txt0001: Label 'Scan In 👍';
                        Txt0002: Label 'Scan Out 👍';
                    begin
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

    var
        AssemblyGrpNo: Code[20];
        User: Code[50];
}
