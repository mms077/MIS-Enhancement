page 50284 "Staff Sizes"
{
    ApplicationArea = All;
    Caption = 'Staff Sizes';
    PageType = List;
    SourceTable = "Staff Sizes";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Size Code"; Rec."Size Code")
                {
                    ApplicationArea = All;
                }
                field("Fit Code"; Rec."Fit Code")
                {
                    ApplicationArea = All;
                }
                field("Cut Code"; Rec."Cut Code")
                {
                    ApplicationArea = All;
                }
                field("Staff Code"; Rec."Staff Code")
                {
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = all;
                }
                field("Position Name"; Rec."Position Name")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec."Type")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
