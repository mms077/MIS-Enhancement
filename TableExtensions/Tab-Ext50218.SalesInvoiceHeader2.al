tableextension 50218 "Sales Invoice Header 2" extends "Sales Invoice Header"
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
            Caption = 'IC Source No.';
            DataClassification = ToBeClassified;
        }
        field(50302; "IC Company Name"; Text[30])
        {
            Caption = 'IC Company Name';
            DataClassification = ToBeClassified;
            TableRelation = Company.Name;
        }
        field(50303; "Sales Quote No."; Code[20])
        {
            TableRelation = "Sales Header"."No." where("Document Type" = const(Quote));
        }
        field(50304; "Lines Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Line" where("Document No." = field("No.")));
            Editable = false;
        }
        field(50305; "IC Customer SO No."; Code[20])
        {

        }
        field(50306; "IC Customer Project Code"; Code[20])
        {

        }
    }
}

