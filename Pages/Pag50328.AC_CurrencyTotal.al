page 50328 AC_CurrencyTotal
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "AC Currency Total";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Curr_Code; Rec.CurrencyCode)
                {
                    ApplicationArea = All;

                }

            }
        }
    }
}