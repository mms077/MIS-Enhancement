page 50368 "Daily Transfer Header"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Daily Transfer Header";
    Caption = 'Daily Transfer';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the daily transfer.';
                    Editable = HeaderFieldsEditable;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used for the daily transfer.';
                    Editable = false;
                    Visible = false;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the daily transfer.';
                    Editable = HeaderFieldsEditable;
                }
                field("User"; Rec."User")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user who created the daily transfer.';
                    Editable = HeaderFieldsEditable;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source location for the transfer.';
                    Editable = HeaderFieldsEditable;
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the destination location for the transfer.';
                    Editable = HeaderFieldsEditable;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the daily transfer.';
                    Editable = HeaderFieldsEditable;
                }
                field("Posted Whse. Shipment No."; Rec."Posted Whse. Shipment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posted warehouse shipment number related to this daily transfer.';
                    Editable = false;
                }
                field("Posted Whse. Receipt No."; Rec."Posted Whse. Receipt No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posted warehouse receipt number related to this daily transfer.';
                    Editable = false;
                }
            }
            group(Scanner)
            {
                Caption = 'Scanner Input';

                field("Scanner Input"; Rec."Scanner Input")
                {
                    ApplicationArea = All;
                    ToolTip = 'Scan serial number or assembly order number to populate lines.';
                    ShowMandatory = true;
                    Editable = ScannerEditable;
                    trigger OnValidate()
                    begin
                        CurrPage.Lines.Page.Update(false);
                        CurrPage.Update(false);
                        UpdateHeaderFieldsEditable();
                    end;
                }
            }
            part(Lines; "Daily Transfer Lines Subform")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Code");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(RefreshLines)
            {
                ApplicationArea = All;
                Caption = 'Refresh Lines';
                Image = Refresh;
                ToolTip = 'Refresh the lines display after scanning.';

                trigger OnAction()
                begin
                    CurrPage.Lines.Page.Update(false);
                    CurrPage.Update(false);
                end;
            }
            action(CreateWarehouseDocuments)
            {
                ApplicationArea = All;
                Caption = 'Create Warehouse Shipment & Pick';
                Image = Shipment;
                ToolTip = 'Create warehouse shipments and picks for the transfer orders referenced in the daily transfer lines.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    DailyTransferMgt: Codeunit "Daily Transfer Management";
                begin
                    if Confirm('Do you want to create warehouse shipments and picks for the transfer orders in this daily transfer?') then begin
                        DailyTransferMgt.CreateWarehouseShipmentAndPick(Rec);
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }

    var
        HeaderFieldsEditable: Boolean;
        ScannerEditable: Boolean;


    trigger OnAfterGetRecord()
    begin
        UpdateHeaderFieldsEditable();
        ScannerIsEditable();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec."Code" = '' then begin
            Rec."Date" := Today;
            Rec."User" := UserId;
        end;
        UpdateHeaderFieldsEditable();
        ScannerIsEditable();
    end;

    local procedure UpdateHeaderFieldsEditable()
    begin
        HeaderFieldsEditable := not Rec.HasLines();
    end;

    local procedure ScannerIsEditable()
    begin
        ScannerEditable := Rec."Status" = Rec."Status"::"Open";
    end;
}
