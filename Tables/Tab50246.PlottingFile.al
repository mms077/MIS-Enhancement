table 50246 "Plotting File"
{
    Caption = 'Plotting File';
    //DataPerCompany = false;
    DataPerCompany = false;
    fields
    {
        field(1; "Design Plotting ID"; Integer)
        {
            Caption = 'Design Plotting ID';
            Editable = false;
        }
        field(2; Picture; MediaSet)
        {
            Caption = 'Picture';
        }
        /*field(3; Width; Integer)
        {
            Caption = 'Width';
            TableRelation = "Fabric Width".Width;
            Editable = false;
        }*/
        field(4; ID; Integer)
        {
            Caption = 'ID';
            Editable = false;
        }
        field(5; Cut; Code[50])
        {
            Caption = 'Cut';
            TableRelation = Cut.Code;
            //Editable = false;
        }
        field(6; "Item Features Set"; Integer)
        {
            Caption = 'Item Features Set';
            TableRelation = "Item Features Set"."Item Feature Set ID";
            //Editable = false;
        }
        field(7; "Design Code"; Code[50])
        {
            Caption = 'Design Code';
            FieldClass = FlowField;
            CalcFormula = lookup("Design Plotting"."Design Code" where(ID = field("Design Plotting ID")));
        }
        field(8; Size; Code[50])
        {
            Caption = 'Size';
            FieldClass = FlowField;
            CalcFormula = lookup("Design Plotting"."Size" where(ID = field("Design Plotting ID")));
        }
        field(9; Fit; Code[50])
        {
            Caption = 'Fit';
            FieldClass = FlowField;
            CalcFormula = lookup("Design Plotting"."Fit" where(ID = field("Design Plotting ID")));
        }
        field(10; "Has Picture"; Boolean)
        {
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Design Plotting ID", Cut, "Item Features Set")
        {
            Clustered = true;
        }
        key(FK; ID)
        {

        }
    }
    fieldgroups
    {
        fieldgroup(Brick; Cut, Picture)
        {
        }
    }
    trigger OnInsert()
    var
        LastPlottingFile: Record "Plotting File";
    begin
        Clear(LastPlottingFile);
        LastPlottingFile.SetCurrentKey(ID);
        if LastPlottingFile.FindLast() then
            Rec.ID := LastPlottingFile.ID + 1
        else
            Rec.ID := 1;
    end;
}
