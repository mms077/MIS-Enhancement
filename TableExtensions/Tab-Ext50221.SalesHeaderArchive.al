tableextension 50221 "Sales Header Archive 2" extends "Sales Header Archive"
{
    fields
    {
        field(50300; "Order Type"; Option)
        {
            OptionMembers = " ","Re-order","New order","Re-order & New order","Replacement";
            OptionCaption = ' ,Re-order,New order,Re-order & New order,Replacement';
        }
        field(50301; "IC Source No."; Code[50])
        {
            Caption = 'IC Customer No.';
            DataClassification = ToBeClassified;
        }
        field(50302; "IC Company Name"; Text[30])
        {
            Caption = 'IC Company Name';
            DataClassification = ToBeClassified;
            TableRelation = Company.Name;
        }
        /*field(50303; "Sales Quote No."; Code[20])
        {
            TableRelation = "Sales Header"."No." where("Document Type" = const(Quote), "Sell-to Customer No." = field("Sell-to Customer No."));
        }*/
        field(50303; "Sales Quote No. ER"; Code[20])
        {
            TableRelation = "Sales Header"."No." where("Document Type" = const(Quote), "Sell-to Customer No." = field("Sell-to Customer No."));
        }
        field(50304; "Lines Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Line" where("Document No." = field("No."), "Document Type" = field("Document Type")));
            Editable = false;
        }
        field(50305; "End Client SO No."; Code[20])
        {

        }
        field(50306; "End Client Project Code"; Code[20])
        {

        }
    }
}
