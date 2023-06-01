pageextension 50248 "Tenant Permission Subform" extends "Tenant Permission Subform"
{
    actions
    {
        addfirst(Processing)
        {
            action(EditInExcel)
            {
                Caption = 'Edit in Excel';
                Image = Excel;
                ToolTip = 'Send the data to an Excel file for editing.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    EditInExcel: Codeunit "Edit in Excel";
                    ODataFilter: Text;
                    Filters: Label 'Role_ID eq ''%1''';
                begin
                    ODataFilter := StrSubstNo(Filters, Rec."Role ID");
                    EditInExcel.EditPageInExcel(CurrPage.ObjectId(true), CurrPage.ObjectId(false), ODataFilter);
                end;
            }

        }

    }
}

