unit fuMTSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DateUtils,
  Vcl.StdCtrls, Vcl.ExtCtrls, AdvGlowButton, AdvEdit, W7Classes, W7Bars, AdvUtil,  ShellAPI,
  AdvOfficeButtons, VCLTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series,
  VCLTee.TeeProcs, VCLTee.Chart, Vcl.Menus, AdvMenus, AdvCustomComponent,
  AdvPDFIO, AdvGridPDFIO;

type
  TfrmMTSearch = class(TForm)
    sgSearch: TAdvStringGrid;
    W7InformationBar1: TW7InformationBar;
    lblRecordCount: TLabel;
    Panel1: TPanel;
    cbCriteria: TComboBox;
    Label1: TLabel;
    chkOpenOnly: TAdvOfficeCheckBox;
    btnSearch: TAdvGlowButton;
    eSearch: TComboBox;
    TeeGDIPlus1: TTeeGDIPlus;
    chtResults: TChart;
    Series1: TPieSeries;
    Panel2: TPanel;
    pdfSave: TAdvGridPDFIO;
    AdvGlowButton1: TAdvGlowButton;
    popSave: TAdvPopupMenu;
    PDF1: TMenuItem;
    xlsx1: TMenuItem;
    sd1: TSaveDialog;
    procedure cbCriteriaChange(Sender: TObject);
    procedure SearchMT;
    procedure ClearGrid;
    procedure btnSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IncCtgyCount(CtgyID : integer);
    procedure FillAndShowCtgyChart;
    procedure eSearchKeyPress(Sender: TObject; var Key: Char);
    procedure PDF1Click(Sender: TObject);
    procedure xlsx1Click(Sender: TObject);
    procedure chtResultsClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    stlMTS_MemberID : TStringList;
    iMTS_AssignedToID : integer;
    stlCtgyCount : TStringList;
    iMTS_ByCtgyID : integer;
  end;

var
  frmMTSearch: TfrmMTSearch;

implementation

{$R *.dfm}

uses duMT2, fuCustomerLog, uMT2GlobalVar, uCommon;

procedure TfrmMTSearch.btnSearchClick(Sender: TObject);
begin

      SearchMT;
end;

procedure TfrmMTSearch.cbCriteriaChange(Sender: TObject);
begin
   eSearch.Items.Clear;
   eSearch.Text:= '';
   case cbCriteria.ItemIndex of
   0: begin
        eSearch.Items.Assign(stlGV_CLDept);
        eSearch.ItemIndex:= 0;
      end;
   else

   end;
end;

procedure TfrmMTSearch.chtResultsClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  sCtgyName : String;

begin
     sCtgyName:=  Series.Labels[ValueIndex];
     iMTS_ByCtgyID:= GetCategoryIDFromName(sCtgyName);
     SearchMT;

end;

procedure TfrmMTSearch.SearchMT;
var
  iRow : integer;
  sOpenOnlyPhrase : String;
  sByCtgyPhrase : String;
