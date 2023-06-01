tableextension 50217 "Sales Header" extends "Sales Header"
{
    fields
    {
        modify("Payment Terms Code")
        {
            trigger OnBeforeValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if (xRec."Payment Terms Code" <> '') and (Rec."Payment Terms Code" <> xRec."Payment Terms Code") then begin
                    UserSetup.Get(UserId);
                    UserSetup.TestField("Modify Payment Terms", true);
                end;
            end;
        }
        modify("Requested Delivery Date")
        {
            trigger OnAfterValidate()

            begin
                "Shipment Date" := "Requested Delivery Date";
                UpdateSalesLineDates("Requested Delivery Date");
                UpdateShipmentLinesDates("Requested Delivery Date");
                UpdateAssemblyDates("Requested Delivery Date");
            end;
        }
        modify("Cust Project")
        {
            trigger OnAfterValidate()
            begin
                Rec.Validate("Shortcut Dimension 1 Code", "Cust Project");
            end;
        }
        field(50300; "Order Type"; Option)
        {
            OptionMembers = " ","Re-order","New order","Re-order & New order","Replacement";
            OptionCaption = ' ,Re-order,New order,Re-order & New order,Replacement';
        }
        field(50301; "IC Source No."; Code[50])
        {
            Caption = 'IC Customer No.';
            DataClassification = ToBeClassified;
        }
        field(50302; "IC Company Name"; Text[30])
        {
            Caption = 'IC Company Name';
            DataClassification = ToBeClassified;
            TableRelation = Company.Name;
            trigger OnValidate()
            begin
                Rec."IC Customer Project Code" := Rec.GetICProjectCode();
                Rec.Modify();
            end;
        }
        field(50303; "Sales Quote No."; Code[20])
        {
            TableRelation = "Sales Header"."No." where("Document Type" = const(Quote), "Sell-to Customer No." = field("Sell-to Customer No."));
        }
        field(50304; "Lines Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Line" where("Document No." = field("No."), "Document Type" = field("Document Type")));
            Editable = false;
        }
        field(50305; "IC Customer SO No."; Code[20])
        {
            trigger OnValidate()
            var
            begin
                Rec."IC Customer Project Code" := Rec.GetICProjectCode();
                Rec.Modify();
            end;
        }
        field(50306; "IC Customer Project Code"; Code[20])
        {

        }
    }
    procedure GetICProjectCode(): Code[20]
    var
        Customer: Record Customer;
        ICSalesHeader: Record "Sales Header";
    begin
        Clear(ICSalesHeader);
        if (Rec."IC Company Name" <> '') and (Rec."IC Customer SO No." <> '') then begin
            ICSalesHeader.ChangeCompany(Rec."IC Company Name");
            if ICSalesHeader.get(ICSalesHeader."Document Type"::Order, Rec."IC Customer SO No.") then
                exit(ICSalesHeader."Cust Project")
            //Could not find the SO
            else
                exit('');
        end else
            exit('');
    end;

    procedure UpdateSalesLineDates(NewDate: Date);
    var
        SalesLine: Record "Sales Line";
    begin
        Clear(SalesLine);
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        if SalesLine.FindSet() then
            repeat
                SalesLine."Shipment Date" := NewDate;
                SalesLine."Requested Delivery Date" := NewDate;
                SalesLine.Modify(false)
            until SalesLine.Next() = 0;
    end;

    procedure UpdateShipmentLinesDates(NewDate: Date);
    var
        WhsShipmentLine: Record "Warehouse Shipment Line";
    begin
        Clear(WhsShipmentLine);
        WhsShipmentLine.SetRange("Source No.", Rec."No.");
        if WhsShipmentLine.FindSet() then
            repeat
                WhsShipmentLine."Shipment Date" := NewDate;
                WhsShipmentLine."Due Date" := NewDate;
                WhsShipmentLine.Modify(false)
            until WhsShipmentLine.Next() = 0;
    end;

    procedure UpdateAssemblyDates(NewDate: Date);
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        Clear(AssemblyHeader);
        AssemblyHeader.SetRange("Source Type", Rec."Document Type");
        AssemblyHeader.SetRange("Source No.", Rec."No.");
        if AssemblyHeader.FindSet() then
            repeat
                AssemblyHeader."Due Date" := NewDate;
                AssemblyHeader.Modify(false)
            until AssemblyHeader.Next() = 0;
    end;
}
