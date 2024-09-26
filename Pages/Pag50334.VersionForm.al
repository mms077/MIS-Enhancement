page 50334 "Version Form"
{
    Caption = 'Version';
    PageType = Document;
    SourceTable = "Look Version";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                Caption = 'General';
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Description)
                {
                    ApplicationArea = All;
                }
               
            }


            part(lookversionSubform; "version Subform")
            {
                ApplicationArea = basic, suite;
                SubPageLink = "Version Code" = field("Code");
                UpdatePropagation = Both;
            }
            /*part(DesignMeasurement; "Design Measurement Subform")
            {
                ApplicationArea = basic, suite;
                SubPageLink = "Design Code" = field("Code");
                UpdatePropagation = Both;
            }*/

        }
        /*area(factboxes)
        {

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
        }*/
    }

    actions
    {
        area(Processing)
        {

        }
    }





}