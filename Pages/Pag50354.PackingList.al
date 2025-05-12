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
                    Editable = NOT Rec."Bins Created";
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location for this packing list.';
                    Editable = NOT Rec."Bins Created";
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

    actions
    {
        area(Processing)
        {
            action(CreateBins)
            {
                Caption = 'Create Bins';
                Image = CreateBins;
                ApplicationArea = All;
                Enabled = NOT Rec."Bins Created";
                trigger OnAction()
                var
                    PackingListMgt: Codeunit "Packing List Management";
                begin
                    PackingListMgt.CreateBinsForPackingList(Rec);
                    CurrPage.Update();
                end;
            }
            action(DeleteBins)
            {
                Caption = 'Delete Bins';
                Image = Delete;
                ApplicationArea = All;
                Enabled = Rec."Bins Created";
                trigger OnAction()
                var
                    PackingListMgt: Codeunit "Packing List Management";
                begin
                    PackingListMgt.DeleteBinsForPackingList(Rec);
                    CurrPage.Update();
                end;
            }
        }
    }

    // Actions can be added later for manual adjustments (Move to Box, etc.)
}