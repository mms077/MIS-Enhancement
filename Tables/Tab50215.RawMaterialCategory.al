table 50215 "Raw Material Category"
//table 50215 Fabric
{
    Caption = 'Raw Material Category';
    DataPerCompany = false;

    fields
    {
        field(2; "Code"; Code[50])
        {
            Caption = 'Code';

        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';

        }
        /*field(4; "Design Section Code"; Code[50])
        {
            Caption = 'Design Section Code';
            
            TableRelation = "Design Section".Code;
        }*/
        field(5; "Related Design Sections Count"; Integer)
        {
            Caption = 'Related Design Sections Count';
            FieldClass = FlowField;
            CalcFormula = count("RM Category Design Section" where("RM Category Code" = field(Code)));
            Editable = false;
        }
        field(6; "Related Raw Materials Count"; Integer)
        {
            Caption = 'Related Raw Materials Count';
            FieldClass = FlowField;
            CalcFormula = count("Raw Material" where("Raw Material Category" = field(Code)));
            Editable = false;
        }
    }
    keys
    {
        //key(PK; Code, "Design Section Code")
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}
