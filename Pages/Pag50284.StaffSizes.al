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
                field(Type; Rec."Type")
                {
                    ApplicationArea = all;
                }
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
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(UpdateStaffTypeCombination)
            {
                ApplicationArea = All;
                Caption = 'Update Staff Type Combination';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    StaffSizes: Record "Staff Sizes";
                    Company: Record "Company";
                begin
                    if Company.FindSet() then
                        repeat
                            StaffSizes.ChangeCompany(Company."Name");
                            if StaffSizes.FindSet() then
                                repeat
                                    StaffSizes."StaffType Combination" := StaffSizes."Staff Code" + StaffSizes."Type";
                                    StaffSizes.Modify();
                                until StaffSizes.Next() = 0;
                        until Company.Next() = 0;
                end;
            }
        }
    }
}
