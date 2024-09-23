page 50237 "Design Subform"
{
    Caption = 'Design Details';
    PageType = ListPart;
    SourceTable = "Design Detail";
    SourceTableView = sorting("Fit Code", "Size Code", "Section Number", "Design Section Code") order(ascending);

    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Size Code"; Rec."Size Code")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Design: Record Design;
                        SizeCategoryPage: Page "Size Categories";
                        SizeCategoryRec: Record "Size Category";
                    begin
                        if Design.Get(Rec."Design Code") then begin
                            SizeCategoryRec.SetRange("Size Gender", Design.Gender);
                            SizeCategoryRec.SetRange("Category Code", Design.Category);
                            if SizeCategoryRec.FindSet() then begin
                                SizeCategoryPage.SetTableView(SizeCategoryRec);
                                SizeCategoryPage.LookupMode(true);
                                if SizeCategoryPage.RunModal() = Action::LookupOK then begin
                                    SizeCategoryPage.GetRecord(SizeCategoryRec);
                                    Rec.Validate("Size Code", SizeCategoryRec."Size Code");
                                end;
                            end;
                        end;
                    end;
                }
                field("Size Name"; Rec."Size Name")
                {
                    ApplicationArea = All;
                    Caption = 'Size Name';
                    Editable = false;
                }
                field("Fit Code"; Rec."Fit Code")
                {
                    ApplicationArea = All;
                    LookupPageId = Fits;
                }
                field("Fit Name"; Rec."Fit Name")
                {
                    ApplicationArea = All;
                    Caption = 'Fit Name';
                    Editable = false;
                }

                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                    LookupPageId = Sections;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SectionRec: Record Section;
                        SectionPage: Page Sections;
                    begin
                        Clear(SectionPage);
                        Clear(SectionRec);
                        SectionRec.SetCurrentKey(Number);
                        if SectionRec.FindSet() then begin
                            SectionPage.SetTableView(SectionRec);
                            SectionPage.LookupMode(true);
                            if SectionPage.RunModal() = Action::LookupOK then begin
                                SectionPage.GetRecord(SectionRec);
                                Rec.Validate("Section Code", SectionRec.Code);
                            end;
                        end;
                    end;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                    Caption = 'Section Name';
                    Editable = false;
                }
                field("Section Group"; Rec."Section Group")
                {
                    ApplicationArea = all;
                }
                field("Section Composition"; Rec."Section Composition")
                {
                    ApplicationArea = all;
                }
                field("Design Section Code"; Rec."Design Section Code")
                {
                    ApplicationArea = All;
                    LookupPageId = "Design Sections";
                }
                field("Design Section Name"; Rec."Design Section Name")
                {
                    ApplicationArea = All;
                    Caption = 'Design Section Name';
                    Editable = false;
                }
                field("UOM Code"; Rec."UOM Code")
                {
                    ApplicationArea = All;
                    LookupPageId = "Units of Measure";
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Length (cm)"; Rec."Length (cm)")
                {
                    ApplicationArea = All;
                }
                field("Width (cm)"; Rec."Width (cm)")
                {
                    ApplicationArea = all;
                }
                field("Section Perimeter (cm2)"; Rec."Section Perimeter (cm)")
                {
                    ApplicationArea = all;
                }
                field("Section Surface (cm2)"; Rec."Section Surface (cm2)")
                {
                    ApplicationArea = all;
                }
            }
        }

    }
    actions
    {
        area(Processing)
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
                    Filters: Label 'Design_Code eq ''%1''';
                    EditinExcelFilters: Codeunit "Edit in Excel Filters";
                begin
                    /* ODataFilter := StrSubstNo(Filters, Rec."Design Code");
                     EditInExcel.EditPageInExcel(CurrPage.ObjectId(true), CurrPage.ObjectId(false), ODataFilter);*/

                    //correct the edit in excel to remove the warning
                    EditinExcelFilters.AddField('Design_Code', Enum::"Edit in Excel Filter Type"::Equal, Rec."Design Code", Enum::"Edit in Excel Edm Type"::"Edm.String");
                    EditinExcel.EditPageInExcel(
                        'Design_Details',
                        page::"Design Subform",
                        EditinExcelFilters,
                        StrSubstNo(Filters, Rec."Design Code"));
                end;

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        MandatoryFields();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        MandatoryFields();
    end;

    procedure MandatoryFields()
    begin
        Rec.TestField("Size Code");
        Rec.TestField("Fit Code");
        Rec.TestField("Section Code");
        Rec.TestField("Design Section Code");
    end;
}
