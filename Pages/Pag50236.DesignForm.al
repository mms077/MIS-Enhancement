page 50236 "Design Form"
{
    Caption = 'Design';
    PageType = Document;
    SourceTable = Design;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                Caption = 'General';
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
            }


            part(DesignDetails; "Design Subform")
            {
                ApplicationArea = basic, suite;
                SubPageLink = "Design Code" = field("Code");
                UpdatePropagation = Both;
            }
            part(DesignMeasurement; "Design Measurement Subform")
            {
                ApplicationArea = basic, suite;
                SubPageLink = "Design Code" = field("Code");
                UpdatePropagation = Both;
            }

        }
        area(factboxes)
        {
            part(ItemPicture; "Design Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Code" = FIELD("Code");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50213),
                              "No." = FIELD(Code);
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = true;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Design Details Combination")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    DesignDetail: Record "Design Detail";
                    Txt001: Label 'The design details must be empty';
                begin
                    //Prevent creation if there is any record in the details
                    DesignDetail.SetRange("Design Code", Rec.Code);
                    if DesignDetail.FindFirst() then
                        Error(Txt001)
                    else
                        Page.Run(50260, Rec);
                end;
            }
            action("Fill Measurement")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                begin
                    FillMeasurementsCombination;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        Section: Record Section;
        DesignDetail: Record "Design Detail";
    begin
        //FillMeasurementsCombination;
        //Sorting By Size Fit and Section Number
        /*DesignDetail.SetRange("Design Code", Rec."Code");
        if DesignDetail.FindFirst() then begin
            repeat
                if Section.Get(DesignDetail."Section Code") then begin
                    DesignDetail."Section Number" := Section.Number;
                    DesignDetail.Modify();
                end;
            until DesignDetail.Next() = 0;
        end;*/
    end;



    procedure FillMeasurementsCombination()
    var
        DesignDetail: Record "Design Detail";
        DesignDetailBuffer: Record "Design Detail" temporary;
        DesignMeasurement: Record "Design Measurement";
        PreviousSizeCode: Code[10];
        PreviousFitCode: Code[10];
        lineNumber: Integer;
        LastLineNumber: Integer;
        LastDesignMeasurement: Record "Design Measurement";
    begin
        Clear(LastDesignMeasurement);
        if LastDesignMeasurement.FindLast() then
            LastLineNumber := LastDesignMeasurement."Line No." + 1
        else
            LastLineNumber := 1;
        //Fill the buffer with unique fit size combination
        Clear(DesignDetail);
        DesignDetail.SetCurrentKey("Size Code");
        DesignDetail.SetRange("Design Code", Rec.Code);
        if DesignDetail.FindFirst() then begin
            repeat
                if (DesignDetail."Size Code" <> PreviousSizeCode)
                OR (DesignDetail."Fit Code" <> PreviousFitCode) then begin
                    lineNumber := lineNumber + 10000;
                    DesignDetailBuffer.Init();
                    DesignDetailBuffer."Line No." := lineNumber;
                    DesignDetailBuffer."Fit Code" := DesignDetail."Fit Code";
                    DesignDetailBuffer."Size Code" := DesignDetail."Size Code";
                    DesignDetailBuffer.Insert();
                    PreviousFitCode := DesignDetail."Fit Code";
                    PreviousSizeCode := DesignDetail."Size Code";
                end;
            until DesignDetail.Next() = 0;
            //fill the design Measurement base on the buffer
            if DesignDetailBuffer.FindSet() then
                repeat
                    //Check if the Design Measurement line is not existing
                    Clear(DesignMeasurement);
                    DesignMeasurement.SetRange("Design Code", Rec.Code);
                    DesignMeasurement.SetRange("Size Code", DesignDetailBuffer."Size Code");
                    DesignMeasurement.SetRange("Fit Code", DesignDetailBuffer."Fit Code");
                    if not DesignMeasurement.FindSet() then begin
                        DesignMeasurement.Init();
                        DesignMeasurement."Line No." := LastLineNumber;
                        DesignMeasurement."Design Code" := Rec.Code;
                        DesignMeasurement."Size Code" := DesignDetailBuffer."Size Code";
                        DesignMeasurement."Fit Code" := DesignDetailBuffer."Fit Code";
                        DesignMeasurement.Insert(true);
                        LastLineNumber := LastLineNumber + 1;
                    end;
                until DesignDetailBuffer.Next() = 0;
        end;
    end;
}