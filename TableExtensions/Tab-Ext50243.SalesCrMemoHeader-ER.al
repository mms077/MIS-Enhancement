tableextension 50243 "Sales Cr.Memo Header - ER" extends "Sales Cr.Memo Header"
{
    fields
    {
        modify("Payment Terms Code")
        {
            trigger OnBeforeValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if (xRec."Payment Terms Code" <> '') and (Rec."Payment Terms Code" <> xRec."Payment Terms Code") then begin
                    UserSetup.Get(UserId);
                    UserSetup.TestField("Modify Payment Terms", true);
                end;
            end;
        }
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
        field(50303; "Sales Quote No."; Code[20])
        {
            TableRelation = "Sales Header"."No." where("Document Type" = const(Quote), "Sell-to Customer No." = field("Sell-to Customer No."));
        }
        field(50304; "Lines Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Line" where("Document No." = field("No.")));
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
