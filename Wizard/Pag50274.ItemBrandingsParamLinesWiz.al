page 50274 "Item Brandings Param Lines Wiz"
{
    Caption = 'Item Brandings';
    PageType = NavigatePage;
    SourceTable = "Item Branding Param lines";
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                /*field("Color Id"; Rec."Color Id")
                {
                    ApplicationArea = all;
                }*/
                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = all;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = all;
                }
                field(Include; Rec.Include)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SaveAndClose)
            {
                Caption = 'Save And Close';
                InFooterBar = true;
                ApplicationArea = all;
                Visible = ShowNonVariantControls;
                trigger OnAction()
                var
                    CUManagement: Codeunit Management;
                    ParameterHeader: Record "Parameter Header";
                begin
                    Clear(ParameterHeader);
                    ParameterHeader.Get(Rec."Header Id");
                    CUManagement.UpdateAndClose(ParameterHeader);
                    CurrPage.Close();
                end;
            }
            action(Backaction)
            {
                Caption = 'Back';
                //Enabled = BackEnable;
                Image = PreviousRecord;
                InFooterBar = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    BackPressed := true;
                    CurrPage.Close();
                end;
            }
            action(FinishAction)
            {
                Caption = 'Finish';
                //Visible = ShowNonVariantControls;
                Image = Approve;
                InFooterBar = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    Answer: Boolean;
                begin
                    Answer := true;
                    if not AnyBrandingSelected() then
                        Answer := Dialog.Confirm('Do you want to proceed without selecting any Branding?', true);
                    if Answer = true then begin
                        FinishPressed := true;
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        ParameterHeaderLoc: Record "Parameter Header";
    begin
        ShowNonVariantControls := true;
        if ParameterHeaderLoc.Get(MyParameterHeaderId) then
            if ParameterHeaderLoc."Create Variant" then
                ShowNonVariantControls := false;
    end;

    procedure SetParameterHeaderID(ParameterHeaderID: Integer)
    begin
        MyParameterHeaderId := ParameterHeaderID;
    end;

    procedure AnyBrandingSelected(): Boolean
    var
        ItemBrandingParLines: Record "Item Branding Param Lines";
        Txt001: Label 'At least one branding should be selected';
    begin
        Clear(ItemBrandingParLines);
        ItemBrandingParLines.SetRange("Header ID", Rec."Header ID");
        if ItemBrandingParLines.FindSet() then begin
            ItemBrandingParLines.SetRange(Include, true);
            if ItemBrandingParLines.IsEmpty then
                exit(false)
        end;
        exit(true)
    end;

    var
        FinishPressed: Boolean;
        BackPressed: Boolean;
        CanContinue: Boolean;
        DesignSectionParameterHeader: Record "Parameter Header";
        EditColor: Boolean;
        ShowNonVariantControls: Boolean;
        MyParameterHeaderId: Integer;

    procedure Finish(): Boolean
    begin
        exit(FinishPressed);
    end;

    procedure Back(): Boolean
    begin
        exit(BackPressed);
    end;
}
