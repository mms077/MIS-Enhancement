page 50286 "Departments Wizard"
{
    Caption = 'Departments Wizard';
    PageType = NavigatePage;
    SourceTable = "Parameter Header Departments";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Department Code"; Rec."Department Code")
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
