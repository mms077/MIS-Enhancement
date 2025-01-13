pageextension 50209 "Assembly Orders" extends "Assembly Orders"
{
    layout
    {
        addafter("Remaining Quantity")
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = all;
            }
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = all;
            }
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = all;
            }
            field("Source Line No."; Rec."Source Line No.")
            {
                ApplicationArea = all;
            }
            field("ER - Manufacturing Order No."; Rec."ER - Manufacturing Order No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Variant Code")
        {
            field("Item Size"; Rec."Item Size")
            {
                ApplicationArea = all;
            }
            field("Item Fit"; Rec."Item Fit")
            {
                ApplicationArea = all;
            }
            field("Item Cut Code"; Rec."Item Cut Code")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter(Line)
        {
            group("Assembly Approval")
            {
                Caption = 'Assembly Approval';

                action("Approve")
                {
                    ApplicationArea = all;
                    Visible = ApproveVisible;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Approve;
                    trigger OnAction()
                    begin
                        ApproveAssembly();
                    end;
                }
                action("Reject")
                {
                    ApplicationArea = all;
                    Visible = ApproveVisible;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Reject;
                    trigger OnAction()
                    begin
                        RejectAssembly();
                    end;
                }
            }
        }
        addafter(Line)
        {
            /*action("Cutting Sheet")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    AssemblHeader: Record "Assembly Header";
                begin
                    CurrPage.SetSelectionFilter(AssemblHeader);
                    //AssemblHeader.SetFilter("No.", Rec."No.");
                    Report.Run(Report::"Cutting Sheet Report", true, true, AssemblHeader);
                end;
            }
            action("Dashboard")
            {
                ApplicationArea = all;
                Image = ShowChart;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Cutting Sheet Dashboard";
                RunPageLink = "Assembly No." = field("No.");
            }
            action("Scan")
            {
                ApplicationArea = all;
                Image = NumberGroup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                //RunObject = page "Scan Cutting Sheet";
                //RunPageLink = "No." = field("No.");
                trigger OnAction()
                var
                    ScanCuttingSheet: Page "Scan Cutting Sheet";
                    AssemblyNo: Code[20];
                    UserName: Code[50];
                begin
                    ScanCuttingSheet.RunModal();
                end;
            }*/
            action("Update Grouping Criteria")
            {
                ApplicationArea = all;
                Image = Action;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    AssemblyHeader: Record "Assembly Header";
                    CUManagement: Codeunit Management;
                begin
                    Clear(AssemblyHeader);
                    if AssemblyHeader.FindFirst() then
                        repeat
                            AssemblyHeader.CalcFields("Item Size", "Item Fit", "Item Cut Code");
                            //check if the item with embroidery
                            if CUManagement.WithEmbroidery(AssemblyHeader) then
                                AssemblyHeader."Grouping Criteria" := AssemblyHeader."Item No." + '-' + AssemblyHeader."Item Size" + '-' + AssemblyHeader."Item Fit" + '-' + AssemblyHeader."Item Cut Code" + '-WithEmb'
                            else
                                AssemblyHeader."Grouping Criteria" := AssemblyHeader."Item No." + '-' + AssemblyHeader."Item Size" + '-' + AssemblyHeader."Item Fit" + '-' + AssemblyHeader."Item Cut Code" + '-WithoutEmb';
                            AssemblyHeader.Modify();
                        until AssemblyHeader.Next() = 0;
                end;
            }
            action("Suggest Grouping")
            {
                ApplicationArea = all;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    AssemblyHeader: Record "Assembly Header";
                    AssemblyOrdersPage: Page "Assembly Orders";
                begin
                    Rec.TestField("ER - Manufacturing Order No.", '');
                    Clear(AssemblyHeader);
                    AssemblyHeader.FilterGroup(2);
                    AssemblyHeader.SetRange("ER - Manufacturing Order No.", '');
                    AssemblyHeader.SetRange("Grouping Criteria", Rec."Grouping Criteria");
                    if AssemblyHeader.FindSet() then begin
                        AssemblyOrdersPage.SetTableView(AssemblyHeader);
                        AssemblyOrdersPage.LookupMode(true);
                        AssemblyOrdersPage.Run();
                    end;
                    AssemblyHeader.FilterGroup(0);
                end;
            }
            action("Process Manufacturing Order")
            {
                ApplicationArea = all;
                Image = SpecialOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    "ER - Manufacturing Order": Record "ER - Manufacturing Order";
                    LastNo: Code[50];
                    AssemblHeader: Record "Assembly Header";
                    AssemblyGroupsList: Page "ER - Manufacturing Orders";
                begin
                    if "ER - Manufacturing Order".FindLast() then
                        LastNo := IncStr("ER - Manufacturing Order"."No.")
                    else
                        LastNo := 'AGRP-00001';
                    CurrPage.SetSelectionFilter(AssemblHeader);
                    if AssemblHeader.FindSet() then begin
                        if CheckSameItemNo(AssemblHeader) = false then
                            Error(Txt001);
                        if CheckSameSize(AssemblHeader) = false then
                            Error(Txt002);
                        if CheckSameFit(AssemblHeader) = false then
                            Error(Txt003);
                        if CheckSameCut(AssemblHeader) = false then
                            Error(Txt004);
                        /*if CheckSameColor(AssemblHeader) = false then
                            Error(Txt005);
                        if CheckSameTonality(AssemblHeader) = false then
                            Error(Txt006);*/
                    end;

                    //Create Assembly Group
                    Clear("ER - Manufacturing Order");
                    "ER - Manufacturing Order".Init();
                    "ER - Manufacturing Order"."No." := LastNo;
                    "ER - Manufacturing Order"."Current Sequence No." := 1;
                    "ER - Manufacturing Order".Insert();
                    //Assign Assembly Group
                    if AssemblHeader.FindSet() then
                        repeat
                            AssemblHeader.TestField("ER - Manufacturing Order No.", '');
                            AssemblHeader.TestField(Status, AssemblHeader.Status::Released);
                            AssemblHeader."ER - Manufacturing Order No." := "ER - Manufacturing Order"."No.";
                            AssemblHeader.Modify();
                        until AssemblHeader.Next() = 0;
                    //Set Item No. to ER - Manufacturing Order
                    "ER - Manufacturing Order"."Item No." := AssemblHeader."Item No.";
                    "ER - Manufacturing Order"."Item Description" := AssemblHeader."Description";
                    "ER - Manufacturing Order".Modify();
                    AssemblyGroupsList.SetTableView("ER - Manufacturing Order");
                    AssemblyGroupsList.Run();
                end;
            }
            action("Validate All Variants")
            {
                ApplicationArea = all;
                Image = SpecialOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    AssemblHeader: Record "Assembly Header";
                    CUManagement: Codeunit Management;
                    CuttingSheetDashboard: Record "Cutting Sheets Dashboard";
                    CuttingSheetDashboardTemp: Record "Cutting Sheets Dashboard" temporary;
                begin
                    CurrPage.SetSelectionFilter(AssemblHeader);
                    if AssemblHeader.FindSet() then begin
                        repeat
                            if (AssemblHeader."Variant Code" <> '') and (AssemblHeader."Assemble to Order" = false) then begin
                                if AssemblHeader.Status = AssemblHeader.Status::Released then begin
                                    AssemblHeader.Status := AssemblHeader.Status::Open;
                                    AssemblHeader.Modify();
                                end;
                                AssemblHeader."Parameters Header ID" := 0;
                                AssemblHeader.Validate("Variant Code", AssemblHeader."Variant Code");
                                AssemblHeader.Modify();

                                if CuttingSheetDashboard.Get(AssemblHeader."No.") then begin
                                    CuttingSheetDashboardTemp.Init();
                                    CuttingSheetDashboardTemp := CuttingSheetDashboard;
                                    CuttingSheetDashboardTemp.Insert();


                                    CuttingSheetDashboard.Delete();
                                    // insert old data to dashboard 
                                    Clear(CuttingSheetDashboard);
                                    CuttingSheetDashboard.Init();
                                    CuttingSheetDashboard := CuttingSheetDashboardTemp;
                                    CuttingSheetDashboard.Insert();
                                    //CUManagement.CreateCuttingSheetDashboard(AssemblHeader, '');
                                    //Create Parameter Header for the assembly
                                    CuttingSheetDashboardTemp.DeleteAll();
                                end else
                                    CUManagement.CreateCuttingSheetDashboard(AssemblHeader, '');
                                CUManagement.CreateParameterHeaderForAssembly(AssemblHeader);
                            end;
                        until AssemblHeader.Next() = 0;
                    end;

                end;
            }
        }
        modify(Release)
        {
            Visible = AllowDirectRelease;
        }
        modify(Reopen)
        {
            Visible = AllowDirectRelease;
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        VisibilityControl;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Grouping Criteria");
    end;

    procedure ApproveAssembly()
    begin
        Rec.TestField(Status, Rec.Status::Open);
        Rec.CalcFields("Workflow Approver", "Total Sequences");
        //Approve and increase sequence by 1
        if Rec."Sequence No." < Rec."Total Sequences" then begin
            Rec."Sequence No." := Rec."Sequence No." + 1;
            Rec.Modify();
            Rec.CalcFields("Workflow Approver");
            //To change action visibility
            CurrPage.Close();
            Page.Run(Page::"Assembly Order", Rec);
        end else
            //Last Approver --> release
            if Rec."Sequence No." = Rec."Total Sequences" then begin
                Rec.validate(Status, Rec.Status::Released);
                Rec.Modify();
            end;
        Message('Approved Successfully');
    end;

    procedure RejectAssembly()
    begin
        Rec.CalcFields("Workflow Approver", "Total Sequences");
        //Decrease sequence by 1
        if Rec."Sequence No." <> 1 then begin
            Rec."Sequence No." := Rec."Sequence No." - 1;
            Rec.Modify();
            Rec.CalcFields("Workflow Approver");
        end;
        Message('Rejected Successfully');
    end;

    procedure VisibilityControl()
    begin
        Rec.CalcFields("Workflow Approver", "Total Sequences");
        if Rec."Workflow Approver" = UserId then
            ApproveVisible := true
        else
            ApproveVisible := false;

        //Hide Release and Open Action if there is workflow
        if Rec."Workflow User Group Code" = '' then
            AllowDirectRelease := true
        else
            AllowDirectRelease := false;
    end;


    procedure CheckSameItemNo(var AssemblHeader: Record "Assembly Header"): Boolean
    var
        ItemNo: Code[50];
    begin
        if AssemblHeader.FindSet() then begin
            ItemNo := AssemblHeader."Item No.";
            repeat
                if AssemblHeader."Item No." <> ItemNo then
                    exit(false)
            until AssemblHeader.Next() = 0;
            if AssemblHeader."Item No." <> ItemNo then
                exit(false)
            else
                exit(true);
        end;
    end;

    procedure CheckSameSize(var AssemblHeader: Record "Assembly Header"): Boolean
    var
        ItemVariant: Record "Item Variant";
        ItemSize: Code[50];
    begin
        if AssemblHeader.FindSet() then begin
            ItemVariant.Get(AssemblHeader."Item No.", AssemblHeader."Variant Code");
            ItemSize := ItemVariant."Item Size";
            repeat
                ItemVariant.Get(AssemblHeader."Item No.", AssemblHeader."Variant Code");
                if ItemVariant."Item Size" <> ItemSize then
                    exit(false);
            until AssemblHeader.Next() = 0;
            if ItemVariant."Item Size" <> ItemSize then
                exit(false)
            else
                exit(true);
        end;
    end;

    procedure CheckSameFit(var AssemblHeader: Record "Assembly Header"): Boolean
    var
        ItemVariant: Record "Item Variant";
        ItemFit: Code[50];
    begin
        if AssemblHeader.FindSet() then begin
            ItemVariant.Get(AssemblHeader."Item No.", AssemblHeader."Variant Code");
            ItemFit := ItemVariant."Item Fit";
            repeat
                ItemVariant.Get(AssemblHeader."Item No.", AssemblHeader."Variant Code");
                if ItemVariant."Item Fit" <> ItemFit then
                    exit(false);
            until AssemblHeader.Next() = 0;
            if ItemVariant."Item Fit" <> ItemFit then
                exit(false)
            else
                exit(true);
        end;
    end;

    procedure CheckSameCut(var AssemblHeader: Record "Assembly Header"): Boolean
    var
        ItemVariant: Record "Item Variant";
        ItemCut: Code[50];
    begin
        if AssemblHeader.FindSet() then begin
            ItemVariant.Get(AssemblHeader."Item No.", AssemblHeader."Variant Code");
            ItemCut := ItemVariant."Item Cut Code";
            repeat
                ItemVariant.Get(AssemblHeader."Item No.", AssemblHeader."Variant Code");
                if ItemVariant."Item Cut Code" <> ItemCut then
                    exit(false);
            until AssemblHeader.Next() = 0;
            if ItemVariant."Item Cut Code" <> ItemCut then
                exit(false)
            else
                exit(true);
        end;
    end;

    procedure CheckSameColor(var AssemblHeader: Record "Assembly Header"): Boolean
    var
        ItemVariant: Record "Item Variant";
        ItemColor: Integer;
    begin
        if AssemblHeader.FindSet() then begin
            ItemVariant.Get(AssemblHeader."Item No.", AssemblHeader."Variant Code");
            ItemColor := ItemVariant."Item Color ID";
            repeat
                ItemVariant.Get(AssemblHeader."Item No.", AssemblHeader."Variant Code");
                if ItemVariant."Item Color ID" <> ItemColor then
                    exit(false);
            until AssemblHeader.Next() = 0;
            if ItemVariant."Item Color ID" <> ItemColor then
                exit(false)
            else
                exit(true);
        end;
    end;

    procedure CheckSameTonality(var AssemblHeader: Record "Assembly Header"): Boolean
    var
        ItemVariant: Record "Item Variant";
        ItemTonality: Code[50];
    begin
        if AssemblHeader.FindSet() then begin
            ItemVariant.Get(AssemblHeader."Item No.", AssemblHeader."Variant Code");
            ItemTonality := ItemVariant."Tonality Code";
            repeat
                ItemVariant.Get(AssemblHeader."Item No.", AssemblHeader."Variant Code");
                if ItemVariant."Tonality Code" <> ItemTonality then
                    exit(false);
            until AssemblHeader.Next() = 0;
            if ItemVariant."Tonality Code" <> ItemTonality then
                exit(false)
            else
                exit(true);
        end;
    end;

    var
        [InDataSet]
        ApproveVisible, AllowDirectRelease : Boolean;
        MasterItemCU: Codeunit MasterItem;
        Txt001: label 'The Assembly Orders should have same Item No. to group them';
        Txt002: label 'The Assembly Orders should have same Item Size to group them';
        Txt003: label 'The Assembly Orders should have same Item Fit to group them';
        Txt004: label 'The Assembly Orders should have same Item Cut to group them';
        Txt005: label 'The Assembly Orders should have same Item Color to group them';
        Txt006: label 'The Assembly Orders should have same Color Tonality to group them';
}

