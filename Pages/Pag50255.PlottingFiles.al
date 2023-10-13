page 50255 "Plotting Files"
{
    ApplicationArea = All;
    Caption = 'Plotting Files';
    PageType = List;
    SourceTable = "Plotting File";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Design Code"; Rec."Design Code")
                {
                    ApplicationArea = all;
                }
                field(Size; Rec.Size)
                {
                    ApplicationArea = all;
                }
                field(Fit; Rec.Fit)
                {
                    ApplicationArea = all;
                }
                field(Cut; Rec.Cut)
                {
                    Caption = 'Cut';
                    ApplicationArea = All;
                }
                /*field(Width; Rec.Width)
                {
                    Caption = 'Fabric Width';
                    ApplicationArea = All;
                }*/
                field("Item Features Set"; Rec."Item Features Set")
                {
                    ApplicationArea = all;
                }
                field("Has Picture"; Rec."Has Picture")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
        area(FactBoxes)
        {
            part(PlottingPictureFactBox; "Plotting File FactBox")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "ID" = field("ID");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50246),
                              "Line No." = FIELD(id);
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
            action("Measurements")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Plotting File Measurements";
                RunPageLink = "Plotting File ID" = field("ID");
                trigger OnAction()
                var
                begin
                    //CreatePlottingFilesMeasurement()
                end;
            }
        }
    }
    /*procedure CreatePlottingFilesMeasurement()
    var
        DesignDetail: Record "Design Detail";
        DesignPloting: Record "Design Plotting";
        PlottingFileMeasurement: Record "Plotting File Measurement";
    begin
        CheckIfAnyRecToDelete();
        Clear(DesignDetail);
        Clear(DesignPloting);
        DesignPloting.SetRange(ID, Rec."Design Plotting ID");
        DesignPloting.FindFirst();
        DesignDetail.SetRange("Design Code", DesignPloting."Design Code");
        DesignDetail.SetRange("Section Composition", DesignDetail."Section Composition"::Fabrics);
        DesignDetail.SetRange("Size Code", DesignPloting.Size);
        DesignDetail.SetRange("Fit Code", DesignPloting.Fit);
        if DesignDetail.FindSet() then
            repeat
                PlottingFileMeasurement.Init();
                PlottingFileMeasurement."Plotting File ID" := Rec."ID";
                PlottingFileMeasurement."Section" := DesignDetail."Section Code";
                PlottingFileMeasurement."Section Group" := DesignDetail."Section Group";
                PlottingFileMeasurement.Cut := Rec.Cut;
                //PlottingFileMeasurement.Width := Rec.Width;
                if PlottingFileMeasurement.Insert() then;
            until DesignDetail.Next() = 0;
    end;*/

    procedure CheckIfAnyRecToDelete()
    var
        DesignDetail: Record "Design Detail";
        DesignPloting: Record "Design Plotting";
        PlottingFileMeasurement: Record "Plotting File Measurement";
    begin
        Clear(DesignPloting);
        DesignPloting.SetRange(ID, Rec."Design Plotting ID");
        DesignPloting.FindFirst();
        Clear(PlottingFileMeasurement);
        PlottingFileMeasurement.SetRange("Plotting File ID", Rec."ID");
        //PlottingFileMeasurement.SetRange(Width, Rec.Width);
        PlottingFileMeasurement.SetRange(Cut, Rec.Cut);
        if PlottingFileMeasurement.FindSet() then
            repeat
                Clear(DesignDetail);
                DesignDetail.SetRange("Design Code", DesignPloting."Design Code");
                DesignDetail.SetRange("Section Composition", DesignDetail."Section Composition"::Fabrics);
                DesignDetail.SetRange("Size Code", DesignPloting.Size);
                DesignDetail.SetRange("Fit Code", DesignPloting.Fit);
                DesignDetail.SetRange("Section Code", PlottingFileMeasurement.Section);
                DesignDetail.SetRange("Section Group", PlottingFileMeasurement."Section Group");
                if not DesignDetail.FindFirst() then
                    PlottingFileMeasurement.Delete(true);
            until PlottingFileMeasurement.Next() = 0;
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec.Picture.Count = 0 then
            Rec."Has Picture" := false
        else
            Rec."Has Picture" := true;
        Rec.Modify();
    end;
}