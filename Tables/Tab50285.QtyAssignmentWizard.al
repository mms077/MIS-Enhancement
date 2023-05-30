table 50285 "Qty Assignment Wizard"
{
    Caption = 'Wizard Qty Assignment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header Id"; Integer)
        {
            Caption = 'Header Id';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Size; Code[50])
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
        }
        field(4; Fit; Code[50])
        {
            Caption = 'Fit';
            DataClassification = ToBeClassified;
        }
        field(5; Cut; Code[50])
        {
            Caption = 'Cut';
            DataClassification = ToBeClassified;
        }
        field(6; "Quantity To Assign"; Decimal)
        {
            Caption = 'Quantity To Assign';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ParameterHeader: Record "Parameter Header";
            begin
                if ParameterHeader.get(Rec."Header Id") then begin
                    ParameterHeader."Item Size" := Rec.Size;
                    ParameterHeader."Item Cut" := Rec.Cut;
                    ParameterHeader."Item Fit" := Rec.Fit;
                    ParameterHeader.Modify();
                end;
            end;
        }
        field(7; "Parent Header Id"; Integer)
        {
            Caption = 'Parent Header Id';
            DataClassification = ToBeClassified;
            TableRelation = "Parameter Header".ID;
        }
        field(8; "Sales Line Unit Price"; Decimal)
        {
            Editable = false;
        }
        /*field(9; "Sales Line Amount"; Decimal)
        {
            Editable = false;
        }
        field(10; "Sales Line Line Amount"; Decimal)
        {
            Editable = false;
        }
        field(11; "Sales Line Amount Incl. VAT"; Decimal)
        {
            Editable = false;
        }*/
        field(12; "Extra Charge %"; Decimal)
        {
            Editable = false;
        }
        /*field(13; "Extra Charge Amount"; Decimal)
        {
            Editable = false;
        }*/
        field(14; "Sales Line Discount %"; Decimal)
        {
            Editable = false;
        }
        /*field(15; "Sales Line Discount Amount"; Decimal)
        {
            Editable = false;
        }*/
    }
    keys
    {
        key(PK; "Header Id", "Line No.", "Parent Header Id")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    var
        ParameterHeader: Record "Parameter Header";
    begin
        if ParameterHeader.get(Rec."Header Id") then begin
            ParameterHeader."Item Size" := Rec.Size;
            ParameterHeader."Item Cut" := Rec.Cut;
            ParameterHeader."Item Fit" := Rec.Fit;
            ParameterHeader.Modify();
        end;
        ValidateTotalQty();
    end;

    procedure ValidateTotalQty()
    var
        ParentParameterHeader: Record "Parameter Header";
        QtyToAssignment: Record "Qty Assignment Wizard";
        TotalAssignedQty: Decimal;
        Txt001: label 'The assigned quantity is bigger than the total quantity by %1';
    begin
        TotalAssignedQty := 0;
        ParentParameterHeader.Get(Rec."Parent Header Id");
        Clear(QtyToAssignment);
        QtyToAssignment.SetRange("Parent Header Id", Rec."Parent Header Id");
        if QtyToAssignment.FindSet() then
            repeat
                if Rec.SystemId = QtyToAssignment.SystemId then
                    TotalAssignedQty := TotalAssignedQty + Rec."Quantity To Assign"
                else
                    TotalAssignedQty := TotalAssignedQty + QtyToAssignment."Quantity To Assign";
            until QtyToAssignment.Next() = 0;
        if TotalAssignedQty > ParentParameterHeader."Sales Line Quantity" then
            Error(Txt001, TotalAssignedQty - ParentParameterHeader."Sales Line Quantity");
    end;
}
