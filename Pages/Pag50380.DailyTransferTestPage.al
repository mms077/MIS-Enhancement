page 50380 "Daily Transfer Test Page"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'Daily Transfer Warehouse Test';

    layout
    {
        area(Content)
        {
            group(TestInformation)
            {
                Caption = 'Test Information';

                field(TestDescription; 'This page validates the Daily Transfer warehouse pick creation fix.')
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    Style = StandardAccent;
                }

                field(FixDescription; 'The fix changes from using Warehouse Shipment Header to Warehouse Shipment Line for pick creation.')
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenDailyTransferList)
            {
                ApplicationArea = All;
                Caption = 'Open Daily Transfer List';
                Image = List;
                ToolTip = 'Open the Daily Transfer List to test the warehouse document creation';

                trigger OnAction()
                begin
                    Page.Run(Page::"Daily Transfer List");
                end;
            }
        }
    }
}
