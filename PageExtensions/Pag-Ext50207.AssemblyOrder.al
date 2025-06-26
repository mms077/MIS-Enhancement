pageextension 50207 "Assembly Order" extends "Assembly Order"
{
    layout
    {
        addafter(Status)
        {
            field("Item Size"; Rec."Item Size")
            {
                ApplicationArea = all;
            }
            field("Item Fit"; Rec."Item Fit")
            {
                ApplicationArea = all;
            }
            field("Item Cut Code"; Rec."Item Cut Code")
            {
                ApplicationArea = all;
            }
            field("Item Color ID"; Rec."Item Color ID")
            {
                ApplicationArea = all;
            }
            field("Item Tonality Code"; Rec."Tonality Code")
            {
                ApplicationArea = all;
            }
            field("Workflow User Group Code"; Rec."Workflow User Group Code")
            {
                ApplicationArea = all;
            }
            field("Sequence No."; Rec."Sequence No.")
            {
                ApplicationArea = all;
            }
            field("Workflow Approver"; Rec."Workflow Approver")
            {
                ApplicationArea = all;
            }
            field("Total Sequences"; Rec."Total Sequences")
            {
                ApplicationArea = all;
            }
            field("Parameters Header ID"; Rec."Parameters Header ID")
            {
                ApplicationArea = all;
                Lookup = true;
                trigger OnDrillDown()
                var
                    ParamHeader: Record "Parameter Header";
                begin
                    ParamHeader.Get(Rec."Parameters Header ID");
                    Page.Run(Page::"Parameters Form", ParamHeader);
                end;
            }
            field("ER - Manufacturing Order No."; Rec."ER - Manufacturing Order No.")
            {
                ApplicationArea = all;
            }
            field("Qty To Package"; Rec."Qty To Package") { ApplicationArea = all; Editable = false; }
            field("Qty Packaged"; Rec."Qty Packaged") { ApplicationArea = all; Editable = false; }
        }

    }
    actions
    {
        addafter("P&osting")
        {
            group("Assembly Approval")
            {
                Caption = 'Assembly Approval';

                action("Approve")
                {
                    ApplicationArea = all;
                    Visible = ApproveVisible;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = Approve;
                    trigger OnAction()
                    begin
                        ApproveAssembly();
                    end;
                }
                action("Reject")
                {
                    ApplicationArea = all;
                    Visible = ApproveVisible;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = Reject;
                    trigger OnAction()
                    begin
                        RejectAssembly();
                    end;
                }
            }
        }
        modify(Release)
        {
            Visible = AllowDirectRelease;
        }
        modify("Re&open")
        {
            Visible = AllowDirectRelease;
        }
        modify("Re&lease")
        {
            Visible = AllowDirectRelease;
        }
        addafter(Print)
        {
            action("Cutting Sheet")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                trigger OnAction()
                var
                    AssemblHeader: Record "Assembly Header";
                begin
                    AssemblHeader.SetFilter("No.", Rec."No.");
                    Report.Run(Report::"ER - Manufacturing Order", true, true, AssemblHeader);
                end;
            }
            action("Create Dashboard")
            {
                ApplicationArea = all;
                Image = CreateDocument;
                Enabled = Rec."Assemble to Order" = false;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    CUManagement: Codeunit Management;
                    Txt001: Label 'Dashboard Created Successfully';
                begin
                    //Change Status Released
                    Rec.TestField(Status, Rec.Status::Released);
                    //Create Dashboard
                    CUManagement.CreateCuttingSheetDashboard(Rec, '');
                    //Create Parameter Header for the assembly
                    CUManagement.CreateParameterHeaderForAssembly(Rec);
                    Message(Txt001);
                end;
            }
            action("Dashboard")
            {
                ApplicationArea = all;
                Image = ShowChart;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Cutting Sheet Dashboard";
                RunPageLink = "Assembly No." = field("No.");
            }
            action("Scan")
            {
                ApplicationArea = all;
                Image = NumberGroup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                trigger OnAction()
                var
                    ScanCuttingSheet: Page "Scan Cutting Sheet";
                    AssemblyNo: Code[20];
                    UserName: Code[50];
                begin
                    ScanCuttingSheet.RunModal();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        VisibilityControl;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        VisibilityControl;
        //incrementpackagedqty on every
        FillQtyToPackageAndQtyPackaged;
    end;

    local procedure FillQtyToPackageAndQtyPackaged()
    var
        myInt: Integer;
        SalesRecSetup: Record "Sales & Receivables Setup";
        SalesLineUnitRef: Record "Sales Line Unit Ref.";
        SalesLine: Record "Sales Line";
    begin
        //update Packaging QTy
        SalesRecSetup.Get();
        if Rec.Quantity > 0 then begin
            Rec."Qty To Package" := Rec.Quantity;
            Rec.Modify();
        end;
        Clear(SalesLineUnitRef);
        SalesLine.SetFilter("Document No.", rec."Source No.");
        SalesLine.SetRange("Line No.", rec."Source Line No.");
        if SalesLine.FindFirst() then begin
            SalesLineUnitRef.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
            if SalesLineUnitRef.FindSet() then
                repeat
                    IF STRPOS(SalesLineUnitRef."Scan Out", SalesRecSetup."Packaging Stage") > 0 then begin
                        Rec."Qty Packaged" := Rec."Qty Packaged" + SalesLineUnitRef.Quantity;
                        Rec.Modify();
                    end;
                until SalesLineUnitRef.Next() = 0;
        end;
    end;

    procedure ApproveAssembly()
    begin
        Rec.TestField(Status, Rec.Status::Open);
        Rec.CalcFields("Total Sequences");
        //Approve and increase sequence by 1
        if Rec."Sequence No." < Rec."Total Sequences" then begin
            Rec."Sequence No." := Rec."Sequence No." + 1;
            Rec.Modify();
            Rec.CalcFields("Workflow Approver");
            //To change action visibility
            CurrPage.Close();
            Page.Run(Page::"Assembly Order", Rec);
        end else
            //Last Approver --> release
            if Rec."Sequence No." = Rec."Total Sequences" then begin
                Rec.validate(Status, Rec.Status::Released);
                Rec.Modify();
            end;
        Message('Approved Successfully');
    end;

    procedure RejectAssembly()
    begin
        Rec.CalcFields("Total Sequences");
        //Decrease sequence by 1
        if Rec."Sequence No." <> 1 then begin
            Rec."Sequence No." := Rec."Sequence No." - 1;
            Rec.Modify();
            Rec.CalcFields("Workflow Approver");
        end;
        Message('Rejected Successfully');
    end;

    procedure VisibilityControl()
    begin
        Rec.CalcFields("Workflow Approver", "Total Sequences");
        if Rec."Workflow Approver" = UserId then
            ApproveVisible := true
        else
            ApproveVisible := false;

        //Hide Release and Open Action if there is workflow
        if Rec."Workflow User Group Code" = '' then
            AllowDirectRelease := true
        else
            AllowDirectRelease := false;
    end;

    var
        [InDataSet]
        ApproveVisible, AllowDirectRelease : Boolean;
      

}