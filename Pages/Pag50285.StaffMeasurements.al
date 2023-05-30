page 50285 "Staff Measurements"
{
    ApplicationArea = All;
    Caption = 'Staff Measurements';
    PageType = List;
    SourceTable = "Staff Measurements";
    UsageCategory = Lists;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Measurement Code"; Rec."Measurement Code")
                {
                    ApplicationArea = All;
                }
                field("Value"; Rec."Value")
                {
                    ApplicationArea = All;
                }
                field("UOM Code"; Rec."UOM Code")
                {
                    ApplicationArea = All;
                }
                field("Staff Code"; Rec."Staff Code")
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
            }
        }
    }
}
