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
            field("IC Customer SO No."; Rec."IC Customer SO No.")
            {
                ApplicationArea = all;
                ToolTip = 'The no. of the SO related to the end client';
                Editable = false;
            }
            field("IC Customer Project Code"; Rec."IC Customer Project Code")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("Shipping and Billing")
        {
            group(GroupingCriteria)
            {
                Caption = 'Grouping Criteria';
                field("Grouping Criteria Field No."; Rec."Grouping Criteria Field No.")
                {
                    ApplicationArea = All;
                    LookupPageId = "Grouping Criteria";
                    Lookup = true;
                    trigger OnValidate()
                    var
                        GroupingCriteriaRec: Record "Grouping Criteria";
                    begin
                        // Set the field name based on the selected field number
                        if Rec."Grouping Criteria Field No." <> 0 then begin
                            GroupingCriteriaRec.Get(Rec."Grouping Criteria Field No.");
                            Rec."Grouping Criteria Field Name" := GroupingCriteriaRec."Field Name";
                            Rec.Modify();
                        end else begin
                            Rec."Grouping Criteria Field Name" := '';
                            Rec.Modify();
                        end;
                    end;
                }
                field("Grouping Criteria Field Name"; Rec."Grouping Criteria Field Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select the field to be used for grouping related lines.';
                    Editable = false; // Make editable to allow lookup trigger
                }
            }
        }
        modify("Cust Project")
        {
            Importance = Promoted;
            ShowMandatory = true;
            Caption = 'Customer Project';
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
        addafter(Release)
        {
            action("Group Sales Lines")
            {
                ApplicationArea = All;
                Caption = 'Group Sales Lines';
                ToolTip = 'Groups the sales lines based on the selected Grouping Criteria Field.';
                Image = Group;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesOrderGroupingMgt: Codeunit "Sales Order Grouping Mgt.";
                begin
                    // Call the grouping logic from the codeunit
                    SalesOrderGroupingMgt.GroupSalesLines(Rec);
                end;
            }
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
        addafter("F&unctions") // Or choose another appropriate anchor
        {
            action(GeneratePackingList)
            {
                Caption = 'Generate Packing List';
                ToolTip = 'Calculates and generates the packing list for this sales order in the background.';
                ApplicationArea = All;
                Image = CalculateInventory;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PackingListMgt: Codeunit "Packing List Management";
                begin
                    PackingListMgt.GeneratePackingList(Rec);
                end;
            }
            // Moved ShowPackingList here as well
            action(ShowPackingList)
            {
                Caption = 'Packing List';
                ToolTip = 'View the generated packing list for this sales order.';
                ApplicationArea = All;
                Image = Filed;
                Promoted = true;
                PromotedCategory = Category4; // Changed from Navigate

                trigger OnAction()
                var
                    PackingListHeader: Record "Packing List Header";
                begin
                    PackingListHeader.SetRange("Document Type", Rec."Document Type");
                    PackingListHeader.SetRange("Document No.", Rec."No.");
                    if PackingListHeader.FindFirst() then
                        Page.Run(Page::"Packing List", PackingListHeader)
                    else
                        Message('No packing list has been generated for this order yet.');
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
