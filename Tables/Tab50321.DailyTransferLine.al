table 50321 "Daily Transfer Line"
{
    Caption = 'Daily Transfer Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = "Daily Transfer Header"."Code";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "From Location"; Code[10])
        {
            Caption = 'From Location';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
        field(4; "To Location"; Code[10])
        {
            Caption = 'To Location';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
        field(5; "Serial No."; Code[50])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
        }
        field(6; "Transfer Order No."; Code[20])
        {
            Caption = 'Transfer Order No.';
            DataClassification = CustomerContent;
            TableRelation = "Transfer Header"."No.";
        }
        field(7; "Transfer Line No."; Integer)
        {
            Caption = 'Transfer Line No.';
            DataClassification = CustomerContent;
        }
        field(8; "Warning"; Text[100])
        {
            Caption = 'Warning';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }
        key(LocationKey; "From Location", "To Location")
        {
        }
    }

    trigger OnDelete()
    var
        DailyTransferHeader: Record "Daily Transfer Header";
    begin
        if DailyTransferHeader.Get("No.") then;
    end;
}
