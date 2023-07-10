pageextension 50254 PaymentJournal extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {

        /*modify("Post and &Print")
        {
             Visible = false;



        }*/
        addafter("Post and &Print")
        {
            action("Post and &Print New")
            {
                ApplicationArea = Basic, Suite, all;
                Caption = 'Post and &Print';
                Image = PostPrint;
                ShortCutKey = 'Shift+F9';
                PromotedCategory = Process;
                Promoted = true;
                ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
                trigger OnAction()
                begin
                    Rec.SendToPosting(Codeunit::"Gen. Jnl.-Post");
                    GenJnlLine.Copy(Rec);
                    RecRefToPrint.GetTable(GenJnlLine);
                    PrintJournal(RecRefToPrint);
                    CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                    SetJobQueueVisibility();
                    CurrPage.Update(false);
                end;
            }
        }

    }
    procedure PrintJournal(RecRef: RecordRef)
    var
        GeneralLedgerSetup: Record "General Ledger Setup";

        GenJnlTemplate: Record "Gen. Journal Template";
        GenJrnlLine: Record "Gen. Journal Line";
        GLReg: Record "G/L Register";
    begin
        if RecRef.Number <> DATABASE::"Gen. Journal Line" then
            exit;

        RecRef.SetTable(GenJrnlLine);
        GenJnlTemplate.Get(GenJrnlLine."Journal Template Name");

        GeneralLedgerSetup.Get();
        with GenJrnlLine do
            if GLReg.Get(GenJrnlLine."Line No.") then begin
                if GenJnlTemplate."Cust. Receipt Report ID" <> 0 then
                    PrintCustReceiptReport(GLReg, GenJnlTemplate, GeneralLedgerSetup);

                if GenJnlTemplate."Vendor Receipt Report ID" <> 0 then
                    PrintVendorReceiptReport(GLReg, GenJnlTemplate, GeneralLedgerSetup);

                if GenJnlTemplate."Posting Report ID" <> 0 then
                    PrintPostingReport(GLReg, GenJnlTemplate, GeneralLedgerSetup);
            end;
    end;


    local procedure PrintCustReceiptReport(GLReg: Record "G/L Register"; GenJnlTemplate: Record "Gen. Journal Template"; GeneralLedgerSetup: Record "General Ledger Setup")
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforePrintCustReceiptReport(GLReg, GenJnlTemplate, GeneralLedgerSetup, IsHandled);
        if IsHandled then
            exit;

        CustLedgEntry.SetRange("Entry No.", GLReg."From Entry No.", GLReg."To Entry No.");
        if GeneralLedgerSetup."Post & Print with Job Queue" then
            SchedulePrintJobQueueEntry(GLReg, GenJnlTemplate."Cust. Receipt Report ID", GeneralLedgerSetup."Report Output Type")
        else
            REPORT.Run(GenJnlTemplate."Cust. Receipt Report ID", false, false, CustLedgEntry);
    end;

    local procedure PrintVendorReceiptReport(GLReg: Record "G/L Register"; GenJnlTemplate: Record "Gen. Journal Template"; GeneralLedgerSetup: Record "General Ledger Setup")
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforePrintVendorReceiptReport(GLReg, GenJnlTemplate, GeneralLedgerSetup, IsHandled);
        if IsHandled then
            exit;

        VendLedgEntry.SetRange("Entry No.", GLReg."From Entry No.", GLReg."To Entry No.");
        if GeneralLedgerSetup."Post & Print with Job Queue" then
            SchedulePrintJobQueueEntry(GLReg, GenJnlTemplate."Vendor Receipt Report ID", GeneralLedgerSetup."Report Output Type")
        else
            REPORT.Run(GenJnlTemplate."Vendor Receipt Report ID", false, false, VendLedgEntry);
    end;

    local procedure PrintPostingReport(GLReg: Record "G/L Register"; GenJnlTemplate: Record "Gen. Journal Template"; GeneralLedgerSetup: Record "General Ledger Setup")
    var
        IsHandled: Boolean;
        GLRegister: Record "G/L Register";
    begin
        GLReg.SetRecFilter();
        IsHandled := false;
        // OnBeforeGLRegPostingReportPrint(GenJnlTemplate."Posting Report ID", false, false, GLReg, IsHandled);
        if IsHandled then
            exit;

        if GeneralLedgerSetup."Post & Print with Job Queue" then
            SchedulePrintJobQueueEntry(GLReg, GenJnlTemplate."Posting Report ID", GeneralLedgerSetup."Report Output Type")
        else begin
            Clear(GLRegister);
            GLRegister.FindLast();
            GLEntry.SetRange("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
            if GLEntry.FindSet() then
                REPORT.Run(50212, false, false, GLEntry);
        end;
    end;

    procedure SchedulePrintJobQueueEntry(RecVar: Variant; ReportId: Integer; ReportOutputType: Option)
    var
        JobQueueEntry: Record "Job Queue Entry";
        RecRefToPrint: RecordRef;
    begin
        RecRefToPrint.GetTable(RecVar);
        with JobQueueEntry do begin
            Clear(ID);
            "Object Type to Run" := "Object Type to Run"::Report;
            "Object ID to Run" := ReportId;
            "Report Output Type" := ReportOutputType;
            "Record ID to Process" := RecRefToPrint.RecordId;
            Description := Format("Report Output Type");
            CODEUNIT.Run(CODEUNIT::"Job Queue - Enqueue", JobQueueEntry);
            Commit();
        end;
    end;

    local procedure SetJobQueueVisibility()
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        JobQueuesUsed := GeneralLedgerSetup.JobQueueActive();
    end;

    var
        myInt: Integer;
        CurrentJnlBatchName: Code[10];
        RecRefToPrint: RecordRef;
        BatchPostingPrintMgt: Codeunit "Batch Posting Print Mgt.";
        GeneralLedgerSetup: Record "General Ledger Setup";
        JobQueuesUsed: Boolean;
        JobQueueVisible: Boolean;
        GLEntry: record "G/L Entry";
        GenJnlLine: Record "Gen. Journal Line";
}