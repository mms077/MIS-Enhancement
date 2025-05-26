page 50370 "Daily Transfer List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Daily Transfer Header";
    Caption = 'Daily Transfer List';
    CardPageID = "Daily Transfer";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the daily transfer.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the daily transfer.';
                }
                field("User"; Rec."User")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user who created the daily transfer.';
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source location for the transfer.';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the daily transfer.';
                }
            }
        }
        area(Factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewTransfer)
            {
                ApplicationArea = All;
                Caption = 'New Daily Transfer';
                Image = New;
                ToolTip = 'Create a new daily transfer.';

                trigger OnAction()
                var
                    DailyTransferHeader: Record "Daily Transfer Header";
                    DailyTransferPage: Page "Daily Transfer";
                begin
                    DailyTransferHeader.Init();
                    DailyTransferHeader.Insert(true);
                    DailyTransferPage.SetRecord(DailyTransferHeader);
                    DailyTransferPage.Run();
                end;
            }
        }
        area(Navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Open the daily transfer document.';

                    trigger OnAction()
                    begin
                        PAGE.Run(PAGE::"Daily Transfer", Rec);
                    end;
                }
            }
        }
        area(Reporting)
        {
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = Print;
                ToolTip = 'Print the daily transfer list.';

                trigger OnAction()
                begin
                    // Add print functionality if needed
                    Message('Print functionality can be implemented here.');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        // Set default filter to show recent transfers
        Rec.SetRange("Date", CalcDate('-30D', Today), Today);
    end;
}
