page 50371 "Location Selection Dialog"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    Caption = 'Select Destination Location';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Transfer Details';

                field("From Location"; FromLocationCode)
                {
                    ApplicationArea = All;
                    Caption = 'From Location';
                    ToolTip = 'Specifies the source location for the transfer.';
                    Editable = false;
                }
                field("To Location"; ToLocationCode)
                {
                    ApplicationArea = All;
                    Caption = 'To Location';
                    ToolTip = 'Specifies the destination location for the transfer.';
                    TableRelation = Location.Code;

                    trigger OnValidate()
                    begin
                        if ToLocationCode = FromLocationCode then
                            Error('Destination location cannot be the same as source location.');
                    end;
                }
            }
        }
    }

    var
        FromLocationCode: Code[10];
        ToLocationCode: Code[10];

    /// <summary>
    /// Sets the from location code
    /// </summary>
    /// <param name="LocationCode">The source location code</param>
    procedure SetFromLocation(LocationCode: Code[10])
    begin
        FromLocationCode := LocationCode;
    end;

    /// <summary>
    /// Gets the selected destination location
    /// </summary>
    /// <returns>The selected destination location code</returns>
    procedure GetToLocation(): Code[10]
    begin
        exit(ToLocationCode);
    end;
}
