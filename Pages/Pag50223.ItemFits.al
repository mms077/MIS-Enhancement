page 50223 "Item Fits"
{
    ApplicationArea = All;
    Caption = 'Item Fits';
    PageType = List;
    SourceTable = "Item Fit";
    UsageCategory = Lists;
    DelayedInsert = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }*/
                field("Fit Code"; Rec."Fit Code")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Item: Record Item;
                        DesignDetail: Record "Design Detail";
                        FitFilter: Text[2048];
                        PreviousFit: Code[100];
                        FitPage: Page Fits;
                        FitRec: Record "Fit";
                    begin
                        Clear(FitFilter);
                        Clear(PreviousFit);
                        if Item.Get(Rec."Item No.") then begin
                            Clear(DesignDetail);
                            DesignDetail.SetCurrentKey("Fit Code");
                            DesignDetail.SetRange("Design Code", Item."Design Code");
                            if DesignDetail.FindSet() then begin
                                repeat
                                    if PreviousFit <> DesignDetail."Fit Code" then begin
                                        FitFilter := FitFilter + DesignDetail."Fit Code" + '|';
                                    end;
                                    PreviousFit := DesignDetail."Fit Code";
                                until DesignDetail.Next() = 0;
                                Clear(FitRec);
                                FitFilter := DELCHR("FitFilter", '>', '|');
                                FitRec.SetFilter("Code", FitFilter);
                                if FitRec.FindSet() then begin
                                    FitPage.SetTableView(FitRec);
                                    FitPage.LookupMode(true);
                                    if FitPage.RunModal() = Action::LookupOK then begin
                                        FitPage.GetRecord(FitRec);
                                        Rec.Validate("Fit Code", FitRec."Code");
                                    end;
                                end;
                            end;
                        end;
                    end;
                }
                field("Fit Name"; Rec."Fit Name")
                {
                    ApplicationArea = all;
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
