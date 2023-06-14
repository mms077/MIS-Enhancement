page 50207 "ER - Sales Lines"
{
    ApplicationArea = All;
    Caption = 'ER - Sales Lines';
    PageType = List;
    SourceTable = "Sales Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Type"; Rec."Type")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Variant Code"; Rec."Variant Code")
                {
                }
                field("Design Sections Set"; Rec."Design Sections Set")
                {

                }
                field("Item Features Set"; Rec."Item Features Set")
                {

                }
                field("Item Brandings Set"; Rec."Item Brandings Set")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Posting Group"; Rec."Posting Group")
                {
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Description 2"; Rec."Description 2")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                }
                field("VAT %"; Rec."VAT %")
                {
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Net Weight"; Rec."Net Weight")
                {
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                }
                field("Job No."; Rec."Job No.")
                {
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                }
                field("Recalculate Invoice Disc."; Rec."Recalculate Invoice Disc.")
                {
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                }
                field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
                {
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                }
                field("Shipment Line No."; Rec."Shipment Line No.")
                {
                }
                field("Profit %"; Rec."Profit %")
                {
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                }
                field("Purch. Order Line No."; Rec."Purch. Order Line No.")
                {
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                }
                field("VAT Calculation Type"; Rec."VAT Calculation Type")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Transport Method"; Rec."Transport Method")
                {
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                }
                field("Exit Point"; Rec."Exit Point")
                {
                }
                field("Area"; Rec."Area")
                {
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                }
                field("Tax Category"; Rec."Tax Category")
                {
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                }
                field("VAT Clause Code"; Rec."VAT Clause Code")
                {
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Outstanding Amount (LCY)"; Rec."Outstanding Amount (LCY)")
                {
                }
                field("Shipped Not Invoiced (LCY)"; Rec."Shipped Not Invoiced (LCY)")
                {
                }
                field("Shipped Not Inv. (LCY) No VAT"; Rec."Shipped Not Inv. (LCY) No VAT")
                {
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                }
                field(Reserve; Rec.Reserve)
                {
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                }
                field("Inv. Disc. Amount to Invoice"; Rec."Inv. Disc. Amount to Invoice")
                {
                }
                field("VAT Identifier"; Rec."VAT Identifier")
                {
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                }
                field("Prepmt. Amt. Incl. VAT"; Rec."Prepmt. Amt. Incl. VAT")
                {
                }
                field("Prepayment Amount"; Rec."Prepayment Amount")
                {
                }
                field("Prepmt. VAT Base Amt."; Rec."Prepmt. VAT Base Amt.")
                {
                }
                field("Prepayment VAT %"; Rec."Prepayment VAT %")
                {
                }
                field("Prepmt. VAT Calc. Type"; Rec."Prepmt. VAT Calc. Type")
                {
                }
                field("Prepayment VAT Identifier"; Rec."Prepayment VAT Identifier")
                {
                }
                field("Prepayment Tax Area Code"; Rec."Prepayment Tax Area Code")
                {
                }
                field("Prepayment Tax Liable"; Rec."Prepayment Tax Liable")
                {
                }
                field("Prepayment Tax Group Code"; Rec."Prepayment Tax Group Code")
                {
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                }
                field("Prepayment Line"; Rec."Prepayment Line")
                {
                }
                field("Prepmt. Amount Inv. Incl. VAT"; Rec."Prepmt. Amount Inv. Incl. VAT")
                {
                }
                field("Prepmt. Amount Inv. (LCY)"; Rec."Prepmt. Amount Inv. (LCY)")
                {
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                }
                field("Prepmt. VAT Amount Inv. (LCY)"; Rec."Prepmt. VAT Amount Inv. (LCY)")
                {
                }
                field("Prepayment VAT Difference"; Rec."Prepayment VAT Difference")
                {
                }
                field("Prepmt VAT Diff. to Deduct"; Rec."Prepmt VAT Diff. to Deduct")
                {
                }
                field("Prepmt VAT Diff. Deducted"; Rec."Prepmt VAT Diff. Deducted")
                {
                }
                field("IC Item Reference No."; Rec."IC Item Reference No.")
                {
                }
                field("Pmt. Discount Amount"; Rec."Pmt. Discount Amount")
                {
                }
                field("Prepmt. Pmt. Discount Amount"; Rec."Prepmt. Pmt. Discount Amount")
                {
                }
                field("Line Discount Calculation"; Rec."Line Discount Calculation")
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
                field("Qty. to Assemble to Order"; Rec."Qty. to Assemble to Order")
                {
                }
                field("Qty. to Asm. to Order (Base)"; Rec."Qty. to Asm. to Order (Base)")
                {
                }
                field("ATO Whse. Outstanding Qty."; Rec."ATO Whse. Outstanding Qty.")
                {
                }
                field("ATO Whse. Outstd. Qty. (Base)"; Rec."ATO Whse. Outstd. Qty. (Base)")
                {
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                }
                field("Job Contract Entry No."; Rec."Job Contract Entry No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                }
                field("Returns Deferral Start Date"; Rec."Returns Deferral Start Date")
                {
                }
                field("Bin Code"; Rec."Bin Code")
                {
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                }
                field(Planned; Rec.Planned)
                {
                }
                field("Qty. Rounding Precision"; Rec."Qty. Rounding Precision")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Qty. Rounding Precision (Base)"; Rec."Qty. Rounding Precision (Base)")
                {
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                }
                field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
                {
                }
                field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
                {
                }
                field("Qty. to Ship (Base)"; Rec."Qty. to Ship (Base)")
                {
                }
                field("Qty. Shipped Not Invd. (Base)"; Rec."Qty. Shipped Not Invd. (Base)")
                {
                }
                field("Qty. Shipped (Base)"; Rec."Qty. Shipped (Base)")
                {
                }
                field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
                {
                }
                field("Reserved Qty. (Base)"; Rec."Reserved Qty. (Base)")
                {
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field("Out-of-Stock Substitution"; Rec."Out-of-Stock Substitution")
                {
                }
                field("Substitution Available"; Rec."Substitution Available")
                {
                }
                field("Originally Ordered No."; Rec."Originally Ordered No.")
                {
                }
                field("Originally Ordered Var. Code"; Rec."Originally Ordered Var. Code")
                {
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                }
                field(Nonstock; Rec.Nonstock)
                {
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                }
                field("Special Order"; Rec."Special Order")
                {
                }
                field("Special Order Purchase No."; Rec."Special Order Purchase No.")
                {
                }
                field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
                {
                }
                field("Item Reference No."; Rec."Item Reference No.")
                {
                }
                field("Item Reference Unit of Measure"; Rec."Item Reference Unit of Measure")
                {
                }
                field("Item Reference Type"; Rec."Item Reference Type")
                {
                }
                field("Item Reference Type No."; Rec."Item Reference Type No.")
                {
                }
                field("Whse. Outstanding Qty."; Rec."Whse. Outstanding Qty.")
                {
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                }
                field("Return Qty. to Receive"; Rec."Return Qty. to Receive")
                {
                }
                field("Return Qty. to Receive (Base)"; Rec."Return Qty. to Receive (Base)")
                {
                }
                field("Return Qty. Rcd. Not Invd."; Rec."Return Qty. Rcd. Not Invd.")
                {
                }
                field("Ret. Qty. Rcd. Not Invd.(Base)"; Rec."Ret. Qty. Rcd. Not Invd.(Base)")
                {
                }
                field("Return Rcd. Not Invd."; Rec."Return Rcd. Not Invd.")
                {
                }
                field("Return Rcd. Not Invd. (LCY)"; Rec."Return Rcd. Not Invd. (LCY)")
                {
                }
                field("Return Qty. Received"; Rec."Return Qty. Received")
                {
                }
                field("Return Qty. Received (Base)"; Rec."Return Qty. Received (Base)")
                {
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                }
                field("Item Charge Qty. to Handle"; Rec."Item Charge Qty. to Handle")
                {
                }
                field("BOM Item No."; Rec."BOM Item No.")
                {
                }
                field("Return Receipt No."; Rec."Return Receipt No.")
                {
                }
                field("Return Receipt Line No."; Rec."Return Receipt Line No.")
                {
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                }
                field("Copied From Posted Doc."; Rec."Copied From Posted Doc.")
                {
                }
                field("Price Calculation Method"; Rec."Price Calculation Method")
                {
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                }
                field(Subtype; Rec.Subtype)
                {
                }
                field("Price description"; Rec."Price description")
                {
                }
                field("Attached Doc Count"; Rec."Attached Doc Count")
                {
                }
                field(Size; Rec.Size)
                {
                }
                field(Fit; Rec.Fit)
                {
                }
                field(Color; Rec.Color)
                {
                }
                field("Assembly No."; Rec."Assembly No.")
                {
                }
                field(Cut; Rec.Cut)
                {
                }
                field(Tonality; Rec.Tonality)
                {
                }
                field("Parameters Header ID"; Rec."Parameters Header ID")
                {
                }
                field("Needed RM Batch"; Rec."Needed RM Batch")
                {
                }
                field("Allocation Code"; Rec."Allocation Code")
                {
                }
                field("Allocation Type"; Rec."Allocation Type")
                {
                }
                field("Parent Parameter Header ID"; Rec."Parent Parameter Header ID")
                {
                }
                field("Control Number"; Rec."Control Number")
                {
                }
                field("Extra Charge %"; Rec."Extra Charge %")
                {
                }
                field("Extra Charge Amount"; Rec."Extra Charge Amount")
                {
                }
                field("Qty Assignment Wizard Id"; Rec."Qty Assignment Wizard Id")
                {
                }
                field("IC Parameters Header ID"; Rec."IC Parameters Header ID")
                {
                }
                field("IC Parent Parameter Header ID"; Rec."IC Parent Parameter Header ID")
                {
                }
                field("Par Level"; Rec."Par Level")
                {
                }
                field("Department Code"; Rec."Department Code")
                {
                }
                field("Position Code"; Rec."Position Code")
                {
                }
                field("Staff Code"; Rec."Staff Code")
                {
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                }
                field(SystemId; Rec.SystemId)
                {
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                }
            }
        }
    }
}
