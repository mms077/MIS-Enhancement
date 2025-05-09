page 50360 "Workflow User Group-Scan Doc"
{
    Caption = 'Workflow User Group-ER';
    PageType = Document;
    SourceTable = "Workflow User Group Scan";

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
            part(Control5; "Workflow User Group Memb-Scan")
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

