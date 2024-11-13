codeunit 50217 "Cost Adjust-EX"
{
    trigger OnRun()
    var
        Item: Record Item;
    begin
       // Item.SetFilter("No.", '0003724-1/2');
        Item.SetRange("Cost is Adjusted", false);
        if Item.FindSet() then begin
            repeat
                RunCostAdjustment(Item);
                Commit();
            until Item.Next() = 0;

        end;
    end;

    local procedure RunCostAdjustment(var Item: Record Item)
    var
        UpdateItemAnalysisView: Codeunit "Update Item Analysis View";
        UpdateAnalysisView: Codeunit "Update Analysis View";
        InvtAdjmtHandler: Codeunit "Inventory Adjustment Handler";
    begin
        InvtAdjmtHandler.SetFilterItem(Item);
        InvtAdjmtHandler.MakeInventoryAdjustment(false, false);

        UpdateItemAnalysisView.UpdateAll(0, true);
    end;

    var
        myInt: Integer;
}