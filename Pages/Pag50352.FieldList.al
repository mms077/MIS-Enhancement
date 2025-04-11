page 50352 "Field List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = Field;
    Caption = 'Field List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Field Number"; Rec."No.") // Added Rec.
                {
                    ApplicationArea = All;
                    Caption = 'Field Number';
                }

                field("Field Name"; Rec.FieldName) // Added Rec.
                {
                    ApplicationArea = All;
                    Caption = 'Field Name';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(TableNo, 37); // Added Rec.
    end;
}