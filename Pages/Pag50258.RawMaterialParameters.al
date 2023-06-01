page 50258 "Raw Material Parameters"
{
    Caption = 'Raw Material Parameters';
    PageType = StandardDialog;
    layout
    {
        area(content)
        {
            field(DesignSection; DesignSection)
            {
                ApplicationArea = all;
                Caption = 'Design Section';
                TableRelation = "Design Section".Code;
            }
            field(ColorID; ColorID)
            {
                ApplicationArea = all;
                Caption = 'Color';
                TableRelation = Color.ID;
            }
            field(Tonality; Tonality)
            {
                ApplicationArea = all;
                Caption = 'Tonality';
                TableRelation = Tonality.Code;
            }
            field(FabricCode; FabricCode)
            {
                ApplicationArea = all;
                Caption = 'Raw Material Category';
                TableRelation = "Raw Material Category".Code;
            }
        }
    }

    procedure GetParameters(var DesignSec: Code[50]; var Color: integer; var Fabric: Code[50]; var TonalityPar: Code[50])
    begin
        DesignSec := DesignSection;
        Color := ColorID;
        Fabric := FabricCode;
        TonalityPar := Tonality;
    end;

    var
        DesignSection: Code[50];
        ColorID: Integer;
        FabricCode: Code[50];
        Tonality: Code[50];
}
