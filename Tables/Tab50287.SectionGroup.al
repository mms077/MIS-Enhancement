table 50287 "Section Group"
{
    Caption = 'Section Group';
    DataClassification = ToBeClassified;
    DataPerCompany = false;
    fields
    {
        field(1; "Section Code"; Code[50])
        {
            Caption = 'Section Code';
            DataClassification = ToBeClassified;
            TableRelation = Section.Code;
        }
        field(2; "Group Code"; Code[50])
        {
            Caption = 'Group Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Show On MO Report"; Boolean)
        {
            Caption = 'Show On MO Report';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Section Code", "Group Code")
        {
            Clustered = true;
        }
    }
}