begin
    try
      sgSearch.BeginUpdate;
      ClearGrid;
      stlMTS_memberID.Clear;
      stlCtgyCount.Clear;
      iRow:= 1;
      if chkOpenOnly.Checked  then
        sOpenOnlyPhrase:= ' AND a.status < 4 '
      else
        sOpenOnlyPhrase:= '';
      if iMTS_ByCtgyID > 0 then
         sByCtgyPhrase:= ' AND a.ctgyid = ' + IntToStr(iMTS_ByCtgyID)
      else
         sByCtgyPhrase:= '';


      With dmMT2.fqMTSearch do
         try
           DisableControls;
           Active:= false;
           Params.Clear;
           SQL.Text:= UseDB;
           SQL.Add('SELECT a.logid,a.caller,a.logdate,a.summary,1,a.ctgyid,a.status,a.customerid');
           SQL.Add(',b.custname');
           SQL.Add('FROM tblCustomerLogInfo a');
           SQL.Add('INNER JOIN [wddc].dbo.RM00101 b ON (a.customerid = b.custnmbr)');
           case cbCriteria.ItemIndex of
           0:  begin //assigned to a department

                  SQL.Add('WHERE a.DeptID=:prm1' + sOpenOnlyPhrase + sByCtgyPhrase);
                  SQL.Add('ORDER BY a.logid DESC');
                  Params[0].AsInteger:=  Integer(stlGV_CLDept.Objects[stlGV_CLDept.IndexOf(eSearch.Text)]);
               end;
           1:  begin //log id
                  SQL.Add('WHERE a.logid =:prm0');
                  Params[0].AsInteger:= StrToIntDef(eSearch.Text,0);
               end;
           2: begin //invoice number
                  SQL.Add('JOIN tblInvoiceNumbers c ON (a.logid = c.logID)');
                  SQL.Add('WHERE c.invoicenumber LIKE :prm1' + sOpenOnlyPhrase + sByCtgyPhrase);
                  Params[0].AsString:= eSearch.Text + '%';
               end;
           3: begin // an item
                  SQL.Add('JOIN tblItems c ON (a.logID = c.logid)');
                  SQL.Add('WHERE c.itemcode LIKE :prb1' + sOpenOnlyPhrase + sByCtgyPhrase );
                  SQL.Add('ORDER BY a.logId DESC');
                  Params[0].AsString:=  eSearch.Text + '%';
               end;
           4: begin // a word in the text field
                  SQL.Add('JOIN tblCustomerLog c ON (a.LogId = c.logid)');
                  SQL.Add('WHERE c.problem LIKE :prb1' + sOpenOnlyPhrase + sByCtgyPhrase);
                  SQL.Add('ORDER BY a.logId DESC');
                  Params[0].AsString:= '%' + eSearch.Text + '%';
               end;
           5: begin // longer than certain days
                  SQL.Add('WHERE a.logdate < :prb1 AND a.status < 4' + sByCtgyPhrase);
                  SQL.Add('ORDER BY a.logId DESC');
                  ParamByName('prb1').AsDateTime:= IncDay(Now, - (StrToIntDef(eSearch.Text,30)));
               end;
           6: begin // certain words in summary
                  SQL.Add('WHERE a.summary LIKE :prb1' + sOpenOnlyPhrase + sByCtgyPhrase);
                  SQL.Add('ORDER BY a.logId DESC');
                  ParamByName('prb1').AsString:= '%' + eSearch.Text + '%';
               end;
           7: begin // logs created by the logged in user
                  SQL.Add('WHERE a.creator = :prb1' + sOpenOnlyPhrase + sByCtgyPhrase);
                  SQL.Add('ORDER BY a.logId DESC');
                  ParamByName('prb1').AsString:= rGV_MTUser.UserName;
               end;

           end;
           Active:= true;
           if RecordCount = 0 then
             begin
                  MessageDlg('No records found. Change your search criteria and try again',mtInformation,[mbOK],0);
                  lblRecordcount.Caption:= '';
             end
           else
            begin
            while not EOF do
             begin
                WIth sgSearch do
                  begin
                     if iRow > 1 then
                       AddRow;
                     Cells[0,iRow]:= FOrmatDateTime('mm dd yyyy h:nn AM/PM',Fields[2].AsDateTime);
                     Cells[1,iRow]:= FIelds[0].AsString;
                     Cells[2,iRow]:= Fields[7].AsString + ' - ' + Fields[8].AsString;
                     Cells[3,iRow]:= GetCategoryName(Fields[5].AsInteger);
                     Cells[4,iRow]:= Fields[3].AsString;
                     stlMTS_MemberID.Add(Fields[7].AsString);
                     IncCtgyCount(Fields[5].AsInteger);

                  end;
                Next;
                Inc(iRow);
             end;
             lblRecordcount.Caption:= IntToStr(Recordcount) + ' records found.';
            end;

         finally
          begin
           Active:= false;
           EnableControls;
          end;
         end;
    finally
      sgSearch.EndUpdate;
      if cbCriteria.ItemIndex IN [3,4] then
         begin
           sgSearch.AutoSizeRows(false,3);
           sgSearch.HilightInCol(False,false,4,eSearch.Text);
         end;
      FillAndShowCtgyChart;
      iMTS_ByCtgyID:= 0;
    end;
