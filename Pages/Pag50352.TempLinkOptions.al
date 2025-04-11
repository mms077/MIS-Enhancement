page 50352 "Temp Link Options"
{
    PageType = List;
    SourceTable = "Temp Link Options";
    ApplicationArea = All;
    SourceTableTemporary = true;
    Editable = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Selected; rec.Selected)
                {
                    ApplicationArea = All;
                    Caption = 'Selected';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Option Name';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
                ApplicationArea = All;
                Caption = 'OK';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    CurrPage.Close();
                end;
            }
        }
    }
}