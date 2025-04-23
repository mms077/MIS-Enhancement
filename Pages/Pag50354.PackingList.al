page 50354 "Packing List"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Documents; // Or Tasks depending on usage
    SourceTable = "Packing List Header";
    Caption = 'Packing List';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the source document.';
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the source document.';
                    Editable = false;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the packing list.';
                    // Allow manual status updates? Maybe based on permissions.
                }
                field("No. of Boxes Calculated"; Rec."No. of Boxes Calculated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total number of boxes calculated for this packing list.';
                    Editable = false;
                }
                field("Generation DateTime"; Rec."Generation DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the packing list was generated.';
                    Editable = false;
                }
            }
            part(PackingLines; "Packing List Lines Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = field("Document No.");
                UpdatePropagation = Both;
            }
        }
    }

    // Actions can be added later for manual adjustments (Move to Box, etc.)
}