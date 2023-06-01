pageextension 50233 "Purchase Order List" extends "Purchase Order List"
{
    layout
    {
        modify(Amount)
        {
            Visible = CostVisible;
        }
        modify("Amount Including VAT")
        {
            Visible = CostVisible;
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
    }
    trigger OnOpenPage()
    var
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.AllowShowCost() then
            CostVisible := true
        else
            CostVisible := false;
    end;

    trigger OnAfterGetRecord()
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
        CostVisible: Boolean;
        ICCustomerName: Text[150];
}
