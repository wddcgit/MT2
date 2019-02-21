unit fuMTSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DateUtils,
  Vcl.StdCtrls, Vcl.ExtCtrls, AdvGlowButton, AdvEdit, W7Classes, W7Bars, AdvUtil;

type
  TfrmMTSearch = class(TForm)
    sgSearch: TAdvStringGrid;
    cbCriteria: TComboBox;
    pnlSearchFor: TPanel;
    Label1: TLabel;
    btnSearch: TAdvGlowButton;
    eSearch: TAdvEdit;
    W7InformationBar1: TW7InformationBar;
    lblRecordCount: TLabel;
    procedure cbCriteriaChange(Sender: TObject);
    procedure SearchMT;
    procedure ClearGrid;
    function GetMemberName(MemberNbr : String) : String;
    procedure btnSearchClick(Sender: TObject);
    procedure eSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgSearchDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function GetAssignedToIDFromName(NameIn : String) : integer;
  private
    { Private declarations }
  public
    { Public declarations }
    stlMTS_MemberID : TStringList;
    iMTS_AssignedToID : integer;
  end;

var
  frmMTSearch: TfrmMTSearch;

implementation

{$R *.dfm}

uses duMT2, fuCustomerLog, uMT2GlobalVar, uCommon;

procedure TfrmMTSearch.btnSearchClick(Sender: TObject);
begin
      case cbCriteria.ItemIndex of
      0:  begin
             iMTS_AssignedToID:= GetAssignedToIDFromName(eSearch.Text);
             if iMTS_AssignedToID = 0 then
                begin
                  lblRecordCount.Caption:= 'Invalid Assigned To Name';
                  exit;
                end;
          end;
      end;


      SearchMT;
end;

procedure TfrmMTSearch.cbCriteriaChange(Sender: TObject);
begin
   case cbCriteria.ItemIndex of
   0: eSearch.EmptyText:= 'Enter Assigned To Name';
   else
     eSearch.EmptyText:= '';
   end;
end;

procedure TfrmMTSearch.SearchMT;
var
  iRow : integer;
begin
    try
      sgSearch.BeginUpdate;
      ClearGrid;
      stlMTS_memberID.Clear;
      iRow:= 1;
      With dmMT2.qMT_Search do
         try
           DisableControls;
           Active:= false;
           case cbCriteria.ItemIndex of
           0:  begin //lassigned to a specific person
                  SQL.Text:= 'SELECT a.logid,a.caller,a.logdate,b.problem,b.notes,b.categoryid,b.closed,a.customerid';
                  SQL.Add('FROM [MT2].dbo.tblCustomerLogInfo a');
                  SQL.Add('LEFT OUTER JOIN [MT2].dbo.tblCustomerLog b ON (a.LogId = b.logid)');
                  SQL.Add('WHERE a.AssignedToID=:asid');
                  SQL.Add('ORDER BY a.logid DESC');
                  ParamByName('asid').AsInteger:=  iMTS_AssignedToID;
               end;
           1,5:  begin //open logs
                  SQL.Text:= 'SELECT a.logid,a.caller,a.logdate,b.problem,b.notes,b.categoryid,a.status,a.customerid';
                  SQL.Add('FROM [MT2].dbo.tblCustomerLogInfo a');
                  SQL.Add('LEFT OUTER JOIN [MT2].dbo.tblCustomerLog b ON (a.LogId = b.logid)');
                  SQL.Add('WHERE a.status = 0');
                  if cbCriteria.ItemIndex = 5 then
                    begin
                      SQL.Add('AND a.logdate > :ldat');
                      ParamByName('ldat').AsDateTime:=  IncDay(Now,-30);
                    end;
                  SQL.Add('ORDER BY a.logid DESC');
               end;
           2: begin //specific log
                  SQL.Text:= 'SELECT a.logid,a.caller,a.logdate,b.problem,b.notes,b.categoryid,b.closed,a.customerid';
                  SQL.Add('FROM [MT2].dbo.tblCustomerLogInfo a');
                  SQL.Add('LEFT OUTER JOIN [MT2].dbo.tblCustomerLog b ON (a.LogId = b.logid)');
                  SQL.Add('WHERE a.logid = :log1');
                  ParamByName('log1').AsInteger:= StrToIntDef(eSearch.Text,0);
               end;
           3: begin // a word in the problem field
                  SQL.Text:= 'SELECT a.logid,a.caller,a.logdate,b.problem,b.notes,b.categoryid,b.closed,a.customerid';
                  SQL.Add('FROM [MT2].dbo.tblCustomerLogInfo a');
                  SQL.Add('LEFT OUTER JOIN [MT2].dbo.tblCustomerLog b ON (a.LogId = b.logid)');
                  SQL.Add('WHERE b.problem LIKE :prb1');
                  SQL.Add('ORDER BY a.logId DESC');
                  ParamByName('prb1').AsString:= '%' + eSearch.Text + '%';
               end;
           4: begin // a word in the notes field
                  SQL.Text:= 'SELECT a.logid,a.caller,a.logdate,b.problem,b.notes,b.categoryid,b.closed,a.customerid';
                  SQL.Add('FROM [MT2].dbo.tblCustomerLogInfo a');
                  SQL.Add('LEFT OUTER JOIN [MT2].dbo.tblCustomerLog b ON (a.LogId = b.logid)');
                  SQL.Add('WHERE b.notes LIKE :prb1');
                  SQL.Add('ORDER BY a.logId DESC');
                  ParamByName('prb1').AsString:= '%' + eSearch.Text + '%';
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
                     Cells[2,iRow]:= GetMemberName(Fields[7].AsString) + ' - ' + FIelds[7].AsString;
                     Cells[3,iRow]:= GetCategoryName(Fields[5].AsInteger);
                     Cells[4,iRow]:= Fields[3].AsString;
                     stlMTS_MemberID.Add(Fields[7].AsString);
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
    end;
