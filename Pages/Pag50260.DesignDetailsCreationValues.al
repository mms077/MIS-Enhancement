page 50260 "Design Details Creation Values"
{
    Caption = 'Design Details Creation Values';
    PageType = Document;
    SourceTable = Design;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Design Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Sizes; "Design Details Sizes Values")
            {
                ApplicationArea = basic, suite;
                Caption = 'Sizes';
                SubPageLink = "Design Code" = field("Code");
                UpdatePropagation = Both;
            }
            part(Fits; "Design Details Fits Values")
            {
                ApplicationArea = basic, suite;
                Caption = 'Fits';
                SubPageLink = "Design Code" = field("Code");
                UpdatePropagation = Both;
            }
            part(SectionDetails; "Design Details Sections Values")
            {
                ApplicationArea = basic, suite;
                Caption = 'Sections';
                SubPageLink = "Design Code" = field("Code");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateCombination)
            {
                Caption = 'Create Combination';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    CreateDesignDetailsCombination;
                end;
            }
        }

    }
    procedure CreateDesignDetailsCombination()
    var
        DesignDetails: Record "Design Detail";
        DesignDetailsSizesValues: Record "Design Details Sizes Values";
        DesignDetailsFitsValues: Record "Design Details Fits Values";
        DesignDetailsSectionsValues: Record "Design Details Sections Values";
        LastDesignDetail: Record "Design Detail";
        LineNumber: Integer;
    begin
        DesignDetailsSizesValues.SetRange("Design Code", Rec.Code);
        if DesignDetailsSizesValues.FindSet() then
            //Sizes Loop
            repeat
                Clear(DesignDetailsFitsValues);
                DesignDetailsFitsValues.SetRange("Design Code", Rec.Code);
                if DesignDetailsFitsValues.FindSet() then
                    //Fits Loop
                    repeat
                        Clear(DesignDetailsSectionsValues);
                        DesignDetailsSectionsValues.SetRange("Design Code", Rec.Code);
                        //Sections Loop
                        if DesignDetailsSectionsValues.FindSet() then begin
                            if LineNumber <> 0 then
                                LineNumber := LineNumber
                            else
                                if LastDesignDetail.FindLast() then
                                    LineNumber := LastDesignDetail."Line No." + 1
                                else
                                    LineNumber := 1;
                            repeat
                                DesignDetails.Init();
                                DesignDetails."Design Code" := Rec.Code;
                                DesignDetails."Size Code" := DesignDetailsSizesValues."Size Code";
                                DesignDetails."Fit Code" := DesignDetailsFitsValues."Fit Code";
                                DesignDetails."Section Code" := DesignDetailsSectionsValues."Section Code";
                                DesignDetails."Design Section Code" := DesignDetailsSectionsValues."Design Section Code";
                                //DesignDetails."UOM Code" := DesignDetailsSectionsValues."UOM Code";
                                DesignDetails."Quantity" := DesignDetailsSectionsValues."Quantity";
                                DesignDetails."Line No." := LineNumber;
                                DesignDetails.Insert();
                                LineNumber := LineNumber + 1;
                            until DesignDetailsSectionsValues.Next() = 0;
                        end;
                    until DesignDetailsFitsValues.Next() = 0;
            until DesignDetailsSizesValues.Next() = 0;
        CurrPage.Close();
    end;
}
