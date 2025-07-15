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
                    EditinExcelFilters: Codeunit "Edit in Excel Filters";
                begin
                    /* ODataFilter := StrSubstNo(Filters, Rec."Role ID");
                     EditInExcel.EditPageInExcel(CurrPage.ObjectId(true), CurrPage.ObjectId(false), ODataFilter);*/
                    //EditInExcelImpl.EditPageInExcel(PageCaption, PageId, Filter, '');
                    //correct the edit in excel to remove the warning
                    EditinExcelFilters.AddFieldv2('AppId', Enum::"Edit in Excel Filter Type"::Equal, Rec."App ID", Enum::"Edit in Excel Edm Type"::"Edm.String");
                    EditinExcel.EditPageInExcel(
                        'Tenant Permission Subform',
                        50248,
                        EditinExcelFilters,
                        StrSubstNo(Filters, Rec."App ID"));
                end;
            }

        }

    }
}

