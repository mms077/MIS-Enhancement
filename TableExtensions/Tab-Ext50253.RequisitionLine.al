tableextension 50253 "Requisition Line" extends "Requisition Line"
{
    fields
    {
        field(50206; "Parameters Header ID"; Integer)
        {
            Caption = 'Parameters Header ID';

            Editable = false;
        }
        field(50208; "Allocation Code"; Code[50])
        {
            Caption = 'Allocation Code';
            Editable = false;
        }
        field(50209; "Allocation Type"; Option)
        {
            OptionMembers = " ","Department","Position","Staff";
            Editable = false;
        }
        field(50210; "Parent Parameter Header ID"; Integer)
        {
            Caption = 'Parent Parameters Header ID';

            Editable = false;
        }
    }
}
