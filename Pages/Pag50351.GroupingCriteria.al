page 50351 "Grouping Criteria"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Grouping Criteria";
    Caption = 'Grouping Criteria';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Field Number"; Rec."Field Number")
                {
                    ApplicationArea = All;
                    Caption = 'Field Number';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        FieldRec: Record Field;
                    begin
                        FieldRec.SetRange(TableNo, 37); // Filter to Sales Order Line table
                        if Page.RunModal(Page::"Field List", FieldRec) = Action::LookupOK then begin
                            Rec."Field Number" := FieldRec."No.";
                            Rec."Field Name" := FieldRec.FieldName;
                            //Rec.Modify();
                        end;
                        //exit(false);
                    end;
                }

                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    Caption = 'Field Name';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AddField)
            {
                Caption = 'Add Field';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CurrPage.Editable := true;
                end;
            }
        }
    }

}