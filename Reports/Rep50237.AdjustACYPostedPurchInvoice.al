report 50237 "Adjust Acy Rate"
{
    Caption = 'Adjust Acy Rate Posted Purchase Invoice';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(DocumentNo; DocumentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No';
                        TableRelation = "Purch. Inv. Header";
                        ShowMandatory = true;
                        trigger OnValidate()
                        var
                            myInt: Integer;
                            PurchInvHeader: Record "Purch. Inv. Header";
                        begin
                            PurchInvHeader.SetFilter("No.", DocumentNo);
                            if PurchInvHeader.FindFirst() then begin
                                Rate := 1 / PurchInvHeader."Currency Factor";
                            end;
                        end;
                    }
                    field(SourceCode; SourceCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Source Code';
                        TableRelation = "Source Code".Code;
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field(Rate; Rate)
                    {
                        ApplicationArea = All;
                        DecimalPlaces = 0 : 2;
                        ShowMandatory = true;
                        Editable = false;
                    }
                }

            }

        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        SourceCode := 'INVTPCOST';
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
        GlEntry: Record "G/L Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        GlSetup: Record "General Ledger Setup";
        ValueEntries: Record "Value Entry";
        AdjustACY: Codeunit "Adjust Acy PostedPurchInv";
    begin

        AdjustACY.AdjustAcyPostedPurchInvoice(DocumentNo, SourceCode, Rate);

    end;

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        //Check Mandatory field
        if (DocumentNo = '') or (SourceCode = '') or (Rate = 0) then
            Error('Please fill Mandatory fields');
    end;

    var
        myInt: Integer;
        Rate: Decimal;
        DocumentNo: Code[50];
        SourceCode: Code[50];
}
