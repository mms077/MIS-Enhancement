page 50291 "Cutting Sheet Dashboard"
{
    //ApplicationArea = All;
    Caption = 'Dashboard';
    PageType = List;
    SourceTable = "Cutting Sheets Dashboard";
    UsageCategory = Lists;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(MarketName; MarketName)
                {
                    ApplicationArea = All;
                    Caption = 'Market';
                    Editable = false;
                }
                field(ICClienstSONo; ICClienstSONo)
                {
                    ApplicationArea = all;
                    Caption = 'IC Client SO No.';
                    Editable = false;
                }
                field(CustomerName; CustomerName)
                {
                    ApplicationArea = All;
                    Caption = 'End Client';
                    Editable = false;
                }
                field(ProjectName; ProjectName)
                {
                    ApplicationArea = All;
                    Caption = 'Project Name';
                    Editable = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("Item Category"; Rec."Item Category")
                {
                    ApplicationArea = All;
                }
                field(DepartmentName; DepartmentName)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Department';
                }
                field(PositionName; PositionName)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Position';
                }
                field(StaffName; StaffName)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Staff';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Item Size"; Rec."Item Size")
                {
                    ApplicationArea = All;
                }
                field("Current Sequence No."; Rec."Current Sequence No.")
                {
                    ApplicationArea = All;
                }
                field("ER - Manufacturing Order No."; Rec."ER - Manufacturing Order No.")
                {
                    ApplicationArea = all;
                }

                /*field(Plotting; Rec."1")
                 {
                     ApplicationArea = All;
                 }
                 field(Cutting; Rec."2")
                 {
                     ApplicationArea = All;
                 }
                 field(Embroidery; Rec."3")
                 {
                     ApplicationArea = All;
                 }
                 field("Production Line"; Rec."4")
                 {
                     ApplicationArea = All;
                 }
                 field(Finishing; Rec."5")
                 {
                     ApplicationArea = All;
                 }
                 field(Trimming; Rec."6")
                 {
                     ApplicationArea = All;
                 }
                 field(Pressing; Rec."7")
                 {
                     ApplicationArea = All;
                 }
                 field(Packing; Rec."8")
                 {
                     ApplicationArea = All;
                 }*/
                field("MO Created"; "MO Created")
                {
                    ApplicationArea = All;
                }
                field("Plotting"; Rec."Plotting")
                {
                    ApplicationArea = All;
                }
                field("Cutting"; Rec."Cutting")
                {
                    ApplicationArea = All;
                }
                field("Embroidery"; Rec."Embroidery")
                {
                    ApplicationArea = All;
                }
                field("Production Line"; Rec."Production Line")
                {
                    ApplicationArea = All;
                }
                field("Finishing"; Rec."Finishing")
                {
                    ApplicationArea = All;
                }
                field("Trimming"; Rec."Trimming")
                {
                    ApplicationArea = All;
                }
                /*field("Pressing Symbol"; Rec."Pressing Symbol")
                {
                    ApplicationArea = All;
                }*/
                field("Packaging"; Rec."Packaging")
                {
                    ApplicationArea = All;
                }
                field("Scan Count"; Rec."Scan Count")
                {
                    ApplicationArea = All;
                }
                field("Sales Order Date"; Rec."Sales Order Date")
                {
                    ApplicationArea = all;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = all;
                }
                field(RemainingDays; RemainingDays)
                {
                    Caption = 'Remaining Days';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Assembly No."; Rec."Assembly No.")
                {
                    ApplicationArea = All;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = All;
                }
                field("Total Sequence"; Rec."Total Sequence")
                {
                    ApplicationArea = All;
                }
                /*field("Current Approver"; Rec."Current Approver")
                {
                    ApplicationArea = All;
                }*/
                /*field("Scanned In"; Rec."Scanned In")
                {
                    ApplicationArea = all;
                }
                field("Scanned Out"; Rec."Scanned Out")
                {
                    ApplicationArea = all;
                }*/
                field("Source Line No."; Rec."Source Line No.")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Details")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Cutting Sheet Scanning Details";
                RunPageLink = "Assembly No." = field("Assembly No.");
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
    begin
        UpdateSymbols();
        CalculateRemainingDays;

        Clear(SalesHeader);
        Clear(SalesLine);
        if SalesHeader.get(SalesHeader."Document Type"::Order, Rec."Source No.") then;
        if SalesLine.get(SalesLine."Document Type"::Order, Rec."Source No.", Rec."Source Line No.") then;
        GetAllocationName();
        GetMarket(SalesHeader);
        GetCustomerName(SalesHeader);
        GetProject(SalesHeader, SalesLine);
        GetICClientSONO(SalesHeader);
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter(Quantity, '>0');
        Rec.SetFilter("Assembly No.", '<>AQ*');
    end;


    procedure UpdateSymbols()
    begin
        OutSymbol := '🟢';
        InSymbol := '🔵';
        //InSymbol := '🟡';
        PendingSymbol := '🔴';
        NotAvailableSymbol := ' ';

        //update "MO Created"
        Rec.CalcFields("ER - Manufacturing Order No.");
        if Rec."ER - Manufacturing Order No." = '' then
            "MO Created" := '🔴'
        else
            "MO Created" := '🟢';

        if Rec."1" = Rec."1"::"IN" then
            Rec."Plotting" := InSymbol
        else
            if Rec."1" = Rec."1"::"OUT" then
                Rec."Plotting" := OutSymbol
            else
                if Rec."1" = Rec."1"::" " then
                    Rec."Plotting" := PendingSymbol;

        if Rec."2" = Rec."2"::"IN" then
            Rec."Cutting" := InSymbol
        else
            if Rec."2" = Rec."2"::"OUT" then
                Rec."Cutting" := OutSymbol
            else
                if Rec."2" = Rec."2"::" " then
                    Rec."Cutting" := PendingSymbol;

        if Rec."3" = Rec."3"::"IN" then
            Rec."Embroidery" := InSymbol
        else
            if Rec."3" = Rec."3"::"OUT" then
                Rec."Embroidery" := OutSymbol
            else
                if Rec."3" = Rec."3"::"Not Available" then
                    Rec."Embroidery" := NotAvailableSymbol
                else
                    if Rec."3" = Rec."3"::" " then
                        Rec."Embroidery" := PendingSymbol;

        if Rec."4" = Rec."4"::"IN" then
            Rec."Production Line" := InSymbol
        else
            if Rec."4" = Rec."4"::"OUT" then
                Rec."Production Line" := OutSymbol
            else
                if Rec."4" = Rec."4"::" " then
                    Rec."Production Line" := PendingSymbol;

        if Rec."5" = Rec."5"::"IN" then
            Rec."Finishing" := InSymbol
        else
            if Rec."5" = Rec."5"::"OUT" then
                Rec."Finishing" := OutSymbol
            else
                if Rec."5" = Rec."5"::" " then
                    Rec."Finishing" := PendingSymbol;

        if Rec."6" = Rec."6"::"IN" then
            Rec."Trimming" := InSymbol
        else
            if Rec."6" = Rec."6"::"OUT" then
                Rec."Trimming" := OutSymbol
            else
                if Rec."6" = Rec."6"::" " then
                    Rec."Trimming" := PendingSymbol;

        if Rec."7" = Rec."7"::"IN" then
            Rec."Packaging" := InSymbol
        else
            if Rec."7" = Rec."7"::"OUT" then
                Rec."Packaging" := OutSymbol
            else
                if Rec."7" = Rec."7"::" " then
                    Rec."Packaging" := PendingSymbol;

    end;

    procedure CalculateRemainingDays()
    begin
        RemainingDays := 0;
        Rec.CalcFields("Requested Delivery Date");
        if (Rec."Requested Delivery Date" <> 0D) then
            RemainingDays := Rec."Requested Delivery Date" - Today;
    end;

    procedure GetAllocationName()
    var
        SalesLine: Record "Sales Line";
        CustomerDepartment: Record "Customer Departments";
        CustomerPosition: Record "Department Positions";
        CustomerStaff: Record Staff;
        Department: Record Department;
        Position: Record Position;
        ParameterHeader: Record "Parameter Header";
        SalesHeader: Record "Sales Header";
    begin
        Clear(SalesHeader);
        Clear(SalesLine);
        Clear(CustomerDepartment);
        Clear(CustomerPosition);
        Clear(CustomerStaff);
        Clear(DepartmentName);
        Clear(PositionName);
        Clear(StaffName);
        Clear(Department);
        Clear(Position);
        Clear(ParameterHeader);
        if SalesHeader.get(SalesHeader."Document Type"::Order, Rec."Source No.") then
            if SalesHeader."IC Source No." <> '' then
                GetICAllocationName(SalesHeader."IC Company Name", SalesHeader."IC Source No.", SalesHeader."IC Customer SO No.")
            else
                if SalesLine.get(SalesLine."Document Type"::Order, Rec."Source No.", Rec."Source Line No.") then begin
                    case SalesLine."Allocation Type" of
                        SalesLine."Allocation Type"::" ":
                            exit;
                        SalesLine."Allocation Type"::Department:
                            begin
                                if CustomerDepartment.Get(SalesLine."Sell-to Customer No.", SalesLine."Allocation Code") then begin
                                    if Department.Get(CustomerDepartment."Department Code") then
                                        DepartmentName := Department.Name;
                                end;
                            end;
                        SalesLine."Allocation Type"::Position:
                            begin
                                if ParameterHeader.Get(SalesLine."Parameters Header ID") then begin
                                    CustomerPosition.SetRange("Position Code", SalesLine."Allocation Code");
                                    CustomerPosition.SetRange("Customer No.", SalesLine."Sell-to Customer No.");
                                    CustomerPosition.SetRange("Department Code", ParameterHeader."Department Code");
                                    if CustomerPosition.FindFirst() then begin
                                        if Position.Get(CustomerPosition."Position Code") then
                                            PositionName := Position.Name;
                                        if Department.Get(ParameterHeader."Department Code") then
                                            DepartmentName := Department.Name;
                                    end;
                                end;
                            end;
                        SalesLine."Allocation Type"::Staff:
                            begin
                                if ParameterHeader.Get(SalesLine."Parameters Header ID") then begin
                                    CustomerStaff.SetRange(Code, SalesLine."Allocation Code");
                                    CustomerStaff.SetRange("Customer No.", SalesLine."Sell-to Customer No.");
                                    CustomerStaff.SetRange("Department Code", ParameterHeader."Department Code");
                                    CustomerStaff.SetRange("Position Code", ParameterHeader."Position Code");
                                    if CustomerStaff.FindFirst() then begin
                                        StaffName := CustomerStaff.Name;
                                        if Department.Get(ParameterHeader."Department Code") then
                                            DepartmentName := Department.Name;
                                        if Position.Get(ParameterHeader."Position Code") then
                                            PositionName := Position.Name;
                                    end;
                                end;
                            end;
                    end;
                end;
    end;

    procedure GetICAllocationName(ICCompany: Code[20]; ICCustomerNo: Code[20]; ICCustomerSONo: Code[20])
    var
        ICSalesHeader: Record "Sales Header";
        ICSalesLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        CustomerDepartment: Record "Customer Departments";
        CustomerPosition: Record "Department Positions";
        CustomerStaff: Record Staff;
        Department: Record Department;
        Position: Record Position;
        ParameterHeader: Record "Parameter Header";
        SalesHeader: Record "Sales Header";
    begin
        Clear(SalesHeader);
        Clear(SalesLine);
        Clear(CustomerDepartment);
        Clear(CustomerPosition);
        Clear(CustomerStaff);
        Clear(DepartmentName);
        Clear(PositionName);
        Clear(StaffName);
        Clear(Department);
        Clear(Position);
        Clear(ParameterHeader);
        if SalesLine.get(SalesLine."Document Type"::Order, Rec."Source No.", Rec."Source Line No.") then;
        CustomerDepartment.ChangeCompany(ICCompany);
        CustomerPosition.ChangeCompany(ICCompany);
        CustomerStaff.ChangeCompany(ICCompany);
        Department.ChangeCompany(ICCompany);
        Position.ChangeCompany(ICCompany);
        ParameterHeader.ChangeCompany(ICCompany);
        ICSalesHeader.ChangeCompany(ICCompany);
        if ICSalesHeader.get(ICSalesHeader."Document Type"::Order, ICCustomerSONo) then begin
            ICSalesLine.ChangeCompany(ICCompany);
            ICSalesLine.SetRange("Document No.", ICSalesHeader."No.");
            /*ICSalesLine.SetRange("Allocation Type", SalesLine."Allocation Type");
            icSalesLine.SetRange("Allocation Code", SalesLine."Allocation Code");*/
            ICSalesLine.SetRange("Parameters Header ID", SalesLine."IC Parameters Header ID");
            if ICSalesLine.FindFirst() then begin
                if Department.Get(ICSalesLine."Department Code") then
                    DepartmentName := Department.Name;
                if Position.Get(ICSalesLine."Position Code") then
                    PositionName := Position.Name;
                if ICSalesLine."Staff Code" <> '' then begin
                    CustomerStaff.SetRange(Code, ICSalesLine."Staff Code");
                    CustomerStaff.SetRange("Customer No.", ICSalesLine."Sell-to Customer No.");
                    CustomerStaff.SetRange("Department Code", ICSalesLine."Department Code");
                    CustomerStaff.SetRange("Position Code", ICSalesLine."Position Code");
                    if CustomerStaff.FindFirst() then
                        StaffName := CustomerStaff.Name;
                end;
            end;
        end;
    end;

    procedure GetMarket(SalesHeader: Record "Sales Header")
    begin
        Clear(MarketName);
        if SalesHeader."IC Company Name" = '' then
            MarketName := CompanyName
        else
            MarketName := SalesHeader."IC Company Name";
    end;

    procedure GetCustomerName(SalesHeader: Record "Sales Header")
    var
        ICCustomerRec: Record Customer;
    begin
        Clear(CustomerName);
        if SalesHeader."IC Company Name" = '' then
            CustomerName := SalesHeader."Sell-to Customer Name"
        else begin
            Clear(ICCustomerRec);
            ICCustomerRec.ChangeCompany(SalesHeader."IC Company Name");
            if ICCustomerRec.get(SalesHeader."IC Source No.") then
                CustomerName := ICCustomerRec.Name;
        end;
    end;

    procedure GetProject(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line")
    var
        CustomerProject: Record "Customer Projects";
    begin
        Clear(ProjectName);
        Clear(CustomerProject);
        if SalesHeader."IC Company Name" = '' then begin
            if CustomerProject.Get(SalesHeader."Cust Project", SalesHeader."Sell-to Customer No.") then
                ProjectName := CustomerProject."Project Name";
        end else begin
            CustomerProject.ChangeCompany(SalesHeader."IC Company Name");
            if CustomerProject.get(SalesHeader."IC Customer Project Code", SalesHeader."IC Source No.") then
                ProjectName := CustomerProject."Project Name";
        end;
    end;

    procedure GetICClientSONO(SalesHeader: Record "Sales Header")
    begin
        Clear(ICClienstSONo);
        ICClienstSONo := SalesHeader."IC Customer SO No.";
    end;

    var
        OutSymbol: Text[100];
        InSymbol:
                        Text[100];
        PendingSymbol:
                        Text[100];
        NotAvailableSymbol:
                        Text[100];
        RemainingDays:
                        Decimal;
        DepartmentName:
                        Text[100];
        PositionName:
                        Text[100];
        StaffName:
                        Text[100];
        MarketName: Text[30];
        CustomerName: Text[100];
        ProjectName: Text[150];
        ICClienstSONo: Code[20];
        "MO Created": Text[100];
}
