pageextension 50256 ReqWorkSheet extends "Req. Worksheet"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(CarryOutActionMessage)
        {
            action(CarryOutActionMessageForQuote)
            {
                ApplicationArea = Planning;
                Caption = 'Carry &Out Action Message';
                Ellipsis = true;
                Image = CarryOutActionMessage;
                ToolTip = 'Use a batch job to help you create actual supply orders from the order proposals.';

                trigger OnAction()
                begin
                    CarryOutActionMsg();
                    CurrentJnlBatchName := GetRangeMax("Journal Batch Name");
                    CurrPage.Update(false);
                end;
            }
        }
    }
    local procedure CarryOutActionMsg()
    var
        CarryOutActionMsgReq: Report "Carry Out Action Msg. - Req.";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCarryOutActionMsg(Rec, IsHandled);
        if IsHandled then
            exit;

        CarryOutActionMsgReq.SetReqWkshLine(Rec);
        CarryOutActionMsgReq.RunModal();
        CarryOutActionMsgReq.GetReqWkshLine(Rec);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCarryOutActionMsg(var RequisitionLine: Record "Requisition Line"; var IsHandled: Boolean);
    begin
    end;

    var
        myInt: Integer;
}