pageextension 50216 "Sales Order" extends "Sales Order"
{
    layout
    {
        addafter("Work Description")
        {
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = all;

            }
        }
        addafter(Status)
        {
            field("IC Status"; Rec."IC Status")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addfirst(Control90)
        {
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
        }
        modify("Cust Project")
        {
            Importance = Promoted;
            ShowMandatory = true;
        }
    }
    actions
    {
        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                if ((Rec."Promised Delivery Date" = 0D) or (Rec."Requested Delivery Date" = 0D)) then
                    Error('Please fill the Promised Delivery Date and Requested Delivery Date');
            end;
        }
        addafter("Create Inventor&y Put-away/Pick")
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
                RunPageLink = "Source No." = field("No.");
            }
        }
        addafter("Print Confirmation")
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        Customer: Record Customer;
        SalesLineLoc: Record "Sales Line";
    begin
        if Rec."No." <> '' then begin
            Clear(ICCustomerName);
            if (Rec."IC Source No." <> '') and (Rec."IC Company Name" <> '') then begin
                if Rec."IC Company Name" <> CompanyName then
                    Customer.ChangeCompany(Rec."IC Company Name");
                if Customer.Get(Rec."IC Source No.") then
                    ICCustomerName := Customer.Name;
            end;
            Rec."IC Customer Project Code" := Rec.GetICProjectCode();
            Rec.Modify();
        end;

        //Update Department Position Staff
        Clear(SalesLineLoc);
        SalesLineLoc.SetRange("Document No.", Rec."No.");
        if SalesLineLoc.FindSet() then
            repeat
                SalesLineLoc.UpdateDepartmentPositionStaff(SalesLineLoc, true, Rec."IC Company Name");
            until SalesLineLoc.Next() = 0;
    end;

    var
        ICCustomerName: Text[150];
}
