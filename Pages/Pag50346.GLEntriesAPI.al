page 50346 "GLEntries API"
{
    ApplicationArea = All;
    Caption = 'G/L Entries API';
    SourceTable = "G/L Entry";
    UsageCategory = Lists;
    PageType = API;

    APIVersion = 'v2.0';
    APIPublisher = 'Exquitech';
    APIGroup = 'demo';

    EntityCaption = 'G/L Entries';
    EntitySetCaption = 'G/L Entries';
    EntityName = 'GLEntry';
    EntitySetName = 'GLEntry';

    ODataKeyFields = SystemId;

    Extensible = false;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry_No"; rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Posting_Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document_Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document_No"; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("G_L_Account_No"; rec."G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("G_L_Account_Name"; rec."G/L Account Name")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Additional_Currency_Amount"; Rec."Additional-Currency Amount")
                {
                    ApplicationArea = All;
                }

                field("GlobalDimension1Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("GlobalDimension2Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("ShortcutDimension4Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
