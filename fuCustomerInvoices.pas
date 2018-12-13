unit fuCustomerInvoices;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DateUtils,
  Vcl.StdCtrls, AdvGlowButton, AdvEdit, Vcl.ExtCtrls;

type
  TfrmCustomerInvoices = class(TForm)
    sgInvoiceSum: TAdvStringGrid;
    Panel1: TPanel;
    AdvGlowButton1: TAdvGlowButton;
    eItem: TAdvEdit;
    btnItem: TAdvGlowButton;
    Label1: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    sgInvoiceDet: TAdvStringGrid;
    Panel4: TPanel;
    lbInvoicesToAdd: TListBox;
    Label2: TLabel;
    lblInvDet: TLabel;
    sgBoL: TAdvStringGrid;
    lblBoL: TLabel;
    lbTrackingNbr: TListBox;
    Label3: TLabel;
    procedure ListInvoices;
    procedure ClearGrid(GridIn : TADVStringGrid);
    procedure ListInvoiceDet(SopNumbe : String);
    procedure sgInvoiceSumClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormShow(Sender: TObject);
    procedure sgInvoiceSumDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure lbInvoicesToAddKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListInvoicesContainingItem;
    procedure FormCreate(Sender: TObject);
    procedure btnItemClick(Sender: TObject);
    procedure GetBoL(SOPNumbe : String);
    procedure sgBoLSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure sgBoLDblClickCell(Sender: TObject; ARow, ACol: Integer);
    function GetContainerPicker(ContainerID : String) : String;
    procedure sgInvoiceSumGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
  private
    { Private declarations }
  public
    { Public declarations }
    sCI_CustomerNbr : String;
    sCI_SOPNumbe : String;
    stlCI_Package_Id : TStringList;

  end;

var
  frmCustomerInvoices: TfrmCustomerInvoices;

implementation

{$R *.dfm}

uses duMT2, uCommon;

procedure TfrmCustomerInvoices.ListInvoices;
var
   iRow : integer;
   iY : integer;
begin
    With sgInvoiceSum do
       try
          BeginUpdate;
          ClearGrid(sgInvoiceSum);
          iRow:= 1;
          With dmMT2.qDB_InvoiceList do
            try
              Active:= false;
              ParamByName('cnbr').AsString:= sCI_CustomerNbr;
              ParamByName('sdat').AsDateTime:= IncYear(Now,-3); //go back three years
              Active:= true;
              while not EOF do
                begin
                  if iRow > 1 then
                    AddRow;
                  Cells[0,iRow]:= Fields[0].AsString;
                  Cells[1,iRow]:= FormatDateTime('mmm dd yyyy',Fields[1].AsDateTime);
                  Cells[2,iRow]:= Format('%m',[Fields[2].AsCurrency]);
                  Cells[3,iRow]:= Format('%m',[Fields[3].AsCurrency]);
                  Cells[4,iRow]:= Format('%m',[Fields[4].AsCurrency]);
                  if Fields[3].AsCurrency <= 0 then
                    for iY:= 0 to 4 do
                       Objects[iY,iRow]:= TObject(13);
                  Next;
                  Inc(iRow);
                end;
            finally
              Active:= false;
            end;
       finally
         EndUpdate;
       end;
end;

procedure TfrmCustomerInvoices.ListInvoicesContainingItem;
var
   iRow, iY : integer;
