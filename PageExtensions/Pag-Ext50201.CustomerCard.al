pageextension 50201 "Customer Card" extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field("Name2"; Rec."Name 2")
            {
                ApplicationArea = All;
            }
            field("System ID"; Rec.SystemId)
            {
                ApplicationArea = All;
            }
        }
        modify("Name 2")
        {
            Visible = false;
        }
        addafter("CustSalesLCY - CustProfit - AdjmtCostLCY")
        {
            field("Branding Code"; Rec."Branding Code")
            {
                ApplicationArea = All;
                Importance = Standard;
                Lookup = true;
                LookupPageId = Branding;
            }
        }
        addafter("Branding Code")
        {
            field("Created By"; UserCreater)
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Created By';
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = all;
                Caption = 'Created At';
            }
            field("Modified By"; UserModifier)
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Modified By';
            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                ApplicationArea = all;
                Caption = 'Modified At';
            }
        }
        addafter("EORI Expiry Date")
        {
            field(SIRET; Rec.SIRET)
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addlast("&Customer")
        {
            action("Branding")
            {
                Caption = 'Branding';
                ApplicationArea = All;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedOnly = true;
                RunObject = page "Branding";
                RunPageLink = "Customer No." = field("No.");
            }
            action("Customer Departments")
            {
                Caption = 'Departments';
                ApplicationArea = All;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedOnly = true;
                RunObject = page "Customer Departments";
                RunPageLink = "Customer No." = field("No.");
            }
            action("Order History")
            {
                Caption = 'Order History';
                ApplicationArea = All;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedOnly = true;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";

                    SalesDocType: Enum "Sales Document Type";
                    OrderHistory: Record OrderHistory;
                    OrderHistoryPage: Page "OrderHistory";

                    SalesHeaderArchive: Record "Sales Header Archive";

                begin
                    SalesHeader.setfilter("Sell-to Customer No.", Rec."No.");
                    SalesHeader.setfilter("Document Type", 'Order');
                    if SalesHeader.FindFirst() then begin
                        repeat
                            if not (OrderHistory.Get(SalesHeader."No.", SessionID)) then begin
                                OrderHistory.Init();
                                OrderHistory.SO_NO := SalesHeader."No.";
                                OrderHistory.Validate(CustomerProjectCode,SalesHeader."Cust Project");
                                OrderHistory."Customer No." := rec."No.";
                                OrderHistory."Order Type" := OrderHistory."Order Type"::"Sales Order";
                                SalesHeader.CalcFields("Lines Count");
                                OrderHistory."Line Counts" := SalesHeader."Lines Count";
                                OrderHistory."Session ID" := SessionID;
                                OrderHistory.Insert();
                            end
                            // else begin
                            //     OrderHistory.Source := '';
                            //     OrderHistory."Session ID" := SessionID;
                            //     OrderHistory.Modify();
                            // end;
                        until SalesHeader.Next() = 0;
                    end;

                    SalesHeaderArchive.setfilter("Sell-to Customer No.", Rec."No.");
                    SalesHeaderArchive.setfilter("Document Type", 'Order');
                    if SalesHeaderArchive.FindFirst() then
                        repeat
                            if not (OrderHistory.Get(SalesHeaderArchive."No.", SessionID)) then begin
                                OrderHistory.Init();
                                OrderHistory.SO_NO := SalesHeaderArchive."No.";
                                OrderHistory.Validate(CustomerProjectCode,SalesHeaderArchive."Cust Project");
                                OrderHistory."Customer No." := rec."No.";
                                OrderHistory."Order Type" := OrderHistory."Order Type"::"Sales Order Archive";
                                SalesHeaderArchive.CalcFields("Archive Lines Count");
                                OrderHistory."Line Counts" := SalesHeaderArchive."Archive Lines Count";
                                OrderHistory."Session ID" := SessionID;
                                OrderHistory.Insert();
                            end
                            // else begin
                            //     OrderHistory.Source := '';
                            //     OrderHistory.Modify();
                            // end;
                        until SalesHeaderArchive.Next() = 0;
                    Clear(OrderHistory);
                    OrderHistory.SetRange("Session ID", SessionID);
                    OrderHistory.SetRange("Customer No.", Rec."No.");
                    if OrderHistory.FindSet() then
                        page.Run(page::OrderHistory, OrderHistory);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if User.Get(Rec.SystemCreatedBy) then
            UserCreater := User."User Name";
        if User2.Get(Rec.SystemModifiedBy) then
            UserModifier := User2."User Name";
    end;

    trigger OnOpenPage()
    begin
        SessionID := Database.SessionId();
    end;

    var
        SessionID: Integer;
        User: Record User;
        User2: Record User;
        UserCreater: Code[50];
        UserModifier: Code[50];
}