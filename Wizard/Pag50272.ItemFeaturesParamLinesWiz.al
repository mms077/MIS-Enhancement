page 50272 "Item Features Param Lines Wiz"
{
    Caption = 'Item Features';
    PageType = NavigatePage;
    SourceTable = "Item Features Param lines";
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Design Section Code"; Rec."Feature Name")
                {
                    ApplicationArea = All;
                }
                field("Value"; Rec."Value")
                {
                    StyleExpr = StyleExprTxt;
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemFeaturePossibleValuePage: Page "Item Feature Possible Values";
                        ItemFeaturePossibleValueRec: Record "Item Feature Possible Values";
                    begin
                        Clear(ItemFeaturePossibleValuePage);
                        Clear(ItemFeaturePossibleValueRec);
                        ItemFeaturePossibleValueRec.SetRange("Feature Name", Rec."Feature Name");
                        if ItemFeaturePossibleValueRec.FindSet() then begin
                            ItemFeaturePossibleValuePage.SetTableView(ItemFeaturePossibleValueRec);
                            ItemFeaturePossibleValuePage.LookupMode(true);
                            if ItemFeaturePossibleValuePage.RunModal() = Action::LookupOK then begin
                                ItemFeaturePossibleValuePage.GetRecord(ItemFeaturePossibleValueRec);
                                Rec.Validate(Value, ItemFeaturePossibleValueRec."Possible Value");
                                CheckStyleExpr;
                            end;
                        end;
                    end;
                }
                field("Has Color"; Rec."Has Color")
                {
                    ApplicationArea = all;
                }
                field("Color ID"; Rec."Color Id")
                {
                    ApplicationArea = All;
                    Editable = EditColor;
                }
                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = all;
                }
                field(Instructions; Rec.Instructions)
                {
                    ApplicationArea = all;
                    //Editable = EditInstructions;
                }
                field(Cost; Rec.Cost)
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
            action(NextAction)
            {
                Caption = 'Next';
                //Enabled = CanFinish;
                Image = Approve;
                InFooterBar = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    NextPressed := true;
                    CurrPage.Close();
                end;
            }
        }
    }
    /*trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        CUManagement: Codeunit Management;
        ParameterHeader: Record "Parameter Header";
    begin
        Clear(ParameterHeader);
        ParameterHeader.Get(Rec."Header Id");
        CUManagement.UpdateAndClose(ParameterHeader);
    end;*/

    var
        NextPressed, BackPressed, CanContinue : Boolean;
        DesignSectionParameterHeader: Record "Parameter Header";
        EditColor, EditValue, EditInstructions : Boolean;
        StyleExprTxt: Text[100];
        MyParameterHeaderId: Integer;
        ShowNonVariantControls: Boolean;


    trigger OnOpenPage()
    var
        ParameterHeaderLoc: Record "Parameter Header";
    begin
        EditColor := false;
        EditValue := false;
        ShowNonVariantControls := true;
        if ParameterHeaderLoc.Get(MyParameterHeaderId) then
            if ParameterHeaderLoc."Create Variant" then
                ShowNonVariantControls := false;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CheckEditable;
        CheckStyleExpr;
    end;

    trigger OnAfterGetRecord()
    var
    begin
        CheckStyleExpr();
    end;

    procedure Next(): Boolean
    begin
        exit(NextPressed);
    end;

    procedure Back(): Boolean
    begin
        exit(BackPressed);
    end;

    procedure CheckEditable()
    begin
        if Rec."Has Color" then
            EditColor := true
        else
            EditColor := false;

        /*if Rec.Value = '' then
            EditValue := true
        else
            EditValue := false;*/

        /*if Rec.Instructions = '' then
            EditInstructions := true
        else
            EditInstructions := false;*/
    end;

    procedure CheckStyleExpr()
    var
        ItemFeaturePossibleValue: Record "Item Feature Possible Values";
    begin
        StyleExprTxt := '';
        Clear(ItemFeaturePossibleValue);
        ItemFeaturePossibleValue.SetRange("Feature Name", Rec."Feature Name");
        ItemFeaturePossibleValue.SetRange("Possible Value", Rec."Value");
        if ItemFeaturePossibleValue.FindFirst() then
            if ItemFeaturePossibleValue.Default then
                StyleExprTxt := 'StrongAccent';
        if Not ItemFeaturePossibleValue."Has Color" then begin
            EditColor := false;
            Rec."Color Id" := 193;
            Rec."Has Color" := false;
            Rec.CalcFields("Color Name");
            Rec.Modify();
        end else begin
            EditColor := true;
            Rec."Has Color" := true;
            Rec.CalcFields("Color Name");
            Rec.Modify();
        end;
    end;

    procedure SetParameterHeaderID(ParameterHeaderID: Integer)
    begin
        MyParameterHeaderId := ParameterHeaderID;
    end;
}
