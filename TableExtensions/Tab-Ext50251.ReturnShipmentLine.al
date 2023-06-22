tableextension 50251 "Return Shipment Line" extends "Return Shipment Line"
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
        /*field(50203; "Assembly No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Assemble-to-Order Link"."Assembly Document No."
                          where("Document No." = field("Document No."),
                          "Document Line No." = field("Line No.")));
            Editable = false;
        }*/
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
        field(50225; "Design Sections Set"; Integer)
        {
            Caption = 'Design Sections Set';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Design Sections Set ID" where("Item No." = field("No."), "Code" = field("Variant Code")));
        }
        field(50226; "Item Features Set"; Integer)
        {
            Caption = 'Item Features Set';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Item Features Set ID" where("Item No." = field("No."), "Code" = field("Variant Code")));
        }
        field(50227; "Item Brandings Set"; Integer)
        {
            Caption = 'Item Brandings Set';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Item Brandings Set ID" where("Item No." = field("No."), "Code" = field("Variant Code")));
        }
    }
}
