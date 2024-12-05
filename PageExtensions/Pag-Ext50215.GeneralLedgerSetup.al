pageextension 50215 "General Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        addlast(General)
        {
            field("IC SQ Location"; Rec."IC SQ Location")
            {
                ApplicationArea = all;
                ToolTip = 'The location of the SQ Line if the company is not the prodcution company.';
            }
            field("Disregard Item Availability"; Rec."Disregard Item Availability")
            {
                ApplicationArea = all;
                ToolTip = 'Disregard the availability of the items, always create assembly.';
            }

        }
        addlast(Reporting)
        {
            field("Sub Tax Invoice Title"; Rec."Sub Tax Invoice Title")
            {
                ApplicationArea = All;
                ToolTip = 'Substitute Sales invoice Title with Tax Invoice & Credit Note with Tax Credit Note.';
            }
            field("Default VAT %"; Rec."Default VAT %")
            {
                ApplicationArea = All;
                ToolTip = 'The default VAT % in the company';
            }
            field("Arabic Desc. in SI Report"; Rec."Arabic Desc. in SI Report")
            {
                ApplicationArea = All;
                ToolTip = 'Show the Arabic Description in the Sales Invoice Report';
            }
        }
        addafter(Application)
        {
            group("Item Master")
            {
                field("Company Type"; Rec."Company Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Full Production: when the company produce all types. Only from SF: when the company produce only finished Items based on the Semi-Finished. No Production: When the company does not operate production';
                }
                field("MOF Receipt"; Rec."MOF Receipt")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
