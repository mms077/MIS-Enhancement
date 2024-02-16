codeunit 50210 "G/L Account Default Dim."
{
    procedure CopyToTempGLAccountDimfromGLAccountDim()
    var
        TempGLDimTable: Record TempGLAccountDim;
        DefDim: Record "Default Dimension";
        GLAccount: Record "G/L Account";
    begin
        TempGLDimTable.DeleteAll();
        GLAccount.Reset();
        if GLAccount.FindFirst() then begin
            repeat
                DefDim.Reset();
                DefDim.SetRange("Table ID", 15);
                DefDim.SetRange("No.", GLAccount."No.");
                if DefDim.FindFirst() then begin
                    repeat
                        TempGLDimTable.Init();
                        TempGLDimTable."Entry No" := 0;
                        TempGLDimTable."Table ID" := Database::"G/L Account";
                        TempGLDimTable.No := GLAccount."No.";
                        TempGLDimTable."Dimension Code" := DefDim."Dimension Code";
                        TempGLDimTable."Dimension Value Code" := DefDim."Dimension Value Code";
                        TempGLDimTable."Value Posting" := Format(DefDim."Value Posting");
                        TempGLDimTable.Insert();

                        Commit();

                        DefDim."Value Posting" := DefDim."Value Posting"::" ";
                        DefDim.Modify();
                    until DefDim.Next() = 0;
                end;
            until GLAccount.Next() = 0;
        end;
    end;

    procedure CopyToGLAccountDimFromTempTable()
    var
        TempGLDimTable: Record TempGLAccountDim;
        DefDim: Record "Default Dimension";
        DefDim2: Record "Default Dimension";
        GLAccount: Record "G/L Account";
    begin
        GLAccount.Reset();
        GLAccount.SetCurrentKey("No.");
        GLAccount.SetRange("Account Type", GLAccount."Account Type"::Posting);
        GLAccount.SetRange("Income/Balance", GLAccount."Income/Balance"::"Income Statement");
        if GLAccount.FindFirst() then begin
            repeat
                TempGLDimTable.Reset();
                TempGLDimTable.SetCurrentKey("Table ID", No, "Dimension Code");
                TempGLDimTable.SetRange("Table ID", Database::"G/L Account");
                TempGLDimTable.SetRange(No, GLAccount."No.");
                if TempGLDimTable.FindFirst() then begin
                    repeat
                        DefDim.Reset();
                        DefDim.SetCurrentKey("Table ID", "No.", "Dimension Code");
                        DefDim.SetRange("Table ID", Database::"G/L Account");
                        DefDim.SetRange("No.", GLAccount."No.");
                        DefDim.SetRange("Dimension Code", TempGLDimTable."Dimension Code");
                        if not DefDim.FindFirst() then begin
                            DefDim2.Init();
                            DefDim2."Table ID" := Database::"Default Dimension";
                            DefDim2."No." := DefDim."No.";
                            DefDim2."Dimension Code" := TempGLDimTable."Dimension Code";
                            DefDim2."Dimension Value Code" := TempGLDimTable."Dimension Value Code";
                            if TempGLDimTable."Value Posting" = '' then
                                DefDim2."Value Posting" := DefDim2."Value Posting"::" ";
                            if TempGLDimTable."Value Posting" = 'Code Mandatory' then
                                DefDim2."Value Posting" := DefDim2."Value Posting"::"Code Mandatory";
                            if TempGLDimTable."Value Posting" = 'No Code' then
                                DefDim2."Value Posting" := DefDim2."Value Posting"::"No Code";
                            if TempGLDimTable."Value Posting" = 'Same Code' then
                                DefDim2."Value Posting" := DefDim2."Value Posting"::"Same Code";
                            DefDim2."Table Caption" := 'G/L Account';
                            DefDim2.Insert();
                        end
                        else begin
                            DefDim.Reset();
                            DefDim.SetCurrentKey("Table ID", "No.", "Dimension Code");
                            DefDim.SetRange("Table ID", Database::"G/L Account");
                            DefDim.SetRange("No.", GLAccount."No.");
                            DefDim.SetRange("Dimension Code", TempGLDimTable."Dimension Code");
                            if DefDim.FindFirst() then begin
                                if TempGLDimTable."Value Posting" = '' then
                                    DefDim."Value Posting" := DefDim."Value Posting"::" ";
                                if TempGLDimTable."Value Posting" = 'Code Mandatory' then
                                    DefDim."Value Posting" := DefDim."Value Posting"::"Code Mandatory";
                                if TempGLDimTable."Value Posting" = 'No Code' then
                                    DefDim."Value Posting" := DefDim."Value Posting"::"No Code";
                                if TempGLDimTable."Value Posting" = 'Same Code' then
                                    DefDim."Value Posting" := DefDim."Value Posting"::"Same Code";
                                DefDim.Modify();
                            end
                        end;
                    until TempGLDimTable.Next() = 0;
                end;
            until GLAccount.Next() = 0;
        end;


    end;

}
