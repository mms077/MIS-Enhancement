/*page 50209 "ZATCA QR Logs Archive"
{
    ApplicationArea = All;
    Caption = 'ZATCA QR Logs Archive';
    PageType = List;
    SourceTable = "ZATCA QR Logs Archive";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field(QR; Rec.QR)
                {
                    ApplicationArea = all;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = all;
                }
                field("Time"; Rec."Time")
                {
                    ApplicationArea = all;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = all;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = all;
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = all;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = all;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Download QR")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    TenantMedia: Record "Tenant Media";
                    TenantMediaSet: Record "Tenant Media Set";
                    InS: instream;
                    OutS: OutStream;
                    FileName: Text;
                    TempBlob: Codeunit "Temp Blob";
                    DataCompression: Codeunit "Data Compression";
                    FileMgt: Codeunit "File Management";
                begin
                    Clear(TenantMedia);
                    Clear(TenantMediaSet);
                    TenantMediaSet.SetFilter(ID, Format(Rec.QR));
                    if TenantMediaSet.FindFirst() then begin
                        TenantMedia.SetFilter(ID, Format(TenantMediaSet."Media ID"));
                        if TenantMedia.FindFirst() then
                            if TenantMedia.Content.HasValue then begin
                                TenantMedia.CalcFields(Content);
                                TenantMedia.Content.CreateInStream(InS);
                                TempBlob.CreateOutStream(OutS);
                                CopyStream(OutS, InS);
                                FileName := Rec."Document No." + '.bmp';
                                FileMgt.BLOBExport(TempBlob, FileName, true);
                            end;
                    end;
                end;
            }
            group("ZATCA QR Logs Archive")
            {
                action(TransferZatcaQRLogToArchive)
                {
                    ApplicationArea = All;
                    Caption = 'Transfer ZATCA QR Log to Archive';
                    Image = Archive;
                    trigger OnAction()
                    var
                        DataTransferCU: Codeunit DataTransferCU;
                    begin
                        DataTransferCU.TransferZatcaQRLogToArchive();
                    end;
                }
            }
        }
    }
}
*/