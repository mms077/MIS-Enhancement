table 50284 "ER - Manufacturing Order"
{
    Caption = 'ER - Manufacturing Order';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "No. Of Copies"; Integer)
        {
            Caption = 'No. Of Copies';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Assembly Count"; Integer)
        {
            Caption = 'Assembly Count';
            FieldClass = FlowField;
            CalcFormula = count("Assembly Header" where("ER - Manufacturing Order No." = field("No.")));
            Editable = false;
        }
        field(4; Status; Option)
        {
            OptionMembers = "Open","Closed";
            Editable = false;
        }
        field(5; "Current Sequence No."; Integer)
        {
            Editable = false;
            /*FieldClass = FlowField;
            CalcFormula = lookup("Cutting Sheets Dashboard"."Current Sequence No." where("ER - Manufacturing Order No." = field("No.")));*/
        }
        field(7; "Item No."; Code[20])
        {
            Editable = false;
            /*FieldClass = FlowField;
            CalcFormula = lookup("Cutting Sheets Dashboard"."Item No." where("ER - Manufacturing Order No." = field("No.")));*/
        }
        field(8; "Item Description"; Text[100])
        {
            Editable = false;
            /*FieldClass = FlowField;
            CalcFormula = lookup(item.Description where("No." = field("Item No.")));*/
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    begin
        CheckDeleteMOPermission();
        ClearRelatedAssembly();
    end;

    procedure CheckDeleteMOPermission()
    var
        UserSetup: Record "User Setup";
    begin
        Clear(UserSetup);
        UserSetup.Get(UserId);
        UserSetup.TestField("Delete MO");
    end;

    procedure ClearRelatedAssembly()
    var
        AssemblyHeader: Record "Assembly Header";
    begin
        Clear(AssemblyHeader);
        AssemblyHeader.SetRange("ER - Manufacturing Order No.", Rec."No.");
        if AssemblyHeader.FindSet() then
            AssemblyHeader.ModifyAll("ER - Manufacturing Order No.", '', true);
    end;
}
