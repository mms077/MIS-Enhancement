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
        }
    }
    trigger OnAfterGetRecord()
    begin
        if User.Get(Rec.SystemCreatedBy) then
            UserCreater := User."User Name";
        if User2.Get(Rec.SystemModifiedBy) then
            UserModifier := User2."User Name";
    end;

    var
        User: Record User;
        User2: Record User;
        UserCreater: Code[50];
        UserModifier: Code[50];
}