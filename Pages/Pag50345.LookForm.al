page 50345 "Look Form"
{
    Caption = 'Look Form';
    PageType = Document;
    SourceTable = Look;
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


            part(lookDetails; "look Subform")
            {
                ApplicationArea = basic, suite;
                SubPageLink = "Look Code" = field("Code");
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