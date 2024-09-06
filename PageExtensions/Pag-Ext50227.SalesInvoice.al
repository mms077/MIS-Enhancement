pageextension 50227 "Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addafter(Status)
        {
            field("IC Status"; Rec."IC Status")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addfirst(Control200)
        {
            field("IC Company Name"; Rec."IC Company Name")
            {
                Caption = 'IC Company Name';
                ApplicationArea = all;
                Editable = false;
            }
            field("IC Source No."; Rec."IC Source No.")
            {
                Caption = 'IC Customer No.';
                ApplicationArea = all;
                Editable = false;
            }
            field(ICCustomerName; ICCustomerName)
            {
                Caption = 'IC Customer Name';
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("Work Description")
        {
            field("Posting No. Series 2"; Rec."Posting No. Series")
            {
                ApplicationArea = all;
            }
            field("Sales Quote No."; Rec."Sales Quote No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Sales Quote No.")
        {
            field("Warehouse Shipment No."; Rec."Warehouse Shipment No.") { ApplicationArea = all; Editable = false; }
        }

    }


    actions
    {
        addlast(navigation)
        {
            action("ER-Commercial Invoice")
            {
                Caption = 'ER - Commercial Invoice';
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                trigger OnAction()
                begin
                    G_SalesHeader.SetFilter("No.", Rec."No.");
                    Report.Run(Report::"ER - Commercial Invoice", true, true, G_SalesHeader);
                end;
            }
            action("ER-Commercial Invoice- Shipment")
            {
                Caption = 'ER - Commercial Invoice- Shipments';
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    "ERCommercialWhseShipment": Report "ER - Commercial Whse Shipment";
                    WhseShipmentHeader: Record "Warehouse Shipment Header";
                begin
                    Rec.TestField("Warehouse Shipment No.");
                    //ERCommercialWhseShipment.ShipmentFilters(Rec."Warehouse Shipment No.");
                    WhseShipmentHeader.SetFilter("No.", Rec."Warehouse Shipment No.");
                    if WhseShipmentHeader.FindSet() then
                        Report.Run(Report::"ER - Commercial Whse Shipment", true, true, WhseShipmentHeader);

                end;
            }
        }

    }


    trigger OnOpenPage()
    var
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.AllowShowSalesPrice() then
            PriceVisible := true
        else
            PriceVisible := false;
    end;

    trigger OnAfterGetCurrRecord()
    var
        Customer: Record Customer;
    begin
        Clear(ICCustomerName);
        if (Rec."IC Source No." <> '') and (Rec."IC Company Name" <> '') then begin
            if Rec."IC Company Name" <> CompanyName then
                Customer.ChangeCompany(Rec."IC Company Name");
            if Customer.Get(Rec."IC Source No.") then
                ICCustomerName := Customer.Name;
        end;
    end;


    var
        ICCustomerName: Text[150];
        PriceVisible: Boolean;
        G_SalesHeader: Record "Sales Header";
}