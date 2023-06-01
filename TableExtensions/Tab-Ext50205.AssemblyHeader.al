tableextension 50205 "Assembly Header" extends "Assembly Header"
{
    fields
    {
        field(50200; "Source Type"; Enum "Assembly Document Type")
        {
            Caption = 'Source Type';
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
        field(50208; "ER - Manufacturing Order No."; Code[50])
        {
            Caption = 'ER - Manufacturing Order No.';
            TableRelation = "ER - Manufacturing Order"."No.";
            Editable = false;
        }
        field(50209; "Parent Parameter Header ID"; Integer)
        {
            Caption = 'Parent Parameter Header ID';
            Editable = false;
        }
        field(50210; "Grouping Criteria"; Text[250])
        {
            Caption = 'Grouping Criteria';
            Editable = false;
        }
        field(50211; "Item Size"; Code[50])
        {
            Caption = 'Item Size';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Item Size" where(Code = field("Variant Code"), "Item No." = field("Item No.")));
            TableRelation = Size.Code where(Code = field("Item Size"));
            Editable = false;
        }
        field(50212; "Item Fit"; Code[50])
        {
            Caption = 'Item Fit';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Item Fit" where(Code = field("Variant Code"), "Item No." = field("Item No.")));
            TableRelation = Fit.Code where(Code = field("Item Fit"));
            Editable = false;
        }
        field(50213; "Item Color ID"; Integer)
        {
            Caption = 'Item Color ID';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Item Color ID" where(Code = field("Variant Code"), "Item No." = field("Item No.")));
            TableRelation = Color.ID where(id = field("Item Color ID"));
            Editable = false;
        }

        field(50214; "Item Cut Code"; Code[50])
        {
            Caption = 'Item Cut';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Item Cut Code" where(Code = field("Variant Code"), "Item No." = field("Item No.")));
            TableRelation = Cut.Code where(Code = field("Item Cut Code"));
            Editable = false;
        }
        field(50215; "Tonality Code"; Code[50])
        {
            Caption = 'Tonality Code';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Tonality Code" where(Code = field("Variant Code"), "Item No." = field("Item No.")));
            TableRelation = Tonality.Code where(Code = field("Tonality Code"));
            Editable = false;
        }

        field(50216; "Design Sections Set ID"; Integer)
        {
            Caption = 'Design Sections Set ID';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Design Sections Set ID" where(Code = field("Variant Code"), "Item No." = field("Item No.")));
            TableRelation = "Design Sections Set"."Design Section Set ID";
        }
        field(50217; "Item Features Set ID"; Integer)
        {
            Caption = 'Item Features Set ID';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Item Features Set ID" where(Code = field("Variant Code"), "Item No." = field("Item No.")));
            TableRelation = "Item Features Set"."Item Feature Set ID";
        }
        field(50218; "Item Brandings Set ID"; Integer)
        {
            Caption = 'Item Brandings  Set ID';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."Item Brandings Set ID" where(Code = field("Variant Code"), "Item No." = field("Item No.")));
            TableRelation = "Item Brandings Set"."Item Branding Set ID";
        }
    }
    keys
    {
        key(FK; "Grouping Criteria")
        {
        }
    }
    trigger OnModify()
    var
        UserSetup: Record "User Setup";
        Txt001: Label 'You should have Modify Assembly permission to edit the record';
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.CanModifyAssembly(UserId) = false then
            Error(Txt001);
        Rec.CalcFields("Item Size", "Item Fit", "Item Cut Code");
        Rec."Grouping Criteria" := Rec."Item No." + '-' + Rec."Item Size" + '-' + Rec."Item Fit" + '-' + Rec."Item Cut Code";
    end;
}
