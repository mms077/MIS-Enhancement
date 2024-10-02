
page 50349 "Aged AP Entity-ACY Receivable"
{
    Caption = 'AgedAccountsReceivableWithACY', Locked = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Aged Report Entity";
    PageType = List;
    SourceTableTemporary = true;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CustId; Rec.AccountId)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Account ID.';
                    Caption = 'Id', Locked = true;
                }
                field(CustNumber; Rec."No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Customer No.';
                    Caption = 'CustomerNumber', Locked = true;
                }
                field(name; Rec.Name)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Customer Name';
                    Caption = 'Name', Locked = true;
                }
                field(currencyCode; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Currency Code';
                    Caption = 'CurrencyCode', Locked = true;
                }
                field(balanceDue; Rec.Balance)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Vendor Balance';
                    Caption = 'Balance', Locked = true;
                }
                field(balanceDueACY; Rec.BalanceACY)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Customer Balance';
                    Caption = 'Balance ACY', Locked = true;
                }
                field(currentAmount; Rec.Before)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies Before';
                    Caption = 'Before', Locked = true;
                }
                field(period1Amount; Rec."Period 1")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies Period 1';
                    Caption = 'Period1', Locked = true;
                }
                field(period1AmountACY; Rec."Period 1 ACY")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies Period 1 ACY';
                    Caption = 'Period1', Locked = true;
                }
                field(period2Amount; Rec."Period 2")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies Period 2';
                    Caption = 'Period2', Locked = true;
                }
                field(period2AmountACY; Rec."Period 2 ACY")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies Period 2 ACY';
                    Caption = 'Period2', Locked = true;
                }
                field(period3Amount; Rec."Period 3")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies Period 3';
                    Caption = 'Period3', Locked = true;
                }
                field(period3AmountACY; Rec."Period 3 ACY")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies Period 3 ACY';
                    Caption = 'Period3', Locked = true;
                }
                field(agedAsOfDate; Rec."Period Start Date")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Period Start Date';
                    Caption = 'PeriodStartDate', Locked = true;
                }
                field(periodLengthFilter; Rec."Period Length")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Period Length';
                    Caption = 'PeriodLength', Locked = true;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        GraphMgtReports: Codeunit "Graph Mgt - Reports-ACY";
        RecVariant: Variant;
        ReportAPIType: Option "Balance Sheet","Income Statement","Trial Balance","CashFlow Statement","Aged Accounts Payable","Aged Accounts Receivable","Retained Earnings";
    begin
        RecVariant := Rec;
        GraphMgtReports.SetUpAgedReportAPIData(RecVariant, ReportAPIType::"Aged Accounts Receivable");

    end;
}