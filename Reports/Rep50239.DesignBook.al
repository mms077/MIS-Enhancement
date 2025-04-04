report 50239 "Design Book"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Reports Layouts/ER-DesignBook.rdlc';
    Caption = 'Look Book';
    dataset
    {
        dataitem("Customer Look Version"; "Customer Look Version")
        {

            RequestFilterFields = "Customer No.";
            DataItemTableView = sorting(Code) WHERE("Is Printable" = CONST(true));
            column(Customer_No_; "Customer No.") { }
            column(Look_Code_Cust; "Look Code") { }
            column(Look_Version_Code; "Look Version Code") { }
            dataitem("Look Version"; "Look Version")
            {
                DataItemLink = Code = field("Look Version Code");
                column(Front_Picture; "Front Picture") { }
                column(Look_Code; "Look Code") { }
                column(VersionCode; Code) { }
                column(Back_Picture; "Back Picture") { }
                column(Sides_Picture; "Sides Picture") { }
                column(Add_1; "Add 1") { }
                column(Add_2; "Add 2") { }
                column(Add_3; "Add 3") { }
                column(CustomerImage; Customer.Image) { }
                column(CustomerName; Customer.Name) { }
                column(CompInfoImage; CompInfo.Picture) { }
                dataitem("Item Version"; "Item Version")
                {
                    DataItemLink = "Look Version Code" = field(Code);
                    column(Item_No_; "Item No.") { }
                    column(Category; Category) { }
                    column(Design; Design) { }
                    column(Item_Description; "Item Description") { }
                    column(Version_Code; "Look Version code") { }
                }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    Customer.Reset();
                    Customer.get("Customer Look Version"."Customer No.");
                end;



            }



        }

    }


    requestpage
    {
        SaveValues = true;
        layout
        {

            area(Content)
            {
                group(GroupName)
                {


                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        CompInfo.get();
        CompInfo.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        Customer: Record Customer;
        CompInfo: Record "Company Information";

}