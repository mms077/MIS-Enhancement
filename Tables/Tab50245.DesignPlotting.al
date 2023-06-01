table 50245 "Design Plotting"
{
    Caption = 'Design Plotting';
    //DataPerCompany = false;
    DataPerCompany = false;
    fields
    {
        field(1; "Design Code"; Code[50])
        {
            Caption = 'Design Code';

            TableRelation = Design.Code;
        }
        field(2; Size; Code[50])
        {
            Caption = 'Size';

            TableRelation = Size.Code;
        }
        field(3; Fit; Code[50])
        {
            Caption = 'Fit';

            TableRelation = Fit.Code;
        }
        field(4; ID; Integer)
        {
            Caption = 'ID';
        }

    }
    keys
    {
        key(PK; "Design Code", Size, Fit)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        LastDesignPlotting: Record "Design Plotting";
    begin
        Clear(LastDesignPlotting);
        LastDesignPlotting.SetCurrentKey(ID);
        if LastDesignPlotting.FindLast() then
            Rec.ID := LastDesignPlotting.ID + 1
        else
            Rec.ID := 1;
    end;
}
