pageextension 50220 "Sales Quote" extends "Sales Quote"
{
    layout
    {
        moveafter("External Document No."; "Payment Terms Code")

        modify("Payment Terms Code")
        {
            Importance = Promoted;
            ShowMandatory = true;
        }
        modify("Sell-to Customer No.")
        {
            Importance = Promoted;
        }
        modify("Cust Project")
        {
            Importance = Promoted;
            ShowMandatory = true;
        }
        addafter("Requested Delivery Date")
        {
            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = all;
                Editable = true;
                Enabled = true;
            }
        }
    }
    actions
    {
        addfirst(Reporting)
        {
            group("ER - Reports")
            {
                
                Caption = 'ER Reports';
                action("ER - Sales Quote With Visuals")
                {
                    Caption = 'ER - Sales Quote W/ Visuals';
                    ApplicationArea = All;
                    Image = Report;
                    trigger OnAction()
                    begin
                        G_SalesHeader.SetFilter("No.", Rec."No.");
                        Report.Run(Report::"ER - Sales Quote With Visuals", true, true, G_SalesHeader);
                    end;
                }



            }

        }
        addlast("&Quote"){
            
            action("Order History")
                {
                    Caption = 'Order History';
                    ApplicationArea = All;
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Enabled = true;
                    
                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        SalesDocType: Enum "Sales Document Type";
                        OrderHistory: Record OrderHistory;
                        SalesHeaderArchive: Record "Sales Header Archive";
                    begin
                        if not(EnableOrderHistory()) then begin
                            Error('Please make Sure you have a Customer and No Lines on the Quote');
                            exit;
                        end;
                        SalesHeader.setfilter("Sell-to Customer No.", Rec."Sell-to Customer No.");
                        SalesHeader.setfilter("Document Type", 'Order');
                        if SalesHeader.FindFirst() then
                            repeat
                                if not (OrderHistory.Get(SalesHeader."No.", SessionID)) then begin
                                    OrderHistory.Init();
                                    OrderHistory.SO_NO := SalesHeader."No.";
                                    OrderHistory.Validate(CustomerProjectCode,SalesHeader."Cust Project");
                                    OrderHistory."Customer No." := rec."Sell-to Customer No.";
                                    OrderHistory."Order Type" := OrderHistory."Order Type"::"Sales Order";
                                    SalesHeader.CalcFields("Lines Count");
                                    OrderHistory."Line Counts" := SalesHeader."Lines Count";
                                    OrderHistory."Session ID" := SessionID;
                                    OrderHistory.Source :=rec."No.";
                                    OrderHistory.Insert();
                                end
                            until SalesHeader.Next() = 0;

                        SalesHeaderArchive.setfilter("Sell-to Customer No.", Rec."Sell-to Customer No.");
                        SalesHeaderArchive.setfilter("Document Type", 'Order');
                        if SalesHeaderArchive.FindFirst() then
                            repeat
                                if not (OrderHistory.Get(SalesHeaderArchive."No.", SessionID)) then begin
                                    OrderHistory.Init();
                                    OrderHistory.SO_NO := SalesHeaderArchive."No.";
                                    OrderHistory.Validate(CustomerProjectCode,SalesHeaderArchive."Cust Project");
                                    OrderHistory."Customer No." := rec."Sell-to Customer No.";
                                    OrderHistory."Order Type" := OrderHistory."Order Type"::"Sales Order Archive";
                                    SalesHeaderArchive.CalcFields("Archive Lines Count");
                                    OrderHistory."Line Counts" := SalesHeaderArchive."Archive Lines Count";
                                    OrderHistory."Session ID" := SessionID;
                                    OrderHistory.Source :=rec."No.";
                                    OrderHistory.Insert();
                                end
                            until SalesHeaderArchive.Next() = 0;
                        Clear(OrderHistory);
                        OrderHistory.SetRange("Session ID", SessionID);
                        OrderHistory.SetRange("Customer No.", Rec."Sell-to Customer No.");
                        if OrderHistory.FindSet() then
                            page.Run(page::OrderHistory, OrderHistory);
                    end;
                }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        SalesLineLoc: Record "Sales Line";
    begin
        //Update Department Position Staff
        Clear(SalesLineLoc);
        SalesLineLoc.SetRange("Document No.", Rec."No.");
        if SalesLineLoc.FindSet() then
            repeat
                SalesLineLoc.UpdateDepartmentPositionStaff(SalesLineLoc, true, Rec."IC Company Name");
            until SalesLineLoc.Next() = 0;
    end;

    trigger OnOpenPage()
    begin
        SessionID := Database.SessionId();
    end;

    local procedure EnableOrderHistory():Boolean
    begin
        G_SalesLine.SetRange("Document No.", Rec."No.");
        if (G_SalesLine.IsEmpty()) and (rec."Sell-to Customer No."<>'')then
            exit(true);
        exit(false);
    end;

    

    var
        SessionID: Integer;
        G_SalesHeader: Record "Sales Header";
        G_SalesLine: Record "Sales Line";
}