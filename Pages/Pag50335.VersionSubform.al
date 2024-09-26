page 50335 "Version Subform"
{
    Caption = 'Version Details';
    PageType = ListPart;
    SourceTable = "Version Detail";
    //SourceTableView = sorting("Fit Code", "Size Code", "Section Number", "Design Section Code") order(ascending);

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
                field("Category"; Rec.Category) { ApplicationArea = all; }
                field(Type; Rec.Type) { ApplicationArea = all; }
                field(Design; rec.Design) { ApplicationArea = all; }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Item")
            {
                ApplicationArea = All;
                Image = Item;
                trigger OnAction()
                var
                    myInt: Integer;
                    NoSeries: Record "No. Series";
                    Noseriesmgt: Codeunit NoSeriesManagement;
                    Item: Record Item;
                    NewNumber: Code[20];
                    Txt0002: Label 'There is no No. Series related to this category';
                begin
                    /*  rec.TestField(Category);
                      rec.TestField(Type);
                      rec.TestField(Design);
                      NoSeries.SetRange("Item Category", Rec.Category);
                      if NoSeries.FindFirst() then begin
                          NewNumber := Noseriesmgt.GetNextNo(NoSeries.Code, 0D, true);
                          Clear(Item);
                          Item.Init();
                          Item.Validate("No.", NewNumber);
                          Item.Validate("Design Code", Rec.Design);
                          //will be filled by Validate No.
                          //Item."Item Category Code" := Rec.Category;
                          Item.Insert(true);
                          Message('Item Created SuccessFully');
                          Page.Run(30, Item);
                      end
                      else
                          Error(Txt0002);*/
                end;
            }

        }
    }

}

