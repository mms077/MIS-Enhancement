pageextension 50211 "Sales & Receivables Setup - ER" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter(Archiving)
        {
            group("Item Master")
            {
                /*field("Branding Category Code"; Rec."Branding Category Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Do not skip cutting sheet Embroidery Department if this Branding Category exists in item variant';
                }*/
                field("Cutting Sheet Workflow Group"; Rec."Cutting Sheet Workflow Group")
                {
                    Caption = 'Cutting Sheet Workflow Group';
                    ApplicationArea = All;
                    ToolTip = 'Cutting Sheet Workflow to be used on the cutting sheet scanning';
                }
                field("Scanning Workflow Group"; Rec."Scanning Workflow Group") { ApplicationArea = all; }
                field("Packaging Stage"; Rec."Packaging Stage") { ApplicationArea = all; }
                field("Scan In/Out Interval"; Rec."Scan In/Out Interval")
                {
                    ApplicationArea = all;
                    ToolTip = 'Minimum time between scan in and out';
                }
                field("Wizard Default Location"; Rec."Wizard Default Location")
                {
                    ApplicationArea = all;
                    ToolTip = 'Set the default location code to appear on wizard page';
                }
                /*field("Keep Sales Quote"; Rec."Keep Sales Quote")
                {
                    ApplicationArea = all;
                    ToolTip = 'Keep sales quote after making order';
                }*/

            }
        }
        addafter("Direct Debit Mandate Nos.")
        {
            field("Look Nos."; rec."Look Nos.") { ApplicationArea = all; }
            field("Look Version Nos."; rec."Look Version Nos.") { ApplicationArea = all; }
            field("Item Look Version Nos."; rec."Item Look Version Nos.") { ApplicationArea = all; }
        }
        addbefore(Control1900383207)
        {
            part(SalesReceivablesPicture; "Sales & Receivables Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Primary Key" = FIELD("Primary Key");
            }
        }
    }
}
