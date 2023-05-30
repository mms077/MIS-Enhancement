page 50283 Staff
{
    ApplicationArea = All;
    Caption = 'Staff';
    PageType = List;
    SourceTable = Staff;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                field("Position Name"; Rec."Position Name")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Sizes")
            {
                Caption = 'Sizes';
                ApplicationArea = All;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Staff Sizes";
                RunPageLink = "Staff Code" = field("Code"),
                             "Customer No." = field("Customer No."),
                             "Department Code" = field("Department Code"),
                             "Position Code" = field("Position Code");
            }
            action("Measurements")
            {
                Caption = 'Measurements';
                ApplicationArea = All;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Staff Measurements";
                RunPageLink = "Staff Code" = field("Code"),
                              "Customer No." = field("Customer No."),
                              "Department Code" = field("Department Code"),
                              "Position Code" = field("Position Code");
            }
        }
    }
}
