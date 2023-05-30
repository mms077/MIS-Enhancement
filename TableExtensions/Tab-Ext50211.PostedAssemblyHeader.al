tableextension 50211 "Posted Assembly Header" extends "Posted Assembly Header"
{
    fields
    {
        field(50200; "Source Type"; Option)
        {
            Caption = 'Source Type';

            OptionMembers = " ","Sales Order","Sales Invoice";
            OptionCaption = ' ,Sales Order,Sales Invoice';
            Editable = false;
        }
        field(50201; "Source No."; Code[20])
        {
            Caption = 'Source No.';

            Editable = false;
        }
        field(50202; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';

            Editable = false;
        }
        field(50203; "Workflow User Group Code"; Code[20])
        {
            Caption = 'Workflow User Group Code';
            TableRelation = "Workflow User Group".Code;
            Editable = false;
        }
        field(50204; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
            Editable = false;
        }
        field(50205; "Workflow Approver"; Code[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Workflow User Group Member"."User Name" where("Workflow User Group Code" = field("Workflow User Group Code"), "Sequence No." = field("Sequence No.")));
        }
        field(50206; "Total Sequences"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = max("Workflow User Group Member"."Sequence No." where("Workflow User Group Code" = field("Workflow User Group Code")));
        }
        field(50207; "Parameters Header ID"; Integer)
        {
            Caption = 'Parameters Header ID';

            Editable = false;
        }
    }
}
