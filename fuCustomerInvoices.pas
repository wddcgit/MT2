unit fuCustomerInvoices;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DateUtils,
  Vcl.StdCtrls, AdvGlowButton, AdvEdit, Vcl.ExtCtrls, AdvUtil,  AdvSmoothPanel;
type
    TPicker = Record
      PickerID : String;
      PickerName : String;
      PickDateAndTime : TDateTime;
      ItemID          : string;
      ItemQty : integer;

End;

type
  TfrmCustomerInvoices = class(TForm)
    Panel1: TPanel;
    btnSave: TAdvGlowButton;
    Label1: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    lbInvoicesToAdd: TListBox;
    Label2: TLabel;
    lbTrackingNbr: TListBox;
    Label3: TLabel;
    AdvSmoothPanel1: TAdvSmoothPanel;
    sgInvoiceSum: TAdvStringGrid;
    sgInvoiceDet: TAdvStringGrid;
    lblBoL: TLabel;
    sgBoL: TAdvStringGrid;
    btnItem: TAdvGlowButton;
    eItem: TAdvEdit;
    lblInvDet: TLabel;
    lbItemsList: TListBox;
    Label4: TLabel;
    procedure ListInvoices(SOPNumber : String);
    procedure ClearGrid(GridIn : TADVStringGrid);
    procedure ListInvoiceDet(SopNumbe : String);
    procedure ListInvoiceDetByItem(SopNumbe : String);
    procedure sgInvoiceSumClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormShow(Sender: TObject);
    procedure lbInvoicesToAddKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListInvoicesContainingItem;
    procedure FormCreate(Sender: TObject);
    procedure btnItemClick(Sender: TObject);
    procedure GetBoL(SOPNumbe : String);
    procedure GetBoLByItem(SOPNumbe : String);
    procedure sgBoLSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure sgInvoiceSumGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure eItemKeyPress(Sender: TObject; var Key: Char);
    procedure sgBoLAnchorClick(Sender: TObject; ARow, ACol: Integer;
      Anchor: string; var AutoHandle: Boolean);
    procedure sgInvoiceSumAnchorClick(Sender: TObject; ARow, ACol: Integer;
      Anchor: string; var AutoHandle: Boolean);
    procedure sgInvoiceDetAnchorClick(Sender: TObject; ARow, ACol: Integer;
      Anchor: string; var AutoHandle: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    sCI_CustomerNbr : String;
    sCI_SOPNumbe : String;
    stlCI_Package_Id : TStringList;
    rCI_Picker : TPicker;

  end;



var
  frmCustomerInvoices: TfrmCustomerInvoices;

implementation

{$R *.dfm}

uses duMT2, uCommon, fuPicker, uMT2Classes;

procedure TfrmCustomerInvoices.ListInvoices(Sopnumber : String);
var
   iRow : integer;
   iY : integer;
begin
    With sgInvoiceSum do
       try
          BeginUpdate;
          ClearGrid(sgInvoiceSum);
          iRow:= 1;
          With dmMT2.fqDB_InvoiceList do
            try
              Params.Clear;
              if SopNumber <> '' then
                 begin
                   dmMT2.SetInvoiceListQueryBySOP;
                   Params[0].AsString:= sCI_CustomerNbr;
                   Params[1].AsString:= SopNumber + '%';
                 end
              else
                 begin
                  dmMT2.SetInvoiceListQuery ;
                  Params[0].AsString:= sCI_CustomerNbr;
                  Params[1].AsDateTime:= IncYear(Now,-3); //go back three years
                 end;
              Active:= true;
              while not EOF do
                begin
                  if iRow > 1 then
                    AddRow;
                  Cells[0,iRow]:= Fields[0].AsString;
                  Cells[1,iRow]:= FormatDateTime('mmm dd yyyy',Fields[1].AsDateTime);
                  Cells[2,iRow]:= Format('%m',[Fields[4].AsCurrency]);
                  Cells[3,iRow]:= '<A HREF="ADDINVOICE"><IMG SRC="IDX:7"></A>';
                  if Fields[3].AsCurrency <= 0 then
                    for iY:= 0 to 2 do
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
          With dmMT2.fqDB_InvoiceByItem do
            try
              Active:= false;
              ParamByName('cnbr').AsString:= sCI_CustomerNbr;
              ParamByName('itm1').AsString:= TRIM(eItem.Text);
              ParamByName('sdat').AsDateTime:= IncYear(Now,-3); //go back three years
              Active:= true;
              while not EOF do
                begin
                  if iRow > 1 then
                    AddRow;
                  Cells[0,iRow]:= Fields[0].AsString;
                  Cells[1,iRow]:= FormatDateTime('mmm dd yyyy',Fields[1].AsDateTime);
                  Cells[2,iRow]:= Format('%m',[Fields[4].AsCurrency]);
                  Cells[3,iRow]:= '<A HREF="ADDINVOICE"><IMG SRC="IDX:7"></A>';

                  if Fields[3].AsCurrency <= 0 then
                    for iY:= 0 to 2 do
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

procedure TfrmCustomerInvoices.sgBoLAnchorClick(Sender: TObject; ARow,
  ACol: Integer; Anchor: string; var AutoHandle: Boolean);
var
   sContainerID : String;
   iRow : integer;
   pOrigin : TPoint;
begin
   if UpperCAse(Copy(Anchor,1,5)) = 'TRACK' then
      begin
            With sgBol do
              if (ARow > 0) and (Cells[3,ARow] <> '') and (lbTrackingNbr.Items.IndexOf(Cells[3,ARow]) = -1) then
                 lbTrackingNbr.Items.Add(Cells[3,ARow]);
      end
   else
      begin
       sContainerID:= Copy(Anchor,5,Length(Anchor)-4);
       iRow:= 1;
       With TfrmPicker.Create(nil) do
         begin
             With dmMT2.fqPicker do
                try
                  Active:= false;
                  Params[0].AsString:= sContainerID + '%';
                  Active:= true;
                  while not EOF do
                     begin
                        if (Length(eItem.Text) = 0) OR (eItem.Text = Fields[3].AsString)  then
                           begin
                              if iRow > 1  then
                                  sgPicker.AddRow;
                              sgPicker.Cells[0,iRow]:= Fields[1].AsString;
                              sgPicker.Cells[1,iRow]:= FIelds[2].AsString;
                              sgPicker.Cells[2,iRow]:= FormatDateTime('mmm dd yyyy hh:mm:ss am/pm',Fields[0].AsDateTime);
                              sgPicker.Cells[3,iRow]:= Fields[3].AsString;
                              sgPicker.Cells[4,iRow]:= Fields[4].AsString;
                              Inc(iRow);
                           end;
                        Next;

                     end;

                finally
                  Active:= false;
                end;
             //position the form
             pOrigin:= sgBol.ClientOrigin;
             Left:= ClientToScreen(pOrigin).X;
             Top:=  ClientToScreen(pOrigin).Y;
             Show;
         end;
      end;
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
{     CanSelect:= ARow > 0;
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
        end;   }

end;

procedure TfrmCustomerInvoices.sgInvoiceDetAnchorClick(Sender: TObject; ARow,
  ACol: Integer; Anchor: string; var AutoHandle: Boolean);
var
  MyItem : TItem;
begin
    With sgInvoiceDet do
       if (ARow > 0) and (Cells[0,ARow] <> '') and (lbItemsList.Items.IndexOf(Cells[0,ARow] + ' ' + Cells[1,Arow]) = -1) then
             begin

                MyITem:= TItem.Create;
                MyItem.SOPNumbe:= sCI_SopNumbe;
                MyItem.ItemID:= Cells[0,ARow];
                MyITem.ItemDesc:= cells[1,ARow];
                MyItem.ItemQty:= Ints[2,ARow];
                MyItem.LotNbr:= Cells[3,ARow];
                MyItem.ExpyDate:= Cells[4,ARow];
                lbItemsList.Items.AddObject(Cells[0,ARow] + ' ' + Cells[1,Arow],TObject(MyItem));
             end;
end;

procedure TfrmCustomerInvoices.sgInvoiceSumAnchorClick(Sender: TObject; ARow,
  ACol: Integer; Anchor: string; var AutoHandle: Boolean);
begin
     With sgInvoiceSum do
       if (ARow > 0) and (Cells[0,ARow] <> '') and (lbInvoicesToAdd.Items.IndexOf(Cells[0,ARow]) = -1) then
          lbInvoicesToAdd.Items.Add(Cells[0,ARow]);
end;

procedure TfrmCustomerInvoices.sgInvoiceSumClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
   With sgInvoiceSum do
    begin
       if (ARow > 0) and (Cells[0,Arow] <> '') and (sCI_sopNumbe <> Cells[0,ARow]) then
         begin
           sCI_SopNumbe:= Cells[0,ARow];
           if IsPossibleItem(eItem.Text)  then
            begin
              ListInvoiceDetByItem(sCI_SopNumbe);
              GetBOLByItem(sCI_SopNumbe);
            end
          else
            begin
              ListInvoiceDet(sCI_SopNumbe);
              GetBOL(sCI_SopNumbe);
            end;
         end;
    end;

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
   sCI_SopNumbe:= '';
   case Length(eItem.Text) of
   0: ListInvoices('');
   6: if not IsValidInt(Copy(eItem.Text,1,6)) then
         MessageDlg('Invalid WDDC item code.',mtError,[mbOK],0)
      else
         ListInvoicesContainingItem;
   else
      ListInvoices(eItem.Text);
   end;

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

procedure TfrmCustomerInvoices.eItemKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 THen
     btnItemClick(nil);
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
    ListInvoices('');
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
          With dmMT2.fqInvoiceDetail do
            try
              Active:= false;
              Params[0].AsString:= SopNumbe;
              DisableControls;
              Active:= true;

              while not EOF do
                begin
                  if iRow > 1 then
                    AddRow;
                  Cells[0,iRow]:= Fields[0].AsString;
                  Cells[1,iRow]:= Fields[1].AsString;
                  Cells[2,iRow]:= Fields[4].AsString;
                  Cells[3,iRow]:= Format('%m',[Fields[7].AsCurrency]);
                  Cells[4,iRow]:= Format('%m',[Fields[2].AsCurrency]);
                  Cells[5,iRow]:= Format('%m',[Fields[3].AsCurrency]);
                  Cells[6,iRow]:= Fields[5].AsString;
                  Cells[7,iRow]:= Fields[6].AsString;


                  Cells[8,iRow]:= '<A HREF="ADDITEM"><IMG SRC="IDX:7"></A>';
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

procedure TfrmCustomerInvoices.ListInvoiceDetByItem(SopNumbe : String);
var
   iRow : integer;

begin
    With sgInvoiceDet do
       try
          BeginUpdate;
          ClearGrid(sgInvoiceDet);
          iRow:= 1;
          lblInvDet.Caption:= 'Line Items for ' + SopNumbe;

          With dmMT2.fqInvoiceDetailByItem do
            try
              Active:= false;
              Params[0].AsString:= SopNumbe;
              Params[1].AsString:= eItem.Text;
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
                  Cells[5,iRow]:= Fields[5].AsString;
                  Cells[6,iRow]:= Fields[6].AsString;
                  Cells[7,iRow]:= '<A HREF="ADDITEM"><IMG SRC="IDX:7"></A>';
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
         With dmMT2.fqDB_TrackingNbr do
            try
              Active:= false;
              ParamBYName('sop2').AsString:= SOPNumbe;

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
                  stlCI_Package_ID.Add(Fields[6].AsString);
                  Cells[5,iRow]:= '<A HREF="CNTR' + FIelds[5].AsString + '">Details</A>';
                  Cells[6,iRow]:= '<A HREF="TRACK"><IMG SRC="IDX:7"></A>';
                  Next;
                  Inc(iRow);
                end;
            finally
             begin
              Active:= false;

             end;
            end;
       finally
         EndUpdate;
       end;
end;

procedure TfrmCustomerInvoices.GetBoLByItem(SOPNumbe: string);
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
         With dmMT2.fqTrackingNbrByItem do
            try
              Active:= false;
              Params[0].AsString:= Copy(eItem.Text,1,6);
              Params[1].AsString:= SOPNumbe;

              Active:= true;
              while not EOF do
                begin
                  if iRow > 1 then
                     AddROw;
                  Cells[0,iRow]:= FormatDateTime('mmm dd yy',Fields[8].AsDateTime); // trans_Date
                  Cells[1,iRow]:= Fields[9].AsString; //carrier
                  Cells[2,iRow]:= FIelds[6].AsString; // order nbr
                  Cells[3,iRow]:= Fields[7].AsString; //tracking num
                  Cells[4,iRow]:= FloatToStrF(Fields[10].AsFloat,ffGeneral,3,1); //weight
                  stlCI_Package_ID.Add(Fields[12].AsString);
                  Cells[5,iRow]:= '<A HREF="CNTR' + Fields[11].AsString + '">Details</A>';
                  Cells[6,iRow]:= '<A HREF="TRACK"><IMG SRC="IDX:7"></A>';
                  Next;
                  Inc(iRow);
                end;
            finally
             begin
              Active:= false;

             end;
            end;
       finally
         EndUpdate;
       end;
end;


end.
