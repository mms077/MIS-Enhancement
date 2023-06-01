page 50289 "Staff Wizard"
{
    Caption = 'Staff Wizard';
    PageType = NavigatePage;
    SourceTable = "Parameter Header Staff";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Staff Code"; Rec."Staff Code")
                {
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                }
                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = All;
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
            action(Continueaction)
            {
                Caption = 'Next';
                //Enabled = CanContinue;
                Image = NextRecord;
                InFooterBar = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    /*DoStep(CurrentStep + 1);
                    CurrPage.UPDATE;*/
                    ContinuePressed := true;
                    CurrPage.Close();
                end;
            }
            action(Backaction)
            {
                Caption = 'Back';
                //Enabled = CanContinue;
                Image = PreviousRecord;
                InFooterBar = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    /*DoStep(CurrentStep + 1);
                    CurrPage.UPDATE;*/
                    BackPressed := true;
                    CurrPage.Close();
                end;
            }
        }
    }
    var

        ItemColorPage: Page "Item Colors";
        ItemDesignSecFabricPage: Page "Item Design Section RM";
        ItemSizePage: Page "Item Sizes";
        ItemFitPage: Page "Item Fits";
        ItemColorRec: Record "Item Color";
        ItemSizeRec: Record "Item Size";
        ItemFitRec: Record "Item Fit";
        ContinuePressed: Boolean;
        BackPressed: Boolean;
        MyParameterHeaderId: Integer;
        //CanContinue: Boolean;
        ShowNonVariantControls: Boolean;

    trigger OnOpenPage()
    var
        ParameterHeaderLoc: Record "Parameter Header";
    begin
        ContinuePressed := false;

        ShowNonVariantControls := true;
        if ParameterHeaderLoc.Get(MyParameterHeaderId) then
            if ParameterHeaderLoc."Create Variant" then
                ShowNonVariantControls := false;
    end;

    procedure Continue(): Boolean
    begin
        exit(ContinuePressed);
    end;

    procedure Back(): Boolean
    begin
        exit(BackPressed);
    end;

    procedure SetParameterHeaderID(ParameterHeaderID: Integer)
    begin
        MyParameterHeaderId := ParameterHeaderID;
    end;
}
