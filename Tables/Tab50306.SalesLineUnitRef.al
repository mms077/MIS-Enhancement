table 50306 "Sales Line Unit Ref."
{
    Caption = 'Sales Line Unit Ref.';
    DataPerCompany = false;

    fields
    {
        field(1; "Sales Line Ref."; Guid)
        {
            Caption = 'Sales Line Ref.';
            TableRelation = "Sales Line".SystemId;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = item."No.";
        }
        field(3; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
        }
        field(4; "Sales Line Unit"; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(6; "Variant Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code;
        }
        field(7; "Unit of Measure Code"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }
    }

    keys
    {
        key(PK; "Sales Line Unit") // Primary key based on Design Code and Activity Name
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        WorkflowActivitiesER: Record "Workflow Activities - ER";

    begin
        // // Ensure that the combination of Design Code and Activity Name is unique
        // if Rec.Get(Rec."Design Code", Rec."Activity Name") then
        //     Error('The combination of Design Code "%1" and Activity Name "%2" already exists.', Rec."Design Code", Rec."Activity Name");


    end;
}