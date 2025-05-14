pageextension 50217 "Sales Order List" extends "Sales Order List"
{
    layout
    {
        modify(Amount)
        {
            Visible = PriceVisible;
        }
        modify("Amount Including VAT")
        {
            Visible = PriceVisible;
        }
        addafter("Amount Including VAT")
        {
            field("Lines Count"; Rec."Lines Count")
            {
                ApplicationArea = all;
            }
            field("IC Company Name"; Rec."IC Company Name")
            {
                Caption = 'IC Company Name';
                ApplicationArea = all;
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
            field("IC Customer SO No."; Rec."IC Customer SO No.")
            {
                ApplicationArea = all;
                ToolTip = 'The no. of the SO related to the end client';
            }
            field("IC Customer Project Code"; Rec."IC Customer Project Code")
            {
                ApplicationArea = all;
            }
            field(MyField; Rec."Cust Project")
            {
                ApplicationArea = All;
                Caption = 'Customer Project';
            }
            field(UserCreater; UserCreater)
            {
                ApplicationArea = All;
                Caption = 'Created By';
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                Caption = 'Created At';
            }
            field(UserModifier; UserModifier)
            {
                ApplicationArea = All;
                Caption = 'Modified By';
            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                ApplicationArea = All;
                Caption = 'Modified At';
            }
        }
    }
    actions
    {
        addafter("S&hipments")
        {
            action("Dashboard")
            {
                ApplicationArea = all;
                Image = ShowChart;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Cutting Sheet Dashboard";
                RunPageLink = "Source No." = field("No."), "Assembly No." = filter('AS*');
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
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    Report.Run(Report::"Sales Line Label Printing EN", true, true, SalesLine);
                end;
            }
            action("Label Printing No Asm")
            {
                ApplicationArea = all;
                Caption = 'Label Printing No Asm';
                Image = Transactions;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    Report.Run(Report::"Sales Line Label No Assembly", true, true, SalesLine);
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
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    Report.Run(Report::"Sales Line Label Printing FR", true, true, SalesLine);
                end;
            }

        }

        addafter(Release) // Use standard anchor
        {
            action(GeneratePackingList)
            {
                Caption = 'Generate Packing List';
                ToolTip = 'Calculates and generates the packing list for the selected sales order(s) in the background.';
                ApplicationArea = All;
                Image = CalculateInventory;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    PackingListMgt: Codeunit "Packing List Management";
                begin
                    CurrPage.SetSelectionFilter(SalesHeader);
                    if SalesHeader.FindSet() then
                        repeat
                            PackingListMgt.GeneratePackingList(SalesHeader);
                        until SalesHeader.Next() = 0;
                end;
            }
        }

        addafter(Release) // Use standard anchor
        {
            action(ShowPackingList)
            {
                Caption = 'Packing List';
                ToolTip = 'View the generated packing list for the selected sales order.';
                ApplicationArea = All;
                Image = Filed;
                Promoted = true;
                PromotedCategory = Report; // Changed category

                trigger OnAction()
                var
                    PackingListHeader: Record "Packing List Header";
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.Count <> 1 then
                        Error('Please select a single sales order to view the packing list.');

                    PackingListHeader.SetRange("Document Type", Rec."Document Type");
                    PackingListHeader.SetRange("Document No.", Rec."No.");
                    if PackingListHeader.FindFirst() then
                        Page.Run(Page::"Packing List", PackingListHeader)
                    else
                        Message('No packing list has been generated for this order yet.');
                end;
            }
        }

        addfirst(Reporting)
        {
            group("ER - Reports")
            {
                Caption = 'ER Reports';
                action("ER - ER - Commercial Invoice")
                {
                    Caption = 'ER - Commercial Invoice';
                    ApplicationArea = All;
                    Image = Report;
                    trigger OnAction()
                    begin
                        G_SalesHeader.SetFilter("No.", Rec."No.");
                        Report.Run(Report::"ER - Commercial Invoice", true, true, G_SalesHeader);
                    end;
                }
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

    trigger OnAfterGetRecord()
    var
        Customer: Record Customer;
        User: Record User;
        User2: Record User;
    begin
        Clear(ICCustomerName);
        if (Rec."IC Source No." <> '') and (Rec."IC Company Name" <> '') then begin
            if Rec."IC Company Name" <> CompanyName then
                Customer.ChangeCompany(Rec."IC Company Name");
            if Customer.Get(Rec."IC Source No.") then
                ICCustomerName := Customer.Name;
        end;

        //Get User Created By and Modified By
        Clear(User);
        Clear(User2);
        if User.Get(Rec.SystemCreatedBy) then
            UserCreater := User."User Name";
        if User2.Get(Rec.SystemModifiedBy) then
            UserModifier := User2."User Name";
    end;

    var
        PriceVisible: Boolean;
        ICCustomerName: Text[150];
        UserCreater: Code[50];
        UserModifier: Code[50];
        G_SalesHeader: Record "Sales Header";
}