end;

procedure TfrmMTSearch.sgSearchDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
var
   iLogID :integer;
   sCustomerID : String;
   iRow : integer;
begin
     // we want to open the customer log form, provide the actual log number and display it.
     try
     iLogID:= StrToInt(sgSearch.Cells[1,sgSearch.Row]);
     sCustomerID:= stlMTS_MemberID[sgSearch.Row -1];
     except //this is not a valid log id, so lets just exit
       exit;
     end;

     // the customer name is in the form customerid<SPACE>-<SPACE>Customer name . so get the string to the first space as the customer id has no spaces?

     // open or create the customer log form, set up the information, show the form and close the search form
     With frmCustomerLog do
        begin

            Show; //we run show to allow the various drop downs to be filled
            eMember.Text:= sCustomerID;
            FindMember(eMember.Text, false);
            sCL_MemberNbr:= sCustomerID;
            GetLogs;
            // now find the specific log on the list
            iRow:= FindLogRow(IntToStr(iLogId));
            sgLogs.Row:= iRow;
            sgLogs.SelectRows(iRow,1);
            ShowLogDetails(iLogID,iRow);

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

procedure TfrmMTSearch.eSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
     btnSearchCLick(nil);
end;

procedure TfrmMTSearch.FormCreate(Sender: TObject);
begin
   stlMTS_MemberID:= TStringList.Create;
   lblRecordCount.Caption:= '';
end;

procedure TfrmMTSearch.FormDestroy(Sender: TObject);
begin
   stlMTS_MemberID.Free;
end;

function TfrmMTSearch.GetMemberName(MemberNbr: string) : String;
begin
    With dmMT2.qDB_MemberSearch do
       try
         Active:= false;
         ParamByName('cnbr').AsString:= MemberNbr;
         Active:= true;
         if RecordCount = 0 then
              Result:= ''
         else
              Result:= FIelds[0].AsString;
       finally
         Active:= false;
       end;
end;

function TfrmMTSearch.GetAssignedToIDFromName(NameIn: string) : integer;
begin
    With dmMT2.qMT_Select do
       try
         Active:= false;
         SQL.Text:= 'USE [MT2]';
         SQL.Add('SELECT DepartmentID FROM tblDepartments WHERE Department LIKE :asnm');
         ParamByName('asnm').AsString:= NameIn + '%';
         Active:= true;
         if RecordCount > 0 then
           Result:= Fields[0].AsInteger
         else
           Result:= 0;

       finally
         Active:= false;
       end;
end;

end.
