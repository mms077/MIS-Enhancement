pageextension 50238 "Purchase Prices" extends "Purchase Prices"
{
    actions
    {
        addafter(CopyPrices)
        {
            action(EditInExcel)
            {
                Caption = 'Edit in Excel';
                Image = Excel;
                ToolTip = 'Send the data to an Excel file for analysis or editing.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    EditInExcel: Codeunit "Edit in Excel";
                    ODataFilter: Text;
                begin
                    EditInExcel.EditPageInExcel(CurrPage.ObjectId(true), CurrPage.ObjectId(false), ODataFilter);
                end;
            }

        }

    }
}