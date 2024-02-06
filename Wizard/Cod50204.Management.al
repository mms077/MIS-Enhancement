codeunit 50204 Management
{
    procedure RunTheProcess(State: Option "Start","Departments","Positions","Staff","Staff Sizes","Header Parameters 0","Header Parameters","Qty Assignment","Lines Parameters","Features Parameters","Branding Parameters";
                             SalesHeader: Record "Sales header"; Process: Option "Old Way","Assignment","Just Create Variant"; var SalesLinePar: Record "Sales Line"; ItemNo: Code[20])
    var
        Step0: Page "Departments Wizard";//Departments
        Step0_1: Page "Positions Wizard";//Positions
        Step0_2: Page "Staff Wizard";//Staffs
        Step0_3: Page "Staff Sizes Wizard";//Staff Sizes
        Step0_4: Page "Item Wizard 0";//Header Parameters 0
        Step1: Page "Item Wizard";//Header Parameters
        Step1_1: Page "Quantity Assigment Wizard";//Quantity Assignment
        Step2: Page "Design Section Param Lines Wiz";//Lines Parameters
        Step3: page "Item Features Param Lines Wiz";//Features Parameters
        Step4: Page "Item Brandings Param Lines Wiz";//Branding Parameters

        //State
        Done: Boolean;
        ParamHeader: Record "Parameter Header";
        DesignSecParamLines: Record "Design Section Param Lines";
        ItemFeaturesParamLine: Record "Item Features Param Lines";
        ItemBrandingParamLine: Record "Item Branding Param Lines";
        LastDesiSecParHeader: Record "Parameter Header";
        ParHeaderDepartments: Record "Parameter Header Departments";
        ParHeaderPositions: Record "Parameter Header Positions";
        ParHeaderStaff: Record "Parameter Header Staff";
        ParHeaderStaffSizes: Record "Parameter Header Staff Sizes";
        ParamHeaderPerStaffSize: Record "Parameter Header";
        QtyAssignmentWizard: Record "Qty Assignment Wizard";
        MasterItem: Codeunit MasterItem;
        VariantCode: Code[10];
        SalesReceivableSetup: Record "Sales & Receivables Setup";
        ChildrenParameterHeader: Record "Parameter Header";
        SalesLinesToDelete: Record "Sales Line";
        ChildParameterHeaderPar: Record "Parameter Header";
    begin
        Done := false; //Not Done
        repeat //State machine loop
            case State of //Defines where we are in the process...keeps looking until done
                State::Start:
                    begin
                        SalesReceivableSetup.Get();
                        ParamHeader.Init();
                        if LastDesiSecParHeader.FindLast() then
                            ParamHeader.ID := LastDesiSecParHeader.ID + 1
                        else
                            ParamHeader.ID := 1;
                        ParamHeader."Item No." := ItemNo;
                        ParamHeader."Customer No." := SalesHeader."Sell-to Customer No.";
                        ParamHeader."Sales Line Document No." := SalesHeader."No.";
                        //ParamHeader."Sales Line Location Code" := SalesReceivableSetup."Wizard Default Location";
                        if Process = Process::"Just Create Variant" then begin
                            ParamHeader."Sales Line Quantity" := 1;
                            ParamHeader."Sales Line UOM" := GetItemBaseUOM(ItemNo);
                            //Used to hide controls on the pages
                            ParamHeader."Create Variant" := true;
                        end;
                        ParamHeader.Insert();
                        if Process = Process::"Old Way" then
                            State := State::Departments
                        else
                            if (Process = Process::"Assignment") or (Process = Process::"Just Create Variant") then
                                State := State::"Header Parameters";
                    end;
                State::Departments:
                    begin
                        Commit();
                        Clear(Step0);
                        //Create ParHeaderDepartments
                        CreateParHeaderDepartments(ParamHeader);
                        //We set commit be cause we are using runmodal
                        Commit();
                        ParHeaderDepartments.SetRange("Parameter Header ID", ParamHeader.ID);
                        if ParHeaderDepartments.FindSet() then;
                        step0.SetTableView(ParHeaderDepartments);
                        Step0.SetParameterHeaderID(ParamHeader.ID);
                        Step0.RunModal();
                        if Step0.Continue() then begin
                            State := State::Positions;
                        end else
                            Done := true;
                    end;
                State::Positions:
                    begin
                        Commit();
                        Clear(Step0_1);
                        //Create ParHeaderPositions
                        CreateParHeaderPositions(ParamHeader);
                        //We set commit be cause we are using runmodal
                        Commit();
                        ParHeaderPositions.SetRange("Parameter Header ID", ParamHeader.ID);
                        if ParHeaderPositions.FindSet() then;
                        Step0_1.SetTableView(ParHeaderPositions);
                        Step0_1.SetParameterHeaderID(ParamHeader.ID);
                        Step0_1.RunModal();
                        if Step0_1.Continue() then
                            State := State::Staff
                        else
                            if Step0_1.Back() then begin
                                //Delete Old Lines
                                DeleteOldDepartments(ParamHeader.ID);
                                DeleteOldPositions(ParamHeader.ID);
                                State := State::Departments;
                            end else
                                Done := true;
                    end;
                State::Staff:
                    begin
                        Commit();
                        Clear(Step0_2);
                        //Create ParHeaderStaff
                        CreateParHeaderStaff(ParamHeader);
                        //We set commit be cause we are using runmodal
                        Commit();
                        ParHeaderStaff.SetRange("Parameter Header ID", ParamHeader.ID);
                        if ParHeaderStaff.FindSet() then;
                        Step0_2.SetTableView(ParHeaderStaff);
                        Step0_2.SetParameterHeaderID(ParamHeader.ID);
                        Step0_2.RunModal();
                        if Step0_2.Continue() then
                            State := State::"Staff Sizes"
                        else
                            if Step0_2.Back() then begin
                                //Delete Old Lines
                                DeleteOldPositions(ParamHeader.ID);
                                DeleteOldStaffs(ParamHeader.ID);
                                State := State::Positions;
                            end else
                                Done := true;
                    end;
                State::"Staff Sizes":
                    begin
                        Commit();
                        Clear(Step0_3);
                        //Create ParHeaderStaffSizes
                        CreateParHeaderStaffSizes(ParamHeader);
                        //We set commit because we are using insert before runmodal
                        Commit();
                        ParHeaderStaffSizes.SetRange("Parameter Header ID", ParamHeader.ID);
                        if ParHeaderStaffSizes.FindSet() then;
                        Step0_3.SetTableView(ParHeaderStaffSizes);
                        Step0_3.SetParameterHeaderID(ParamHeader.ID);
                        Step0_3.RunModal();
                        if Step0_3.Continue() then begin
                            State := State::"Header Parameters 0";
                            //Create Parameter Header for each Staff Size
                            CreateParameterHeaderPerStaffSize(ParamHeader.ID, SalesHeader);
                        end else
                            if Step0_3.Back() then begin
                                //Delete Old Lines
                                DeleteOldStaffs(ParamHeader.ID);
                                DeleteOldStaffSizes(ParamHeader.ID);
                                State := State::Staff
                            end else
                                Done := true;
                    end;
                State::"Header Parameters 0":
                    begin
                        Commit();
                        Clear(Step0_4);
                        Step0_4.SetRecord(ParamHeader);
                        Step0_4.SetParameterHeaderID(ParamHeader.ID);
                        Step0_4.RunModal();
                        if Step0_4.Continue() then begin
                            State := State::"Lines Parameters";
                            Step0_4.GetRecord(ParamHeader);
                            CreateDesignSectionParameterLines(ParamHeader);
                        end else
                            Done := true;
                    end;
                State::"Header Parameters":
                    begin
                        Commit();
                        Clear(Step1);
                        //If load from Sales Line 
                        if SalesLinePar."Parent Parameter Header ID" <> 0 then
                            ParamHeader.Get(SalesLinePar."Parent Parameter Header ID");
                        Step1.SetRecord(ParamHeader);
                        Step1.SetTableView(ParamHeader);
                        Step1.SetParameterHeaderID(ParamHeader.ID);
                        Step1.RunModal();
                        if Step1.Continue() then begin
                            State := State::"Qty Assignment";
                            Step1.GetRecord(ParamHeader);
                            CreateQtyAssignmentWizard(ParamHeader);
                        end else
                            Done := true;
                    end;
                State::"Qty Assignment":
                    begin
                        Commit();
                        Clear(Step1_1);
                        Clear(QtyAssignmentWizard);
                        QtyAssignmentWizard.SetRange("Parent Header ID", ParamHeader.ID);
                        QtyAssignmentWizard.FindSet();
                        Step1_1.SetTableView(QtyAssignmentWizard);
                        Step1_1.SetParameterHeaderID(ParamHeader.ID);
                        Step1_1.RunModal();
                        if Step1_1.Next() then begin
                            //if the item is finished
                            if IsRawMaterial(ParamHeader."Item No.") = false then begin
                                State := State::"Lines Parameters";
                                //Step1_1.GetRecord(ParamHeader);
                                CreateDesignSectionParameterLines(ParamHeader);
                            end else begin
                                //if the item is raw material
                                //Create Variant for each child
                                CreateVariantForEachChild(QtyAssignmentWizard, ParamHeader);
                                State := State::Start;
                            end;
                        end else
                            if Step1_1.Back() then
                                State := State::"Header Parameters"
                            else
                                Done := true;
                    end;
                State::"Lines Parameters":
                    begin
                        Commit();
                        Clear(Step2);
                        Clear(DesignSecParamLines);
                        DesignSecParamLines.SetRange("Header ID", ParamHeader.ID);
                        Step2.SetTableView(DesignSecParamLines);
                        Step2.SetParameterHeaderID(ParamHeader.ID);
                        Step2.RunModal();
                        if Step2.Next() then begin
                            State := State::"Features Parameters";
                            CreateItemFeaturesParameterLines(ParamHeader);
                        end else
                            if Step2.Back() then
                                State := State::"Qty Assignment"
                            else
                                if Step2.Next() then
                                    State := State::"Features Parameters"
                                else
                                    Done := true;
                    end;
                State::"Features Parameters":
                    begin
                        Commit();
                        Clear(Step3);
                        Clear(ItemFeaturesParamLine);
                        ItemFeaturesParamLine.SetRange("Header ID", ParamHeader.ID);
                        Step3.SetTableView(ItemFeaturesParamLine);
                        Step3.SetParameterHeaderID(ParamHeader.ID);
                        Step3.RunModal();
                        if Step3.Next() then begin
                            State := State::"Branding Parameters";
                            CreateItemBrandingParameterLines(ParamHeader);
                        end else
                            if Step3.Back() then begin
                                State := State::"Lines Parameters";
                                //Delete Sales Line already created
                                DeleteSalesLine(ParamHeader);
                            end
                            else
                                Done := true;
                    end;
                State::"Branding Parameters":
                    begin
                        Commit();
                        Clear(Step4);
                        Clear(ItemBrandingParamLine);
                        ItemBrandingParamLine.SetRange("Header ID", ParamHeader.ID);
                        Step4.SetTableView(ItemBrandingParamLine);
                        Step4.SetParameterHeaderID(ParamHeader.ID);
                        Step4.RunModal();
                        if Step4.Finish() then begin
                            DeleteUnselectedBranding(ParamHeader.ID);
                            //Create Design Section Set
                            MasterItem.GenerateDesignSectionSetID(ParamHeader);
                            //Create Item Features Set
                            MasterItem.GenerateItemFeatureSetID(ParamHeader);
                            //Create Item Brandings Set
                            MasterItem.GenerateItemBrandingSetID(ParamHeader);
                            //Transfer the data from the parent parameter to the children
                            MasterItem.TransferParameterDataToChildren(ParamHeader, ChildParameterHeaderPar);

                            //Create Plotting Files for each child
                            Clear(QtyAssignmentWizard);
                            QtyAssignmentWizard.SetRange("Parent Header ID", ParamHeader.ID);
                            if QtyAssignmentWizard.FindSet() then
                                repeat
                                    Clear(ChildrenParameterHeader);
                                    ChildrenParameterHeader.Get(QtyAssignmentWizard."Header Id");
                                    MasterItem.CreateDesignPlotting(ChildrenParameterHeader);
                                until QtyAssignmentWizard.Next() = 0;

                            if (Process = Process::"Just Create Variant") then begin
                                //Create Variant for each child
                                CreateVariantForEachChild(QtyAssignmentWizard, ParamHeader);
                                State := State::Start;
                            end else
                                //Multiple Sales Line
                                if Process = Process::"Old Way" then begin
                                    //Update Parameter Header for each Staff Size
                                    UpdateParameterHeaderPerStaffSize(ParamHeader, SalesHeader);
                                    ParamHeaderPerStaffSize.SetRange("Staff Sizes Parameter Header", ParamHeader.ID);
                                    if ParamHeaderPerStaffSize.FindSet() then
                                        repeat
                                            //Create Variant Per Staff Size
                                            VariantCode := MasterItem.CreateVariant(ParamHeaderPerStaffSize);
                                            //CreateSalesLine;
                                            Clear(QtyAssignmentWizard);
                                            CreateSalesLine(ParamHeaderPerStaffSize, SalesHeader, VariantCode, ParamHeaderPerStaffSize."Sales Line Quantity", ParamHeader, QtyAssignmentWizard);
                                            //Create Needed Raw Material
                                            CreateNeededRawMaterial(ParamHeaderPerStaffSize);
                                            //Create Assembly
                                            CreateAssemblyOrder(NeededRawMaterial, ParamHeader, ParamHeader);
                                        until ParamHeaderPerStaffSize.Next() = 0;
                                    Done := true;
                                end else
                                    if Process = Process::"Assignment" then begin
                                        //Delete Old Sales lines to create new ones
                                        if SalesLinePar."Parent Parameter Header ID" <> 0 then begin
                                            SalesLinesToDelete.SetRange("Parent Parameter Header ID", SalesLinePar."Parent Parameter Header ID");
                                            if SalesLinesToDelete.FindSet() then
                                                SalesLinesToDelete.DeleteAll(true);
                                        end;
                                        //Create Variant for each child
                                        Clear(QtyAssignmentWizard);
                                        QtyAssignmentWizard.SetRange("Parent Header ID", ParamHeader.ID);
                                        if QtyAssignmentWizard.FindSet() then
                                            repeat
                                                Clear(ChildrenParameterHeader);
                                                ChildrenParameterHeader.Get(QtyAssignmentWizard."Header Id");
                                                VariantCode := CheckVariantCode(ChildrenParameterHeader);
                                                //Update The parameters Headers Related to Qty Assignment
                                                //UpdateDesignFeatureBrandingParamLines(ParamHeader, ChildrenParameterHeader);
                                                //CreateSalesLine + Needed Raw Materials + Assembly
                                                CreateMultipleSalesLines(ChildrenParameterHeader, SalesHeader, VariantCode, ParamHeader, QtyAssignmentWizard, true);
                                                //Update parameter header to the line (Remove the Assigned Qty)
                                                ChildrenParameterHeader."Sales Line Quantity" := ChildrenParameterHeader."Sales Line Quantity" - ChildrenParameterHeader."Quantity To Assign";
                                                ChildrenParameterHeader."Quantity To Assign" := 0;
                                                ChildrenParameterHeader.Modify();
                                            until QtyAssignmentWizard.Next() = 0;
                                        Done := true;
                                    end;
                        end else
                            if Step4.Back() then begin
                                State := State::"Features Parameters";
                                //Delete Sales Line already created
                                DeleteSalesLine(ParamHeader);
                            end else
                                Done := true;
                    end;
            end;
        until Done;


    end;

    procedure CreateDesignSectionParameterLines(DesignSecParHeader: Record "Parameter Header")
    var
        CounterHeader: Integer;
        CounterLine:
                    Integer;
        ItemDesignSectionColor:
                    Record "Item Design Section Color";
        RepeatedDesignSection:
                    Code[100];
        DesignSectionParamLine:
                    Record "Design Section Param Lines";
        DesignSectionFilter: Text[2048];
        DesignDetails: Record "Design Detail";
        Item: Record Item;
        DesignSection: Record "Design Section" temporary;
        DesignSectionRec: Record "Design Section";
        ModifyAction: Option "Insert","Modify";
        //CEE
        RMCategoryDesignSection: Record "RM Category Design Section";
        RawMaterialRec: Record "Raw Material";
        DesignRec: Record Design;
        FirstRecColorIDInt: Integer;
    begin
        //To not recreate lines specially on loading parameter from sales line
        DesignSectionParamLine.SetRange("Header ID", DesignSecParHeader.ID);
        if DesignSectionParamLine.FindSet() then
            exit;

        //Create Design Section Parameter Lines
        Clear(DesignSectionParamLine);
        if DesignSectionParamLine.FindLast() then
            CounterLine := DesignSectionParamLine."Line No." + 1
        else
            CounterLine := 1;

        ItemDesignSectionColor.SetCurrentKey("Design Section Code");
        ItemDesignSectionColor.SetRange("Item No.", DesignSecParHeader."Item No.");
        ItemDesignSectionColor.SetRange("Item Color ID", DesignSecParHeader."Item Color ID");
        //Only get the design sections that have more or = 1 from item design section color
        ItemDesignSectionColor.CalcFields("Design Section Color Count");
        ItemDesignSectionColor.SetFilter("Design Section Color Count", '>=1');
        if ItemDesignSectionColor.FindSet() then begin
            repeat
                if RepeatedDesignSection <> ItemDesignSectionColor."Design Section Code" then begin
                    Clear(DesignSectionParamLine);
                    DesignSectionParamLine.Init();
                    DesignSectionParamLine."Header ID" := DesignSecParHeader.ID;
                    DesignSectionParamLine."Line No." := CounterLine;
                    DesignSectionParamLine."Design Section Code" := ItemDesignSectionColor."Design Section Code";
                    //Set Color by default same as main if exist
                    if DefaultColorAsMain(DesignSectionParamLine, DesignSecParHeader) then begin
                        DesignSectionParamLine."Color ID" := DesignSecParHeader."Item Color ID";
                        DesignSectionParamLine."Tonality Code" := DesignSecParHeader."Tonality Code";
                    end;
                    //Set Color to the default one in item design section color
                    DefaultColor(DesignSectionParamLine, DesignSecParHeader);
                    //If there is only one color in item design section set it by default
                    ItemDesignSectionColor.CalcFields("Design Section Color Count");
                    if ItemDesignSectionColor."Design Section Color Count" = 1 then begin
                        DesignSectionParamLine."Color ID" := ItemDesignSectionColor."Color ID";
                        DesignSectionParamLine."Tonality Code" := ItemDesignSectionColor."Tonality Code";
                    end;
                    CheckDesignSectionRawMaterial(DesignSectionParamLine, DesignSecParHeader, ModifyAction::Insert);
                    DesignSectionParamLine.Insert();
                    CounterLine := CounterLine + 1;
                    RepeatedDesignSection := DesignSectionParamLine."Design Section Code";
                    DesignSectionFilter := DesignSectionFilter + '<>' + DesignSectionParamLine."Design Section Code" + '&';
                end;
            until ItemDesignSectionColor.Next() = 0;
        end;
        //Get the design sections not defined in item design section color
        DesignSectionFilter := DELCHR("DesignSectionFilter", '>', '&');
        Clear(Item);
        Clear(DesignDetails);
        Item.Get(DesignSecParHeader."Item No.");
        DesignDetails.SetCurrentKey("Design Section Code");
        DesignDetails.SetRange("Design Code", Item."Design Code");
        DesignDetails.Setfilter("Design Section Code", DesignSectionFilter);
        if DesignDetails.FindSet() then
            repeat
                DesignSection.Init();
                DesignSection.Code := DesignDetails."Design Section Code";
                if DesignSection.Insert() then;
            until DesignDetails.Next() = 0;

        if DesignSection.FindSet() then
            repeat
                DesignSectionRec.Get(DesignSection.Code);
                Clear(DesignSectionParamLine);
                DesignSectionParamLine.Init();
                DesignSectionParamLine."Header ID" := DesignSecParHeader.ID;
                DesignSectionParamLine."Line No." := CounterLine;
                DesignSectionParamLine."Design Section Code" := DesignSection."Code";
                //if the design section has a unique color it should be taken from the design section table
                if DesignSectionRec."Unique Color" <> 0 then begin
                    DesignSectionParamLine."Color ID" := DesignSectionRec."Unique Color";
                    DesignSectionParamLine."Tonality Code" := '0';
                end else begin
                    //(Changed) else it will be same as the main item color and tonality
                    //Cee:task 17641 else it will be same as the main item color and tonality unless it has a unique color on the raw material table
                    Clear(RMCategoryDesignSection);
                    RMCategoryDesignSection.SetRange("Design Section Code", DesignSectionRec.Code);
                    clear(DesignRec);
                    if DesignRec.Get(Item."Design Code") then begin
                        RMCategoryDesignSection.SetRange("Design Type", DesignRec.Type);
                        if RMCategoryDesignSection.Count = 1 then begin
                            if RMCategoryDesignSection.FindFirst() then begin//here
                                Clear(RawMaterialRec);
                                RawMaterialRec.SetRange("Raw Material Category", RMCategoryDesignSection."RM Category Code");
                                if RawMaterialRec.FindFirst() then begin
                                    RawMaterialRec.SetCurrentKey("Color ID");
                                    //check if color id of first rec is equal to color id of last rec
                                    if RawMaterialRec.FindFirst() then begin
                                        FirstRecColorIDInt := RawMaterialRec."Color ID";
                                        if RawMaterialRec.FindLast() then begin
                                            if FirstRecColorIDInt = RawMaterialRec."Color ID" then begin
                                                DesignSectionParamLine."Color ID" := RawMaterialRec."Color ID";
                                                DesignSectionParamLine."Tonality Code" := RawMaterialRec."Tonality Code";
                                            end
                                            else begin
                                                DesignSectionParamLine."Color ID" := DesignSecParHeader."Item Color ID";
                                                DesignSectionParamLine."Tonality Code" := DesignSecParHeader."Tonality Code";
                                            end;
                                        end
                                    end
                                end
                            end
                        end
                        else begin
                            DesignSectionParamLine."Color ID" := DesignSecParHeader."Item Color ID";
                            DesignSectionParamLine."Tonality Code" := DesignSecParHeader."Tonality Code";
                        end;

                    end;
                end;
                CheckDesignSectionRawMaterial(DesignSectionParamLine, DesignSecParHeader, ModifyAction::"Insert");
                DesignSectionParamLine.Insert();
                CounterLine := CounterLine + 1;
            until DesignSection.Next() = 0;
        clear(FirstRecColorIDInt);
    end;

    procedure CreateSalesLine(var
                                  DesignSectionParHeader: Record "Parameter Header";
                                  SalesHeaderPar: Record "Sales Header";
                                  VariantCodePar: Code[10];
                                  QtyPar: decimal;
                                  ParentParameterHeader: Record "Parameter Header";

    var
        QtyAssignmentWizard: Record "Qty Assignment Wizard")
    var
        LineNumber: Integer;
        Item: Record Item;
        SizeLoc: Record Size;
    begin
        Clear(SizeLoc);
        Item.get(DesignSectionParHeader."Item No.");
        SalesLineGlobal.SetRange("Document Type", SalesHeaderPar."Document Type");
        SalesLineGlobal.SetRange("Document No.", SalesHeaderPar."No.");
        if SalesLineGlobal.FindLast() then
            LineNumber := SalesLineGlobal."Line No." + 10000
        else
            LineNumber := 10000;

        Clear(SalesLineGlobal);
        SalesLineGlobal.Init;
        SalesLineGlobal."Document Type" := SalesHeaderPar."Document Type";
        SalesLineGlobal."Document No." := SalesHeaderPar."No.";
        SalesLineGlobal."Line No." := LineNumber;
        SalesLineGlobal.Validate(Type, SalesLineGlobal.Type::Item);
        SalesLineGlobal.Validate("No.", DesignSectionParHeader."Item No.");
        SalesLineGlobal.Validate(Quantity, QtyPar);
        SalesLineGlobal.Validate("Unit of Measure Code", DesignSectionParHeader."Sales Line UOM");
        SalesLineGlobal.Validate("Location Code", DesignSectionParHeader."Sales Line Location Code");
        SalesLineGlobal.Size := DesignSectionParHeader."Item Size";
        SalesLineGlobal.Fit := DesignSectionParHeader."Item Fit";
        //Get Color From Parent Parameter Header
        SalesLineGlobal.Color := ParentParameterHeader."Item Color ID";
        SalesLineGlobal.Tonality := DesignSectionParHeader."Tonality Code";
        SalesLineGlobal.Validate("Parameters Header ID", DesignSectionParHeader.ID);
        SalesLineGlobal.Validate("Parent Parameter Header ID", ParentParameterHeader.ID);
        SalesLineGlobal."Allocation Type" := DesignSectionParHeader."Allocation Type";
        SalesLineGlobal."Allocation Code" := DesignSectionParHeader."Allocation Code";
        SalesLineGlobal.Validate("Variant Code", VariantCodePar);
        SalesLineGlobal."Par Level" := DesignSectionParHeader."Par Level";
        //Oversize Extra Charge 
        if SizeLoc.Get(DesignSectionParHeader."Item Size") then
            if SizeLoc."Extra Charge %" <> 0 then begin
                DesignSectionParHeader."Extra Charge %" := SizeLoc."Extra Charge %";
                DesignSectionParHeader."Extra Charge Amount" := (SalesLineGlobal."Line Amount" * SizeLoc."Extra Charge %") / 100;
                SalesLineGlobal."Extra Charge %" := SizeLoc."Extra Charge %";
                SalesLineGlobal."Extra Charge Amount" := (SalesLineGlobal."Line Amount" * SizeLoc."Extra Charge %") / 100;
                SalesLineGlobal.Validate(SalesLineGlobal."Amount", SalesLineGlobal.Amount + SalesLineGlobal."Extra Charge Amount")
            end;
        SalesLineGlobal."Qty Assignment Wizard Id" := QtyAssignmentWizard."Header Id";
        //Add Invenntory Quantity and Reserved Quantity and Available Quantity in the Inventory
        // Item.SetRange("Location Filter", DesignSectionParHeader."Sales Line Location Code");
        // Item.SetRange("Variant Filter", VariantCodePar);
        // //if Item.FindFirst() then begin
        //     Item.CalcFields("Reserved Qty. on Inventory",Inventory);
        //     SalesLineGlobal."Quantity in the Inventory" := Item."Inventory";
        //     SalesLineGlobal."Reserved Qty in the Inventory" := Item."Reserved Qty. on Inventory";
        //     SalesLineGlobal."Available Qty in the Inventory" := Item."Inventory"-Item."Reserved Qty. on Inventory";
        // //end;
        SalesLineGlobal.Insert(true);
        //Add Invenntory Quantity and Reserved Quantity and Available Quantity in the Inventory

        // SalesLineGlobal.get(SalesHeaderPar."Document Type", SalesHeaderPar."No.", LineNumber);
        // SalesLineGlobal.SetRange("Location Code",DesignSectionParHeader."Sales Line Location Code");
        // SalesLineGlobal.SetRange("Variant Code",VariantCodePar);

        // if SalesLineGlobal.FindFirst() then begin
        //     SalesLineGlobal.CalcFields("Reserved Qty. on Inventory");
        // end;
        DesignSectionParHeader."Sales Line Document Type" := SalesLineGlobal."Document Type";
        DesignSectionParHeader."Sales Line Document No." := SalesLineGlobal."Document No.";
        DesignSectionParHeader."Sales Line No." := SalesLineGlobal."Line No.";
        DesignSectionParHeader."Customer No." := SalesLineGlobal."Sell-to Customer No.";
        if QtyAssignmentWizard."Sales Line Unit Price" = 0 then begin
            QtyAssignmentWizard."Sales Line Unit Price" := SalesLineGlobal."Unit Price";
            QtyAssignmentWizard."Sales Line Discount %" := SalesLineGlobal."Line Discount %";
            //QtyAssignmentWizard."Sales Line Discount Amount" := SalesLineGlobal."Line Discount Amount";
            QtyAssignmentWizard."Extra Charge %" := SalesLineGlobal."Extra Charge %";
            //QtyAssignmentWizard."Extra Charge Amount" := SalesLineGlobal."Extra Charge Amount";
            QtyAssignmentWizard.Modify(true);
            //Update Parameter Header 
            DesignSectionParHeader."Sales Line Unit Price" := SalesLineGlobal."Unit Price";
            DesignSectionParHeader."Sales Line Amount" := SalesLineGlobal.Amount;
            DesignSectionParHeader."Sales Line Line Amount" := SalesLineGlobal."Line Amount";
            DesignSectionParHeader."Sales Line Amount Incl. VAT" := SalesLineGlobal."Amount Including VAT";
            DesignSectionParHeader."Sales Line Discount %" := SalesLineGlobal."Line Discount %";
            DesignSectionParHeader."Sales Line Discount Amount" := SalesLineGlobal."Line Discount Amount";
            DesignSectionParHeader."Extra Charge %" := SalesLineGlobal."Extra Charge %";
            DesignSectionParHeader."Extra Charge Amount" := SalesLineGlobal."Extra Charge Amount";
        end else begin
            SalesLineGlobal.Validate("Unit Price", QtyAssignmentWizard."Sales Line Unit Price");
            SalesLineGlobal.Validate("Amount", QtyAssignmentWizard."Sales Line Unit Price" * DesignSectionParHeader."Quantity To Assign");
            SalesLineGlobal.Validate("Line Amount", QtyAssignmentWizard."Sales Line Unit Price" * DesignSectionParHeader."Quantity To Assign");
            //SalesLineGlobal."Amount Including VAT" := QtyAssignmentWizard."Sales Line Amount Incl. VAT";
            SalesLineGlobal.Validate("Line Discount %", QtyAssignmentWizard."Sales Line Discount %");
            //SalesLineGlobal."Line Discount Amount" := QtyAssignmentWizard."Sales Line Discount Amount";
            SalesLineGlobal.Validate("Extra Charge %", QtyAssignmentWizard."Extra Charge %");
            //SalesLineGlobal."Extra Charge Amount" := QtyAssignmentWizard."Extra Charge Amount";
            SalesLineGlobal.Modify(true);
        end;
        DesignSectionParHeader.Modify();
    end;

    procedure DefaultColorAsMain(var DesignSectionParamLines: Record "Design Section Param Lines"; DesignSectParHeader: Record "Parameter Header"): Boolean
    var
        ItemDesignSectionColor: Record "Item Design Section Color";
    begin
        Clear(ItemDesignSectionColor);
        ItemDesignSectionColor.SetRange("Design Section Code", DesignSectionParamLines."Design Section Code");
        ItemDesignSectionColor.SetRange("Item No.", DesignSectParHeader."Item No.");
        ItemDesignSectionColor.SetRange("Color ID", DesignSectParHeader."Item Color ID");
        if ItemDesignSectionColor.FindFirst() then begin
            DesignSectionParamLines."Tonality Code" := ItemDesignSectionColor."Tonality Code";
            exit(true)
        end else
            exit(false);
    end;

    procedure DefaultColor(var DesignSectionParamLines: Record "Design Section Param Lines"; DesignSectParHeader: Record "Parameter Header")
    var
        ItemDesignSectionColor: Record "Item Design Section Color";
    begin
        Clear(ItemDesignSectionColor);
        ItemDesignSectionColor.SetRange("Design Section Code", DesignSectionParamLines."Design Section Code");
        ItemDesignSectionColor.SetRange("Item No.", DesignSectParHeader."Item No.");
        ItemDesignSectionColor.SetRange("Color ID", DesignSectParHeader."Item Color ID");
        ItemDesignSectionColor.SetRange("Default", true);
        if ItemDesignSectionColor.FindFirst() then begin
            DesignSectionParamLines."Color ID" := ItemDesignSectionColor."Color ID";
            DesignSectionParamLines."Tonality Code" := ItemDesignSectionColor."Tonality Code";
        end;
    end;

    procedure CreateItemFeaturesParameterLines(DesignSecParHeader: Record "Parameter Header")
    var
        ItemFeaturesParLines: Record "Item Features Param Lines";
        CounterLine: Integer;
        ItemFeatures: Record "Item Feature";
        Feature: Record Feature;
        ItemFeaturePossibleValue: Record "Item Feature Possible Values";
        ItemFeatPossValue: Record "Item Feature Possible Values";
    begin
        //To not recreate lines specially on loading parameter from sales line
        ItemFeaturesParLines.SetRange("Header ID", DesignSecParHeader.ID);
        if ItemFeaturesParLines.FindSet() then
            exit;
        Clear(ItemFeaturesParLines);
        ItemFeaturesParLines.SetRange("Header ID", DesignSecParHeader.ID);
        if ItemFeaturesParLines.FindSet() then
            ItemFeaturesParLines.DeleteAll();
        //Create Item Features Parameter Lines
        if ItemFeaturesParLines.FindLast() then
            CounterLine := ItemFeaturesParLines."Line No." + 1
        else
            CounterLine := 1;

        Clear(ItemFeaturesParLines);
        ItemFeaturesParLines.SetRange("Header ID", DesignSecParHeader.ID);
        if ItemFeaturesParLines.FindSet() then
            ItemFeaturesParLines.DeleteAll();
        ItemFeatures.SetRange("Item No.", DesignSecParHeader."Item No.");
        if ItemFeatures.FindSet() then
            repeat
                Feature.Get(ItemFeatures."Feature Name");
                Clear(ItemFeaturesParLines);
                ItemFeaturesParLines.Init();
                ItemFeaturesParLines."Header ID" := DesignSecParHeader.ID;
                ItemFeaturesParLines."Line No." := CounterLine;
                ItemFeaturesParLines."Feature Name" := ItemFeatures."Feature Name";
                if ItemFeatures.Value <> '' then
                    ItemFeaturesParLines.Value := ItemFeatures.Value
                //Set Default Value If Value blank
                else begin
                    ItemFeatPossValue.SetRange("Feature Name", ItemFeatures."Feature Name");
                    ItemFeatPossValue.SetRange("Default", true);
                    if ItemFeatPossValue.FindFirst() then
                        ItemFeaturesParLines.Value := ItemFeatPossValue."Possible Value";
                end;
                ItemFeaturesParLines.Cost := Feature.Cost;
                if ItemFeaturePossibleValue.Get(ItemFeaturesParLines.Value, ItemFeatures."Feature Name") then
                    ItemFeaturesParLines.Instructions := ItemFeaturePossibleValue.Instructions;
                ItemFeaturesParLines."Has Color" := Feature."Has Color";
                if Feature."Has Color" then
                    ItemFeaturesParLines."Color Id" := DesignSecParHeader."Item Color ID";
                ItemFeaturesParLines.Insert();
                CounterLine := CounterLine + 1;
            until ItemFeatures.Next() = 0;

    end;

    procedure CreateItemBrandingParameterLines(DesignSecParHeader: Record "Parameter Header")
    var
        ItemBrandingParLines: Record "Item Branding Param Lines";
        CounterLine: Integer;
        Branding: Record "Branding";
        SalesHeader: Record "Sales Header";
    begin
        //To not recreate lines specially on loading parameter from sales line
        ItemBrandingParLines.SetRange("Header ID", DesignSecParHeader.ID);
        if ItemBrandingParLines.FindSet() then
            exit;
        Clear(ItemBrandingParLines);
        ItemBrandingParLines.SetRange("Header ID", DesignSecParHeader.ID);
        if ItemBrandingParLines.FindSet() then
            ItemBrandingParLines.DeleteAll();
        //Create Item Branding Parameter Lines
        if ItemBrandingParLines.FindLast() then
            CounterLine := ItemBrandingParLines."Line No." + 1
        else
            CounterLine := 1;

        Branding.SetRange("Item No.", DesignSecParHeader."Item No.");
        //If the branding is related to IC
        if SalesHeader.Get(DesignSecParHeader."Sales Line Document Type", DesignSecParHeader."Sales Line Document No.") then
            if SalesHeader."IC Source No." <> '' then
                Branding.SetRange("Customer No.", SalesHeader."IC Source No.")
            else
                Branding.SetRange("Customer No.", DesignSecParHeader."Customer No.");
        if Branding.FindSet() then
            repeat
                Clear(ItemBrandingParLines);
                ItemBrandingParLines.Init();
                ItemBrandingParLines."Header ID" := DesignSecParHeader.ID;
                ItemBrandingParLines."Line No." := CounterLine;
                ItemBrandingParLines.Code := Branding.Code;
                ItemBrandingParLines.Name := Branding.Name;
                ItemBrandingParLines.Description := Branding.Description;
                ItemBrandingParLines."Color Id" := DesignSecParHeader."Item Color ID";
                ItemBrandingParLines.Include := false;
                ItemBrandingParLines.Insert();
                CounterLine := CounterLine + 1;
            until Branding.Next() = 0;
    end;

    procedure DeleteSalesLine(DesignSecParHeader: Record "Parameter Header")
    var
        SalesLineLoc: Record "Sales Line";
    begin
        Clear(SalesLineLoc);
        if SalesLineLoc.get(DesignSecParHeader."Sales Line Document Type", DesignSecParHeader."Sales Line Document No.", DesignSecParHeader."Sales Line No.") then
            SalesLineLoc.Delete();
    end;

    procedure DeleteUnselectedBranding(DesignParamID: Integer)
    var
        ItemBrandParLines2: Record "Item Branding Param Lines";
    begin
        ItemBrandParLines2.SetRange("Header ID", DesignParamID);
        ItemBrandParLines2.SetRange(Include, false);
        if ItemBrandParLines2.FindSet() then
            ItemBrandParLines2.DeleteAll();
    end;

    procedure CreateNeededRawMaterial(ParamHeader: Record "Parameter Header")
    var
        DesignSectionParamHeader: Record "Parameter Header";
        DesignSectionParamLine: Record "Design Section Param Lines";
        SalesLineLoc: Record "Sales Line";
        Txt001: Label 'An assembly has been already created for Item No. %1 in the Line No. %2';
    begin
        //Check if an assambly is already created
        /* if SalesLineLoc.get(ParamHeader."Sales Line Document Type", ParamHeader."Sales Line Document No.", ParamHeader."Sales Line No.") then begin
             SalesLineLoc.CalcFields("Assembly No.");*/
        //On Sales Quote you will have a number
        // if SalesLineLoc."Assembly No." = '' then begin

        //Create Needed RM for Not Inserted Design Section in item design section color (Should take same color as main item or default color)
        //CreateNeededRawMaterialForNotInserted(ParamHeader);
        //Create Needed RM for inserted unique design section colors for this item (Count of item design section color = 1)
        //No need for that anymore --> even the design section colors with unique color are now in wizard
        //CreateNeededRawMaterialUniqueColor(ParamHeader);
        //Create Needed RM for non unique design section colors for this item (Count of item design section color > 1)
        CreateNeededRawMaterialForDesignSecParamLines(ParamHeader);
        /* end else
                 Error(Txt001, SalesLineLoc."No.", SalesLineLoc."Line No.");*/
        //end;
    end;

    procedure CreateNeededRawMaterialForNotInserted(ParamHeader: Record "Parameter Header")
    var
        ItemDesingSecRMLoc: Record "Item Design Section RM";
        ItemLoc: Record Item;
        DesignDetail: Record "Design Detail";
        RawMaterial: Record "Raw Material";
        SalesLineLoc: Record "Sales Line";
        DesignSectionFilter: Text[2048];
        DesignSectionLoc: Record "Design Section";
        RMCategoryDesignSection: Record "RM Category Design Section";
        Design: Record Design;
    begin
        if NeededRawMaterial.FindLast() then begin
            Counter := NeededRawMaterial.ID + 1;
            BatchCounter := NeededRawMaterial.Batch + 1
        end else begin
            Counter := 1;
            BatchCounter := 1;
        end;
        Clear(NeededRawMaterial);
        //Retrieve the inserted item design section color inserted to exclude
        DesignSectionFilter := GetInsertedDesignSectionColor(ParamHeader);
        Clear(ItemLoc);
        ItemLoc.Get(ParamHeader."Item No.");
        Clear(DesignDetail);
        DesignDetail.SetCurrentKey("Section Code", "Design Code", "Size Code", "Fit Code");
        DesignDetail.SetRange("Design Code", ItemLoc."Design Code");
        DesignDetail.SetRange("Size Code", ParamHeader."Item Size");
        DesignDetail.SetRange("Fit Code", ParamHeader."Item Fit");
        //Different of inserted item design section color
        DesignDetail.SetFilter("Design Section Code", DesignSectionFilter);
        if DesignDetail.FindSet() then begin
            Clear(Design);
            Design.Get(DesignDetail."Design Code");
            repeat
                //if design section have just one RM Category --> choose the default one
                DesignSectionLoc.Get(DesignDetail."Design Section Code");
                DesignSectionLoc.SetFilter("Design Type Filter", Design.Type);
                DesignSectionLoc.CalcFields("Related RM Categories Count");
                if DesignSectionLoc."Related RM Categories Count" = 1 then begin
                    RMCategoryDesignSection.SetRange("Design Section Code", DesignSectionLoc.Code);
                    RMCategoryDesignSection.FindFirst();
                    InitRawMaterialForNotInserted(RMCategoryDesignSection."RM Category Code", DesignDetail, ParamHeader);
                end else begin
                    //if design section have more than one RM Category ---> Get RM Category from item design section fabric base on design section code
                    Clear(ItemDesingSecRMLoc);
                    ItemDesingSecRMLoc.SetRange("Item No.", ParamHeader."Item No.");
                    ItemDesingSecRMLoc.SetRange("Design Section Code", DesignDetail."Design Section Code");
                    if ItemDesingSecRMLoc.FindFirst() then
                        InitRawMaterialForNotInserted(ItemDesingSecRMLoc."Raw Material Category", DesignDetail, ParamHeader);
                end;
            until DesignDetail.Next() = 0;
        end;
    end;

    procedure CreateNeededRawMaterialUniqueColor(ParamHeader: Record "Parameter Header")
    var
        ItemDesignSectionColor: Record "Item Design Section Color";
        ItemDesingSecRMLoc: Record "Item Design Section RM";
        ItemLoc: Record Item;
        RawMaterial: Record "Raw Material";
        SalesLineLoc: Record "Sales Line";
        DesignSectionFilter: Text[2048];
        DesignDetail: Record "Design Detail";
        DesignSectionLoc: Record "Design Section";
        RMCategoryDesignSection: Record "RM Category Design Section";
        Design: Record Design;
    begin
        if NeededRawMaterial.FindLast() then begin
            Counter := NeededRawMaterial.ID + 1;
            BatchCounter := NeededRawMaterial.Batch + 1
        end else begin
            Counter := 1;
            BatchCounter := 1;
        end;
        Clear(ItemLoc);
        ItemLoc.Get(ParamHeader."Item No.");

        Clear(ItemDesignSectionColor);
        ItemDesignSectionColor.SetRange("Item No.", ParamHeader."Item No.");
        ItemDesignSectionColor.SetRange("Item Color ID", ParamHeader."Item Color ID");
        if ItemDesignSectionColor.FindFirst() then begin
            Clear(Design);
            Design.Get(DesignDetail."Design Code");
            repeat
                ItemDesignSectionColor.CalcFields("Design Section Color Count");
                if ItemDesignSectionColor."Design Section Color Count" = 1 then begin
                    //Get Related Design Detail
                    Clear(DesignDetail);
                    DesignDetail.SetRange("Design Code", ItemLoc."Design Code");
                    DesignDetail.SetRange("Size Code", ParamHeader."Item Size");
                    DesignDetail.SetRange("Fit Code", ParamHeader."Item Fit");
                    DesignDetail.SetRange("Design Section Code", ItemDesignSectionColor."Design Section Code");
                    DesignDetail.FindFirst();

                    //if design section have just one RM Category --> choose the default one
                    DesignSectionLoc.Get(DesignDetail."Design Section Code");
                    DesignSectionLoc.SetFilter("Design Type Filter", Design.Type);
                    DesignSectionLoc.CalcFields("Related RM Categories Count");
                    if DesignSectionLoc."Related RM Categories Count" = 1 then begin
                        RMCategoryDesignSection.SetRange("Design Section Code", DesignSectionLoc.Code);
                        RMCategoryDesignSection.FindFirst();
                        InitRawMaterialUnique(RMCategoryDesignSection."RM Category Code", ItemDesignSectionColor, DesignDetail, ParamHeader);
                    end else begin
                        //if design section have more than one RM Category ---> Get RM Category from item design section fabric base on design section code
                        Clear(ItemDesingSecRMLoc);
                        ItemDesingSecRMLoc.SetRange("Item No.", ParamHeader."Item No.");
                        ItemDesingSecRMLoc.SetRange("Design Section Code", ItemDesignSectionColor."Design Section Code");
                        if ItemDesingSecRMLoc.FindFirst() then
                            InitRawMaterialUnique(ItemDesingSecRMLoc."Raw Material Category", ItemDesignSectionColor, DesignDetail, ParamHeader);
                    end;
                end;
            until ItemDesignSectionColor.Next() = 0;
        end;
    end;

    procedure CreateNeededRawMaterialForDesignSecParamLines(ParamHeader: Record "Parameter Header")
    var
        ItemDesingSecRMLoc: Record "Item Design Section RM";
        ItemLoc: Record Item;
        DesignDetail: Record "Design Detail";
        RawMaterial: Record "Raw Material";
        SalesLineLoc: Record "Sales Line";
        DesignSectionParamLines: Record "Design Section Param Lines";
        DesignSectionLoc: Record "Design Section";
        RMCategoryDesignSection: Record "RM Category Design Section";
        Design: Record Design;
    begin
        if NeededRawMaterial.FindLast() then begin
            Counter := NeededRawMaterial.ID + 1;
            BatchCounter := NeededRawMaterial.Batch + 1;
        end else begin
            Counter := 1;
            BatchCounter := 1;
        end;
        Clear(NeededRawMaterial);
        Clear(DesignSectionParamLines);
        DesignSectionParamLines.SetRange("Header ID", ParamHeader.ID);
        if DesignSectionParamLines.FindSet() then begin
            repeat
                Clear(ItemLoc);
                ItemLoc.Get(ParamHeader."Item No.");
                Clear(DesignDetail);
                DesignDetail.SetCurrentKey("Section Code", "Design Code", "Size Code", "Fit Code");
                DesignDetail.SetRange("Design Code", ItemLoc."Design Code");
                DesignDetail.SetRange("Size Code", ParamHeader."Item Size");
                DesignDetail.SetRange("Fit Code", ParamHeader."Item Fit");
                DesignDetail.SetRange("Design Section Code", DesignSectionParamLines."Design Section Code");
                ///DesignDetail.SetRange("Section Group", DesignSectionParamLines."Section Group");
                if DesignDetail.FindSet() then begin
                    Clear(Design);
                    Design.Get(DesignDetail."Design Code");
                    repeat
                        //if design section have just one RM Category --> choose the default one
                        DesignSectionLoc.Get(DesignDetail."Design Section Code");
                        DesignSectionLoc.SetRange("Design Type Filter", Design.Type);
                        DesignSectionLoc.CalcFields("Related RM Categories Count");
                        if DesignSectionLoc."Related RM Categories Count" = 1 then begin
                            RMCategoryDesignSection.SetRange("Design Section Code", DesignSectionLoc.Code);
                            RMCategoryDesignSection.SetRange("Design Type", Design.Type);
                            RMCategoryDesignSection.FindFirst();
                            InitRawMaterialFromDesignSecParamLines(RMCategoryDesignSection."RM Category Code", DesignSectionParamLines, DesignDetail, ParamHeader);
                        end else begin
                            //if design section have more than one RM Category ---> Get RM Category from item design section fabric base on design section code
                            Clear(ItemDesingSecRMLoc);
                            ItemDesingSecRMLoc.SetRange("Item No.", ParamHeader."Item No.");
                            ItemDesingSecRMLoc.SetRange("Design Section Code", DesignDetail."Design Section Code");
                            if ItemDesingSecRMLoc.FindFirst() then
                                InitRawMaterialFromDesignSecParamLines(ItemDesingSecRMLoc."Raw Material Category", DesignSectionParamLines, DesignDetail, ParamHeader);
                        end;
                    until DesignDetail.Next() = 0;
                end;
            until DesignSectionParamLines.Next() = 0;
        end;
    end;

    procedure CreateNeededRawMaterialForDesignSecParamLines(ItemVariantPar: Record "Item Variant"; var AssemblyHeaderPar: Record "Assembly Header"): Integer
    var
        ItemDesingSecRMLoc: Record "Item Design Section RM";
        ItemLoc: Record Item;
        DesignDetail: Record "Design Detail";
        DesignSectionSetLoc: Record "Design Sections Set";
        DesignSectionLoc: Record "Design Section";
        RMCategoryDesignSection: Record "RM Category Design Section";
        Design: Record Design;
    begin
        if NeededRawMaterial.FindLast() then begin
            Counter := NeededRawMaterial.ID + 1;
            BatchCounter := NeededRawMaterial.Batch + 1;
        end else begin
            Counter := 1;
            BatchCounter := 1;
        end;
        Clear(NeededRawMaterial);
        Clear(DesignSectionSetLoc);
        DesignSectionSetLoc.SetRange("Design Section Set ID", ItemVariantPar."Design Sections Set ID");
        if DesignSectionSetLoc.FindSet() then begin
            repeat
                Clear(ItemLoc);
                ItemLoc.Get(ItemVariantPar."Item No.");
                Clear(DesignDetail);
                DesignDetail.SetCurrentKey("Section Code", "Design Code", "Size Code", "Fit Code");
                DesignDetail.SetRange("Design Code", ItemLoc."Design Code");
                DesignDetail.SetRange("Size Code", ItemVariantPar."Item Size");
                DesignDetail.SetRange("Fit Code", ItemVariantPar."Item Fit");
                DesignDetail.SetRange("Design Section Code", DesignSectionSetLoc."Design Section Code");
                ///DesignDetail.SetRange("Section Group", DesignSectionParamLines."Section Group");
                if DesignDetail.FindSet() then begin
                    Clear(Design);
                    Design.Get(DesignDetail."Design Code");
                    repeat
                        //if design section have just one RM Category --> choose the default one
                        DesignSectionLoc.Get(DesignDetail."Design Section Code");
                        DesignSectionLoc.SetRange("Design Type Filter", Design.Type);
                        DesignSectionLoc.CalcFields("Related RM Categories Count");
                        if DesignSectionLoc."Related RM Categories Count" = 1 then begin
                            RMCategoryDesignSection.SetRange("Design Section Code", DesignSectionLoc.Code);
                            RMCategoryDesignSection.SetRange("Design Type", Design.Type);
                            RMCategoryDesignSection.FindFirst();
                            InitRawMaterialFromDesignSecParamLines(RMCategoryDesignSection."RM Category Code", DesignSectionSetLoc, DesignDetail, ItemVariantPar, AssemblyHeaderPar);
                        end else begin
                            //if design section have more than one RM Category ---> Get RM Category from item design section fabric base on design section code
                            Clear(ItemDesingSecRMLoc);
                            ItemDesingSecRMLoc.SetRange("Item No.", ItemVariantPar."Item No.");
                            ItemDesingSecRMLoc.SetRange("Design Section Code", DesignDetail."Design Section Code");
                            if ItemDesingSecRMLoc.FindFirst() then
                                InitRawMaterialFromDesignSecParamLines(ItemDesingSecRMLoc."Raw Material Category", DesignSectionSetLoc, DesignDetail, ItemVariantPar, AssemblyHeaderPar);
                        end;
                    until DesignDetail.Next() = 0;
                end;
            until DesignSectionSetLoc.Next() = 0;
        end;
        exit(BatchCounter);
    end;

    procedure GetInsertedDesignSectionColor(ParamHeader: Record "Parameter Header"): Text[2048]
    var
        ItemDesignSecColor: Record "Item Design Section Color";
        PreviousDesignSection: Code[50];
        DesignSectionFilter: Text[2048];
    begin
        Clear(ItemDesignSecColor);
        ItemDesignSecColor.SetCurrentKey("Design Section Code");
        ItemDesignSecColor.SetRange("Item No.", ParamHeader."Item No.");
        ItemDesignSecColor.SetRange("Item Color ID", ParamHeader."Item Color ID");
        if ItemDesignSecColor.FindFirst() then
            repeat
                if PreviousDesignSection <> ItemDesignSecColor."Design Section Code" then begin
                    DesignSectionFilter := DesignSectionFilter + '<>' + ItemDesignSecColor."Design Section Code" + '&';
                end;
                PreviousDesignSection := ItemDesignSecColor."Design Section Code";
            until ItemDesignSecColor.Next() = 0;
        DesignSectionFilter := DELCHR("DesignSectionFilter", '>', '&');
        exit(DesignSectionFilter);
    end;

    procedure InitRawMaterialForNotInserted(RMCategoryCode: Code[50]; DesignDetail: Record "Design Detail"; ParamHeader: Record "Parameter Header")
    var
        SalesLineLoc: Record "Sales Line";
        RawMaterial: Record "Raw Material";
        LocDesignSection: Record "Design Section";
    begin
        Clear(RawMaterial);
        DesignDetail.CalcFields("UOM Code");
        LocDesignSection.Get(DesignDetail."Design Section Code");
        //The Raw Material should be unique by Fabric and Color and tonality
        //RawMaterial.SetRange("Design Section Code", DesignDetail."Design Section Code");

        //disable filter on UOM and do the conversion
        //RawMaterial.SetRange("UOM Code", DesignDetail."UOM Code");

        //Set The Color of design section same as unique if it's different than 0
        LocDesignSection.Get(DesignDetail."Design Section Code");
        if LocDesignSection."Unique Color" = 0 then
            RawMaterial.SetRange("Color ID", ParamHeader."Item Color ID")
        else
            RawMaterial.SetRange("Color ID", LocDesignSection."Unique Color");
        RawMaterial.SetRange("Raw Material Category", RMCategoryCode);
        RawMaterial.SetRange("Tonality Code", '0');
        if RawMaterial.FindSet() then begin
            Clear(SalesLineLoc);
            SalesLineLoc.Get(ParamHeader."Sales Line Document Type", ParamHeader."Sales Line Document No.", ParamHeader."Sales Line No.");
            repeat
                Clear(NeededRawMaterial);
                NeededRawMaterial.Init();
                NeededRawMaterial.ID := Counter;
                NeededRawMaterial."RM Code" := RawMaterial.Code;
                //Check if Raw Material has variant
                NeededRawMaterial."RM Variant Code" := CheckIfRawMaterialHasVariant(RawMaterial.Code, ParamHeader);
                NeededRawMaterial."Color ID" := RawMaterial."Color ID";
                NeededRawMaterial."Tonality Code" := RawMaterial."Tonality Code";
                NeededRawMaterial."Design Detail Line No." := DesignDetail."Line No.";
                NeededRawMaterial."Design Detail Design Code" := DesignDetail."Design Code";
                NeededRawMaterial."Design Detail Section Code" := DesignDetail."Section Code";
                NeededRawMaterial."Design Detail Design Sec. Code" := DesignDetail."Design Section Code";
                NeededRawMaterial."Design Detail Fit Code" := DesignDetail."Fit Code";
                NeededRawMaterial."Design Detail Quantity" := DesignDetail.Quantity;
                NeededRawMaterial."Design Detail Size Code" := DesignDetail."Size Code";
                NeededRawMaterial."Design Detail UOM Code" := DesignDetail."UOM Code";

                //Calculate Qty per UOM of Raw Material
                ItemRM.Get(RawMaterial.Code);
                QtyPerUOMRM := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, RawMaterial."UOM Code");
                //Calculate Qty per UOM of Design Detail
                QtyPerUOMDesignDetail := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, DesignDetail."UOM Code");

                DerivedQty := (DesignDetail.Quantity * QtyPerUOMDesignDetail) / QtyPerUOMRM;
                NeededRawMaterial."Raw Material Category" := RawMaterial."Raw Material Category";
                NeededRawMaterial."Sales Line Quantity" := SalesLineLoc."Quantity";
                NeededRawMaterial."Sales Line Item No." := SalesLineLoc."No.";
                NeededRawMaterial."Sales Line Location Code" := SalesLineLoc."Location Code";
                NeededRawMaterial."Sales Line UOM Code" := SalesLineLoc."Unit of Measure Code";
                NeededRawMaterial."Sales Order No." := SalesLineLoc."Document No.";
                NeededRawMaterial."Sales Order Line No." := SalesLineLoc."Line No.";
                NeededRawMaterial."Assembly Line Quantity" := SalesLineLoc.Quantity * DerivedQty;
                NeededRawMaterial."Assembly Line UOM Code" := RawMaterial."UOM Code";
                //Each set of raw material in one batch
                NeededRawMaterial.Batch := BatchCounter;
                //Add Parameters header Link
                NeededRawMaterial."Paramertes Header ID" := ParamHeader.ID;
                NeededRawMaterial.Insert(true);
                Counter := Counter + 1;
            until RawMaterial.Next() = 0;
        end;
    end;

    procedure InitRawMaterialUnique(RMCategoryCode: Code[50]; ItemDesignSectionColor: Record "Item Design Section Color"; DesignDetail: Record "Design Detail"; ParamHeader: Record "Parameter Header")
    var
        SalesLineLoc: Record "Sales Line";
        RawMaterial: Record "Raw Material";
    begin

        Clear(RawMaterial);
        DesignDetail.CalcFields("UOM Code");
        //The Raw Material should be unique by Fabric and Color
        //RawMaterial.SetRange("Design Section Code", DesignDetail."Design Section Code");

        //disable filter on UOM and do the conversion
        //RawMaterial.SetRange("UOM Code", DesignDetail."UOM Code");
        RawMaterial.SetRange("Color ID", ItemDesignSectionColor."Color ID");
        RawMaterial.SetRange("Tonality Code", ItemDesignSectionColor."Tonality Code");
        RawMaterial.SetRange("Raw Material Category", RMCategoryCode);
        if RawMaterial.FindSet() then begin
            Clear(SalesLineLoc);
            SalesLineLoc.Get(ParamHeader."Sales Line Document Type", ParamHeader."Sales Line Document No.", ParamHeader."Sales Line No.");
            repeat
                Clear(NeededRawMaterial);
                NeededRawMaterial.Init();
                NeededRawMaterial.ID := Counter;
                NeededRawMaterial."RM Code" := RawMaterial.Code;
                //Check if Raw Material has variant
                NeededRawMaterial."RM Variant Code" := CheckIfRawMaterialHasVariant(RawMaterial.Code, ParamHeader);
                NeededRawMaterial."Color ID" := RawMaterial."Color ID";
                NeededRawMaterial."Tonality Code" := RawMaterial."Tonality Code";
                NeededRawMaterial."Design Detail Line No." := DesignDetail."Line No.";
                NeededRawMaterial."Design Detail Design Code" := DesignDetail."Design Code";
                NeededRawMaterial."Design Detail Section Code" := DesignDetail."Section Code";
                NeededRawMaterial."Design Detail Design Sec. Code" := DesignDetail."Design Section Code";
                NeededRawMaterial."Design Detail Fit Code" := DesignDetail."Fit Code";
                NeededRawMaterial."Design Detail Quantity" := DesignDetail.Quantity;
                NeededRawMaterial."Design Detail Size Code" := DesignDetail."Size Code";
                NeededRawMaterial."Design Detail UOM Code" := DesignDetail."UOM Code";

                //NeededRawMaterial."Design Section" := RawMaterial."Design Section Code";
                NeededRawMaterial."Raw Material Category" := RawMaterial."Raw Material Category";

                //Calculate Qty per UOM of Raw Material
                ItemRM.Get(RawMaterial.Code);
                QtyPerUOMRM := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, RawMaterial."UOM Code");
                //Calculate Qty per UOM of Design Detail
                QtyPerUOMDesignDetail := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, DesignDetail."UOM Code");
                DerivedQty := (DesignDetail.Quantity * QtyPerUOMDesignDetail) / QtyPerUOMRM;

                NeededRawMaterial."Sales Line Quantity" := SalesLineLoc."Quantity";
                NeededRawMaterial."Sales Line Item No." := SalesLineLoc."No.";
                NeededRawMaterial."Sales Line Location Code" := SalesLineLoc."Location Code";
                NeededRawMaterial."Sales Line UOM Code" := SalesLineLoc."Unit of Measure Code";
                NeededRawMaterial."Sales Order No." := SalesLineLoc."Document No.";
                NeededRawMaterial."Sales Order Line No." := SalesLineLoc."Line No.";
                NeededRawMaterial."Assembly Line Quantity" := SalesLineLoc.Quantity * DerivedQty;
                NeededRawMaterial."Assembly Line UOM Code" := RawMaterial."UOM Code";
                //Each set of raw material in one batch
                NeededRawMaterial.Batch := BatchCounter;
                //Add Parameters header Link
                NeededRawMaterial."Paramertes Header ID" := ParamHeader.ID;
                NeededRawMaterial.Insert(true);
                Counter := Counter + 1;
            until RawMaterial.Next() = 0;
        end;
    end;

    procedure InitRawMaterialFromDesignSecParamLines(RMCategoryCode: Code[50]; DesignSectionParamLines: Record "Design Section Param Lines"; DesignDetail: Record "Design Detail"; ParamHeader: Record "Parameter Header")
    var
        SalesLineLoc: Record "Sales Line";
        RawMaterial: Record "Raw Material";
    begin
        Clear(RawMaterial);
        DesignDetail.CalcFields("UOM Code");
        RawMaterial.SetRange("Color ID", DesignSectionParamLines."Color ID");
        RawMaterial.SetRange("Tonality Code", DesignSectionParamLines."Tonality Code");
        RawMaterial.SetRange("Raw Material Category", RMCategoryCode);
        if RawMaterial.FindSet() then begin
            Clear(SalesLineLoc);
            SalesLineLoc.Get(ParamHeader."Sales Line Document Type", ParamHeader."Sales Line Document No.", ParamHeader."Sales Line No.");
            repeat
                Clear(NeededRawMaterial);
                NeededRawMaterial.Init();
                NeededRawMaterial.ID := Counter;
                NeededRawMaterial."RM Code" := RawMaterial.Code;
                //Check if Raw Material has variant
                NeededRawMaterial."RM Variant Code" := CheckIfRawMaterialHasVariant(RawMaterial.Code, ParamHeader);
                NeededRawMaterial."Color ID" := RawMaterial."Color ID";
                NeededRawMaterial."Tonality Code" := RawMaterial."Tonality Code";
                NeededRawMaterial."Design Detail Line No." := DesignDetail."Line No.";
                NeededRawMaterial."Design Detail Design Code" := DesignDetail."Design Code";
                NeededRawMaterial."Design Detail Section Code" := DesignDetail."Section Code";
                NeededRawMaterial."Design Detail Design Sec. Code" := DesignDetail."Design Section Code";
                NeededRawMaterial."Design Detail Fit Code" := DesignDetail."Fit Code";
                NeededRawMaterial."Design Detail Quantity" := DesignDetail.Quantity;
                NeededRawMaterial."Design Detail Size Code" := DesignDetail."Size Code";
                NeededRawMaterial."Design Detail UOM Code" := DesignDetail."UOM Code";

                NeededRawMaterial."Raw Material Category" := RawMaterial."Raw Material Category";

                //Calculate Qty per UOM of Raw Material
                ItemRM.Get(RawMaterial.Code);
                QtyPerUOMRM := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, RawMaterial."UOM Code");
                //Calculate Qty per UOM of Design Detail
                QtyPerUOMDesignDetail := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, DesignDetail."UOM Code");
                DerivedQty := (DesignDetail.Quantity * QtyPerUOMDesignDetail) / QtyPerUOMRM;

                DerivedQty := (DesignDetail.Quantity * QtyPerUOMDesignDetail) / QtyPerUOMRM;
                NeededRawMaterial."Raw Material Category" := RawMaterial."Raw Material Category";
                NeededRawMaterial."Sales Line Quantity" := SalesLineLoc."Quantity";
                NeededRawMaterial."Sales Line Item No." := SalesLineLoc."No.";
                NeededRawMaterial."Sales Line Location Code" := SalesLineLoc."Location Code";
                NeededRawMaterial."Sales Line UOM Code" := SalesLineLoc."Unit of Measure Code";
                NeededRawMaterial."Sales Order No." := SalesLineLoc."Document No.";
                NeededRawMaterial."Sales Order Line No." := SalesLineLoc."Line No.";
                NeededRawMaterial."Assembly Line Quantity" := SalesLineLoc.Quantity * DerivedQty;
                NeededRawMaterial."Assembly Line UOM Code" := RawMaterial."UOM Code";
                //Each set of raw material in one batch
                NeededRawMaterial.Batch := BatchCounter;
                //Add Parameters header Link
                NeededRawMaterial."Paramertes Header ID" := ParamHeader.ID;
                NeededRawMaterial.Insert(true);
                Counter := Counter + 1;
            until RawMaterial.Next() = 0;
        end;
    end;

    procedure InitRawMaterialFromDesignSecParamLines(RMCategoryCode: Code[50]; DesignSectionSet: Record "Design Sections Set"; DesignDetail: Record "Design Detail"; ItemVariantPar: Record "Item Variant"; AssemblyHeaderPar: Record "Assembly Header")
    var
        RawMaterial: Record "Raw Material";
    begin
        Clear(RawMaterial);
        DesignDetail.CalcFields("UOM Code");
        RawMaterial.SetRange("Color ID", DesignSectionSet."Color ID");
        RawMaterial.SetRange("Tonality Code", ItemVariantPar."Tonality Code");
        RawMaterial.SetRange("Raw Material Category", RMCategoryCode);
        if RawMaterial.FindSet() then begin
            /*Clear(SalesLineLoc);
            SalesLineLoc.Get(ParamHeader."Sales Line Document Type", ParamHeader."Sales Line Document No.", ParamHeader."Sales Line No.");*/
            repeat
                Clear(NeededRawMaterial);
                NeededRawMaterial.Init();
                NeededRawMaterial.ID := Counter;
                NeededRawMaterial."RM Code" := RawMaterial.Code;
                //Check if Raw Material has variant
                NeededRawMaterial."RM Variant Code" := CheckIfRawMaterialHasVariant(RawMaterial.Code, ItemVariantPar);
                NeededRawMaterial."Color ID" := RawMaterial."Color ID";
                NeededRawMaterial."Tonality Code" := RawMaterial."Tonality Code";
                NeededRawMaterial."Design Detail Line No." := DesignDetail."Line No.";
                NeededRawMaterial."Design Detail Design Code" := DesignDetail."Design Code";
                NeededRawMaterial."Design Detail Section Code" := DesignDetail."Section Code";
                NeededRawMaterial."Design Detail Design Sec. Code" := DesignDetail."Design Section Code";
                NeededRawMaterial."Design Detail Fit Code" := DesignDetail."Fit Code";
                NeededRawMaterial."Design Detail Quantity" := DesignDetail.Quantity;
                NeededRawMaterial."Design Detail Size Code" := DesignDetail."Size Code";
                NeededRawMaterial."Design Detail UOM Code" := DesignDetail."UOM Code";

                NeededRawMaterial."Raw Material Category" := RawMaterial."Raw Material Category";

                //Calculate Qty per UOM of Raw Material
                ItemRM.Get(RawMaterial.Code);
                QtyPerUOMRM := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, RawMaterial."UOM Code");
                //Calculate Qty per UOM of Design Detail
                QtyPerUOMDesignDetail := UOMManagement.GetQtyPerUnitOfMeasure(ItemRM, DesignDetail."UOM Code");
                DerivedQty := (DesignDetail.Quantity * QtyPerUOMDesignDetail) / QtyPerUOMRM;

                DerivedQty := (DesignDetail.Quantity * QtyPerUOMDesignDetail) / QtyPerUOMRM;
                NeededRawMaterial."Raw Material Category" := RawMaterial."Raw Material Category";
                /*NeededRawMaterial."Sales Line Quantity" := SalesLineLoc."Quantity";
                NeededRawMaterial."Sales Line Item No." := SalesLineLoc."No.";
                NeededRawMaterial."Sales Line Location Code" := SalesLineLoc."Location Code";
                NeededRawMaterial."Sales Line UOM Code" := SalesLineLoc."Unit of Measure Code";
                NeededRawMaterial."Sales Order No." := SalesLineLoc."Document No.";
                NeededRawMaterial."Sales Order Line No." := SalesLineLoc."Line No.";*/
                NeededRawMaterial."Sales Line Location Code" := AssemblyHeaderPar."Location Code";
                NeededRawMaterial."Assembly Order No." := AssemblyHeaderPar."No.";
                NeededRawMaterial."Assembly Line Quantity" := AssemblyHeaderPar.Quantity * DerivedQty;
                NeededRawMaterial."Assembly Line UOM Code" := RawMaterial."UOM Code";
                //Each set of raw material in one batch
                NeededRawMaterial.Batch := BatchCounter;
                //Add Parameters header Link
                //NeededRawMaterial."Paramertes Header ID" := ParamHeader.ID;
                NeededRawMaterial.Insert(true);
                Counter := Counter + 1;
            until RawMaterial.Next() = 0;
        end;
    end;

    procedure CreateAssemblyOrder(NeededRawMaterial: Record "Needed Raw Material"; ParameterHeaderPar: Record "Parameter Header"; ParentParameterHeaderPar: Record "Parameter Header")
    var
        SalesLine: Record "Sales Line";
        AssembleToOrderLink: Record "Assemble-to-Order Link";
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        NeededRMLoc: Record "Needed Raw Material";
        EndingDate: Date;
        DueDate: Date;
        LineNumber: Integer;
        AssemblySetup: Record "Assembly Setup";
        Item: Record Item;
        AvailableQty: Decimal;
        SalesHeader: Record "Sales Header";
    begin
        if IsCompanyFullProduction then begin

            #region[Create Assembly Header]
            /*Clear(AssemblyHeader);
            AssemblyHeader.Init();
            EndingDate := CalcDate('1M', Today);
            DueDate := CalcDate('1M', EndingDate);
            AssemblyHeader.Validate("Document Type", AssemblyHeader."Document Type"::Order);
            AssemblyHeader."Starting Date" := Today;
            AssemblyHeader."Ending Date" := EndingDate;
            AssemblyHeader."Due Date" := DueDate;
            AssemblyHeader.Validate("Item No.", NeededRawMaterial."Sales Line Item No.");
            AssemblyHeader.Validate("Location Code", NeededRawMaterial."Sales Line Location Code");
            AssemblyHeader.Validate("Quantity", NeededRawMaterial."Sales Line Quantity");
            AssemblyHeader.Validate("Unit of Measure Code", NeededRawMaterial."Sales Line UOM Code");
            AssemblyHeader."Source Type" := AssemblyHeader."Source Type"::"Sales Order";
            AssemblyHeader."Source No." := NeededRawMaterial."Sales Order No.";
            AssemblyHeader."Source Line No." := NeededRawMaterial."Sales Order Line No.";
            AssemblyHeader.Insert(true);*/

            //if AssemblyHeader."No." <> '' then begin
            //Link Sales Line To Assembly
            //The assembly will be auto created once we validate qty yo assemble to order
            Clear(SalesLine);
            SalesLine.Get(ParameterHeaderPar."Sales Line Document Type", NeededRawMaterial."Sales Order No.", NeededRawMaterial."Sales Order Line No.");
            //for Sales Quote you cannot reserve
            if SalesLine."Document Type" = SalesLine."Document Type"::Quote then begin
                SalesLine.Validate("Qty. to Assemble to Order", NeededRawMaterial."Sales Line Quantity");
                SalesLine.Validate("Parameters Header ID", NeededRawMaterial."Paramertes Header ID");
                SalesLine.Validate("Parent Parameter Header ID", ParentParameterHeaderPar.ID);
                SalesLine."Needed RM Batch" := NeededRawMaterial.Batch;
                SalesLine.Modify();
            end else begin
                //For Sales Order you can reserve
                //Check Item Availability by location
                Clear(Item);
                AvailableQty := 0;
                if Item.Get(SalesLine."No.") then;
                Item.SetRange("Location Filter", SalesLine."Location Code");
                Item.SetRange("Variant Filter", SalesLine."Variant Code");
                Item.CalcFields(Inventory, "FP Order Receipt (Qty.)", "Rel. Order Receipt (Qty.)", "Qty. on Assembly Order", "Qty. on Purch. Order", "Trans. Ord. Receipt (Qty.)", "Qty. On Sales Order", "Qty. on Component Lines", "Qty. on Asm. Component", "Trans. Ord. Shipment (Qty.)");
                AvailableQty := Item.Inventory
                                + (Item."FP Order Receipt (Qty.)" + Item."Rel. Order Receipt (Qty.)" + Item."Qty. on Assembly Order" + Item."Qty. on Purch. Order" + Item."Trans. Ord. Receipt (Qty.)")
                                - (Item."Qty. on Sales Order" + Item."Qty. on Component Lines" + Item."Qty. on Asm. Component" + Item."Trans. Ord. Shipment (Qty.)");

                //If available quantity less than requested quantity but greater than 0 --> just the difference
                if (AvailableQty < NeededRawMaterial."Sales Line Quantity") and (AvailableQty >= 0) then begin
                    SalesLine.Validate("Qty. to Assemble to Order", NeededRawMaterial."Sales Line Quantity" - AvailableQty);
                    SalesLine."Parameters Header ID" := NeededRawMaterial."Paramertes Header ID";
                    SalesLine.Validate("Parent Parameter Header ID", ParentParameterHeaderPar.ID);
                    SalesLine."Needed RM Batch" := NeededRawMaterial.Batch;
                    SalesLine.Modify();
                end else
                    //If available quantity Negative --> all the requested should be assembled
                    if (AvailableQty < 0) then begin
                        SalesLine.Validate("Qty. to Assemble to Order", NeededRawMaterial."Sales Line Quantity");
                        SalesLine.Validate("Parameters Header ID", NeededRawMaterial."Paramertes Header ID");
                        SalesLine.Validate("Parent Parameter Header ID", ParentParameterHeaderPar.ID);
                        SalesLine."Needed RM Batch" := NeededRawMaterial.Batch;
                        SalesLine.Modify();
                    end else
                        //If available quantity greater than requested quantity
                        if AvailableQty >= NeededRawMaterial."Sales Line Quantity" then begin
                            SalesLine.Validate(Reserve, SalesLine.Reserve::Always);
                            SalesLine.AutoReserve();
                            SalesLine."Parameters Header ID" := NeededRawMaterial."Paramertes Header ID";
                            SalesLine.Validate("Parent Parameter Header ID", ParentParameterHeaderPar.ID);
                            SalesLine."Needed RM Batch" := NeededRawMaterial.Batch;
                            SalesLine.Modify();
                            exit;
                        end;
            end;

            //Get the created Assembly No.
            Clear(AssembleToOrderLink);
            AssembleToOrderLink.SetRange(Type, AssembleToOrderLink.Type::Sale);
            AssembleToOrderLink.SetRange("Document Type", SalesLine."Document Type");
            AssembleToOrderLink.SetRange("Document No.", SalesLine."Document No.");
            AssembleToOrderLink.SetRange("Document Line No.", SalesLine."Line No.");
            AssembleToOrderLink.FindFirst();
            AssemblyHeader.GET(AssembleToOrderLink."Document Type", AssembleToOrderLink."Assembly Document No.");
            AssemblySetup.Get();
            AssemblyHeader."Workflow User Group Code" := AssemblySetup."Workflow User Group Code";
            AssemblyHeader."Sequence No." := 1;
            AssemblyHeader."Parameters Header ID" := SalesLine."Parameters Header ID";
            AssemblyHeader."Parent Parameter Header ID" := ParentParameterHeaderPar.ID;
            AssemblyHeader."Source Type" := SalesLine."Document Type";
            AssemblyHeader."Source No." := NeededRawMaterial."Sales Order No.";
            AssemblyHeader."Source Line No." := NeededRawMaterial."Sales Order Line No.";
            AssemblyHeader.CalcFields("Item Size", "Item Fit");
            //check if the item with embroidery
            if WithEmbroidery(AssemblyHeader) then
                AssemblyHeader."Grouping Criteria" := AssemblyHeader."Item No." + '-' + AssemblyHeader."Item Size" + '-' + AssemblyHeader."Item Fit" + '-WithEmb'
            else
                AssemblyHeader."Grouping Criteria" := AssemblyHeader."Item No." + '-' + AssemblyHeader."Item Size" + '-' + AssemblyHeader."Item Fit" + '-WithoutEmb';
            AssemblyHeader."Quantity to Assemble" := AssemblyHeader.Quantity;
            AssemblyHeader.Modify();
            //Create Cutting Sheet Dashboard 
            //Check if the variant is created
            if SalesLine."Variant Code" <> '' then begin
                If SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then
                    if SalesHeader."IC Source No." <> '' then
                        CreateCuttingSheetDashboard(AssemblyHeader, SalesHeader."IC Source No.")
                    else
                        CreateCuttingSheetDashboard(AssemblyHeader, ParameterHeaderPar."Customer No.");
            end;
            //Page.Run(Page::"Assembly Order", AssemblyHeader);
            //end;
            #endregion[Create Assembly Header]

            #region[Create Assembly Line]
            Clear(NeededRMLoc);
            LineNumber := 10000;
            NeededRMLoc.SetRange(Batch, NeededRawMaterial.Batch);
            if NeededRMLoc.FindSet() then begin
                repeat
                    Clear(AssemblyLine);
                    AssemblyLine.Init();
                    AssemblyLine."Document Type" := AssemblyHeader."Document Type";
                    AssemblyLine."Document No." := AssemblyHeader."No.";
                    AssemblyLine."Line No." := LineNumber;
                    AssemblyLine.Validate(Type, AssemblyLine.Type::Item);
                    AssemblyLine.Validate("No.", NeededRMLoc."RM Code");
                    //Raw Material Variant Code
                    AssemblyLine.Validate("Variant Code", NeededRMLoc."RM Variant Code");
                    AssemblyLine.Validate("Location Code", AssemblyHeader."Location Code");
                    AssemblyLine.Validate("Quantity Per", NeededRMLoc."Assembly Line Quantity" / AssemblyHeader.Quantity);
                    AssemblyLine.Validate("Quantity", NeededRMLoc."Assembly Line Quantity");
                    AssemblyLine.Validate("Unit of Measure Code", NeededRMLoc."Assembly Line UOM Code");
                    AssemblyLine.Validate(Reserve, AssemblyLine.Reserve::Always);
                    AssemblyLine.Insert(true);
                    AssemblyLine.AutoReserve();
                    LineNumber := LineNumber + 10000;
                    NeededRMLoc."Assembly Order No." := AssemblyHeader."No.";
                    NeededRMLoc."Assembly Order Line No." := AssemblyLine."Line No.";
                    NeededRMLoc.Modify();
                until NeededRMLoc.Next() = 0;
            end;
            #endregion[Create Assembly Line]   
        end else begin
            Clear(SalesLine);
            SalesLine.Get(ParameterHeaderPar."Sales Line Document Type", NeededRawMaterial."Sales Order No.", NeededRawMaterial."Sales Order Line No.");
            SalesLine.Validate("Parameters Header ID", NeededRawMaterial."Paramertes Header ID");
            SalesLine.Validate("Parent Parameter Header ID", ParentParameterHeaderPar.ID);
            SalesLine."Needed RM Batch" := NeededRawMaterial.Batch;
            SalesLine.Modify();
        end
    end;

    procedure CreateAssemblyOrder(NeededRawMaterial: Record "Needed Raw Material"; ParameterHeaderPar: Record "Parameter Header"; ParentParameterHeaderPar: Record "Parameter Header"; var SalesLine: Record "Sales Line")
    var
        AssembleToOrderLink: Record "Assemble-to-Order Link";
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        NeededRMLoc: Record "Needed Raw Material";
        EndingDate: Date;
        DueDate: Date;
        LineNumber: Integer;
        AssemblySetup: Record "Assembly Setup";
        Item: Record Item;
        AvailableQty: Decimal;
        SalesHeader: Record "Sales Header";
    begin
        if IsCompanyFullProduction then begin

            #region[Create Assembly Header]
            //Link Sales Line To Assembly
            //The assembly will be auto created once we validate qty yo assemble to order
            //for Sales Quote you cannot reserve
            if SalesLine."Document Type" = SalesLine."Document Type"::Quote then begin
                SalesLine.Validate("Qty. to Assemble to Order", NeededRawMaterial."Sales Line Quantity");
                SalesLine.Validate("Parameters Header ID", NeededRawMaterial."Paramertes Header ID");
                SalesLine.Validate("Parent Parameter Header ID", ParentParameterHeaderPar.ID);
                SalesLine."Needed RM Batch" := NeededRawMaterial.Batch;
                SalesLine.Modify();
            end else begin
                //For Sales Order you can reserve
                //Check Item Availability by location
                Clear(Item);
                AvailableQty := 0;
                if Item.Get(SalesLine."No.") then;
                Item.SetRange("Location Filter", SalesLine."Location Code");
                Item.SetRange("Variant Filter", SalesLine."Variant Code");
                Item.CalcFields(Inventory, "FP Order Receipt (Qty.)", "Rel. Order Receipt (Qty.)", "Qty. on Assembly Order", "Qty. on Purch. Order", "Trans. Ord. Receipt (Qty.)", "Qty. On Sales Order", "Qty. on Component Lines", "Qty. on Asm. Component", "Trans. Ord. Shipment (Qty.)");
                AvailableQty := Item.Inventory
                                + (Item."FP Order Receipt (Qty.)" + Item."Rel. Order Receipt (Qty.)" + Item."Qty. on Assembly Order" + Item."Qty. on Purch. Order" + Item."Trans. Ord. Receipt (Qty.)")
                                - (Item."Qty. on Sales Order" + Item."Qty. on Component Lines" + Item."Qty. on Asm. Component" + Item."Trans. Ord. Shipment (Qty.)");

                //If available quantity less than requested quantity but greater than 0 --> just the difference
                if (AvailableQty < NeededRawMaterial."Sales Line Quantity") and (AvailableQty >= 0) then begin
                    SalesLine.Validate("Qty. to Assemble to Order", NeededRawMaterial."Sales Line Quantity" - AvailableQty);
                    SalesLine."Parameters Header ID" := NeededRawMaterial."Paramertes Header ID";
                    SalesLine.Validate("Parent Parameter Header ID", ParentParameterHeaderPar.ID);
                    SalesLine."Needed RM Batch" := NeededRawMaterial.Batch;
                    SalesLine.Modify();
                end else
                    //If available quantity Negative --> all the requested should be assembled
                    if (AvailableQty < 0) then begin
                        SalesLine.Validate("Qty. to Assemble to Order", NeededRawMaterial."Sales Line Quantity");
                        SalesLine.Validate("Parameters Header ID", NeededRawMaterial."Paramertes Header ID");
                        SalesLine.Validate("Parent Parameter Header ID", ParentParameterHeaderPar.ID);
                        SalesLine."Needed RM Batch" := NeededRawMaterial.Batch;
                        SalesLine.Modify();
                    end else
                        //If available quantity greater than requested quantity
                        if AvailableQty >= NeededRawMaterial."Sales Line Quantity" then begin
                            SalesLine.Validate(Reserve, SalesLine.Reserve::Always);
                            SalesLine.AutoReserve();
                            SalesLine."Parameters Header ID" := NeededRawMaterial."Paramertes Header ID";
                            SalesLine.Validate("Parent Parameter Header ID", ParentParameterHeaderPar.ID);
                            SalesLine."Needed RM Batch" := NeededRawMaterial.Batch;
                            SalesLine.Modify();
                            exit;
                        end;
            end;

            //Get the created Assembly No.
            Clear(AssembleToOrderLink);
            AssembleToOrderLink.SetRange(Type, AssembleToOrderLink.Type::Sale);
            AssembleToOrderLink.SetRange("Document Type", SalesLine."Document Type");
            AssembleToOrderLink.SetRange("Document No.", SalesLine."Document No.");
            AssembleToOrderLink.SetRange("Document Line No.", SalesLine."Line No.");
            AssembleToOrderLink.FindFirst();
            AssemblyHeader.GET(AssembleToOrderLink."Document Type", AssembleToOrderLink."Assembly Document No.");
            AssemblySetup.Get();
            AssemblyHeader."Workflow User Group Code" := AssemblySetup."Workflow User Group Code";
            AssemblyHeader."Sequence No." := 1;
            AssemblyHeader."Parameters Header ID" := SalesLine."Parameters Header ID";
            AssemblyHeader."Parent Parameter Header ID" := ParentParameterHeaderPar.ID;
            AssemblyHeader."Source Type" := SalesLine."Document Type";
            AssemblyHeader."Source No." := NeededRawMaterial."Sales Order No.";
            AssemblyHeader."Source Line No." := NeededRawMaterial."Sales Order Line No.";
            AssemblyHeader.CalcFields("Item Size", "Item Fit");
            //check if the item with embroidery
            if WithEmbroidery(AssemblyHeader) then
                AssemblyHeader."Grouping Criteria" := AssemblyHeader."Item No." + '-' + AssemblyHeader."Item Size" + '-' + AssemblyHeader."Item Fit" + '-WithEmb'
            else
                AssemblyHeader."Grouping Criteria" := AssemblyHeader."Item No." + '-' + AssemblyHeader."Item Size" + '-' + AssemblyHeader."Item Fit" + '-WithoutEmb';
            AssemblyHeader."Quantity to Assemble" := AssemblyHeader.Quantity;
            AssemblyHeader.Modify();
            //Create Cutting Sheet Dashboard
            If SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then
                if SalesHeader."IC Source No." <> '' then
                    CreateCuttingSheetDashboard(AssemblyHeader, SalesHeader."IC Source No.")
                else
                    CreateCuttingSheetDashboard(AssemblyHeader, ParameterHeaderPar."Customer No.");
            //Page.Run(Page::"Assembly Order", AssemblyHeader);
            //end;
            #endregion[Create Assembly Header]

            #region[Create Assembly Line]
            Clear(NeededRMLoc);
            LineNumber := 10000;
            NeededRMLoc.SetRange(Batch, NeededRawMaterial.Batch);
            if NeededRMLoc.FindSet() then begin
                repeat
                    Clear(AssemblyLine);
                    AssemblyLine.Init();
                    AssemblyLine."Document Type" := AssemblyHeader."Document Type";
                    AssemblyLine."Document No." := AssemblyHeader."No.";
                    AssemblyLine."Line No." := LineNumber;
                    AssemblyLine.Validate(Type, AssemblyLine.Type::Item);
                    AssemblyLine.Validate("No.", NeededRMLoc."RM Code");
                    //Raw Material Variant Code
                    AssemblyLine.Validate("Variant Code", NeededRMLoc."RM Variant Code");
                    AssemblyLine.Validate("Location Code", AssemblyHeader."Location Code");
                    AssemblyLine.Validate("Quantity Per", NeededRMLoc."Assembly Line Quantity" / AssemblyHeader.Quantity);
                    AssemblyLine.Validate("Quantity", NeededRMLoc."Assembly Line Quantity");
                    AssemblyLine.Validate("Unit of Measure Code", NeededRMLoc."Assembly Line UOM Code");
                    AssemblyLine.Validate(Reserve, AssemblyLine.Reserve::Always);
                    AssemblyLine.Insert(true);
                    AssemblyLine.AutoReserve();
                    LineNumber := LineNumber + 10000;
                    NeededRMLoc."Assembly Order No." := AssemblyHeader."No.";
                    NeededRMLoc."Assembly Order Line No." := AssemblyLine."Line No.";
                    NeededRMLoc.Modify();
                until NeededRMLoc.Next() = 0;
            end;
            #endregion[Create Assembly Line]   
        end
        else begin
            Clear(SalesLine);
            SalesLine.Get(ParameterHeaderPar."Sales Line Document Type", NeededRawMaterial."Sales Order No.", NeededRawMaterial."Sales Order Line No.");
            SalesLine.Validate("Parameters Header ID", NeededRawMaterial."Paramertes Header ID");
            SalesLine.Validate("Parent Parameter Header ID", ParentParameterHeaderPar.ID);
            SalesLine."Needed RM Batch" := NeededRawMaterial.Batch;
            SalesLine.Modify();
        end
    end;

    procedure CreateParHeaderDepartments(ParamHeader: Record "Parameter Header")
    var
        ParDepartments: Record "Parameter Header Departments";
        CustomerDepartments: Record "Customer Departments";
    begin
        CustomerDepartments.SetRange("Customer No.", ParamHeader."Customer No.");
        if CustomerDepartments.FindSet() then
            repeat
                ParDepartments.Init();
                ParDepartments."Parameter Header ID" := ParamHeader.ID;
                ParDepartments."Department Code" := CustomerDepartments."Department Code";
                ParDepartments."Customer No." := ParamHeader."Customer No.";
                ParDepartments.Insert();
            until CustomerDepartments.Next() = 0;
    end;

    procedure CreateParHeaderPositions(ParamHeader: Record "Parameter Header")
    var
        ParDepartments: Record "Parameter Header Departments";
        ParPositions: Record "Parameter Header Positions";
        CustomerDepartments: Record "Customer Departments";
        DepartmentPositions: Record "Department Positions";
    begin
        ParDepartments.SetRange("Parameter Header ID", ParamHeader.ID);
        ParDepartments.SetRange(Include, true);
        if ParDepartments.FindSet() then
            repeat
                Clear(DepartmentPositions);
                DepartmentPositions.SetRange("Department Code", ParDepartments."Department Code");
                DepartmentPositions.SetRange("Customer No.", ParDepartments."Customer No.");
                if DepartmentPositions.FindSet() then
                    repeat
                        ParPositions.Init();
                        ParPositions."Parameter Header ID" := ParamHeader.ID;
                        ParPositions."Position Code" := DepartmentPositions."Position Code";
                        ParPositions."Customer No." := ParamHeader."Customer No.";
                        ParPositions.Insert();
                    until DepartmentPositions.Next() = 0;
            until ParDepartments.Next() = 0;
    end;

    procedure CreateParHeaderStaff(ParamHeader: Record "Parameter Header")
    var
        ParStaff: Record "Parameter Header Staff";
        ParDepartments: Record "Parameter Header Departments";
        ParPositions: Record "Parameter Header Positions";
        CustomerDepartments: Record "Customer Departments";
        DepartmentPositions: Record "Department Positions";
        Staff: Record "Staff";
    begin
        ParPositions.SetRange("Parameter Header ID", ParamHeader.ID);
        ParPositions.SetRange(Include, true);
        if ParPositions.FindSet() then
            repeat
                Clear(Staff);
                Staff.SetRange("Position Code", ParPositions."Position Code");
                Staff.SetRange("Customer No.", ParDepartments."Customer No.");
                if Staff.FindSet() then
                    repeat
                        ParStaff.Init();
                        ParStaff."Parameter Header ID" := ParamHeader.ID;
                        ParStaff."Staff Code" := Staff.Code;
                        ParStaff."Staff Name" := Staff.Name;
                        ParStaff."Position Code" := Staff."Position Code";
                        ParStaff."Customer No." := ParamHeader."Customer No.";
                        ParStaff.Insert();
                    until Staff.Next() = 0;
            until ParPositions.Next() = 0;
    end;

    procedure CreateParHeaderStaffSizes(ParamHeader: Record "Parameter Header")
    var
        ParStaff: Record "Parameter Header Staff";
        ParStaffSizes: Record "Parameter Header Staff Sizes";
        ParDepartments: Record "Parameter Header Departments";
        ParPositions: Record "Parameter Header Positions";
        CustomerDepartments: Record "Customer Departments";
        DepartmentPositions: Record "Department Positions";
        StaffSizes: Record "Staff Sizes";
    begin
        ParStaff.SetRange("Parameter Header ID", ParamHeader.ID);
        ParStaff.SetRange(Include, true);
        if ParStaff.FindSet() then
            repeat
                Clear(StaffSizes);
                StaffSizes.SetRange("Staff Code", ParStaff."Staff Code");
                StaffSizes.SetRange("Customer No.", ParStaff."Customer No.");
                if StaffSizes.FindSet() then
                    repeat
                        ParStaffSizes.Init();
                        ParStaffSizes."Parameter Header ID" := ParamHeader.ID;
                        ParStaffSizes."Staff Code" := StaffSizes."Staff Code";
                        ParStaffSizes."Size Code" := StaffSizes."Size Code";
                        ParStaffSizes."Fit Code" := StaffSizes."Fit Code";
                        ParStaffSizes."Customer No." := ParamHeader."Customer No.";
                        ParStaffSizes.Insert();
                    until StaffSizes.Next() = 0;
            until ParStaff.Next() = 0;
    end;

    procedure DeleteOldDepartments(ParamHeaderID: Integer)
    var
        ParDepartments: Record "Parameter Header Departments";
    begin
        ParDepartments.SetRange("Parameter Header ID", ParamHeaderID);
        if ParDepartments.FindSet() then
            ParDepartments.DeleteAll();
    end;

    procedure DeleteOldPositions(ParamHeaderID: Integer)
    var
        ParPositions: Record "Parameter Header Positions";
    begin
        ParPositions.SetRange("Parameter Header ID", ParamHeaderID);
        if ParPositions.FindSet() then
            ParPositions.DeleteAll();
    end;

    procedure DeleteOldStaffs(ParamHeaderID: Integer)
    var
        ParStaffs: Record "Parameter Header Staff";
    begin
        ParStaffs.SetRange("Parameter Header ID", ParamHeaderID);
        if ParStaffs.FindSet() then
            ParStaffs.DeleteAll();
    end;

    procedure DeleteOldStaffSizes(ParamHeaderID: Integer)
    var
        ParStaffSizes: Record "Parameter Header Staff Sizes";
    begin
        ParStaffSizes.SetRange("Parameter Header ID", ParamHeaderID);
        if ParStaffSizes.FindSet() then
            ParStaffSizes.DeleteAll();
    end;

    procedure CreateParameterHeaderPerStaffSize(ParameterHeaderID: Integer; SalesHeader: Record "Sales Header")
    var
        StaffSizesPar: Record "Parameter Header Staff Sizes";
        ParameterHeader: Record "Parameter Header";
        LastParHeader: Record "Parameter Header";
    begin
        StaffSizesPar.SetRange("Parameter Header ID", ParameterHeaderID);
        StaffSizesPar.SetRange(Include, true);
        if StaffSizesPar.FindSet() then
            repeat
                ParameterHeader.Init();
                if LastParHeader.FindLast() then
                    ParameterHeader.ID := LastParHeader.ID + 1
                else
                    ParameterHeader.ID := 1;
                ParameterHeader."Customer No." := SalesHeader."Sell-to Customer No.";
                ParameterHeader."Item Size" := StaffSizesPar."Size Code";
                ParameterHeader."Item Fit" := StaffSizesPar."Fit Code";
                ParameterHeader."Staff Sizes Parameter Header" := StaffSizesPar."Parameter Header ID";
                ParameterHeader."Sales Line Quantity" := StaffSizesPar.Quantity;
                ParameterHeader."Allocation Type" := ParameterHeader."Allocation Type"::Staff;
                ParameterHeader."Allocation Code" := StaffSizesPar."Staff Code";
                ParameterHeader.Insert();
            until StaffSizesPar.Next() = 0;
    end;

    procedure UpdateParameterHeaderPerStaffSize(ParameterHeader: Record "Parameter Header"; SalesHeader: Record "Sales Header")
    var
        ParHeader: Record "Parameter Header";
        DesignSecParamLines: Record "Design Section Param Lines";
        ItemFeatureParamLines: Record "Item Features Param Lines";
        ItemBrandParamLines: Record "Item Branding Param Lines";
        DesignSecParamLines2: Record "Design Section Param Lines";
        ItemFeatureParamLines2: Record "Item Features Param Lines";
        ItemBrandParamLines2: Record "Item Branding Param Lines";
    begin
        ParHeader.SetRange("Staff Sizes Parameter Header", ParameterHeader.ID);
        if ParHeader.FindSet() then
            repeat
                ParHeader."Item No." := ParameterHeader."Item No.";
                ParHeader."Item Color ID" := ParameterHeader."Item Color ID";
                ParHeader."Sales Line Document No." := ParameterHeader."Sales Line Document No.";
                ParHeader."Sales Line Document Type" := ParameterHeader."Sales Line Document Type";
                ParHeader."Tonality Code" := ParameterHeader."Tonality Code";
                ParHeader."Sales Line UOM" := ParameterHeader."Sales Line UOM";
                ParHeader."Sales Line Location Code" := ParameterHeader."Sales Line Location Code";
                ParHeader."Design Sections Set ID" := ParameterHeader."Design Sections Set ID";
                ParHeader."Item Features Set ID" := ParameterHeader."Item Features Set ID";
                ParHeader."Item Brandings Set ID" := ParameterHeader."Item Brandings Set ID";
                ParHeader.Modify();

                //Create Related Design Section Lines
                DesignSecParamLines.SetRange("Header ID", ParameterHeader.ID);
                if DesignSecParamLines.FindSet() then
                    repeat
                        DesignSecParamLines2.Init();
                        DesignSecParamLines2.TransferFields(DesignSecParamLines);
                        DesignSecParamLines2."Header ID" := ParHeader.ID;
                        DesignSecParamLines2.Insert();
                    until DesignSecParamLines.Next() = 0;
                //Create Related Features Lines
                ItemFeatureParamLines.SetRange("Header ID", ParameterHeader.ID);
                if ItemFeatureParamLines.FindSet() then
                    repeat
                        ItemFeatureParamLines2.Init();
                        ItemFeatureParamLines2.TransferFields(ItemFeatureParamLines);
                        ItemFeatureParamLines2."Header ID" := ParHeader.ID;
                        ItemFeatureParamLines2.Insert();
                    until ItemFeatureParamLines.Next() = 0;
                //Create Related Branding Lines
                ItemBrandParamLines.SetRange("Header ID", ParameterHeader.ID);
                if ItemBrandParamLines.FindSet() then
                    repeat
                        ItemBrandParamLines2.Init();
                        ItemBrandParamLines2.TransferFields(ItemBrandParamLines);
                        ItemBrandParamLines2."Header ID" := ParHeader.ID;
                        ItemBrandParamLines2.Insert();
                    until ItemBrandParamLines.Next() = 0;

            until ParHeader.Next() = 0;
    end;

    procedure CreateCuttingSheetDashboard(AssemblyHeader: Record "Assembly Header"; CustomerNo: Code[20])
    var
        CuttingSheetDashboard: Record "Cutting Sheets Dashboard";
        ItemVariant: Record "Item Variant";
        ItemBrandingSet: Record "Item Brandings Set";
        Branding: Record Branding;
        WithEmbroidery: Boolean;
        SalesRecivableSetup: Record "Sales & Receivables Setup";
        BrandingCategory: Record "Branding Category";
    begin
        WithEmbroidery := false;
        SalesRecivableSetup.get();
        CuttingSheetDashboard.Init();
        CuttingSheetDashboard."Assembly No." := AssemblyHeader."No.";
        CuttingSheetDashboard."Item No." := AssemblyHeader."Item No.";
        CuttingSheetDashboard."Variant Code" := AssemblyHeader."Variant Code";
        CuttingSheetDashboard.Description := AssemblyHeader.Description;
        CuttingSheetDashboard."Cutting Sheet Workflow Group" := SalesRecivableSetup."Cutting Sheet Workflow Group";
        CuttingSheetDashboard."Current Sequence No." := 1;
        CuttingSheetDashboard."Source Type" := AssemblyHeader."Source Type";
        CuttingSheetDashboard."Source No." := AssemblyHeader."Source No.";
        CuttingSheetDashboard."Source Line No." := AssemblyHeader."Source Line No.";
        //Check if there is Embroidery
        if ItemVariant.Get(AssemblyHeader."Item No.", AssemblyHeader."Variant Code") then
            if ItemVariant."Item Brandings Set ID" <> 0 then begin
                ItemBrandingSet.SetRange("Item Branding Set ID", ItemVariant."Item Brandings Set ID");
                if ItemBrandingSet.FindSet() then
                    repeat
                        Clear(Branding);
                        Branding.SetRange("Item No.", AssemblyHeader."Item No.");
                        Branding.SetRange(Code, ItemBrandingSet."Item Branding Code");
                        if Branding.FindFirst() then
                            //If Branding.Get(ItemBrandingSet."Item Branding Code", CustomerNo) then
                            if BrandingCategory.Get(Branding."Branding Category Code") then
                                if BrandingCategory."With Embroidery" then begin
                                    //if Branding."Branding Category Code" = SalesRecivableSetup."Branding Category Code" then begin
                                    WithEmbroidery := true;
                                    break;
                                end;
                    until ItemBrandingSet.Next() = 0;
            end;
        if WithEmbroidery = false then
            CuttingSheetDashboard."3" := CuttingSheetDashboard."3"::"Not Available";
        CuttingSheetDashboard.Insert(true);
    end;

    procedure CreateMultipleSalesLines(var DesignSectionParHeader: Record "Parameter Header"; SalesHeaderPar: Record "Sales Header"; VariantCodePar: Code[10]; var ParentParHeader: Record "Parameter Header"; QtyAssignmentWizard: Record "Qty Assignment Wizard"; WithVariant: Boolean)
    var
        WizardDepartments: Record "Wizard Departments";
        WizardPositions: Record "Wizard Positions";
        WizardStaff: Record "Wizard Staff";
        ParameterHeaderLoc: Record "Parameter Header";
        Txt001: Label 'There is no related raw materials to the wizard parameters selection for the item %1';
        Assigned: Boolean;
    begin
        Assigned := false;
        //Create Line For Each Department
        WizardDepartments.SetRange("Parameter Header Id", DesignSectionParHeader.ID);
        WizardDepartments.Setfilter("Quantity To Assign", '>0');
        if WizardDepartments.FindSet() then
            repeat
                Assigned := true;
                ParameterHeaderLoc := CreateParHeaderPerDepartment(WizardDepartments, DesignSectionParHeader);
                CreateSalesLine(ParameterHeaderLoc, SalesHeaderPar, VariantCodePar, WizardDepartments."Quantity To Assign", ParentParHeader, QtyAssignmentWizard);
                // UpdateDesignFeatureBrandingParamLines(DesignSectionParHeader, ParameterHeaderLoc);
                if WithVariant then begin
                    if ParameterHeaderLoc."Sales Line No." <> 0 then begin
                        //Create Needed Raw Material
                        CreateNeededRawMaterial(ParameterHeaderLoc);
                        //Create Assembly
                        if NeededRawMaterial.Id = 0 then
                            if IsCompanyFullProduction then
                                Error(Txt001, ParameterHeaderLoc."Item No.");
                        if IsCompanyFullProduction then
                            CreateAssemblyOrder(NeededRawMaterial, ParameterHeaderLoc, ParentParHeader);
                    end;
                end;
            until WizardDepartments.Next() = 0;
        //Create Line For Each Position
        WizardPositions.SetRange("Parameter Header Id", DesignSectionParHeader.ID);
        WizardPositions.Setfilter("Quantity To Assign", '>0');
        if WizardPositions.FindSet() then
            repeat
                Assigned := true;
                ParameterHeaderLoc := CreateParHeaderPerPosition(WizardPositions, DesignSectionParHeader);
                CreateSalesLine(ParameterHeaderLoc, SalesHeaderPar, VariantCodePar, WizardPositions."Quantity To Assign", ParentParHeader, QtyAssignmentWizard);
                //UpdateDesignFeatureBrandingParamLines(DesignSectionParHeader, ParameterHeaderLoc);
                if WithVariant then begin
                    if ParameterHeaderLoc."Sales Line No." <> 0 then begin
                        //Create Needed Raw Material
                        CreateNeededRawMaterial(ParameterHeaderLoc);
                        //Create Assembly
                        if NeededRawMaterial.Id = 0 then
                            if IsCompanyFullProduction then
                                Error(Txt001, ParameterHeaderLoc."Item No.");
                        if IsCompanyFullProduction then
                            CreateAssemblyOrder(NeededRawMaterial, ParameterHeaderLoc, ParentParHeader);
                    end;
                end;
            until WizardPositions.Next() = 0;
        //Create Line For Each Staff
        WizardStaff.SetRange("Parameter Header Id", DesignSectionParHeader.ID);
        WizardStaff.Setfilter("Quantity To Assign", '>0');
        if WizardStaff.FindSet() then
            repeat
                Assigned := true;
                ParameterHeaderLoc := CreateParHeaderPerStaff(WizardStaff, DesignSectionParHeader);
                CreateSalesLine(ParameterHeaderLoc, SalesHeaderPar, VariantCodePar, WizardStaff."Quantity To Assign", ParentParHeader, QtyAssignmentWizard);
                //UpdateDesignFeatureBrandingParamLines(DesignSectionParHeader, ParameterHeaderLoc);
                if WithVariant then begin
                    if ParameterHeaderLoc."Sales Line No." <> 0 then begin
                        //Create Needed Raw Material
                        CreateNeededRawMaterial(ParameterHeaderLoc);
                        //Create Assembly
                        if NeededRawMaterial.Id = 0 then
                            if IsCompanyFullProduction then
                                Error(Txt001, ParameterHeaderLoc."Item No.");
                        if IsCompanyFullProduction then
                            CreateAssemblyOrder(NeededRawMaterial, ParameterHeaderLoc, ParentParHeader);
                    end;
                end;
            until WizardStaff.Next() = 0;

        //If the line in qty assignment is not assigned to a department or position or staff
        if Assigned = false then begin
            CreateSalesLine(DesignSectionParHeader, SalesHeaderPar, VariantCodePar, QtyAssignmentWizard."Quantity To Assign", ParentParHeader, QtyAssignmentWizard);
            if WithVariant then begin
                if DesignSectionParHeader."Sales Line No." <> 0 then begin
                    //Create Needed Raw Material
                    CreateNeededRawMaterial(DesignSectionParHeader);
                    //Create Assembly
                    if NeededRawMaterial.Id = 0 then
                        if IsCompanyFullProduction then
                            Error(Txt001, DesignSectionParHeader."Item No.");
                    if NeededRawMaterial.Id <> 0 then
                        CreateAssemblyOrder(NeededRawMaterial, DesignSectionParHeader, ParentParHeader);
                    //Update Parameter Header Quantity
                    DesignSectionParHeader."Sales Line Quantity" := QtyAssignmentWizard."Quantity To Assign";
                    DesignSectionParHeader."Quantity To Assign" := 0;
                    DesignSectionParHeader.Modify();
                end;
            end;
        end;
    end;

    procedure CreateParHeaderPerDepartment(WizardDepartments: Record "Wizard Departments";
        ParamHeaderPar: Record "Parameter Header"): Record "Parameter Header"
    var
        ParameterHeader: Record "Parameter Header";
        LastParmaeterHeader: Record "Parameter Header";
        LastID: Integer;
    begin
        if LastParmaeterHeader.FindLast() then
            LastID := LastParmaeterHeader.ID + 1
        else
            LastID := 1;
        ParameterHeader.Init();
        ParameterHeader.TransferFields(ParamHeaderPar);
        ParameterHeader.ID := LastID;
        ParameterHeader."Sales Line Quantity" := WizardDepartments."Quantity To Assign";
        ParameterHeader."Quantity To Assign" := WizardDepartments."Quantity To Assign";
        ParameterHeader."Allocation Type" := ParameterHeader."Allocation Type"::Department;
        ParameterHeader."Allocation Code" := WizardDepartments."Department Code";
        ParameterHeader."Par Level" := WizardDepartments."Par Level";
        ParameterHeader.Insert();
        exit(ParameterHeader)
    end;

    procedure CreateParHeaderPerPosition(WizardPositions: Record "Wizard Positions"; ParamHeaderPar: Record "Parameter Header"): Record "Parameter Header"
    var
        ParameterHeader: Record "Parameter Header";
        LastParmaeterHeader: Record "Parameter Header";
        LastID: Integer;
    begin
        if LastParmaeterHeader.FindLast() then
            LastID := LastParmaeterHeader.ID + 1
        else
            LastID := 1;
        ParameterHeader.Init();
        ParameterHeader.TransferFields(ParamHeaderPar);
        ParameterHeader.ID := LastID;
        ParameterHeader."Sales Line Quantity" := WizardPositions."Quantity To Assign";
        ParameterHeader."Quantity To Assign" := WizardPositions."Quantity To Assign";
        ParameterHeader."Allocation Type" := ParameterHeader."Allocation Type"::Position;
        ParameterHeader."Allocation Code" := WizardPositions."Position Code";
        ParameterHeader."Department Code" := WizardPositions."Department Code";
        ParameterHeader."Par Level" := WizardPositions."Par Level";
        ParameterHeader.Insert();
        exit(ParameterHeader)
    end;

    procedure CreateParHeaderPerStaff(WizardStaff: Record "Wizard Staff"; ParamHeaderPar: Record "Parameter Header"): Record "Parameter Header"
    var
        ParameterHeader: Record "Parameter Header";
        LastParmaeterHeader: Record "Parameter Header";
        LastID: Integer;
    begin
        if LastParmaeterHeader.FindLast() then
            LastID := LastParmaeterHeader.ID + 1
        else
            LastID := 1;
        ParameterHeader.Init();
        ParameterHeader.TransferFields(ParamHeaderPar);
        ParameterHeader.ID := LastID;
        ParameterHeader."Sales Line Quantity" := WizardStaff."Quantity To Assign";
        ParameterHeader."Quantity To Assign" := WizardStaff."Quantity To Assign";
        ParameterHeader."Allocation Type" := ParameterHeader."Allocation Type"::Staff;
        ParameterHeader."Allocation Code" := WizardStaff."Staff Code";
        ParameterHeader."Department Code" := WizardStaff."Department Code";
        ParameterHeader."Position Code" := WizardStaff."Position Code";
        ParameterHeader."Par Level" := WizardStaff."Par Level";
        ParameterHeader.Insert();
        exit(ParameterHeader)
    end;

    procedure UpdateDesignFeatureBrandingParamLines(OriginalParHeader: Record "Parameter Header"; NewParHeader: Record "Parameter Header")
    var
        DesignSecParamLines: Record "Design Section Param Lines";
        DesignSecParamLines2: Record "Design Section Param Lines" temporary;
        ItemFeatureParamLines: Record "Item Features Param Lines";
        ItemFeatureParamLines2: Record "Item Features Param Lines" temporary;
        ItemBrandParamLines: Record "Item Branding Param Lines";
        ItemBrandParamLines2: Record "Item Branding Param Lines" temporary;
    begin
        //Create Related Design Section Lines
        DesignSecParamLines.SetRange("Header ID", OriginalParHeader.ID);
        if DesignSecParamLines.FindSet() then
            repeat
                DesignSecParamLines2.Init();
                DesignSecParamLines2.TransferFields(DesignSecParamLines);
                DesignSecParamLines2."Header ID" := NewParHeader.ID;
                if DesignSecParamLines2.Insert() then;
            until DesignSecParamLines.Next() = 0;
        //Create Related Features Lines
        ItemFeatureParamLines.SetRange("Header ID", OriginalParHeader.ID);
        if ItemFeatureParamLines.FindSet() then
            repeat
                ItemFeatureParamLines2.Init();
                ItemFeatureParamLines2.TransferFields(ItemFeatureParamLines);
                ItemFeatureParamLines2."Header ID" := NewParHeader.ID;
                if ItemFeatureParamLines2.Insert() then;
            until ItemFeatureParamLines.Next() = 0;
        //Create Related Branding Lines
        ItemBrandParamLines.SetRange("Header ID", OriginalParHeader.ID);
        if ItemBrandParamLines.FindSet() then
            repeat
                ItemBrandParamLines2.Init();
                ItemBrandParamLines2.TransferFields(ItemBrandParamLines);
                ItemBrandParamLines2."Header ID" := NewParHeader.ID;
                if ItemBrandParamLines2.Insert() then;
            until ItemBrandParamLines.Next() = 0;
        UpdateDesignFeatureBrandingParamLinesFromTemp(DesignSecParamLines2, ItemFeatureParamLines2, ItemBrandParamLines2);
    end;

    procedure UpdateDesignFeatureBrandingParamLinesFromTemp(Var DesignSecParamLinesPar: Record "Design Section Param Lines" temporary; Var ItemFeatureParamLinesPar: Record "Item Features Param Lines" temporary; Var ItemBrandParamLinesPar: Record "Item Branding Param Lines" temporary)
    var
        DesignSecParamLines: Record "Design Section Param Lines";
        ItemFeatureParamLines: Record "Item Features Param Lines";
        ItemBrandParamLines: Record "Item Branding Param Lines";
        MasterItemCU: Codeunit MasterItem;
        DesignSecParamLinesToDelete: Record "Design Section Param Lines";
        ItemFeatureParamLinesToDelete: Record "Item Features Param Lines";
        ItemBrandParamLinesToDelete: Record "Item Branding Param Lines";
    begin
        if DesignSecParamLinesPar.FindSet() then begin
            //Delete Old Child Lines
            DesignSecParamLinesToDelete.SetRange("Header ID", DesignSecParamLinesPar."Header ID");
            if DesignSecParamLinesToDelete.FindSet() then
                DesignSecParamLinesToDelete.DeleteAll();
            repeat
                DesignSecParamLines.Init();
                DesignSecParamLines.TransferFields(DesignSecParamLinesPar);
                DesignSecParamLines."Header ID" := DesignSecParamLinesPar."Header ID";
                if DesignSecParamLines.Insert() then;
            until DesignSecParamLinesPar.Next() = 0;
        end;

        if ItemFeatureParamLinesPar.FindSet() then begin
            //Delete Old Child Lines
            ItemFeatureParamLinesToDelete.SetRange("Header ID", ItemFeatureParamLinesPar."Header ID");
            if ItemFeatureParamLinesToDelete.FindSet() then
                ItemFeatureParamLinesToDelete.DeleteAll();
            repeat
                ItemFeatureParamLines.Init();
                ItemFeatureParamLines.TransferFields(ItemFeatureParamLinesPar);
                ItemFeatureParamLines."Header ID" := ItemFeatureParamLinesPar."Header ID";
                if ItemFeatureParamLines.Insert() then;
            until ItemFeatureParamLinesPar.Next() = 0;
        end;

        if ItemBrandParamLinesPar.FindSet() then begin
            //Delete Old Child Lines
            ItemBrandParamLinesToDelete.SetRange("Header ID", ItemBrandParamLinesPar."Header ID");
            if ItemBrandParamLinesToDelete.FindSet() then
                ItemBrandParamLinesToDelete.DeleteAll();
            repeat
                ItemBrandParamLines.Init();
                ItemBrandParamLines.TransferFields(ItemBrandParamLinesPar);
                ItemBrandParamLines."Header ID" := ItemBrandParamLinesPar."Header ID";
                if ItemBrandParamLines.Insert() then;
            until ItemBrandParamLinesPar.Next() = 0;
            DesignSecParamLinesPar.DeleteAll();
            ItemFeatureParamLinesPar.DeleteAll();
            ItemBrandParamLinesPar.DeleteAll();
        end;
    end;

    procedure IsCompanyFullProduction(): boolean
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        Txt001: Label 'You must select Company Type in the General Ledger Setup page,in the Master Item Tab';
    begin
        GeneralLedgerSetup.Get();
        if GeneralLedgerSetup."Company Type" = GeneralLedgerSetup."Company Type"::" " then
            Error(Txt001);
        if GeneralLedgerSetup."Company Type" <> GeneralLedgerSetup."Company Type"::"Full Production" then
            exit(false)
        else
            exit(true);
    end;

    procedure CreateQtyAssignmentWizard(ParamHeaderPar: Record "Parameter Header")
    var
        QtyAssignmentWizard: Record "Qty Assignment Wizard";
        LastParameterHeader: Record "Parameter Header";
        NewParameterHeader: Record "Parameter Header";
        QtyAssignWizardPage: Page "Quantity Assigment Wizard";
    begin
        Clear(QtyAssignmentWizard);
        QtyAssignmentWizard.SetRange("Parent Header Id", ParamHeaderPar.ID);
        if QtyAssignmentWizard.FindFirst() then
            exit
        else begin
            NewParameterHeader.Init();
            NewParameterHeader.TransferFields(ParamHeaderPar);
            if LastParameterHeader.FindLast() then
                NewParameterHeader.ID := LastParameterHeader.ID + 1
            else
                NewParameterHeader.ID := 1;
            NewParameterHeader.Insert();
            QtyAssignmentWizard.Init();
            QtyAssignmentWizard."Parent Header Id" := ParamHeaderPar.ID;
            QtyAssignmentWizard."Header Id" := NewParameterHeader.ID;
            QtyAssignWizardPage.GetRelatedInfo(NewParameterHeader."Item No.", QtyAssignmentWizard);
            QtyAssignmentWizard.Insert();
        end;
    end;

    procedure UpdateAndClose(ParameterHeader: Record "Parameter Header")
    var
        SalesLinesToDelete: Record "Sales Line";
        QtyAssignmentWizard: Record "Qty Assignment Wizard";
        ChildrenParameterHeader: Record "Parameter Header";
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("No.", ParameterHeader."Sales Line Document No.");
        SalesHeader.FindFirst();
        //Delete Old Sales lines to create new ones
        SalesLinesToDelete.SetRange("Parent Parameter Header ID", ParameterHeader."ID");
        if SalesLinesToDelete.FindSet() then
            SalesLinesToDelete.DeleteAll(true);
        //Create Variant for each child
        Clear(QtyAssignmentWizard);
        QtyAssignmentWizard.SetRange("Parent Header ID", ParameterHeader.ID);
        if QtyAssignmentWizard.FindSet() then
            repeat
                Clear(ChildrenParameterHeader);
                if ChildrenParameterHeader.Get(QtyAssignmentWizard."Header Id") then;
                //Update The parameters Headers Related to Qty Assignment
                UpdateDesignFeatureBrandingParamLines(ParameterHeader, ChildrenParameterHeader);
                //CreateSalesLine + Needed Raw Materials + Assembly
                CreateMultipleSalesLines(ChildrenParameterHeader, SalesHeader, '', ParameterHeader, QtyAssignmentWizard, false);
                //Update parameter header to the line (Remove the Assigned Qty)
                ChildrenParameterHeader."Sales Line Quantity" := ChildrenParameterHeader."Sales Line Quantity" - ChildrenParameterHeader."Quantity To Assign";
                ChildrenParameterHeader."Quantity To Assign" := 0;
                ChildrenParameterHeader.Modify();
            //CreateSalesLine + Needed Raw Materials + Assembly for "Sales Line Quantity" - "Quantity To Assign"
            /*if ChildrenParameterHeader."Sales Line Quantity" > ChildrenParameterHeader."Quantity To Assign" then begin
                CreateSalesLine(ChildrenParameterHeader, SalesHeader, VariantCode, ChildrenParameterHeader."Sales Line Quantity" - ChildrenParameterHeader."Quantity To Assign");
                CreateNeededRawMaterial(ChildrenParameterHeader);
                CreateAssemblyOrder(NeededRawMaterial, ChildrenParameterHeader, ParamHeader);
            end;*/
            until QtyAssignmentWizard.Next() = 0
        else
            CreateSalesLine(ParameterHeader, SalesHeader, '', ParameterHeader."Sales Line Quantity", ParameterHeader, QtyAssignmentWizard);
    end;

    procedure GetItemBaseUOM(ItemNo: Code[20]): Code[10]
    var
        Item: Record Item;
    begin
        Clear(Item);
        Item.Get(ItemNo);
        exit(Item."Base Unit of Measure");
    end;

    procedure CheckDesignSectionRawMaterial(var DesignSectionParamLinePar: Record "Design Section Param Lines"; ParamHeader: Record "Parameter Header"; ModifyAction: Option "Insert","Modify")
    var
        ItemLoc: Record Item;
        Design: Record Design;
        DesignSectionLoc: Record "Design Section";
        RMCategoryDesignSection: Record "RM Category Design Section";
        ItemDesingSecRMLoc: Record "Item Design Section RM";
        RawMaterial: Record "Raw Material";
    begin
        Clear(ItemLoc);
        ItemLoc.Get(ParamHeader."Item No.");
        Clear(Design);
        Design.Get(ItemLoc."Design Code");
        //if design section have just one RM Category --> choose the default one
        DesignSectionLoc.Get(DesignSectionParamLinePar."Design Section Code");
        DesignSectionLoc.SetRange("Design Type Filter", Design.Type);
        DesignSectionLoc.CalcFields("Related RM Categories Count");
        if DesignSectionLoc."Related RM Categories Count" = 1 then begin
            RMCategoryDesignSection.SetRange("Design Section Code", DesignSectionLoc.Code);
            RMCategoryDesignSection.SetRange("Design Type", Design.Type);
            RMCategoryDesignSection.FindFirst();
            Clear(RawMaterial);
            RawMaterial.SetRange("Color ID", DesignSectionParamLinePar."Color ID");
            RawMaterial.SetRange("Tonality Code", DesignSectionParamLinePar."Tonality Code");
            RawMaterial.SetRange("Raw Material Category", RMCategoryDesignSection."RM Category Code");
            if RawMaterial.FindFirst() then begin
                DesignSectionParamLinePar."Has Raw Material" := true;
                DesignSectionParamLinePar."Raw Material Code" := RawMaterial.Code;
                if ModifyAction = ModifyAction::Modify then
                    DesignSectionParamLinePar.Modify(true);
            end;
        end else begin
            //if design section have more than one RM Category ---> Get RM Category from item design section fabric base on design section code
            Clear(ItemDesingSecRMLoc);
            ItemDesingSecRMLoc.SetRange("Item No.", ParamHeader."Item No.");
            ItemDesingSecRMLoc.SetRange("Design Section Code", DesignSectionParamLinePar."Design Section Code");
            if ItemDesingSecRMLoc.FindFirst() then begin
                Clear(RawMaterial);
                RawMaterial.SetRange("Color ID", DesignSectionParamLinePar."Color ID");
                RawMaterial.SetRange("Tonality Code", DesignSectionParamLinePar."Tonality Code");
                RawMaterial.SetRange("Raw Material Category", ItemDesingSecRMLoc."Raw Material Category");
                if RawMaterial.FindFirst() then begin
                    DesignSectionParamLinePar."Has Raw Material" := true;
                    DesignSectionParamLinePar."Raw Material Code" := RawMaterial.Code;
                    if ModifyAction = ModifyAction::Modify then
                        DesignSectionParamLinePar.Modify(true);
                end;
            end;
        end;
    end;

    Procedure WithEmbroidery(AssemblyHeaderPar: Record "Assembly Header"): Boolean
    var
        ItemVariant: Record "Item Variant";
        BrandingSet: Record "Item Brandings Set";
        Branding: Record Branding;
        BrandingCategory: Record "Branding Category";
    begin
        Clear(ItemVariant);
        if ItemVariant.Get(AssemblyHeaderPar."Item No.", AssemblyHeaderPar."Variant Code") then begin
            Clear(BrandingSet);
            BrandingSet.SetRange("Item Branding Set ID", ItemVariant."Item Brandings Set ID");
            if BrandingSet.FindSet() then
                repeat
                    Clear(Branding);
                    Branding.SetRange(Code, BrandingSet."Item Branding Code");
                    if Branding.FindFirst() then
                        if BrandingCategory.Get(Branding."Branding Category Code") then
                            //if Branding."Branding Category Code" = SalesReceivSetup."Branding Category Code" then
                            if BrandingCategory."With Embroidery" then
                                exit(true);
                until BrandingSet.Next() = 0;
            exit(false);
        end;
    end;

    procedure CheckIfRawMaterialHasVariant(RMCode: Code[20]; ParamHeaderPar: Record "Parameter Header"): Text[10]
    var
        ItemVariant: Record "Item Variant";
    begin
        Clear(ItemVariant);
        ItemVariant.SetRange("Item No.", RMCode);
        ItemVariant.SetRange("Item Size", ParamHeaderPar."Item Size");
        ItemVariant.SetRange("Item Color Id", ParamHeaderPar."Item Color Id");
        if ItemVariant.FindFirst() then
            exit(ItemVariant."Code")
        else
            exit('');

    end;

    procedure CheckIfRawMaterialHasVariant(RMCode: Code[20]; ItemVariantPar: Record "Item Variant"): Text[10]
    var
        ItemVariant: Record "Item Variant";
    begin
        Clear(ItemVariant);
        ItemVariant.SetRange("Item No.", RMCode);
        ItemVariant.SetRange("Item Size", ItemVariantPar."Item Size");
        ItemVariant.SetRange("Item Color Id", ItemVariantPar."Item Color Id");
        if ItemVariant.FindFirst() then
            exit(ItemVariant."Code")
        else
            exit('');

    end;

    local procedure IsRawMaterial(ItemNoPar: Code[20]): Boolean
    var
        Item: Record Item;
    begin
        Clear(Item);
        if Item.Get(ItemNoPar) then begin
            Item.CalcFields(IsRawMaterial);
            exit(Item.IsRawMaterial);
        end;

    end;

    local procedure CreateVariantForEachChild(QtyAssignmentWizard: Record "Qty Assignment Wizard"; ParamHeader: Record "Parameter Header")
    var
        ChildrenParameterHeader: Record "Parameter Header";
        MasterItem: Codeunit MasterItem;
        VariantCode: Code[10];
    begin
        Clear(QtyAssignmentWizard);
        QtyAssignmentWizard.SetRange("Parent Header ID", ParamHeader.ID);
        if QtyAssignmentWizard.FindSet() then
            repeat
                Clear(ChildrenParameterHeader);
                ChildrenParameterHeader.Get(QtyAssignmentWizard."Header Id");
                VariantCode := MasterItem.CreateVariant(ChildrenParameterHeader);
                Message('The Variant code is %1', VariantCode);
            until QtyAssignmentWizard.Next() = 0;
    end;

    procedure CreateParameterHeaderForAssembly(var AssemblyHeaderPar: Record "Assembly Header")
    var
        ParameterHeader: Record "Parameter Header";
        ItemVariantLoc: Record "Item Variant";
        ParameterFormPage: Page "Parameters Form";
    begin
        Clear(ItemVariantLoc);
        if ItemVariantLoc.Get(AssemblyHeaderPar."Item No.", AssemblyHeaderPar."Variant Code") then;
        ParameterHeader.Init();
        ParameterHeader."Item No." := AssemblyHeaderPar."Item No.";
        ParameterHeader."Sales Line Quantity" := AssemblyHeaderPar.Quantity;
        ParameterHeader."Quantity To Assign" := AssemblyHeaderPar.Quantity;
        ParameterHeader."Item Size" := ItemVariantLoc."Item Size";
        ParameterHeader."Item Fit" := ItemVariantLoc."Item Fit";
        ParameterHeader."Item Color ID" := ItemVariantLoc."Item Color ID";
        ParameterHeader."Tonality Code" := ItemVariantLoc."Tonality Code";
        ParameterHeader."Sales Line UOM" := AssemblyHeaderPar."Unit of Measure Code";
        ParameterHeader."Design Sections Set ID" := ItemVariantLoc."Design Sections Set ID";
        ParameterHeader."Item Features Set ID" := ItemVariantLoc."Item Features Set ID";
        ParameterHeader."Item Brandings Set ID" := ItemVariantLoc."Item Brandings Set ID";
        ParameterHeader."Variance Combination Text" := ItemVariantLoc."Variance Combination Text";
        ParameterHeader.Insert(true);
        AssemblyHeaderPar."Parameters Header ID" := ParameterHeader.ID;
        AssemblyHeaderPar.Modify(true);
        //Update Parameter Lines from Set (Design Section, Item Features, Item Brandings)
        ParameterFormPage.UpdateParameterLinesFromSet(ParameterHeader);
    end;


    procedure CheckVariantCode(DesignSectionParHeader: Record "Parameter Header"): Code[10]
    var
        ItemVariant: Record "Item Variant";
        lastItemVariant: Record "Item Variant";
        ItemLocal: Record Item;
        ItemReference: Record "Item Reference";
        ItemUOM: Record "Item Unit of Measure";
        ParentGlobalSyncSetup: Record "Global Sync Setup";
        ChildGlobalSyncSetup: Record "Global Sync Setup";

    begin
        Clear(ChildGlobalSyncSetup);
        ChildGlobalSyncSetup.Get(CompanyName);
        if ChildGlobalSyncSetup."Sync Type" = ChildGlobalSyncSetup."Sync Type"::Child then begin
            //Sync Log to insert any modifications from parent
            //Stopped because it needs Global Sync Admin user access
            //GlobalSyncData.Run();
            //Change to parent company
            Clear(ParentGlobalSyncSetup);
            ParentGlobalSyncSetup.SetRange("Sync Type", ParentGlobalSyncSetup."Sync Type"::Parent);
            ParentGlobalSyncSetup.FindFirst();
            ItemVariant.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            lastItemVariant.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            ItemLocal.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            ItemReference.ChangeCompany(ParentGlobalSyncSetup."Company Name");
            ItemUOM.ChangeCompany(ParentGlobalSyncSetup."Company Name");
        end;
        ItemVariant.Reset();
        ItemVariant.SetRange("Item No.", DesignSectionParHeader."Item No.");
        ItemVariant.SetRange("Item Size", DesignSectionParHeader."Item Size");
        ItemVariant.SetRange("Item Fit", DesignSectionParHeader."Item Fit");
        ItemVariant.SetRange("Item Color ID", DesignSectionParHeader."Item Color ID");
        ItemVariant.SetRange("Tonality Code", DesignSectionParHeader."Tonality Code");
        ItemVariant.SetRange("Design Sections Set ID", DesignSectionParHeader."Design Sections Set ID");
        ItemVariant.SetRange("Item Features Set ID", DesignSectionParHeader."Item Features Set ID");
        ItemVariant.SetRange("Item Brandings Set ID", DesignSectionParHeader."Item Brandings Set ID");
        if ItemVariant.FindFirst() then begin
            exit(ItemVariant.Code);
        end;
    end;

    var
        SalesLineGlobal: Record "Sales Line";
        NeededRawMaterial: Record "Needed Raw Material";
        Counter: Integer;
        BatchCounter: Integer;
        UOMManagement: Codeunit "Unit of Measure Management";
        QtyPerUOMRM: Decimal;
        QtyPerUOMDesignDetail: Decimal;
        DerivedQty: Decimal;
        ItemRM: Record Item;
        SourceType: Option " ","Department","Position","Staff";


}