begin
    With sgInvoiceSum do
       try
          BeginUpdate;
          ClearGrid(sgInvoiceSum);
          iRow:= 1;
          With dmMT2.qDB_InvoiceByItem do
            try
              Active:= false;
              ParamByName('cnbr').AsString:= sCI_CustomerNbr;
              ParamByName('itm1').AsString:= eItem.Text;
              ParamByName('sdat').AsDateTime:= IncYear(Now,-3); //go back three years
              Active:= true;
              while not EOF do
                begin
                  if iRow > 1 then
                    AddRow;
                  Cells[0,iRow]:= Fields[0].AsString;
                  Cells[1,iRow]:= FormatDateTime('mmm dd yyyy',Fields[1].AsDateTime);
                  Cells[2,iRow]:= Format('%m',[Fields[2].AsCurrency]);
                  Cells[3,iRow]:= Format('%m',[Fields[3].AsCurrency]);
                  Cells[4,iRow]:= Format('%m',[Fields[4].AsCurrency]);
                  if Fields[3].AsCurrency <= 0 then
                    for iY:= 0 to 4 do
                       Objects[iY,iRow]:= TObject(13);
                  Next;
                  Inc(iRow);
                end;
            finally
              Active:= false;
            end;
       finally
         EndUpdate;
       end;
end;

procedure TfrmCustomerInvoices.sgBoLDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
    With sgBol do
       if (ARow > 0) and (Cells[3,ARow] <> '') and (lbTrackingNbr.Items.IndexOf(Cells[3,ARow]) = -1) then
          lbTrackingNbr.Items.Add(Cells[3,ARow]);
end;

procedure TfrmCustomerInvoices.sgBoLSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  sTrack : String;
  sItem : String;
  x, y : integer;
  c1 : TColor;
begin
     //is ARow the previous cell or the newly selected cell?
     CanSelect:= ARow > 0;
     // now highlight the items in the container
     sTrack:= stlCI_Package_ID[ARow -1];
     With dmMT2.qDB_ItemPerCntr do
        try
          Active:= false;
          ParamByName('cid1').AsString:= sTrack + '%';
          Active:= true;
          c1:= $00D7FFD7;
          if RecordCount > 0 then
              try
                sgInvoiceDet.BeginUpdate;
                  for x:= 1 to Pred(sgInvoiceDet.RowCount) do
                     for y:= 0 to Pred(sgInvoiceDet.ColCount) do
                         sgInvoiceDet.Colors[y,x]:= clWindow;
                while not EOF do
                    begin
                      sItem:= Fields[0].AsString;
                      for x:= 1 to Pred(sgInvoiceDet.RowCount) do
                        begin
                          //
                          if sgInvoiceDet.Cells[0,x] = sItem then
                            for y:= 0 to Pred(sgInvoiceDet.ColCount) do
                             sgInvoiceDet.Colors[y,x]:= c1;
                        end;

                      Next;
                    end;
              finally
               begin
                 sgInvoiceDet.EndUpdate;
                 sgInvoiceDet.Repaint;
               end;
              end;
        finally
          Active:= false;
        end;

end;

procedure TfrmCustomerInvoices.sgInvoiceSumClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
   With sgInvoiceSum do
    begin
       if (ARow > 0) and (Cells[0,Arow] <> '') and (sCI_sopNumbe <> Cells[0,ARow]) then
         begin
           sCI_SopNumbe:= Cells[0,ARow];
           ListInvoiceDet(sCI_SopNumbe);
           Application.ProcessMessages;
           GetBOL(sCI_SopNumbe);
         end;
    end;

end;

procedure TfrmCustomerInvoices.sgInvoiceSumDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
    With sgInvoiceSum do
       if (ARow > 0) and (Cells[0,ARow] <> '') and (lbInvoicesToAdd.Items.IndexOf(Cells[0,ARow]) = -1) then
          lbInvoicesToAdd.Items.Add(Cells[0,ARow]);

end;

procedure TfrmCustomerInvoices.sgInvoiceSumGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
      With sgInvoiceSum do
      if Integer(Objects[ACol,ARow]) = 13 then
         ABrush.Color:= $00B7B7FF;

end;

procedure TfrmCustomerInvoices.btnItemClick(Sender: TObject);
begin
   if Length(eItem.Text) = 0  then //cleared the item, so look for all
     ListInvoices
   else
    if Length(eItem.Text) <> 6 then
      MessageDlg('Invalid item code.',mtError,[mbOK],0)
   else
      ListInvoicesContainingItem;
end;

procedure TfrmCustomerInvoices.ClearGrid(GridIn: TAdvStringGrid);
var
  x, y : integer;

