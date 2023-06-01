table 50286 "Plotting File Measurement"
{
    Caption = 'Plotting File Measurement';
    DataPerCompany = false;

    fields
    {
        field(1; "Plotting File ID"; Integer)
        {
            TableRelation = "Plotting File".ID;
            Editable = false;
        }

        field(3; "Fabric Width"; Integer)
        {
            Caption = 'Fabric Width';
            TableRelation = "Fabric Width".Width;
        }
        field(5; Cut; Code[50])
        {
            Caption = 'Cut';
            TableRelation = Cut.Code;
            //Editable = false;
        }
        field(6; "Section"; Code[50])
        {
            TableRelation = "Section".Code;
            //Editable = false;
        }
        field(7; "Quantity"; Decimal)
        {

        }
        field(8; "UOM"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(9; "Section Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Section".Name where(Code = field("Section")));
            Editable = false;
        }
        field(10; "Section Group"; Code[50])
        {
            TableRelation = "Section Group"."Group Code";
            //Editable = false;
        }
        field(12; "No. Of Pieces"; Integer)
        {
        }
        field(13; "Efficiency %"; Decimal)
        {
        }
        field(14; "Estimate %"; Decimal)
        {
        }
    }
    keys
    {
        key(PK; "Plotting File ID", "Fabric Width", "Section", "Section Group")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
