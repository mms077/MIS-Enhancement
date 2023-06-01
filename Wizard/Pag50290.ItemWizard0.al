page 50290 "Item Wizard 0"
{
    Caption = 'Item Wizard';
    PageType = NavigatePage;
    SourceTable = "Parameter Header";
    layout
    {
        area(content)
        {
            group("Item Wizard")
            {
                Caption = 'General';

                field(ItemNo; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item No.';
                    Lookup = true;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemPage: Page "Item List";
                        ItemRec: Record Item;
                    begin
                        Clear(ItemPage);
                        Clear(ItemRec);
                        ItemRec.SetFilter("Design Code", '<>''''');
                        if ItemRec.FindSet() then begin
                            ItemPage.SetTableView(ItemRec);
                            //ItemColorPage.Editable(true);
                            ItemPage.LookupMode(true);
                            if ItemPage.RunModal() = Action::LookupOK then begin
                                ItemPage.GetRecord(ItemRec);
                                Rec.Validate("Item No.", ItemRec."No.");
                                CheckCanContinue;
                                Rec.CalcFields("Item Description");
                            end;
                        end;
                    end;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = all;
                }
                field(ColorID; Rec."Item Color ID")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                    Lookup = true;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Clear(ItemColorPage);
                        Clear(ItemColorRec);
                        ItemColorRec.SetRange("Item No.", Rec."Item No.");
                        if ItemColorRec.FindSet() then begin
                            ItemColorPage.SetTableView(ItemColorRec);
                            //ItemColorPage.Editable(true);
                            ItemColorPage.LookupMode(true);
                            if ItemColorPage.RunModal() = Action::LookupOK then begin
                                ItemColorPage.GetRecord(ItemColorRec);
                                Rec.Validate("Item Color ID", ItemColorRec."Color ID");
                                Rec.Validate("Tonality Code", ItemColorRec."Tonality Code");
                                CheckCanContinue;
                                Rec.CalcFields("Item Color Name");
                            end;
                        end;
                    end;
                }
                field("Item Color Name"; Rec."Item Color Name")
                {
                    ApplicationArea = all;
                }
                field("Tonality Code"; Rec."Tonality Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("UOM"; Rec."Sales Line UOM")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CheckCanContinue;
                    end;
                }
                field("Sales Line Location Code"; Rec."Sales Line Location Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CheckCanContinue;
                    end;
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
                Enabled = CanContinue;
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
        CanContinue: Boolean;
        MyParameterHeaderId: Integer;
        ShowNonVariantControls: Boolean;

    trigger OnOpenPage()
    var
        ParameterHeaderLoc: Record "Parameter Header";
    begin
        ContinuePressed := false;
        CheckCanContinue;
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

    procedure CheckCanContinue()
    begin
        CanContinue := (Rec."Item Color ID" <> 0) and (Rec."Item No." <> '') and (Rec."Tonality Code" <> '') and (Rec."Sales Line UOM" <> '') and (Rec."Sales Line Location Code" <> '');
    end;

    procedure SetParameterHeaderID(ParameterHeaderID: Integer)
    begin
        MyParameterHeaderId := ParameterHeaderID;
    end;
}
