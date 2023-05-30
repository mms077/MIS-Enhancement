page 50204 "Branding Details"
{
    ApplicationArea = All;
    Caption = 'Branding Details';
    PageType = List;
    SourceTable = "Branding Detail";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Branding Name"; Rec."Branding Code")
                {
                    ApplicationArea = All;
                }
                field("Item Color ID"; Rec."Item Color ID")
                {
                    ApplicationArea = All;

                }
                field("Image File"; Rec."Image File")
                {
                    ApplicationArea = All;
                }
                field("Film File"; Rec."Film File")
                {
                    ApplicationArea = All;
                }
            }

        }
    }

}