end;

procedure TfrmMTSearch.xlsx1Click(Sender: TObject);
begin
    sd1.FileName:= '';
    sd1.DefaultExt:= 'xls';
    sd1.Title:= 'Save as Excel';
    sd1.Filter:= 'Excel|*.xls';
    if sd1.Execute then
      begin
         sgSearch.SaveToXLS(sd1.FileName,true);
         ShellExecute(Self.Handle,'OPEN',PWideChar(sd1.FileName),nil,nil,SW_SHOWNORMAL);
      end;
end;

procedure TfrmMTSearch.ClearGrid;
var
  x, y : integer;
begin
        With sgSearch do
        for x:= 0 to Pred(ColCount) do
           for y:= 1 to Pred(RowCount) do
              Cells[x,y]:= '';
        sgSearch.RowCount:= 2;
end;

procedure TfrmMTSearch.eSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (cbCriteria.ItemIndex > -1) and (eSearch.Text <> '') then
      btnSearchClick(nil);

end;

procedure TfrmMTSearch.FormCreate(Sender: TObject);
begin
   stlMTS_MemberID:= TStringList.Create;
   lblRecordCount.Caption:= '';
   chtResults.Visible:= false;
   stlCtgyCount:= TStringList.Create;
   iMTS_ByCtgyID:= 0;
end;

procedure TfrmMTSearch.FormDestroy(Sender: TObject);
begin
   stlMTS_MemberID.Free;
   stlCtgyCount.Free;
end;

procedure TfrmMTSearch.IncCtgyCount(CtgyID: Integer);
var
  iDx : integer;
  iCount : integer;
begin
      iDx:= stlCtgyCount.IndexOfName(IntToStr(CtgyID));
      if iDx = -1 then
        stlCtgyCount.Add(IntToStr(CtgyID) + '=1')
      else
        begin
           iCount:= StrToInt(stlCtgyCount.ValueFromIndex[iDx]);
           Inc(iCount);
           stlCtgyCount[iDx]:= IntToStr(CtgyID) + '=' + IntTOStr(iCount);
        end;
end;

procedure TfrmMTSearch.PDF1Click(Sender: TObject);
begin
    sd1.FileName:= '';
    sd1.DefaultExt:= 'pdf';
    sd1.Title:= 'Save as PDF';
    sd1.Filter:= 'PDF|*.pdf';
    if sd1.Execute then
      begin
         pdfSave.Options.Header:= cbCriteria.Text + ' ' + eSearch.Text;
         pdfSave.Options.Footer:= '';
         pdfSave.Save(sd1.FileName);
         ShellExecute(Self.Handle,'OPEN',PWideChar(sd1.FileName),nil,nil,SW_SHOWNORMAL);
      end;
end;

procedure TfrmMTSearch.FillAndShowCtgyChart;
var
  iInc : integer;
  sCtgyName : String;
begin
    chtResults.Series[0].Clear;
    for iInc:= 0 to Pred(stlCtgyCount.Count) do
      begin
        sCtgyName:= GetCategoryName(StrToInt(stlCtgyCount.Names[iInc]));
        if sCtgyName = '' then
           sCtgyName:= 'Unknown, possibly deactivated';
        chtResults.Series[0].Add(StrToInt(stlCtgyCount.ValueFromIndex[iInc]),sCtgyName);
      end;
    chtResults.Visible:= true;
    chtResults.Title.Text.Clear;

end;

end.
