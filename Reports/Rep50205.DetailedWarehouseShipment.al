report 50205 "Detailed Warehouse Shipment"
{
    ApplicationArea = All;
    Caption = 'Detailed Warehouse Shipment';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Reports Layouts/DetailedWarehouseShipment.rdlc';
    dataset
    {
        dataitem("Warehouse Shipment Header"; "Warehouse Shipment Header")
        {
            dataitem(WarehouseShipmentLine; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = field("No.");
                trigger OnPreDataItem()
                begin
                    ShipmentLineBuffer.Reset();
                    ShipmentLineBuffer.DeleteAll();
                    LineNumber := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    i: Integer;
                begin
                    ShipmentLineBuffer.SetRange("No.", WarehouseShipmentLine."No.");
                    ShipmentLineBuffer.SetRange("Line No.", WarehouseShipmentLine."Line No.");
                    if not ShipmentLineBuffer.Find('-') then begin
                        //Insert line for each quantity
                        for i := 1 to WarehouseShipmentLine.Quantity do begin
                            LineNumber := LineNumber + 1;
                            ShipmentLineBuffer.init;
                            ShipmentLineBuffer := WarehouseShipmentLine;
                            ShipmentLineBuffer.Quantity := 1;
                            ShipmentLineBuffer."Line No." := LineNumber;
                            ShipmentLineBuffer.Insert();
                        end;
                    end;
                end;
            }
            dataitem(ShipmentLineLoop; Integer)
            {
                column(Shipment_Line_Buffer_Line_No; ShipmentLineBuffer."Line No.")
                {
                }
                column(Shipment_Line_Buffer_Item_No; ShipmentLineBuffer."Item No.")
                {
                }
                column(Shipment_Line_Buffer_Variant_Code; ShipmentLineBuffer."Variant Code")
                {
                }
                column(Shipment_Line_Buffer_Description; ShipmentLineBuffer.Description)
                {
                }
                column(Shipment_Line_Buffer_Quantity; ShipmentLineBuffer."Quantity")
                {
                }
                column(Shipment_Line_Buffer_Size; ShipmentLineBuffer.Size)
                {
                }
                column(Shipment_Line_Buffer_Fit; ShipmentLineBuffer.Fit)
                {
                }
                column(Shipment_Line_Buffer_Color; ShipmentLineBuffer.Color)
                {
                }
                column(Shipment_Line_Buffer_Cut; ShipmentLineBuffer.Cut)
                {
                }
                column(Shipment_Line_Buffer_Tonality; ShipmentLineBuffer.Tonality)
                {
                }
                column(Shipment_Line_Buffer_Allocation_Type; ShipmentLineBuffer."Allocation Type")
                {
                }
                column(Shipment_Line_Buffer_Allocation_Code; ShipmentLineBuffer."Allocation Code")
                {
                }
                column(Shipment_Line_Buffer_UOM; ShipmentLineBuffer."Unit of Measure Code")
                {
                }
                column(ColorName; GlobalColor.Name)
                {
                }
                column(Customer_No; GlobalSalesHeader."Sell-to Customer No.")
                {
                }
                column(Customer_Name; GlobalSalesHeader."Sell-to Customer Name")
                {
                }
                column(Design_Section_Set; GlobalVariant."Design Sections Set ID")
                {
                }
                column(Item_Feature_Set; GlobalVariant."Item Features Set ID")
                {
                }
                column(Item_Branding_Set; GlobalVariant."Item Brandings Set ID")
                {
                }
                column(Department_Name; Department.Name)
                {

                }
                column(Position_Name; Position.Name)
                {

                }
                column(Staff_Name; CustomerStaff.Name)
                {

                }
                trigger OnPreDataItem()
                begin
                    ShipmentLineBuffer.Reset();
                    SetRange(Number, 1, ShipmentLineBuffer.Count);
                end;

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then
                        ShipmentLineBuffer.Find('-')
                    else
                        ShipmentLineBuffer.Next();

                    //Get Color Name
                    Clear(GlobalColor);
                    if ShipmentLineBuffer.Color <> 0 then
                        GlobalColor.Get(ShipmentLineBuffer.Color);
                    //Get Customer Details
                    Clear(GlobalSalesHeader);
                    if ShipmentLineBuffer."Source Document" = ShipmentLineBuffer."Source Document"::"Sales Order" then begin
                        GlobalSalesHeader.get(GlobalSalesHeader."Document Type"::Order, ShipmentLineBuffer."Source No.");
                        GetAllocationName(ShipmentLineBuffer."Source No.", ShipmentLineBuffer."Source Line No.");
                    end;
                    //Get Variant Details
                    Clear(GlobalVariant);
                    if ShipmentLineBuffer."Variant Code" <> '' then
                        GlobalVariant.Get(ShipmentLineBuffer."Item No.", ShipmentLineBuffer."Variant Code");
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        ShipmentLineBuffer: Record "Warehouse Shipment Line" temporary;
        LineNumber: Integer;
        GlobalColor: Record Color;
        GlobalSalesHeader: Record "Sales Header";
        GlobalVariant: Record "Item Variant";
        CustomerStaff: Record Staff;
        Department: Record Department;
        Position: Record Position;

    procedure GetAllocationName(SourceNo: Code[50]; SourceLineNo: Integer)
    var
        SalesLine: Record "Sales Line";
        CustomerDepartment: Record "Customer Departments";
        CustomerPosition: Record "Department Positions";
        ParameterHeader: Record "Parameter Header";
        SalesHeader: Record "Sales Header";
    begin
        Clear(SalesHeader);
        Clear(SalesLine);
        Clear(CustomerDepartment);
        Clear(CustomerPosition);
        Clear(CustomerStaff);
        Clear(Department);
        Clear(Position);
        Clear(ParameterHeader);
        if SalesHeader.get(SalesHeader."Document Type"::Order, SourceNo) then
            if SalesHeader."IC Source No." <> '' then
                GetICAllocationName(SalesHeader."IC Company Name", SalesHeader."IC Source No.", SalesHeader."IC Customer SO No.", SourceNo, SourceLineNo)
            else
                if SalesLine.get(SalesLine."Document Type"::Order, SourceNo, SourceLineNo) then begin
                    case SalesLine."Allocation Type" of
                        SalesLine."Allocation Type"::" ":
                            exit;
                        SalesLine."Allocation Type"::Department:
                            begin
                                if CustomerDepartment.Get(SalesLine."Sell-to Customer No.", SalesLine."Allocation Code") then begin
                                    if Department.Get(CustomerDepartment."Department Code") then;
                                end;
                            end;
                        SalesLine."Allocation Type"::Position:
                            begin
                                if ParameterHeader.Get(SalesLine."Parameters Header ID") then begin
                                    CustomerPosition.SetRange("Position Code", SalesLine."Allocation Code");
                                    CustomerPosition.SetRange("Customer No.", SalesLine."Sell-to Customer No.");
                                    CustomerPosition.SetRange("Department Code", ParameterHeader."Department Code");
                                    if CustomerPosition.FindFirst() then begin
                                        if Position.Get(CustomerPosition."Position Code") then;
                                        if Department.Get(ParameterHeader."Department Code") then;
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
                                        if Department.Get(ParameterHeader."Department Code") then;
                                        if Position.Get(ParameterHeader."Position Code") then;
                                    end;
                                end;
                            end;
                    end;
                end;
    end;

    procedure GetICAllocationName(ICCompany: Code[20]; ICCustomerNo: Code[20]; ICCustomerSONo: Code[20]; SourceNo: Code[50]; SourceLineNo: Integer)
    var
        ICSalesHeader: Record "Sales Header";
        ICSalesLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        CustomerDepartment: Record "Customer Departments";
        CustomerPosition: Record "Department Positions";
        ParameterHeader: Record "Parameter Header";
        SalesHeader: Record "Sales Header";
    begin
        Clear(SalesHeader);
        Clear(SalesLine);
        Clear(CustomerDepartment);
        Clear(CustomerPosition);
        Clear(CustomerStaff);
        Clear(Department);
        Clear(Position);
        Clear(ParameterHeader);
        if SalesLine.get(SalesLine."Document Type"::Order, SourceNo, SourceLineNo) then;
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
                if Department.Get(ICSalesLine."Department Code") then;
                if Position.Get(ICSalesLine."Position Code") then;
                if ICSalesLine."Staff Code" <> '' then begin
                    CustomerStaff.SetRange(Code, ICSalesLine."Staff Code");
                    CustomerStaff.SetRange("Customer No.", ICSalesLine."Sell-to Customer No.");
                    CustomerStaff.SetRange("Department Code", ICSalesLine."Department Code");
                    CustomerStaff.SetRange("Position Code", ICSalesLine."Position Code");
                    if CustomerStaff.FindFirst() then;
                end;
            end;
        end;
    end;
}
