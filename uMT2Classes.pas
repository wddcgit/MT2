unit uMT2Classes;

interface

uses   Classes, Generics.Collections;

type TLogPage = Class(TObject)
       LogID : integer;
       PageID : integer;
       Category : String;
       ShippingMethod : String;
       Department : String;
       KeyedBy : String;
       InvoiceList : TStringList;
       TrackingList : TStringList;
       PickedBy : String;
       Problem : String;
       Notes : String;
       Closed : boolean;
       ClosedBy : String;
       ClosedDate : TDateTIme;
       Caller : String;
       OpenedBy : String; // name of the employee that created the log
       LogDate : TDateTime; // the date the log was opened
       EntryDate : TDateTIme ; //the recorded time of each unique entry
       EntryIndex : integer;
       Caption : String;

       constructor Create;
       destructor Destroy ; override;
End;


type TLogSummary = Class(TObject)
        LogID : integer;
        Caller : String;
        Summary : String;
        LogDate : TDateTime;
        AssignedToID : integer;
        AssignedToName : String;
        CategoryID : integer;
        CategoryName : String;
        MemberNbr : String;
        MemberName : String;
        DeptName  : String;
        DeptID    : integer;
        PriorityID : integer;
        PriorityName : String;
        StatusID : integer;
        StatusName : String;
        DueDate  : TDateTime;
        Watched : boolean;
        constructor Create;
End;

type TMember = record
      Nbr : string;
      Name : String;
      Address1: String;
      Address2 : String;
      City : String;
      PostalCode : String;
      Prov  : String;
      email : String;
      Phone : String;
      Fax : String;
      WDDCRep : String;
      SiteID : integer;
End;

type  TAttachment = Class(TObject)
         LogID : integer;
         ProblemID : integer;
         PathAndFileName : String;
         Title  : String;
End;

type TMTUser = record
      UserName : String;
      FullName : String;
      EMail    : String;
      SecurityGroup : String;
      EMailGroup : String;
      Dept : String;
end;

type TMTNotification = Class(TObject)
        LogID : integer;
        SentOn : TDateTime;
        SentTo : String;

end;

type TItem = Class(TObject)
       ItemID : String;
       ItemDesc : String;
       ItemQty : integer;
       LotNbr  : String;
       ExpyDate : String;
       SOPNumbe : String;
       LineNbr  : String;
       procedure CopyFromSourceToDest(Source, Dest : TItem);
end;


type TCategory = Class(TObject)
      CtgyID : integer;
      CtgyName : String;
      Inactive : boolean;
      InvoiceLink : boolean;
End;

type TLogStatus = (lsNew,lsInProgress,lsOnHold,lsWaitingOnClient,lsDone);

type TAttachments = Class(TObjectList<TAttachment>);

type TCategories = Class(TObjectList<TCategory>) ;

type TStringEntryType = (seNewCtgy,seEditCtgy);



implementation

constructor TLogPage.Create;
begin
     inherited Create;
     InvoiceList:= TStringList.Create;
     TrackingList:= TStringList.Create;

end;

destructor TLogPage.Destroy;
begin
    TrackingList.Free;
    InvoiceList.Free;
    inherited Destroy;
end;

constructor TLogSummary.Create;
begin
     inherited Create;
     LogID:= 0;
end;

procedure TItem.CopyFromSourceToDest(Source: TItem; Dest: TItem);
begin
     Dest.ItemID:= Source.ItemID;
     Dest.ItemDesc:= Source.ItemDesc;
     Dest.ItemQty:= Source.ItemQty;
     Dest.LotNbr:= Source.LotNbr;
     Dest.ExpyDate:= Source.ExpyDate;
     Dest.SOPNumbe:= Source.SOPNumbe;
     Dest.LineNbr:= Source.LineNbr;
end;

end.
