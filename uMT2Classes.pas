unit uMT2Classes;

interface

uses   Classes;

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
        Status : shortint;
        JIRAID : String;
        constructor Create;
End;

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

end.
