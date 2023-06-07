pageextension 50218 "Item List" extends "Item List"
{
    layout
    {
        addafter("Default Deferral Template Code")
        {
            field("Hs Code"; Rec."Hs Code")
            {
                ApplicationArea = all;
            }
            field("Created By"; UserCreater)
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Created By';
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = all;
                Caption = 'Created At';
            }
            field("Modified By"; UserModifier)
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Modified By';
            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                ApplicationArea = all;
                Caption = 'Modified At';
            }
        }
        modify("Unit Cost")
        {
            Visible = CostVisible;
        }
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter(CopyItem)
        {
            action("Create Variant")
            {
                ApplicationArea = All;
                Image = VariableList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    Management: Codeunit Management;
                    State: Option "Start","Departments","Positions","Staff","Staff Sizes","Header Parameters 0","Header Parameters","Qty Assignment","Lines Parameters","Features Parameters","Branding Parameters";
                    SalesHeader: Record "Sales Header";
                    Process: Option "Old Way","Assignment","Just Create Variant";
                    SalesLine: Record "Sales Line";
                    ActionName:Option "Create Line","Load Line","Refresh Line";
                begin
                    Management.RunTheProcess(ActionName::"Create Line",State::Start, SalesHeader, Process::"Just Create Variant", SalesLine, '')
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        MasterItemCodeunit: Codeunit MasterItem;
    begin
        if MasterItemCodeunit.AllowShowSalesPrice() then
            CostVisible := true
        else
            CostVisible := false;
    end;

    trigger OnAfterGetRecord()
    begin
        if User.Get(Rec.SystemCreatedBy) then
            UserCreater := User."User Name";
        if User2.Get(Rec.SystemModifiedBy) then
            UserModifier := User2."User Name";
    end;

    var
        User: Record User;
        User2: Record User;
        UserCreater: Code[50];
        UserModifier: Code[50];
        CostVisible: Boolean;
}