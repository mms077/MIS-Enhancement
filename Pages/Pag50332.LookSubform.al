page 50332 "Look Subform"
{
    Caption = 'Look Details';
    PageType = ListPart;
    SourceTable = "Look Detail";
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Look Code"; Rec."Look Code")
                {
                    ApplicationArea = All;
                    Caption = 'Look Code';
                    Editable = false;
                }
                field(Category; Rec.Category) { ApplicationArea = all; }
                field(Type; Rec.Type) { ApplicationArea = all; }
                field(Design; rec.Design) { ApplicationArea = all; }

            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Create Design")
            {
                Caption = 'Create Design';
                Image = Design;
                ToolTip = 'Create Design';
                ApplicationArea = All;
                Enabled = EnableCreateDesign;
                trigger OnAction()
                var
                    Design: Record Design;
                    Look: Record Look;
                    Text001: Label 'Skeleton Design for ';
                begin
                    if rec.Design = '' then begin
                        Rec.TestField(Type);
                        Rec.TestField(Category);
                        Look.SetFilter(Code, Rec."Look Code");
                        if Look.FindFirst() then;

                        Design.Init();
                        //Check Look Gender
                        if Look.Gender <> Look.Gender::" " then begin
                            if Look.Gender = Look.Gender::Female then
                                Design.Code := Rec."Look Code" + '-' + Rec.Category + '-' + 'F'
                            else
                                if Look.Gender = Look.Gender::Male then
                                    Design.Code := Rec."Look Code" + '-' + Rec.Category + '-' + 'M'
                                else
                                    if Look.Gender = Look.Gender::Unisex then
                                        Design.Code := Rec."Look Code" + '-' + Rec.Category + '-' + 'U';
                        end
                        else //if look Gender empty
                            Design.Code := Rec."Look Code" + '-' + Rec.Category + '-';

                        Design.Name := Text001 + Rec."Look Code" + '-' + Rec.Category + '-' + Format(Look.Gender);
                        Design.Category := Rec.Category;
                        Design.Type := Rec.Type;
                        Design.Gender := Look.Gender;
                        Rec.Design := Design.Code;
                        Design.Insert(true);
                        Message('Design Created Successfully');

                    end else
                        Error('The design value already assigned');
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        EnableCreateDesign := true;
        if Rec.Design <> '' then
            EnableCreateDesign := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin

    end;

    var
        EnableCreateDesign: Boolean;
}
