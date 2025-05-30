table 50320 "Daily Transfer Header"
{
    Caption = 'Daily Transfer Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Code" <> xRec."Code" then begin
                    GetInventorySetup();
                    NoSeries.TestManual("No. Series");
                end;
            end;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(3; "User"; Code[50])
        {
            Caption = 'User';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }
        field(4; "From Location"; Code[10])
        {
            Caption = 'From Location';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
        field(5; "To Location"; Code[10])
        {
            Caption = 'To Location';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
        field(6; "Scanner Input"; Code[50])
        {
            Caption = 'Scanner Input';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField("From Location");
                ProcessScannerInput();
            end;
        }
        field(7; "Status"; Enum "Daily Transfer Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series".Code;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(DateKey; "Date")
        {
        }
    }
    trigger OnInsert()
    begin
        if "Code" = '' then begin
            GetInventorySetup();
            InventorySetup.TestField("Daily Transfer Nos.");
            "No. Series" := InventorySetup."Daily Transfer Nos.";
            "Code" := NoSeries.GetNextNo("No. Series");
        end;

        if "Date" = 0D then
            "Date" := Today;
        if "User" = '' then
            "User" := UserId;
        "Status" := "Daily Transfer Status"::Open;
    end;

    var
        InventorySetup: Record "Inventory Setup";
        NoSeries: Codeunit "No. Series";
        InventorySetupRead: Boolean;

    local procedure GetInventorySetup()
    begin
        if not InventorySetupRead then begin
            InventorySetup.Get();
            InventorySetupRead := true;
        end;
    end;

    procedure HasLines(): Boolean
    var
        DailyTransferLine: Record "Daily Transfer Line";
    begin
        DailyTransferLine.SetRange("No.", "Code");
        exit(not DailyTransferLine.IsEmpty());
    end;

    procedure AssistEdit(OldDailyTransferHeader: Record "Daily Transfer Header"): Boolean
    begin
        GetInventorySetup();
        InventorySetup.TestField("Daily Transfer Nos.");
        if NoSeries.LookupRelatedNoSeries(InventorySetup."Daily Transfer Nos.", OldDailyTransferHeader."No. Series", "No. Series") then begin
            "Code" := NoSeries.GetNextNo("No. Series");
            exit(true);
        end;
        exit(false);
    end;

    local procedure ProcessScannerInput()
    var
        DailyTransferMgt: Codeunit "Daily Transfer Management";
    begin
        DailyTransferMgt.ProcessScannerInput(Rec);
    end;
}
