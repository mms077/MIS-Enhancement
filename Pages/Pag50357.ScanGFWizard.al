page 50357 "Scan Unit Ref"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Scan Design Stages- ER Temp";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(UnitRef; UnitRef)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        MasterItemCU: Codeunit MasterItem;
                        AssemblyHeader: Record "Assembly Header";
                        ScanDesignStages: Record "Scan Design Stages- ER"; // Replace with the actual table name for scan activities
                        Dashboard: Record "Cutting Sheets Dashboard"; // Replace with the actual table name for the dashboard
                        Txt001: Label 'No Assembly found in the group %1';
                        Txt0001: Label 'Scan In 👍';
                        Txt0002: Label 'Scan Out 👍';
                        ScanOption: Option "In","Out";
                        Item: Record Item;
                        WorkflowActivitiesER: Record "Workflow Activities - ER";
                        MO: Record "ER - Manufacturing Order";
                        MaxSequenceNo: Integer;
                        Txt003: Label 'The current sequence number %1 exceeds the maximum sequence number %2 in the scan activities.';
                        SalesLine: Record "Sales Line";
                        SalesUnit: Record "Sales Line Unit Ref.";
                        ProcessedAssemblies: Dictionary of [Code[20], Boolean]; // To track processed assemblies
                        DesignActivities: Record "Design Activities";

                    begin
                        //make to scan false
                        ResetDesignActivitiesToScan;
                        rec.DeleteAll();
                        DesignCode := '';
                        // Logic to refresh the subpage when UnitRef changes
                        Clear(ScanDesignStages);
                        Clear(MO);
                        if UnitRef <> '' then begin
                            if MO.Get(UnitRef) then begin
                                Clear(AssemblyHeader);
                                AssemblyHeader.SetFilter("ER - Manufacturing Order No.", MO."No.");
                                if AssemblyHeader.FindFirst() then begin
                                    // i need to fill the ScanDesignStages rec from "Scan Design Stages- ER" table
                                    Rec.TRANSFERFIELDS(ScanDesignStages);
                                    Rec.Insert();
                                    Rec."Item No." := AssemblyHeader."Item No.";
                                    Rec."Design Code" := GetItemDesign(Rec."Item No.");
                                    Rec.Modify();

                                    Clear(SalesLine);
                                    SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                                    SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                                    if SalesLine.FindFirst() then begin
                                        SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                                        if SalesUnit.FindFirst() then begin

                                            CurrPage.Update();
                                        end

                                    end else begin
                                        Clear(AssemblyHeader);
                                        AssemblyHeader.SetRange("No.", UnitRef);
                                        if AssemblyHeader.FindSet() then begin

                                            Rec."Item No." := AssemblyHeader."Item No.";
                                            Rec."Design Code" := GetItemDesign(Rec."Item No.");
                                            Rec.Modify();
                                            CurrPage.Update();

                                        end else begin
                                            SalesUnit.SetFilter("Sales Line Unit", UnitRef);
                                            if SalesUnit.FindFirst() then begin
                                                Clear(SalesLine);
                                                SalesLine.SetFilter("Sales Line Reference", SalesUnit."Sales Line Ref.");
                                                if SalesLine.FindFirst() then begin
                                                    Rec."Item No." := SalesLine."No.";
                                                    Rec."Design Code" := GetItemDesign(Rec."Item No.");
                                                    Rec.Modify();
                                                    CurrPage.Update();
                                                end;
                                            END;
                                        END;
                                    end;
                                end;
                            end;
                        end;
                    end;
                }

                field(User; User)
                {
                    ApplicationArea = All;
                    trigger OnValidate()


                    var
                        MasterItemCU: Codeunit MasterItem;
                        AssemblyHeader: Record "Assembly Header";
                        DesignActivities: Record "design Activities"; // Replace with the actual table name for scan activities
                        Dashboard: Record "Cutting Sheets Dashboard"; // Replace with the actual table name for the dashboard
                        Txt001: Label 'No Assembly found in the group %1';
                        Txt0001: Label 'Scan In 👍';
                        Txt0002: Label 'Scan Out 👍';
                        ScanOption: Option "In","Out";
                        Design: Record Design;
                        Item: Record Item;
                        WorkflowActivitiesER: Record "Workflow Activities - ER";
                        MO: Record "ER - Manufacturing Order";
                        MaxSequenceNo: Integer;
                        Txt003: Label 'The current sequence number %1 exceeds the maximum sequence number %2 in the scan activities.';
                        SalesLine: Record "Sales Line";
                        SalesUnit: Record "Sales Line Unit Ref.";
                        ProcessedAssemblies: Dictionary of [Code[20], Boolean]; // To track processed assemblies
                    begin
                        if UnitRef = '' then
                            Error('You must fill Unit Ref First');
                        // // Logic to refresh the subpage when UnitRef changes
                        // Clear(DesignActivities);
                        // Clear(MO);
                        // if MO.Get(UnitRef) then begin
                        //     Clear(AssemblyHeader);
                        //     AssemblyHeader.SetFilter("ER - Manufacturing Order No.", MO."No.");
                        //     if AssemblyHeader.FindFirst() then
                        //         repeat
                        //             // Check if the assembly has already been processed
                        //             if not ProcessedAssemblies.ContainsKey(AssemblyHeader."No.") then begin
                        //                 ProcessedAssemblies.Add(AssemblyHeader."No.", true); // Mark as processed
                        //                 SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                        //                 SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                        //                 if SalesLine.FindFirst() then begin
                        //                     SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                        //                     if SalesUnit.FindFirst() then begin
                        //                         repeat
                        //                         // Perform the scan for every unit

                        //                         until SalesUnit.Next() = 0;
                        //                     end;
                        //                 end;
                        //             END;
                        //         until AssemblyHeader.Next() = 0;

                        // end else begin
                        //     Clear(AssemblyHeader);
                        //     AssemblyHeader.SetRange("No.", UnitRef);
                        //     if AssemblyHeader.FindSet() then begin
                        //         repeat
                        //             // Check if the assembly has already been processed
                        //             if not ProcessedAssemblies.ContainsKey(AssemblyHeader."No.") then begin
                        //                 ProcessedAssemblies.Add(AssemblyHeader."No.", true); // Mark as processed
                        //                 SalesLine.SetFilter("Document No.", AssemblyHeader."Source No.");
                        //                 SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                        //                 if SalesLine.FindFirst() then begin
                        //                     SalesUnit.SetFilter("Sales Line Ref.", SalesLine."Sales Line Reference");
                        //                     if SalesUnit.FindFirst() then begin
                        //                         repeat
                        //                         // Perform the scan for every unit

                        //                         until SalesUnit.Next() = 0;
                        //                     end;
                        //                 end;
                        //             end;
                        //         until AssemblyHeader.Next() = 0;
                        //     end else begin
                        //         SalesUnit.SetFilter("Sales Line Unit", UnitRef);
                        //         if SalesUnit.FindFirst() then begin

                        //             // Perform the scan for every unit
                        //         END;
                        //     END;
                        // end;


                    end;
                }
            }


            part(DesignActivityStagesPart; "Design Activities Temp")
            {

                // SubPageLink updated to use a valid field from the Design Activities table
                SubPageLink = "Design Code" = field("Design Code");
                SubPageView = sorting("Sequence No.");
                Editable = true;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                trigger OnAction()
                begin
                    // Additional logic if needed
                end;
            }
        }
    }
    local procedure GetItemDesign(ItemNo: Code[20]): Code[50]
    var
        myInt: Integer;
        Item: Record Item;
    begin
        Clear(Item);
        Item.get(ItemNo);
        exit(Item."Design Code");
    end;

    local procedure ResetDesignActivitiesToScan()
    var
        DesignActivities: Record "Design Activities";
    begin
        Clear(DesignActivities);
        if DesignActivities.FindSet() then
            repeat
                DesignActivities."To Scan" := false;
                DesignActivities.Modify();
            until DesignActivities.Next() = 0;
    end;

    var
        UnitRef: Code[50];
        User: Code[50];
        DesignCode: code[50];
}