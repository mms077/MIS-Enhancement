// pageextension 50238 "Purchase Prices" extends "Purchase Prices"
// {
//     actions
//     {
//         addafter(CopyPrices)
//         {
//             action(EditInExcel)
//             {
//                 Caption = 'Edit in Excel';
//                 Image = Excel;
//                 ToolTip = 'Send the data to an Excel file for analysis or editing.';
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 var
//                     EditInExcel: Codeunit "Edit in Excel";
//                     ODataFilter: Text;
//                     EditinExcelFilters: Codeunit "Edit in Excel Filters";
//                     Filters: Label 'Item_No eq ''%1''';
//                 begin
//                     /* EditInExcel.EditPageInExcel(CurrPage.ObjectId(true), CurrPage.ObjectId(false), ODataFilter);*/
//                     //correct the edit in excel to remove the warning
//                     EditinExcelFilters.AddField('ItemNo', Enum::"Edit in Excel Filter Type"::Equal, Rec."Item No.", Enum::"Edit in Excel Edm Type"::"Edm.String");
//                     EditinExcel.EditPageInExcel(
//                         'Purchase Prices',
//                        7012,
//                         EditinExcelFilters,
//                         StrSubstNo(Filters, Rec."Item No."));
//                 end;
//             }

//         }

//     }
// // }