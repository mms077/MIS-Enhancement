tableextension 50204 "Sales Invoice Line - ER" extends "Sales Invoice Line"
{
    fields
    {
        field(50200; Size; Code[50])
        {
            Caption = 'Size';
            Editable = false;
            TableRelation = "Item Size"."Item Size Code" where("Item No." = field("No."));
        }
        field(50201; Fit; Code[50])
        {
            Caption = 'Fit';
            Editable = false;
            TableRelation = "Item Fit"."Fit Code" where("Item No." = field("No."));
        }
        field(50202; Color; Integer)
        {
            Caption = 'Color';
            Editable = false;
            TableRelation = "Item Color"."Color ID" where("Item No." = field("No."));
        }
        field(50203; "Assembly No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Assemble-to-Order Link"."Assembly Document No."
                          where("Document No." = field("Document No."),
                          "Document Line No." = field("Line No.")));
            Editable = false;
        }
        field(50204; Cut; Code[50])
        {
            Caption = 'Cut';
            Editable = false;
            TableRelation = "Item Cut"."Cut Code" where("Item No." = field("No."));
        }
        field(50205; Tonality; Code[50])
        {
            Caption = 'Tonality';

            Editable = false;
        }
        field(50206; "Parameters Header ID"; Integer)
        {
            Caption = 'Parameters Header ID';

            Editable = false;
        }
        field(50207; "Needed RM Batch"; Integer)
        {
            Caption = 'Needed RM Batch';

            Editable = false;
        }
        field(50208; "Allocation Code"; Code[50])
        {
            Caption = 'Allocation Code';
            Editable = false;
        }
        field(50209; "Allocation Type"; Option)
        {
            OptionMembers = " ","Department","Position","Staff";
            Editable = false;
        }
        field(50210; "Parent Parameter Header ID"; Integer)
        {
            Caption = 'Parent Parameters Header ID';

            Editable = false;
        }
        field(50211; "Control Number"; Text[150])
        {
            Caption = 'Control Number';
            Editable = false;
        }
        field(50215; "Extra Charge %"; Decimal)
        {
            TableRelation = Size."Extra Charge %" where(Code = field(Size));
            ValidateTableRelation = false;
            /*trigger Onvalidate()
            var
            begin
                Validate("Line Discount %", "Extra Charge %" * -1);
                "Extra Charge Amount" := "Line Discount Amount" * -1;
            end;*/
        }
        field(50216; "Extra Charge Amount"; Decimal)
        {
            Editable = false;
        }
        field(50217; "Qty Assignment Wizard Id"; Integer)
        {
            Editable = false;
        }
        field(50218; "IC Parameters Header ID"; Integer)
        {
            Caption = 'IC Parameters Header ID';
            Editable = false;
        }
        field(50219; "IC Parent Parameter Header ID"; Integer)
        {
            Caption = 'IC Parent Parameter Header ID';
            Editable = false;
        }
        field(50220; "Par Level"; Integer)
        {
            Caption = 'Par Level';
            Editable = false;
        }
        field(50221; "Department Code"; Code[50])
        {
            Caption = 'Department Code';
            TableRelation = Department.Code;
            Editable = false;
        }
        field(50222; "Position Code"; Code[50])
        {
            Caption = 'Position Code';
            TableRelation = "Department Positions"."Position Code";
            Editable = false;
        }
        field(50223; "Staff Code"; Code[50])
        {
            Caption = 'Staff Code';
            TableRelation = Staff.Code;
            Editable = false;
        }
        field(50224; "Position Sorting"; Integer)
        {
            Caption = 'Position Sorting';
            FieldClass = FlowField;
            CalcFormula = lookup(Position."Sorting Number" where(Code = field("Position Code")));
            Editable = false;
        }
    }
}
