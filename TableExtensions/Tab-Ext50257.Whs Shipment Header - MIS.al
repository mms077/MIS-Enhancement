tableextension 50257 "Whs Shipment Header - MIS" extends "Warehouse Shipment Header"
{
    fields
    {
        field(50200; "Sales Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." where("Document Type" = filter('Invoice'));
            trigger OnValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                /*if SalesHeader.get(SalesHeader."Document Type"::Invoice, rec."Sales Invoice No.") then begin
                    if SalesHeader."Warehouse Shipment No." = '' then begin
                        SalesHeader."Warehouse Shipment No." := Rec."No.";
                        SalesHeader.Modify();
                    end else begin
                        Error('The Selected Invoice is already Linked to another Whse. Shipment');
                    end;
                end;*/
            end;
        }
        field(50201; Printed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}