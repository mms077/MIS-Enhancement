page 50295 "Workflow User Group-ER"
{
    Caption = 'Workflow User Group-ER';
    PageType = Document;
    SourceTable = "Workflow User Group-ER";

    layout
    {
        area(content)
        {
            field("Code"; Rec.Code)
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the workflow user group.';
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the workflow user group.';
            }
            part(Control5; "Workflow User Group Members-ER")
            {
                ApplicationArea = Suite;
                SubPageLink = "Workflow User Group Code" = FIELD(Code);
            }
        }
    }

    actions
    {
    }
}

