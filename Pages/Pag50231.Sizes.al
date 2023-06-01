page 50231 Sizes
{
    ApplicationArea = All;
    Caption = 'Sizes';
    PageType = List;
    SourceTable = Size;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                /*field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }*/
                field("Report Description"; Rec."Report Description")
                {
                    ApplicationArea = all;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(ER; Rec.ER)
                {
                    ApplicationArea = All;
                }
                field(DE; Rec.DE)
                {
                    ApplicationArea = All;
                }
                field(IT; Rec.IT)
                {
                    ApplicationArea = All;
                }
                field(INTL; Rec.INTL)
                {
                    ApplicationArea = All;
                }
                field(UK; Rec.UK)
                {
                    ApplicationArea = All;
                }
                field(US; Rec.US)
                {
                    ApplicationArea = All;
                }
                field(RU; Rec.RU)
                {
                    ApplicationArea = All;
                }
                field(FR; Rec.FR)
                {
                    ApplicationArea = All;
                }
                field("Extra Charge %"; Rec."Extra Charge %")
                {
                    ApplicationArea = All;
                }
                field("Created By"; UserCreater)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Created By';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = all;
                    Caption = 'Created At';
                }
                field("Modified By"; UserModifier)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Modified By';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = all;
                    Caption = 'Modified At';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Related Categories")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Size Categories";
                RunPageLink = "Size Code" = field(Code);
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if User.Get(Rec.SystemCreatedBy) then
            UserCreater := User."User Name";
        if User2.Get(Rec.SystemModifiedBy) then
            UserModifier := User2."User Name";
    end;

    var
        User: Record User;
        User2: Record User;
        UserCreater: Code[50];
        UserModifier: Code[50];
}
