table 50271 "Cutting Sheets Dashboard"
{
    Caption = 'Cutting Sheet Dashboard';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Assembly No."; Code[20])
        {
            Caption = 'Assembly No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "1"; Option)
        {
            Caption = '1';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Not Available","IN","OUT";
            Editable = false;
        }
        field(4; "2"; Option)
        {
            Caption = '2';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Not Available","IN","OUT";
            Editable = false;
        }
        field(5; "3"; Option)
        {
            Caption = '3';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Not Available","IN","OUT";
            Editable = false;
        }
        field(6; "4"; Option)
        {
            Caption = '4';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Not Available","IN","OUT";
            Editable = false;
        }
        field(7; "5"; Option)
        {
            Caption = '5';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Not Available","IN","OUT";
            Editable = false;
        }
        field(8; "6"; Option)
        {
            Caption = '6';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Not Available","IN","OUT";
            Editable = false;
        }
        field(9; "7"; Option)
        {
            Caption = '7';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Not Available","IN","OUT";
            Editable = false;
        }
        /*field(10; "8"; Option)
        {
            Caption = 'Packing';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Not Available","IN","OUT";
            Editable = false;
        }*/
        field(11; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code;
            Editable = false;
        }
        field(12; "Description"; Text[100])
        {
            Editable = false;
        }
        field(13; "Plotting"; text[100])
        {
            Caption = 'Plotting';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Cutting"; text[100])
        {
            Caption = 'Cutting';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Embroidery"; text[100])
        {
            Caption = 'Embroidery';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Production Line"; text[100])
        {
            Caption = 'Production Line';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Finishing"; text[100])
        {
            Caption = 'Finishing';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Trimming"; text[100])
        {
            Caption = 'Trimming';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        /*field(19; "Pressing Symbol"; text[100])
        {
            Caption = 'Pressing Symbol';
            DataClassification = ToBeClassified;
            Editable = false;
        }*/
        field(20; "Packaging"; text[100])
        {
            Caption = 'Packaging';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Scan Count"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count("Cutting Sheet Scanning Details" where("Assembly No." = field("Assembly No.")));
        }
        field(22; "Cutting Sheet Workflow Group"; Code[20])
        {
            Caption = 'Cutting Sheet Workflow Group';
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group-ER".Code;
            Editable = false;
        }
        field(23; "Current Sequence No."; Integer)
        {
            Editable = false;
        }
        field(24; "Total Sequence"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = max("Workflow User Group Member-ER"."Sequence No." where("Workflow User Group Code" = field("Cutting Sheet Workflow Group")));
        }
        //More than one approver
        /*field(25; "Current Approver"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Workflow User Group Member-ER".Name where("Workflow User Group Code" = field("Cutting Sheet Workflow Group"), "Sequence No." = field("Current Sequence No.")));
        }*/
        /*field(26; "Scanned In"; Boolean)
        {
            Editable = false;
        }
        field(27; "Scanned Out"; Boolean)
        {
            Editable = false;
        }*/
        field(25; "Source Type"; Enum "Assembly Document Type")
        {
            Caption = 'Source Type';
            Editable = false;
        }
        field(26; "Source No."; Code[20])
        {
            Caption = 'Source No.';

            Editable = false;
        }
        field(27; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';

            Editable = false;
        }
        field(28; "ER - Manufacturing Order No."; Code[50])
        {
            Caption = 'ER - Manufacturing Order No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Assembly Header"."ER - Manufacturing Order No." where("No." = field("Assembly No.")));
            Editable = false;
        }
        field(29; "Starting Time"; DateTime)
        {
            Editable = false;
        }
        field(30; "Ending Time"; DateTime)
        {
            Editable = false;
        }
        field(31; Quantity; Decimal)
        {
            Caption = 'Quantity';
            FieldClass = FlowField;
            CalcFormula = lookup("Assembly Header".Quantity where("No." = field("Assembly No.")));
            Editable = false;
        }
        field(32; "Item Category"; Code[50])
        {
            Caption = 'Item Category';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Item Category Code" where("No." = field("Item No.")));
            Editable = false;
        }
        field(33; "Sales Order Date"; Date)
        {
            Caption = 'Sales Order Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Order Date" where("No." = field("Source No.")));
            Editable = false;
        }
        field(34; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales line"."Requested Delivery Date" where("Document No." = field("Source No."), "Line No." = field("Source Line No.")));
            Editable = false;
        }
        field(35; "Item Size"; Code[50])
        {
            Caption = 'Item Size';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Line".Size where("Line No." = field("Source Line No."), "Document No." = field("Source No.")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Assembly No.")
        {
            Clustered = true;
        }
        Key(FK; "Current Sequence No.")
        {

        }
    }
}
