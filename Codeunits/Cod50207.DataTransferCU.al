codeunit 50207 DataTransferCU
{
    procedure TransferZatcaQRLogToArchive()
    var
        ZatcaQRLogArchive: Record "Zatca QR Logs Archive";
        ZatcaItegrationLogPhase1: Record "ZATCA Integration Logs Phase 1";
    begin
        if ZatcaQRLogArchive.FindSet() then
            repeat
                ZatcaItegrationLogPhase1.Init();
                ZatcaItegrationLogPhase1."Document No." := ZatcaQRLogArchive."Document No.";
                ZatcaItegrationLogPhase1."QR Picture" := ZatcaQRLogArchive.QR;
                ZatcaItegrationLogPhase1.SystemCreatedAt := ZatcaQRLogArchive.SystemCreatedAt;
                ZatcaItegrationLogPhase1.Time := Format(ZatcaQRLogArchive.Time);
                ZatcaItegrationLogPhase1.Insert();
            until ZatcaQRLogArchive.Next() = 0;
    end;
}
