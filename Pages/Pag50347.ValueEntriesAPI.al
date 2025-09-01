page 50347 "Value_Entries API"
{
    ApplicationArea = All;
    Caption = 'Value_Entries API';
    SourceTable = "Value Entry";
    UsageCategory = Lists;
    PageType = API;

    APIVersion = 'v2.0';
    APIPublisher = 'Exquitech';
    APIGroup = 'demo';

    EntityCaption = 'Value_Entries';
    EntitySetCaption = 'Value_Entries';
    EntityName = 'ValueEntries';
    EntitySetName = 'ValueEntries';

    ODataKeyFields = "Document No.";

    Extensible = false;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item_Ledger_Entry_Type"; rec."Item Ledger Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Document_No"; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Location_Code"; Rec."Location Code") { ApplicationArea = all; }
                field("Posting_Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Item_No"; rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("InvoicedQuantity"; rec."Invoiced Quantity")
                {
                    ApplicationArea = All;
                }
                field("CostAmount_Actual"; Rec."Cost Amount (Actual)") { ApplicationArea = all; }
                field("CostAmount_Actual_ACY"; rec."Cost Amount (Actual) (ACY)")
                {
                    ApplicationArea = all;
                }

            }
        }
    }
}
