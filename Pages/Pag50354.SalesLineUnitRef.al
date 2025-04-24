page 50354 "Sales Line Unit Ref. List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Line Unit Ref.";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
              //  field("Sales Line Ref."; Rec."Sales Line Ref.") { ApplicationArea = all; Editable = false; }
                field("Sales Line Unit"; Rec."Sales Line Unit") { ApplicationArea = all; Editable = false; }
                field("Item No."; Rec."Item No.") { ApplicationArea = all; }
                field(Description; Rec.Description) { ApplicationArea = all; }
                field(Quantity; Rec.Quantity) { ApplicationArea = all; }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
          
        }
    }
}