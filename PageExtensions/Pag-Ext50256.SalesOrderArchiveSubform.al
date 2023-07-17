pageextension 50256 "Sales Order Archive Subform" extends "Sales Order Archive Subform"{
    
        layout
        {
            addafter(Description)
            {
                field("Allocation Type"; rec."Allocation Type")
                {
                    ApplicationArea = All;
                    Caption = 'Allocation Type';
                }
                field("Allocation No."; rec."Allocation Code")
                {
                    ApplicationArea = All;
                    Caption = 'Allocation No.';
                }
                field("Department Code";rec."Department Code")
                {
                    ApplicationArea = All;
                    Caption = 'Department Code';
                }
                field("Position Code";rec."Position Code")
                {
                    ApplicationArea = All;
                    Caption = 'Position Code';
                }
            }
        }
}