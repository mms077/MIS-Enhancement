page 50268 "Design Section Param Lines Wiz"
{
    Caption = 'Item Design Section Colors';
    PageType = NavigatePage;
    SourceTable = "Design Section Param lines";
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Design Section Code"; Rec."Design Section Code")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Design Section Name"; Rec."Design Section Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Color ID"; Rec."Color ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = ColorEditable;
                    Lookup = true;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemDesignSectionColorPage: Page "Item Design Section Colors";
                        ItemDesignSectionColorRec: Record "Item Design Section Color";
                        DesignSectionParameterHeader: Record "Parameter Header";
                        ModifyAction: Option "Insert","Modify";
                        ManagementCU: Codeunit Management;
                    begin
                        Clear(ItemDesignSectionColorPage);
                        Clear(ItemDesignSectionColorRec);
                        Clear(DesignSectionParameterHeader);
                        DesignSectionParameterHeader.Get(Rec."Header ID");
                        ItemDesignSectionColorRec.SetRange("Item No.", DesignSectionParameterHeader."Item No.");
                        ItemDesignSectionColorRec.SetRange("Design Section Code", Rec."Design Section Code");
                        ItemDesignSectionColorRec.SetRange("Item Color ID", DesignSectionParameterHeader."Item Color ID");
                        if ItemDesignSectionColorRec.FindSet() then begin
                            ItemDesignSectionColorPage.SetTableView(ItemDesignSectionColorRec);
                            ItemDesignSectionColorPage.LookupMode(true);
                            if ItemDesignSectionColorPage.RunModal() = Action::LookupOK then begin
                                ItemDesignSectionColorPage.GetRecord(ItemDesignSectionColorRec);
                                Rec.Validate("Color ID", ItemDesignSectionColorRec."Color ID");
                                Rec.Validate("Tonality Code", ItemDesignSectionColorRec."Tonality Code");
                                Rec.Modify();
                                ManagementCU.CheckDesignSectionRawMaterial(Rec, DesignSectionParameterHeader, ModifyAction::Modify);
                            end;
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        CanContinue := true;
                        CheckIfCanNext();
                    end;
                }
                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Tonality Code"; Rec."Tonality Code")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Has Raw Material"; Rec."Has Raw Material")
                {
                    ApplicationArea = all;
                }
                field("Raw Material Code"; Rec."Raw Material Code")
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
                Enabled = CanContinue;
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
    var
        NextPressed: Boolean;
        BackPressed: Boolean;
        CanContinue: Boolean;
        DesignSectionParameterHeader: Record "Parameter Header";
        ColorEditable: Boolean;
        Enabled: Boolean;
        StyleExprTxt: Text[50];
        MyParameterHeaderId: Integer;
        ShowNonVariantControls: Boolean;

    trigger OnOpenPage()
    var
        ParameterHeaderLoc: Record "Parameter Header";
    begin
        ShowNonVariantControls := true;
        if ParameterHeaderLoc.Get(MyParameterHeaderId) then
            if ParameterHeaderLoc."Create Variant" then
                ShowNonVariantControls := false;
    end;

    trigger OnAfterGetCurrRecord()
    var
        ItemDesignSectionColor: Record "Item Design Section Color";
        ParameterHeader: Record "Parameter Header";
    begin
        Clear(ItemDesignSectionColor);
        Clear(ParameterHeader);
        ColorEditable := true;
        ParameterHeader.Get(Rec."Header ID");
        ItemDesignSectionColor.SetRange("Item No.", ParameterHeader."Item No.");
        ItemDesignSectionColor.SetRange("Design Section Code", Rec."Design Section Code");
        ItemDesignSectionColor.SetRange("Item Color ID", ParameterHeader."Item Color ID");
        if ItemDesignSectionColor.FindSet() then begin
            ItemDesignSectionColor.CalcFields("Design Section Color Count");
            if ItemDesignSectionColor."Design Section Color Count" = 1 then
                ColorEditable := false;
        end else
            //if the design section is not defined in item design section colors
            ColorEditable := false;

        CanContinue := true;
        CheckIfCanNext();
    end;

    trigger OnAfterGetRecord()
    var
        ItemDesignSectionColor: Record "Item Design Section Color";
        ParameterHeader: Record "Parameter Header";
    begin
        Clear(ItemDesignSectionColor);
        Clear(ParameterHeader);
        ColorEditable := true;
        ParameterHeader.Get(Rec."Header ID");
        ItemDesignSectionColor.SetRange("Item No.", ParameterHeader."Item No.");
        ItemDesignSectionColor.SetRange("Design Section Code", Rec."Design Section Code");
        ItemDesignSectionColor.SetRange("Item Color ID", ParameterHeader."Item Color ID");
        if ItemDesignSectionColor.FindSet() then begin
            ItemDesignSectionColor.CalcFields("Design Section Color Count");
            if ItemDesignSectionColor."Design Section Color Count" = 1 then
                StyleExprTxt := 'StrongAccent'
            else
                StyleExprTxt := '';
        end else
            //if the design section is not defined in item design section colors
            StyleExprTxt := 'StrongAccent';
    end;

    procedure CheckIfCanNext()
    var
        DesignSectionParamLines: Record "Design Section Param Lines";
    begin
        Clear(DesignSectionParamLines);
        DesignSectionParamLines.SetRange("Header ID", Rec."Header ID");
        if DesignSectionParamLines.FindSet() then
            repeat
                if DesignSectionParamLines."Color ID" = 0 then begin
                    CanContinue := false;
                    exit;
                end;
            until DesignSectionParamLines.Next() = 0;
    end;

    procedure Next(): Boolean
    begin
        exit(NextPressed);
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
