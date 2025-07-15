page 50311 "ER - Manufacturing Orders"
{
    ApplicationArea = All;
    Caption = 'ER - Manufacturing Orders';
    PageType = List;
    SourceTable = "ER - Manufacturing Order";
    UsageCategory = Lists;
    ModifyAllowed = false;
    //DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        AssemblyHeader: Record "Assembly Header";
                        AssemblyOrdersPage: Page "Assembly Orders";
                    begin
                        Clear(AssemblyHeader);
                        AssemblyHeader.SetRange("ER - Manufacturing Order No.", Rec."No.");
                        AssemblyOrdersPage.SetTableView(AssemblyHeader);
                        AssemblyOrdersPage.Run();
                    end;
                }
                field("No. Of Copies"; Rec."No. Of Copies")
                {
                    ApplicationArea = all;
                }
                field("Assembly Count"; Rec."Assembly Count")
                {
                    ApplicationArea = all;
                } ///GOOD
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Current Sequence No."; Rec."Current Sequence No.")
                {
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = all;
                }
                field("Has Plotting Link"; "Has Plotting Link")
                {
                    Caption = 'Has Plotting Link';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update View")
            {
                ApplicationArea = all;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Caption = 'Update View';
                trigger OnAction()
                var
                    ERManufacturingOrder: Record "ER - Manufacturing Order";
                begin
                    Clear(ERManufacturingOrder);
                    if ERManufacturingOrder.FindSet() then
                        repeat
                            GetErManufacturingOrderData(ERManufacturingOrder);
                        until ERManufacturingOrder.Next() = 0;
                end;
            }
            action("ER - Manufacturing Order")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                Caption = 'ER - Manufacturing Order';
                trigger OnAction()
                var
                    AssemblHeader: Record "Assembly Header";
                    AssemblyGroup: Record "ER - Manufacturing Order";
                begin
                    CurrPage.SetSelectionFilter(AssemblyGroup);
                    if AssemblyGroup.FindSet() then begin
                        //AssemblHeader.SetFilter("ER - Manufacturing Order No.", AssemblyGroup."No.");
                        Report.Run(Report::"ER - Manufacturing Order", true, true, AssemblyGroup);
                    end;
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
                RunPageLink = "ER - Manufacturing Order No." = field("No.");
            }
            action("Scan")
            {
                ApplicationArea = all;
                Image = NumberGroup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ScanCuttingSheet: Page "Scan Cutting Sheet";
                    AssemblyHeader: Record "Assembly Header";
                begin
                    Clear(AssemblyHeader);
                    AssemblyHeader.SetRange("ER - Manufacturing Order No.", Rec."No.");
                    if AssemblyHeader.FindFirst() then begin
                        ScanCuttingSheet.SetTableView(AssemblyHeader);
                        ScanCuttingSheet.RunModal();
                    end;
                end;
            }
            action("Add Activity")
            {
                ApplicationArea = all;
                Image = NumberGroup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ScanWizard: Page "Scan Unit Ref";
                    AssemblyHeader: Record "Assembly Header";
                begin
                    ScanWizard.Run(); 
                end;
            }
            action("Force Close MO without Scan")
            {
                ApplicationArea = all;
                Image = NumberGroup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ScanCuttingSheet: Page "Scan Cutting Sheet";
                    AssemblyHeader: Record "Assembly Header";
                    CuttingSheetDashboared: Record "Cutting Sheets Dashboard";
                begin
                    if Rec.Status = Rec.Status::Closed then
                        Error('You cannot Force Close MO');
                    Clear(CuttingSheetDashboared);
                    CuttingSheetDashboared.SetFilter("ER - Manufacturing Order No.", Rec."No.");
                    if CuttingSheetDashboared.FindFirst() then begin
                        repeat
                            CuttingSheetDashboared."1" := CuttingSheetDashboared."1"::"out";
                            CuttingSheetDashboared."2" := CuttingSheetDashboared."2"::"out";
                            CuttingSheetDashboared."3" := CuttingSheetDashboared."3"::"out";
                            CuttingSheetDashboared."4" := CuttingSheetDashboared."4"::"out";
                            CuttingSheetDashboared."5" := CuttingSheetDashboared."5"::"out";
                            CuttingSheetDashboared."6" := CuttingSheetDashboared."6"::"out";
                            CuttingSheetDashboared."7" := CuttingSheetDashboared."7"::"out";
                            CuttingSheetDashboared.Modify();
                        until CuttingSheetDashboared.Next() = 0;

                        // Update the status after processing all records
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify();

                        // Display the message once after the loop
                        Message('Force Closure Successfully Done');
                    end;
                end;
            }

            action("Activities Time Spent")
            {
                ApplicationArea = all;
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    AssemblyGroup: Record "ER - Manufacturing Order";
                begin
                    CurrPage.SetSelectionFilter(AssemblyGroup);
                    if AssemblyGroup.FindSet() then begin
                        //AssemblHeader.SetFilter("ER - Manufacturing Order No.", AssemblyGroup."No.");
                        Report.Run(Report::"Activities Time Spent", true, true, AssemblyGroup);
                    end;
                end;
            }
            action("Reset No. Of Copies")
            {
                ApplicationArea = all;
                Image = ClearLog;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    Txt001: Label 'You do not have access to reset the number of copies';
                begin
                    Clear(UserSetup);
                    UserSetup.Get(UserId);
                    if not UserSetup."Reset No. Of Copies" then
                        Error(Txt001);
                    Rec."No. Of Copies" := 0;
                    Rec.Modify();
                end;
            }
            action("Label Printing EN")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ERManufacturingOrders: Record "ER - Manufacturing Order";
                begin
                    CurrPage.SetSelectionFilter(ERManufacturingOrders);
                    if ERManufacturingOrders.FindSet() then
                        Report.Run(Report::"Sales Line Label Printing EN", true, true, ERManufacturingOrders);
                end;
            }
            action("Label Printing FR")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ERManufacturingOrders: Record "ER - Manufacturing Order";
                begin
                    CurrPage.SetSelectionFilter(ERManufacturingOrders);
                    if ERManufacturingOrders.FindSet() then
                        Report.Run(Report::"Sales Line Label Printing FR", true, true, ERManufacturingOrders);
                end;
            }
            action("Label Printing Assm. to Stock")
            {
                ApplicationArea = all;
                Image = Report;
                Caption = 'Label Printing Assemble to Stock';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ERManufacturingOrders: Record "ER - Manufacturing Order";
                begin
                    CurrPage.SetSelectionFilter(ERManufacturingOrders);
                    if ERManufacturingOrders.FindSet() then
                        Report.Run(Report::"Assembly to Stock Label Print", true, true, ERManufacturingOrders);
                end;
            }
            action(PlottingFile)
            {
                ApplicationArea = All;
                Caption = 'Open Plotting File Link';
                Image = Link;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    OpenPlottingLinks(Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange(Status, Rec.Status::Open);
    end;

    procedure GetErManufacturingOrderData(var ERManufacturingOrder: Record "ER - Manufacturing Order")
    var
        CuttingSheetsDashboard: Record "Cutting Sheets Dashboard";
        AssemblyHeader: Record "Assembly Header";
        Item: Record Item;
    begin
        //Get Item No.
        Clear(AssemblyHeader);
        AssemblyHeader.SetRange("ER - Manufacturing Order No.", ERManufacturingOrder."No.");
        if AssemblyHeader.FindFirst() then begin
            Clear(Item);
            Item.Get(AssemblyHeader."Item No.");
            ERManufacturingOrder."Item No." := Item."No.";
            ERManufacturingOrder."Item Description" := Item.Description;

            //Get Current Sequence Number
            Clear(CuttingSheetsDashboard);
            CuttingSheetsDashboard.SetRange("ER - Manufacturing Order No.", AssemblyHeader."ER - Manufacturing Order No.");
            if CuttingSheetsDashboard.FindFirst() then
                ERManufacturingOrder."Current Sequence No." := CuttingSheetsDashboard."Current Sequence No.";
        end;
        ERManufacturingOrder.Modify();
    end;

    procedure OpenPlottingLinks(ERManufacturingOrder: Record "ER - Manufacturing Order")
    var
        RecordLink: Record "Record Link";
        "Plotting File": Record "Plotting File";
        AssemblyHeader: Record "Assembly Header";
        ItemLoc: Record Item;
        ParameterHeaderLoc: Record "Parameter Header";
        DesignPlotting: Record "Design Plotting";
    begin
        Clear(AssemblyHeader);
        AssemblyHeader.SetRange("ER - Manufacturing Order No.", ERManufacturingOrder."No.");
        if AssemblyHeader.FindFirst() then begin
            Clear("Plotting File");
            Clear(ItemLoc);
            Clear(ParameterHeaderLoc);
            Clear(DesignPlotting);
            ParameterHeaderLoc.Get(AssemblyHeader."Parameters Header ID");
            ItemLoc.Get(AssemblyHeader."Item No.");
            AssemblyHeader.CalcFields("Item Cut Code", "Item Size", "Item Fit");
            if DesignPlotting.Get(ItemLoc."Design Code", AssemblyHeader."Item Size", AssemblyHeader."Item Fit") then begin
                "Plotting File".SetRange("Design Plotting ID", DesignPlotting.ID);
                "Plotting File".SetRange("Item Features Set", ParameterHeaderLoc."Item Features Set ID");
                if "Plotting File".FindFirst() then begin
                    Clear(RecordLink);
                    RecordLink.SetRange(Type, RecordLink.Type::Link);
                    RecordLink.SetRange("Record ID", "Plotting File".RecordId);
                    //RecordLink.SetRange(Company, CompanyName);
                    if RecordLink.FindSet() then
                        repeat
                            Hyperlink(RecordLink.URL1);
                        until RecordLink.Next() = 0;
                end;
            end;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        "Has Plotting Link" := false;
        if HasPlottingLinks(Rec) then
            "Has Plotting Link" := true;
    end;

    procedure HasPlottingLinks(ERManufacturingOrder: Record "ER - Manufacturing Order"): Boolean
    var
        RecordLink: Record "Record Link";
        "Plotting File": Record "Plotting File";
        AssemblyHeader: Record "Assembly Header";
        ItemLoc: Record Item;
        ParameterHeaderLoc: Record "Parameter Header";
        DesignPlotting: Record "Design Plotting";
    begin
        Clear(AssemblyHeader);
        AssemblyHeader.SetRange("ER - Manufacturing Order No.", ERManufacturingOrder."No.");
        if AssemblyHeader.FindFirst() then begin
            Clear("Plotting File");
            Clear(ItemLoc);
            Clear(ParameterHeaderLoc);
            Clear(DesignPlotting);
            ParameterHeaderLoc.Get(AssemblyHeader."Parameters Header ID");
            ItemLoc.Get(AssemblyHeader."Item No.");
            AssemblyHeader.CalcFields("Item Cut Code", "Item Size", "Item Fit");
            if DesignPlotting.Get(ItemLoc."Design Code", AssemblyHeader."Item Size", AssemblyHeader."Item Fit") then begin
                "Plotting File".SetRange("Design Plotting ID", DesignPlotting.ID);
                "Plotting File".SetRange("Item Features Set", ParameterHeaderLoc."Item Features Set ID");
                if "Plotting File".FindFirst() then begin
                    Clear(RecordLink);
                    RecordLink.SetRange(Type, RecordLink.Type::Link);
                    RecordLink.SetRange("Record ID", "Plotting File".RecordId);
                    //RecordLink.SetRange(Company, CompanyName);
                    if RecordLink.FindSet() then
                        exit(true)
                end;
            end;
        end;
        exit(false);
    end;

    var
        "Has Plotting Link": Boolean;
}
