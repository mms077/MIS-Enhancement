page 50337 "Item Look Version"
{
    ApplicationArea = All;
    Caption = 'Item Look Version';
    PageType = List;
    SourceTable = "Item Version";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.") { ApplicationArea = all; }
                field(Category; rec.Category) { ApplicationArea = all; Editable = false; }
                field(Type; rec.Type) { ApplicationArea = all; Editable = false; }
                field(Design; rec.Design) { ApplicationArea = all; Editable = false; }
                field("Item Description"; rec."Item Description") { ApplicationArea = all; }
            }

        }
        area(factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

            action("Create New Item")
            {
                ApplicationArea = All;
                Image = Item;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Enabled = EnableCreateDesign;
                trigger OnAction()
                var
                    myInt: Integer;
                    NoSeries: Record "No. Series";
                    Noseriesmgt: Codeunit "No. Series";
                    Item: Record Item;
                    NewNumber: Code[20];
                    Txt0002: Label 'There is no No. Series related to this category';
                    Txt0003: Label 'Look:';
                    Txt0004: Label 'Version:';
                begin
                    if Rec."Item No." = '' then begin
                        rec.TestField(Category);
                        rec.TestField(Type);
                        rec.TestField(Design);
                        NoSeries.SetRange("Item Category", Rec.Category);
                        if NoSeries.FindFirst() then begin
                            NewNumber := Noseriesmgt.GetNextNo(NoSeries.Code, 0D, true);
                            Clear(Item);
                            Item.Init();
                            Item.Validate("No.", NewNumber);
                            Item.Validate("Design Code", Rec.Design);
                            Item."Base Unit of Measure" := 'PCS';
                            Item.Description := Txt0003 + rec."Look Code" + ' ' + Txt0004 + rec."Look Version code";
                            //will be filled by Validate No.
                            //Item."Item Category Code" := Rec.Category;
                            Rec."Item No." := Item."No.";
                            Rec."Item Description" := Item.Description;
                            Item.Insert(true);
                            Message('Item Created SuccessFully');
                            //  Page.Run(30, Item);
                        end
                        else
                            Error(Txt0002);
                    end else
                        Error('You have already selected Item No.');
                end;



            }
        }
    }
    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        EnableCreateDesign := true;
        if Rec."Item No." <> '' then
            EnableCreateDesign := false;
    end;



    var
        User: Record User;
        User2: Record User;
        UserCreater: Code[50];
        EnableCreateDesign: Boolean;
        UserModifier: Code[50];
}
