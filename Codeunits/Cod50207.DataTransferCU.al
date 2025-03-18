codeunit 50207 DataTransferCU
{
    procedure TransferZatcaQRLogToArchive()
    var
        ZatcaQRLogArchive: Record "Zatca QR Logs Archive";
        ZatcaQRLog: Record "Zatca QR Logs";
    begin
        if ZatcaQRLog.FindSet() then
            repeat
                ZatcaQRLogArchive.Init();
                ZatcaQRLogArchive."Document No." := ZatcaQRLog."Document No.";
                ZatcaQRLogArchive.QR := ZatcaQRLog.QR;
                ZatcaQRLogArchive.Date := ZatcaQRLog.Date;
                ZatcaQRLogArchive.Time := ZatcaQRLog.Time;
                ZatcaQRLogArchive.Insert();
            until ZatcaQRLog.Next() = 0;
    end;
}
