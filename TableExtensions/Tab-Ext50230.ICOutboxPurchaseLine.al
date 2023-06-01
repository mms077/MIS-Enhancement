tableextension 50230 "IC Outbox Purchase Line" extends "IC Outbox Purchase Line"
{
    fields
    {
        field(50200; Size; Code[50])
        {
            Caption = 'Size';
            Editable = false;
            TableRelation = "Item Size"."Item Size Code" where("Item No." = field("IC Partner Code"));
        }
        field(50201; Fit; Code[50])
        {
            Caption = 'Fit';
            Editable = false;
            TableRelation = "Item Fit"."Fit Code" where("Item No." = field("IC Partner Code"));
        }
        field(50202; Color; Integer)
        {
            Caption = 'Color';
            Editable = false;
            TableRelation = "Item Color"."Color ID" where("Item No." = field("IC Partner Code"));
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
            TableRelation = "Item Cut"."Cut Code" where("Item No." = field("IC Partner Code"));
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
        field(50212; "Variant Code"; Code[20])
        {
            Caption = 'Variant Code';
            DataClassification = ToBeClassified;
        }
        field(50210; "Parent Parameter Header ID"; Integer)
        {
            Caption = 'Parent Parameters Header ID';

            Editable = false;
        }
        field(50211; "Control Number"; Text[150])
        {
            Caption = 'Control Number';

        }
        field(50215; "Extra Charge %"; Decimal)
        {
            Editable = false;
        }
        field(50216; "Extra Charge Amount"; Decimal)
        {
            Editable = false;
        }
    }
}
