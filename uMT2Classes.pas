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

       constructor Create;
       destructor Destroy ; override;
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

end.
