table 50290 OrderHistory
{
    DataClassification = ToBeClassified;
    //TableType=Temporary;
    
    fields
    {
        field(1;SO_NO; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(2;"Customer No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Order Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers="Sales Order","Sales Order Archive";
        }
        field(4;"Line Counts";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Source";code[20])
        {
            DataClassification = ToBeClassified;
            //OptionMembers="Customer","Sales Quote";
        }
        field(6;"Session ID";Integer){
            DataClassification = ToBeClassified;
        }
        field(7;CustomerProjectCode;Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (CustomerProjectCode <> '') then
                begin
                    if (CustomerProjectName = '') then
                    begin
                        CustomerProjectName := CustomerProjectCode;
                    end;
                end;
            end;
        }
        field(8;CustomerProjectName;Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }
    
    keys
    {
        key(Key1; SO_NO,"Session ID")
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}