begin
     With GridIn do
        for x:= 0 to Pred(ColCount) do
           for y:= 1 to Pred(RowCount) do
            begin
              Cells[x,y]:= '';
              Objects[x,y]:= TObject(0);
            end;
     GridIn.RowCount:= 2;
end;

procedure TfrmCustomerInvoices.FormCreate(Sender: TObject);
begin
   sCI_SopNumbe:= '';
   stlCI_Package_ID:= TStringList.Create;
end;

procedure TfrmCustomerInvoices.FormDestroy(Sender: TObject);
begin
   stlCI_Package_ID.Free;
end;

procedure TfrmCustomerInvoices.FormShow(Sender: TObject);
begin
    ListInvoices;
end;

procedure TfrmCustomerInvoices.lbInvoicesToAddKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  lb1 : TListBox;
begin
   lb1:= TListBox(Sender);
   if (Key = VK_DELETE) and (lb1.ItemIndex > -1) then
       lb1.Items.Delete(lb1.ItemIndex);
end;

procedure TfrmCustomerInvoices.ListInvoiceDet(SopNumbe : String);
var
   iRow : integer;
begin
    With sgInvoiceDet do
       try
          BeginUpdate;
          ClearGrid(sgInvoiceDet);
          iRow:= 1;
          lblInvDet.Caption:= 'Line Items for ' + SopNumbe;
          With dmMT2.qDB_InvoiceDet do
            try
              Active:= false;
              ParamByName('sop1').AsString:= SopNumbe;
              DisableControls;
              Active:= true;

              while not EOF do
                begin
                  if iRow > 1 then
                    AddRow;
                  Cells[0,iRow]:= Fields[0].AsString;
                  Cells[1,iRow]:= Fields[1].AsString;
                  Cells[2,iRow]:= Fields[4].AsString;
                  Cells[3,iRow]:= Format('%m',[Fields[2].AsCurrency]);
                  Cells[4,iRow]:= Format('%m',[Fields[3].AsCurrency]);
                  Next;
                  Inc(iRow);
                end;
            finally
             begin
                Active:= false;
                EnableControls;
             end;
            end;
       finally
         EndUpdate;
       end;
end;

procedure TfrmCustomerInvoices.GetBoL(SOPNumbe: string);
var
  iRow : integer;
begin
  With sgBol do
       try
         lblBoL.Caption:= 'Tracking Numbers for Invoice ' + SOPNumbe;
         BeginUpdate;
         ClearGrid(sgBol);
         iRow:= 1;
         stlCI_Package_ID.Clear;
         With dmMT2.qDB_TrackingNum do
            try
              Active:= false;
              ParamBYName('sop2').AsString:= SOPNumbe;
              DisableControls;
              Active:= true;
              while not EOF do
                begin
                  if iRow > 1 then
                     AddROw;
                  Cells[0,iRow]:= FormatDateTime('mmm dd yy',Fields[2].AsDateTime);
                  Cells[1,iRow]:= Fields[3].AsString;
                  Cells[2,iRow]:= FIelds[0].AsString;
                  Cells[3,iRow]:= Fields[1].AsString;
                  Cells[4,iRow]:= FloatToStrF(Fields[4].AsFloat,ffGeneral,3,1);
                  Cells[5,iRow]:= GetContainerPicker(Fields[5].AsString);
                  stlCI_Package_ID.Add(Fields[6].AsString);
                  Next;
                  Inc(iRow);
                end;
            finally
             begin
              Active:= false;
              EnableControls;
             end;
            end;
       finally
         EndUpdate;
       end;
end;

function TfrmCustomerInvoices.GetContainerPicker(ContainerID : String) : String;
begin
    With dmMT2.qDB_CntrPicker do
       try
         Active:= false;
         ParamByName('cid1').AsString:= COntainerID + '%';
         Active:= true;
         if RecordCount > 0 then
             Result:= FIelds[0].AsString
         else
             Result:= '';
       finally
          Active:= false;
       end;
end;

end.
