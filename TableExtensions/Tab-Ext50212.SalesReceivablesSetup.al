tableextension 50212 "Sales & Receivables Setup - ER" extends "Sales & Receivables Setup"
{
    fields
    {
        /*field(50300; "Branding Category Code"; Code[50])
        {
            Caption = 'Branding Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "Branding Category".Code;
        }*/
        field(50301; "Cutting Sheet Workflow Group"; Code[20])
        {
            Caption = 'Cutting Sheet Workflow Group';
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group-ER".Code;
        }
        field(50302; "Scan In/Out Interval"; Decimal)
        {
            Caption = 'Scan In/Out Interval Minutes';
        }
        field(50303; "Wizard Default Location"; Code[50])
        {
            TableRelation = Location.Code;
        }
        field(50304; Picture; MediaSet)
        {
            Caption = 'Picture';
        }
        /*field(50305; "Keep Sales Quote"; Boolean)
        {

        }*/
        field(50306; "Look Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50307; "Look Version Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50308; "Item Look Version Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(50309; "Scanning Workflow Group"; Code[20])
        {
            Caption = 'Scanning Workflow Group';
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group scan".Code;
        }
        field(50310; "Packaging Stage"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Scan Design Stages- ER"."Activity Code";
        }
    }
}
