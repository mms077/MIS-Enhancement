page 50330 OrderHistory
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = OrderHistory;
    Caption = 'Order History';


    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Sales Order"; rec.SO_NO)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order';
                    trigger OnAssistEdit()
                    var
                        SalesLine: Record "Sales Line";
                        SalesLines: Page "Sales lines";
                        SalesLineArchives: Record "Sales Line Archive";
                        SalesLinesArchives: Page "Sales Line Archive List";
                    begin
                        SalesLine.SetFilter("Document Type", 'Order');
                        SalesLine.SetFilter("Document No.", rec.SO_NO);
                        if SalesLine.FindSet() then begin
                            SalesLines.SetTableView(SalesLine);
                            SalesLines.Editable := false;
                            SalesLines.RunModal();
                        end
                        else begin
                            SalesLineArchives.SetFilter("Document Type", 'Order');
                            SalesLineArchives.SetFilter("Document No.", rec.SO_NO);
                            SalesLineArchives.SetCurrentKey("Version No.");
                            if SalesLineArchives.FindLast() then begin
                                SalesLineArchives.SetFilter("Version No.", format(SalesLineArchives."Version No."));
                                if SalesLineArchives.FindSet() then begin
                                    SalesLinesArchives.SetTableView(SalesLineArchives);
                                    SalesLinesArchives.Editable := false;
                                    SalesLinesArchives.RunModal();
                                end;
                            end;
                        end;
                        //CurrPage.Close();
                        //SalesLines.Close();


                    end;
                }
                field(CustomerProjectName;Rec.CustomerProjectName)
                {
                    ApplicationArea = All;
                    Caption = 'IC Cust. Project';
                }
                field("Order Type"; Rec."Order Type")
                {
                    ApplicationArea = All;
                    Caption = 'Order Type';
                }
                field("Line Counts"; rec."Line Counts")
                {
                    ApplicationArea = All;
                    Caption = 'Line Counts';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnClosePage()
    var
        OrderHistory:Record OrderHistory;
    begin
        OrderHistory.SetRange("Session ID", rec."Session ID");
        OrderHistory.SetRange("Customer No.", rec."Customer No.");
        if OrderHistory.FindSet() then begin
            OrderHistory.DeleteAll();
        end;
    end;

    var
        myInt: Integer;
}