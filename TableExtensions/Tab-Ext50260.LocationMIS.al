tableextension 50260 "Location MIS" extends Location
{
    fields
    {
        field(50200; "Shipping Location"; Boolean)
        {
            Caption = 'Shipping Location';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
            begin
                // Skip validation if enabling the shipping location
                if "Shipping Location" then
                    exit;

                // Check if any IC Partner is using this location
                ICPartner.Reset();
                ICPartner.SetRange("Default Shipping Location", Rec.Code);
                if not ICPartner.IsEmpty then
                    Error('You cannot disable the Shipping Location flag because this location is set as the Default Shipping Location for one or more IC Partners.');
            end;
        }
        field(50201; "Shipping Zone Code"; Code[20])
        {
            Caption = 'Shipping Zone Code';
            TableRelation = "Zone".Code where("Location Code" = field("Code"));
            DataClassification = SystemMetadata;
        }
    }
}
