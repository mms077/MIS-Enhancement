page 50269 "Needed RM"
{
    Caption = 'Needed Raw Materials';
    PageType = NavigatePage;
    SourceTable = "Needed Raw Material";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("RM Code"; Rec."RM Code")
                {
                    ApplicationArea = All;
                }
                field("Raw Material Name"; Rec."Raw Material Name")
                {
                    ApplicationArea = all;
                }
                field("RM Variant Code"; Rec."RM Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Raw Material Category"; Rec."Raw Material Category")
                {
                    ApplicationArea = All;
                }
                field("Color ID"; Rec."Color ID")
                {
                    ApplicationArea = All;
                }
                field("Tonality Code"; Rec."Tonality Code")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Line No."; Rec."Design Detail Line No.")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Design Code"; Rec."Design Detail Design Code")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Design Section Code"; Rec."Design Detail Design Sec. Code")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Size Code"; Rec."Design Detail Size Code")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Fit Code"; Rec."Design Detail Fit Code")
                {
                    ApplicationArea = All;
                }
                field("Section"; Rec."Design Detail Section Code")
                {
                    ApplicationArea = All;
                }
                field("Design Section"; Rec."Design Detail Design Sec. Code")
                {
                    ApplicationArea = All;
                }
                field("Design Detail UOM Code"; Rec."Design Detail UOM Code")
                {
                    ApplicationArea = All;
                }
                field("Design Detail Quantity"; Rec."Design Detail Quantity")
                {
                    ApplicationArea = All;
                }
                field("Sales Line Quantity"; Rec."Sales Line Quantity")
                {
                    ApplicationArea = All;
                }
                field("Sales Line Item No."; Rec."Sales Line Item No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Line Location Code"; Rec."Sales Line Location Code")
                {
                    ApplicationArea = All;
                }
                field("Sales Line UOM Code"; Rec."Sales Line UOM Code")
                {
                    ApplicationArea = All;
                }
                field("Assembly Order No."; Rec."Assembly Order No.")
                {
                    ApplicationArea = All;
                }
                field("Assembly Order Line No."; Rec."Assembly Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order Line No."; Rec."Sales Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Assembly Line Quantity"; Rec."Assembly Line Quantity")
                {
                    ApplicationArea = All;
                }
                field("Assembly Line UOM Code"; Rec."Assembly Line UOM Code")
                {
                    ApplicationArea = All;
                }
                field(Batch; Rec.Batch)
                {
                    ApplicationArea = All;
                }
                field("Paramertes Header ID"; Rec."Paramertes Header ID")
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
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
                //Enabled = CanFinish;
                Image = Approve;
                InFooterBar = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    FinishPressed := true;
                    CurrPage.Close();
                end;
            }
        }
    }
    var
        BatchGlobal: Integer;
        FinishPressed: Boolean;
        BackPressed: Boolean;
        CanFinish: Boolean;
        DesignSectionParameterHeader: Record "Parameter Header";

    trigger OnOpenPage()
    begin
    end;

    procedure Finish(): Boolean
    begin
        exit(FinishPressed);
    end;

    procedure Back(): Boolean
    begin
        exit(BackPressed);
    end;

    procedure SetParameter(DesignSecParamHeader: Record "Parameter Header")
    begin
        DesignSectionParameterHeader.Get(DesignSecParamHeader.ID);
    end;
}
