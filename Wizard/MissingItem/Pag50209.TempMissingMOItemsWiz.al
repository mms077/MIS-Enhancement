page 50209 "Temp Missing MO Items Wiz"
{
    ApplicationArea = All;
    Caption = 'Missing Raw Materials';
    PageType = NavigatePage;
    SourceTable = "Missing MO Items";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Item"; Rec.Item)
                {
                    ToolTip = 'Specifies the Item';
                    Editable = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ToolTip = 'Specifies the description of the item.';
                    Editable = false;
                }
                field("Missing Qty."; Rec."Missing Qty.")
                {
                    ToolTip = 'Specifies the missing quantity.';
                    Editable = false;
                }
                field("Base UOM"; Rec."Base UOM")
                {
                    ToolTip = 'Specifies the base unit of measure.';
                    Editable = false;
                }
                field("Required Quantity"; Rec."Required Quantity")
                {
                    ToolTip = 'Specifies the required quantity.';
                    Editable = false;
                }
                field("Item Inventory"; Rec."Item Inventory")
                {
                    ToolTip = 'Specifies the item inventory.';
                    Editable = false;
                }
                field("Projected Qty."; Rec."Projected Qty.")
                {
                    ToolTip = 'Specifies the project quantity.';
                    Editable = false;
                }
                field("Gross Requirement Qty."; Rec."Gross Requirement Qty.")
                {
                    ToolTip = 'Specifies the gross requirement quantity.';
                    Editable = false;
                }
                field("Planned Order Recpt. Qty."; Rec."Planned Order Recpt. Qty.")
                {
                    ToolTip = 'Specifies the planned order receipt quantity.';
                    Editable = false;
                }
                field("Scheduled Receipt Qty."; Rec."Scheduled Receipt Qty.")
                {
                    ToolTip = 'Specifies the scheduled receipt quantity.';
                    Editable = false;
                }
                field("Planned Order Releases Qty."; Rec."Planned Order Releases Qty.")
                {
                    ToolTip = 'Specifies the planned order releases quantity.';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            // action(Accept)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Make Order';
            //     ToolTip = 'Disregard Missing Items';
            //     Image = Approval;
            //     InFooterBar = true;
            //     trigger OnAction()
            //     var
            //         StockAvailWarning: Record "MO Stock Avl. Warning Log";
            //         MissingReqItems: Record "Missing MO Items";
            //     begin
            //         if Rec.FindFirst() then begin
            //             StockAvailWarning.Init();
            //             StockAvailWarning."Manufacturing Order No." := Rec."Manufacturing Order No.";
            //             StockAvailWarning.SystemCreatedAt := CURRENTDATETIME;
            //             StockAvailWarning.User := USERID;
            //             StockAvailWarning.Insert();
            //             CurrPage.Close();
            //             MissingReqItems.DeleteAll();
            //         end;
            //     end;
            // }
            action(Decline)
            {
                ApplicationArea = All;
                Caption = 'Cancel';
                ToolTip = 'Cancel the action';
                Image = Cancel;
                InFooterBar = true;
                trigger OnAction()
                var
                    MissingReqItems: Record "Missing MO Items";
                begin
                    CurrPage.Close();
                    MissingReqItems.DeleteAll();
                end;
            }
        }
    }

    var
        MissingReqItem: Boolean;
}
