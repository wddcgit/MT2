unit fuCustomerLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, HTMLabel, AdvEdit,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DateUtils, W7Classes, W7Bars,
  Vcl.ExtCtrls, AdvGlowButton, Vcl.ComCtrls, AdvCombo, ColCombo, uMT2Classes,
  AdvOfficeButtons, Data.DB, MemDS, DBAccess, MSAccess;

type
  TfrmCustomerLog = class(TForm)
    eMember: TAdvEdit;
    lblClient: THTMLabel;
    sgLogs: TAdvStringGrid;
    ibCLInfo: TW7InformationBar;
    lblStatus: TLabel;
    cbMember: TComboBox;
    Label9: TLabel;
    pnlLog: TPanel;
    Label1: TLabel;
    lblLogID: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    pnlButtons: TPanel;
    btnSave: TAdvGlowButton;
    btnNewLog: TAdvGlowButton;
    btnClearLog: TAdvGlowButton;
    btnDeleteLog: TAdvGlowButton;
    cbCaller: TComboBox;
    Panel2: TPanel;
    cbCtgy: TComboBox;
    Label2: TLabel;
    cbShipMethod: TComboBox;
    Label4: TLabel;
    Label3: TLabel;
    cbDept: TComboBox;
    cbStaff: TComboBox;
    Label5: TLabel;
    memInvoices: TMemo;
    HTMLabel1: THTMLabel;
    btnInvoicesandTracking: TAdvGlowButton;
    lblBoL: THTMLabel;
    memWaybills: TMemo;
    Label10: TLabel;
    cbPickedBy: TColumnComboBox;
    memDetail: TMemo;
    Label6: TLabel;
    Label11: TLabel;
    memNotes: TMemo;
    chkClosed: TAdvOfficeCheckBox;
    cbClosedBy: TComboBox;
    Label12: TLabel;
    Label13: TLabel;
    dtpClosedOn: TDateTimePicker;
    lblLogPageID: TLabel;
    btnPrior: TAdvGlowButton;
    btnNext: TAdvGlowButton;
    lblPageCnt: TLabel;
    btnNewPage: TAdvGlowButton;
    btnPrintLog: TAdvGlowButton;
    lblOpenedBy: TLabel;
    Label15: TLabel;
    lblLogDate: TLabel;
    btnPreview: TAdvGlowButton;
    lblSaved: TLabel;
    tmrSaved: TTimer;
    procedure eMemberChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GetLogs;
    procedure eMemberExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgLogsGetColumnFilter(Sender: TObject; Column: Integer;
      Filter: TStrings);
    procedure sgLogsFilterSelect(Sender: TObject; Column, ItemIndex: Integer;
      FriendlyName: string; var FilterCondition: string);
    procedure sgLogsClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure ShowLogDetails(LogId, RowID : integer);
    procedure sgLogsRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure ClearDetails;
    procedure btnNewLogClick(Sender: TObject);
    function SaveLog(LogID : integer) : integer;
    function GetNewLogId : integer;
    procedure btnSaveClick(Sender: TObject);
    procedure btnClearLogClick(Sender: TObject);
    procedure eMemberKeyPress(Sender: TObject; var Key: Char);
    procedure ClearGrid;
    procedure btnDeleteLogClick(Sender: TObject);
    procedure lblBoLAnchorClick(Sender: TObject; Anchor: string);
    procedure btnInvoicesandTrackingClick(Sender: TObject);
    function FindMember(SearchText : String; FromMemberBox : boolean) : boolean;
    procedure cbMemberChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ClearLogPages;
    procedure DisplayLogPage(LogPage : TLogPage);
    procedure btnPriorClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnNewPageClick(Sender: TObject);
    function FindLogRow(LogID : String) : integer;
    procedure SaveLogPage(PageIndex : integer);
    procedure btnPrintLogClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    function SaveLogPageToDB(LogPageIn : TLogPage) : integer;
    procedure cbCtgyChange(Sender: TObject);
    function CreateNewBlankPage(LogID : integer) : integer;
    procedure cbDeptChange(Sender: TObject);
    procedure tmrSavedTimer(Sender: TObject);
    procedure ShowSavedLabel(LogID : integer);
    procedure ValidateTrackingList(StringsIn : TStringList);
  private
    { Private declarations }
  public
    { Public declarations }
    sCL_MemberNbr : String; //holds the selected memer num ber
    sCL_MemberName : String;
    dCL_Start, dCL_End : TDateTime;
    sCL_Open : String ; //holds the default string for open HTML
    bCL_UpdateLog : boolean;
    bCL_EditLog : boolean;
    iCL_LogID : integer;
    bCL_Clear : boolean;
    stlCL_LogPages : TStringList;
    iCL_LogPageIdx : integer;
    iCL_LogPageCount : integer;
    bCL_SavedCompletely : boolean;
  end;


var
  frmCustomerLog: TfrmCustomerLog;

implementation

{$R *.dfm}

uses duMT2, uMT2GlobalVar, fuDateSelection, fuCustomerInvoices, uCommon, fuBoL;


procedure TfrmCustomerLog.eMemberChange(Sender: TObject);
begin
    FindMember(eMember.Text, false);
end;

function TfrmCustomerLog.FindMember(SearchText : String; FromMemberBox : boolean) : boolean;
var
  q1 : TMSQuery;
  sPhone : String;
  sFax : String;
begin
   try
   //first. while we are looking we want to clear the grid and details

   if not bCL_Clear then
      try
        bCL_Clear:= true;
        sgLogs.BeginUpdate;
        ClearGrid;
        ClearDetails;

      finally
        sgLogs.EndUpdate;
      end;

   lblClient.BeginUpdate;
   lblClient.HTMLText.Text:= '';
   if not FromMemberBox then
      cbMember.Items.Clear;

   if eMember.Text <> '' then
    begin
      if IsValidInt(Copy(SearchText,1,1)) then //searching by member nbr
         q1:= dmMT2.qMembers
      else
         q1:= dmMT2.qDB_MemberName;

      With q1 do
      try
        Active:= false;
        ParamByName('cnbr').AsString:= SearchText + '%';

        Active:= true;
        if RecordCount > 0 then
          begin
             sCL_MemberName:= Fields[1].AsString;
             sPhone:= Copy(Fields[6].AsString,1,10);
             sFax:= Copy(Fields[8].AsString,1,10);
             if Length(sPhone) = 10 then
                begin
                  System.Insert('(',sPhone,1);
                  System.Insert(')',sPhone,5);
                  System.Insert(' ',sPhone,9);
                end;
             if Length(sFax) = 10 then
                begin
                  System.Insert('(',sFax,1);
                  System.Insert(')',sFax,5);
                  System.Insert(' ',sFax,9);
                end;
             if not FromMemberbox and (cbMember.Items.IndexOf(FIelds[0].AsString) = -1) then
                 cbMember.Items.Add(Fields[0].AsString);

             lblClient.HTMLText.Clear;
             lblClient.HTMLText.Add('<FONT size="10"><b>' + Fields[1].AsString + '</b></FONT><br>');
             lblClient.HTMLText.Add(Fields[2].AsString + '<br>');
             lblClient.HTMLText.Add(Fields[3].AsString + ', ' + Fields[4].AsString + ' ' + Fields[5].AsString + '<br><br>');
             lblClient.HTMLText.Add('<Font size="9">Phone : <b>' + sPhone + '</b><IND x="140">Fax : <b>' + sFax + '</b></font>');

             if Fields[7].AsString <> '' then
                lblClient.HTMLText.Add('<br><A HREF="emal' + Fields[7].AsString + '">' + Fields[7].AsString + '</A>');
             sCL_MemberNbr:= Fields[0].AsString;
             // add all the other member numbers if there are some
             if not FromMemberBox then
                  while not EOF do
                   begin
                    if cbMember.Items.IndexOf(FIelds[0].AsString) = -1 then
                       cbMember.Items.Add(FIelds[0].AsString);
                    Next;
                   end;
             if not FromMemberBox then
                 cbMember.ItemIndex:= 0;

          end
         else
           sCL_MemberNbr:= '';
      finally
        Active:= false;
      end;
    end;
   finally
     lblClient.EndUpdate;
   end;
   if FromMemberBox then //immediately look up any logs
      GetLogs;
end;

procedure TfrmCustomerLog.eMemberExit(Sender: TObject);
begin
  if sCL_MemberNbr <> '' then
   begin
      dCL_end:= Now; // since logs can occur anytime, this timestamp needs to be current unless using a date range
      GetLogs;
   end;
end;

procedure TfrmCustomerLog.eMemberKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
       eMemberExit(eMember);
end;

procedure TfrmCustomerLog.FormCreate(Sender: TObject);
begin
    lblCLient.HTMLText.Text:= '';
    sCL_MemberNbr:= '';
    //add a bitmap to the first colmun
    dmMT2.iml16x16.GetBitmap(1,sgLogs.CreateBitmap(0,0,true,haRight,vaTop));
    dCL_Start:= IncYear(Now,-10);
    dCL_End:= Now;
    lblStatus.Caption:= '';
    lblLogId.Caption:= '';
    sCL_Open:= '<IMG SRC="idx:0"><IND x="20">Open';
    lblLogDate.Caption:= FormatDateTIme('mmm dd yyyy h:nn AM/PM', Now);
    stlCL_LogPages:= TStringList.Create;
    iCL_LogPageIdx:= -1;
    lblOpenedBy.Caption:= '';
    lblLogPageID.Caption:= '';


end;

procedure TfrmCustomerLog.FormDestroy(Sender: TObject);
begin
    stlCL_LogPages.Free;
end;

procedure TfrmCustomerLog.FormShow(Sender: TObject);
var
  i : integer;
begin
   Caption:= 'Customer Log - Staff : ' + sGV_EmpName;
   cbCtgy.Items.Assign(stlGV_CLCtgy);
   cbDept.Items.Assign(stlGV_Dept);
   cbShipMethod.Items.Assign(stlGV_ShipMethod);
   cbStaff.Items.Assign(stlGV_Staff);
   cbClosedBy.Items.Assign(stlGV_Staff);
   //get opciked by list
   cbPickedBy.ComboItems.Clear;
   try
     cbPickedBy.BeginUpdate;
     for i:= 0 to Pred(stlGV_Pickers.COunt) do
       With cbPickedBy.ComboItems.Add do
          begin
           Strings.Add(stlGV_pickers.ValueFromIndex[i]);
           Strings.Add(stlGV_Pickers.Names[i]);
          end;
   finally
     cbPickedBy.endUpdate;
   end;
   dtpClosedOn.DateTIme:= Now;




end;

procedure TfrmCustomerLog.GetLogs;
var
  x, y : integer;
  sCaller : String;
begin
    ///get the log for the customer
    With sgLogs do
      try
        bCL_Clear:= false;
        bCL_UpdateLog:= True;
        BeginUpdate;

        for x:= 0 to Pred(ColCount) do
          for y:= 1 to Pred(RowCount) do
             Cells[x,y]:= '';
        RowCount:= 2;
        x:= 1;
        With dmMT2.qMT_Logs do
           try
             Active:= false;
             ParamByName('cnbr').AsString:= sCL_MemberNbr;
             ParamByName('stdt').AsDateTime:= dCL_Start;
             ParamByName('endt').AsDateTime:= dCL_End;
             DisableControls;
             Active:= true;
             lblStatus.Caption:= IntTOStr(RecordCount) + ' records found';
             while not EOF do
               begin
                 if x > 1  then
                   AddRow;
                 Cells[0,x]:= FormatDateTime('mm/dd/yy h:nn AM/PM',Fields[2].AsDateTime);   // call time
                 Cells[1,x]:= Fields[0].AsString;
                 Cells[2,x]:= Fields[5].AsString;
                 Cells[3,x]:= Fields[3].AsString;  //problem
                 Objects[3,x]:= TObject(Fields[8].AsInteger);
                 if not Fields[6].AsBoolean then //still open
                      Cells[4,x]:= sCL_Open;
                 Next;
                 Inc(x);
               end;
           finally
            begin
              EnableControls;
              Active:= false;
            end;
           end;
      finally
       begin
         EndUpdate;
        // AutoSizeRows(false,3);
        bCL_UpdateLog:= false;
       end;
      end;

       //get a list of unique callers
       With dmMT2.qMT_CallerList do
         try
           Active:= false;
           ParamByName('cid1').AsString:= sCL_memberNbr;
           Active:= true;
           while not EOF do
             begin
               sCaller:= TRIM(Fields[0].AsString);
               if (sCaller <> '') and (cbCaller.Items.IndexOf(sCaller) = -1) then
                   cbCaller.Items.Add(sCaller);
               Next;
             end;
         finally

         end;

end;

procedure TfrmCustomerLog.lblBoLAnchorClick(Sender: TObject; Anchor: string);
begin
    if sCL_MemberNbr = '' then exit;
    With TfrmBoL.Create(nil) do
       try
         Caption:= 'Tracking History - ' + sCL_MemberName;
         sBL_MemberNbr:= sCL_memberNbr;
         lbBoL.ITems.Assign(memWayBills.Lines);
         ShowModal;
         if ModalResult = mrOK then
            memWayBills.LInes.Assign(lbBoL.Items);


       finally
         Free;
       end;

end;

procedure TfrmCustomerLog.sgLogsClickCell(Sender: TObject; ARow, ACol: Integer);
begin

  case ARow of

  0:  if (ACol = 0) then
       With TfrmDateSelection.Create(nil) do
       try
         dtpStart.DateTime:= dCL_Start;
         dtpEnd.DateTime:= dCL_End;
         ShowModal;
         if ModalResult = mrOK then
             begin
               dCL_Start:= dtpStart.DateTime;
               dCL_end:= dtpEnd.DateTime;
               GetLogs;
             end;
       finally

       end;
  else

      try
       if iCL_LogID <> StrToInt(sgLogs.Cells[1,ARow])  then
            ShowLogDetails(StrToInt(sgLogs.Cells[1,ARow]),ARow);
      except

      end;
  end;
end;

procedure TfrmCustomerLog.sgLogsFilterSelect(Sender: TObject; Column,
  ItemIndex: Integer; FriendlyName: string; var FilterCondition: string);
begin
     if FilterCondition = 'All' then
       FilterCondition:= ''
     else
      case Column of
      2: FilterCondition:= ' = "' + FilterCondition + '"';
      4: FilterCondition:= ' = *Open*';
      end;

end;

procedure TfrmCustomerLog.sgLogsGetColumnFilter(Sender: TObject;
  Column: Integer; Filter: TStrings);
begin
    case Column of
    2: begin
         Filter.Assign(stlGV_CLCtgy);
         Filter.Insert(0,'All');
       end;
    4: begin
         Filter.Clear;
         Filter.Add('All');
         Filter.Add('Open');
       end;
    end;
end;

procedure TfrmCustomerLog.sgLogsRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
       if (NewRow > 0) and not bCL_UpdateLog then
           ShowLogDetails(StrToIntDef(sgLogs.Cells[1,NewRow],0),NewRow);
end;

procedure TfrmCustomerLog.ShowLogDetails(LogId, RowID : integer);
var
  iRow : integer;

  sPicked : String;
  iPageCnt : integer;
  tPage : TLogPage;
  iPage : integer;

procedure GetInvoices(ProblemId : integer;  InvoiceList : TStrings);
begin
     //find any invoices attached
     InvoiceList.Clear;
     With dmMT2.qMT_InvoiceList do
       try
         Active:= false;
         ParamByName('pid1').Asinteger:= ProblemID;
         Active:= true;
         memInvoices.Lines.Clear;
         while not EOF do
           begin
             InvoiceList.Add(Fields[0].AsString);
             Next;
           end;
       finally
         Active:= false;
       end;
end;

procedure GetTrackingNumbers(ProblemId : integer;  WayBillList : TStrings);
begin
     //find any invoices attached
     WayBillList.Clear;
     With dmMT2.qMT_TrackingList do
       try
         Active:= false;
         ParamByName('pid1').Asinteger:= ProblemID;
         Active:= true;
         memInvoices.Lines.Clear;
         while not EOF do
           begin
             WayBillList.Add(Fields[0].AsString);
             Next;
           end;
       finally
         Active:= false;
       end;
end;
function FindLogPageIndex(PageID : integer) : integer;
var
   i1 : integer;
begin
    Result:= -1;
    for i1:= 0 to Pred(stlCL_LogPages.Count) do
         try
             if TLogPage(stlCL_logPages.Objects[i1]).PageID = PageID then
               begin
                 Result:= i1;
                 break;
               end;
         except
         end;
    if Result = -1 then
       Result:= 0;
end;

procedure AddRecordPage;
var
  pg1 : TLogPage;
begin

     pg1:= TLogPage.Create;
     pg1.LogID:= LogID;
     With dmMT2.qMT_LogDet do
        try

            pg1.PageID:= Fields[13].AsINteger;
            pg1.Category:=  Fields[5].AsString;
            pg1.ShippingMethod:= Fields[8].AsString;

            if stlGV_Dept.IndexOfObject(TObject(Fields[12].AsInteger)) > -1 then
                 pg1.Department:= stlGV_Dept[stlGV_Dept.IndexOfObject(TObject(Fields[12].AsInteger))];
            if stlGV_Staff.IndexOfObject(Tobject(Fields[7].AsINteger)) > -1 then
                 pg1.KeyedBy:= stlGV_Staff[stlGV_Staff.IndexOfObject(Tobject(Fields[7].AsINteger))]
            else
                pg1.KeyedBy:= '';
            pg1.InvoiceList.Assign(memINvoices.Lines);
            pg1.TrackingList.Assign(memWaybills.Lines);
            pg1.PickedBy:= Fields[11].AsString;
            pg1.Problem:= Fields[3].AsString;
            pg1.Notes:= Fields[4].AsString;
            pg1.Closed:= Fields[6].AsBoolean;
            pg1.ClosedBy:= Fields[10].AsString;
            if not Fields[9].IsNull then
                 pg1.ClosedDate:= Fields[9].AsDateTime;
            pg1.Caller:= Fields[1].AsString;
            pg1.OpenedBy:= Fields[14].AsString;
            pg1.LogDate:= Fields[2].AsDateTime;
                // find any invoices
            GetInvoices(pg1.PageID,TStrings(pg1.InvoiceList));
            GetTrackingNumbers(pg1.PageID,pg1.TrackingList);
            stlCL_LogPages.AddObject('1',pg1);
        finally

        end;
end;


begin


     if LogID = 0 then exit;
     iCL_LogId:= LogId;
     if RowID > 0 then
        iRow:= RowID
     else
        iRow:= sgLogs.Row;
     //clear out the pages
     ClearLogPages;
     iPageCnt:= 0;

     // log id  and page id
     lblLogID.Caption:= sgLogs.Cells[1,iRow];
     iPage:= INteger(sgLogs.Objects[3,iRow]);
     //category

     //the rest must come from the table
     With dmMT2.qMT_LogDet do
       try
         DisableControls;
         Active:= false;
         ParamByName('logd').Asinteger:= LogId;
         Active:= true;
         iCL_LogPageCount:= RecordCount;
         if RecordCount > 0 then   //add all the found records to the list
           while not EOF do
             begin
                AddRecordPage;
                Next;
                Inc(iPageCnt);
             end;

         // if the row held a specific problem id, go to that, else show the first
         //now go to the first record and display the contents
         if stlCL_LogPages.Count > 0 then
            begin
                if iPage > 0 then //we are looking for a specific page
                   iPage:= FindLogPageIndex(iPage);
                tPage:= TLogPage(stlCL_LogPages.Objects[iPage]);
                DisplayLogPage(tPage);
                iCL_LogPageIdx:= iPage;

            end
          else
            iCL_LogPageIdx:= -1;
          lblPageCnt.Caption:=  'Page ' + IntTOStr(iCL_LogPageIdx + 1) + ' of ' + IntToStr(iPageCnt) + ' pages';
          btnNext.Enabled:= (iCL_LogPageCount > 0);
          btnPrior.Enabled:= (iCL_LogPageCount > 0);
          btnNewPage.Enabled:= true;
       finally
        begin
         Active:= false;
         EnableControls;
        end;
       end;



end;

procedure TfrmCustomerLog.tmrSavedTimer(Sender: TObject);
begin
    lblSaved.Visible:= false;
    tmrSaved.Enabled:= false;
end;

procedure TfrmCustomerLog.btnInvoicesandTrackingClick(Sender: TObject);
begin
   With TfrmCustomerInvoices.Create(nil) do
      try
         Caption:= 'Transaction and Tracking List - ' + sCL_MemberName;
         sCI_CustomerNbr:= sCL_MemberNbr;
         lbInvoicesToAdd.Items.Assign(memInvoices.Lines);
         lbTrackingNbr.Items.Assign(memWaybills.Lines);
         ShowModal;
         if ModalResult = mrOK then
           begin
            memInvoices.Lines.Assign(lbInvoicesToAdd.Items);
            memWaybills.Lines.Assign(lbTrackingNbr.Items);
           end;
      finally
         Free;
      end;
end;

procedure TfrmCustomerLog.btnClearLogClick(Sender: TObject);
begin
   if bCL_EditLog then
     case MessageDlg('Are you sure you want to clear without saving this log?',mtConfirmation,[mbYes,mbCancel],0) of
     mrCancel: exit;
     mrYes : begin
               bCL_EditLog:= false;

               ClearDetails;
            end;

     end
  else
    ClearDetails;
end;

procedure TfrmCustomerLog.btnDeleteLogClick(Sender: TObject);
var
  iRow, i : integer;
  s : String;
begin
   if iCL_LogId = 0 then exit;
   s:= '';
   if InputQuery('Delete log','Please enter the admin password.',s) and (s = 'Dollar6') then

    if MessageDlg('Are you really sure you want to delete Log : ' + IntToStr(iCL_LogID) + '?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
       With dmMT2.qMT_AddOther do
          try

            SQL.Text:= 'USE [MultiTracking];';
            SQL.Add('DELETE FROM dbo.tblCustomerLog WHERE logid=:log2;');
            SQL.Add('DELETE FROM dbo.tblCustomerLogInfo WHERE logid=:log2;');
            ParamByName('log2').AsInteger:= iCL_LogID;
            Execute;
            iRow:= 0;
            With sgLogs do
              try
               BeginUpdate;
               for i := 1 to Pred(RowCOunt) do
                   if Cells[1,i] = IntToStr(iCL_LogID) then
                      begin
                          iRow:= i;
                          break;
                      end;
                If iRow > 0 then
                  RemoveRows(iRow,1);
              finally
                 EndUpdate;
              end;
          finally
             begin
               iCL_LogID:= 0;
               ClearDetails;
             end;
          end;

          btnNext.Enabled:= (iCL_LogPageCount > 0);
          btnPrior.Enabled:= (iCL_LogPageCount > 0);

end;

procedure TfrmCustomerLog.btnNewLogClick(Sender: TObject);
var
  t : TlogPage;
  iNewLog : integer;
begin



     if bCL_EditLog then //there is a pre=existing log, so prompt to save
        case MessageDlg('Save current log before starting a new one?',mtCOnfirmation,[mbYes,mbNo,mbCancel],0) of
        mrYes :  SaveLog(iCL_LogId);
        mrCancel : exit; //do nothing
        end;

     ClearDetails; //removes all the current information including clearing out the log pages

     //now save this as a new blank log
     iNewLog:= SaveLog(0);
     lblLogId.Caption:= IntToStr(iNewLog) ;
     lblLogDate.Caption:= FormatDateTime('mmm dd yyyy h:nn AM/PM',now);
     lblOpenedBy.Caption:= sGV_EmpName;
     iCL_LogID:= iNewLog;
     bCL_EditLog:= true;
     // create a new log page
     //CreateNewBlankPage(iNewLog);


     //the log will be created on todays date so the first box should be the caller
     ActiveControl:= cbCaller;


end;

procedure TfrmCustomerLog.btnNewPageClick(Sender: TObject);
var
  pg1 : TLogPage;
begin

    if stlCL_LogPages.Count > 0 then //save the previos entry in case the user has modified it
       SaveLogPage(iCL_LogPageIdx);

    pg1:= TLogPage.Create;
    pg1.LogID:= iCL_LogID;
    pg1.PageID:= 0;
    pg1.LogDate:= Now;
    pg1.Caller:= cbCaller.Text;
    stlCL_LogPages.AddObject('1',pg1);
    iCL_LogPageCount:= stlCL_LogPages.Count;
    iCL_LogPageIdx:= Pred(iCL_LogPageCount);

    DisplayLogPage(pg1);
    btnPrior.Enabled:= true;

end;

procedure TfrmCustomerLog.btnNextClick(Sender: TObject);
begin

    if iCL_LogPageIdx < Pred(stlCL_LogPages.Count) then
      begin
          //if the user is moving between logs and has modified any settings in the log, then first save the original page
         SaveLogPage(iCL_LogPageIdx); //this does not save to the db, but to the TLogPage in memory

         Inc(iCL_LogPageIdx);
         DisplayLogPage(TLogPage(stlCL_LogPages.Objects[iCL_LogPageIdx]));
         lblPageCnt.Caption:= 'Page ' + IntToStr(iCL_LogPageIdx + 1) + ' of ' + IntToStr(iCL_LogPageCount);
      end;
   btnNext.Enabled:= (iCL_LogPageCount > 0) and (iCL_LogPageIdx < Pred(iCL_logPageCount));
   btnPrior.Enabled:= (iCL_LogPageCount > 0) and (iCL_LogPageIdx > 0);
end;

procedure TfrmCustomerLog.btnPreviewClick(Sender: TObject);
begin
   try
    dmMT2.PrintLog(iCL_LogID,TLogPage(stlCL_LogPages.Objects[iCL_LogPageIdx]).PageID,true);
   except on E: Exception do
    MessageDlg('An error printing has occured. The nature of the error states "' + e.Message + '"' + #13 +'The error has been forwarded to the appropriate authorities.',mtError,[mbOK],0);

   end;
end;

procedure TfrmCustomerLog.btnPrintLogClick(Sender: TObject);
begin
   try
    dmMT2.PrintLog(iCL_LogID,TLogPage(stlCL_LogPages.Objects[iCL_LogPageIdx]).PageID,false);
   except on E: Exception do
    MessageDlg('An error printing has occured. The nature of the error states "' + e.Message + '"' + #13 +'The error has been forwarded to the appropriate authorities.',mtError,[mbOK],0);

   end;
end;

procedure TfrmCustomerLog.btnPriorClick(Sender: TObject);
begin

   if iCL_LogPageIdx > 0 then
      begin
         //if the user is moving between logs and has modified any settings in the log, then first save the original page
         SaveLogPage(iCL_LogPageIdx);

         Dec(iCL_LogPageIdx);
         DisplayLogPage(TLogPage(stlCL_LogPages.Objects[iCL_LogPageIdx]));
         lblPageCnt.Caption:= 'Page ' + IntToStr(iCL_LogPageIdx + 1) + ' of ' + IntToStr(iCL_LogPageCount);

      end;
      btnNext.Enabled:= (iCL_LogPageCount > 0) and (iCL_LogPageIdx < Pred(iCL_logPageCount));
   btnPrior.Enabled:= (iCL_LogPageCount > 0) and (iCL_LogPageIdx > 0);


end;

procedure TfrmCustomerLog.btnSaveClick(Sender: TObject);
var
  iResult : integer;
  iPage : integer;
  t : TLogPage;
begin
   //retain the page number the client was looking at, bearing in mind there might be new numbers
   iPage:= iCL_LogPageIdx; //now we now the last page the client was looking at, once they are saved the log page will have the correct ProblameID
   iResult:= SaveLog(iCL_logID);
   If (iResult > 0) and (bCL_SavedCompletely) then
    begin
       iCL_logID:= iResult;
       try
       t:= TLogPage(stlCL_LogPages.Objects[iPage]);
       iPage:= t.PageID;
       except
         iPage:= 0;
       end;
       ShowSavedLabel(iCL_LogID);
       If bGV_AutoPrint then
           dmMT2.PrintLog(iCL_LogID,iPage,false);
       ClearDetails;
       iCL_LogID:= 0;
    end;
end;

procedure TfrmCustomerLog.cbCtgyChange(Sender: TObject);
begin
  //if there is no current log page (such as when the user has clicked new) , then add a new log page
  if (cbCtgy.ItemIndex > -1) and (iCL_LogID > 0) and (stlCL_LogPages.Count = 0) then
      begin
          CreateNewBlankPage(iCL_LogID);
      end;

end;

procedure TfrmCustomerLog.cbDeptChange(Sender: TObject);
begin
  if (cbDept.ItemIndex > -1) and (iCL_LogID > 0) and (stlCL_LogPages.Count = 0) then
      begin
          CreateNewBlankPage(iCL_LogID);
      end;
end;

procedure TfrmCustomerLog.cbMemberChange(Sender: TObject);
begin
  if (ActiveControl = cbMember) and (cbMember.ItemIndex > -1) then
     FindMember(cbMember.Items[cbMember.ItemIndex],True);
end;

procedure TfrmCustomerLog.ClearDetails;

begin
    // clear all the details
    lblLogId.Caption:= '';
    lblLogDate.Caption:= FormatDateTime('mmm dd yyyy h:nn AM/PM',Now);
    cbCaller.Text:= '';

    cbCtgy.ItemIndex:= -1;
    cbDept.ItemIndex:= -1;
    cbShipMethod.ItemIndex:= -1;
    cbStaff.ItemIndex:= -1;

    memInvoices.Lines.Clear;
    memWaybills.Lines.Clear;
    memDetail.Lines.Clear;
    memNotes.Lines.Clear;

    cbPickedBy.ItemIndex:= -1;

    lblLogPageID.Caption:= '';
    chkClosed.Checked:= false;
    cbCLosedBy.ItemIndex:= -1;
    dtpCLosedOn.DateTIme:= now;

    // now clear out the log pages
    ClearLogPages;




end;

function TfrmCustomerLog.SaveLog(LogID: Integer) : integer;
var
  iProblemID : integer;
  iKeyedBy : integer;
  iPickedBy : integer;
  i , x, y: integer;
  bNew : boolean;
  iRow : integer;
  t : TlogPage;
  w : TWinControl;
  sMsg : String;
  bMissing : boolean;
  iEmpID : integer;
begin
   //saves the log
   //some basic verification
   bCL_SavedCompletely:= false;
   if sCL_MemberNbr = '' then exit; // no customer selected
   //now save the current select log page

   bCL_SavedCompletely:= true;
   SaveLogPage(iCL_LogPageIdx);



   // now go through all the pages to ensure they are not missing information
   //LogId is an identity field (which is an auto increment
   //the only requirement for a new log is the client ID
   bNew:= LogID = 0;

   for y:= 0 to Pred(stlCL_LogPages.Count) do
       begin
          t:= TLogPage(stlCL_LogPages.Objects[y]);
          //there has to be some detail
          bMissing:= false;
          if t.Problem = '' then
              begin
                w:= memDetail;
                sMsg:= 'The detail field cannot be blank';
                bMissing:= true;
              end;
          if not bMissing and (t.Department = '') then
             begin
                w:= cbDept;
                sMsg:= 'Department is a required field.';
                bMissing:= true;

             end;
          if not bMissing and (t.Category = '') then
             begin
                w:= cbCtgy;
                sMsg:= 'Category is a required field.';
                bMissing:= true;
             end;
          //if anything is missing then stop

       end;

   //create or update the main log table
   With dmMT2.qMT_InsertCustomerLogInfo do
          try   //LogID is an autoinc field or in SQL an Identity field. One of the options with the TMSQuery tools must be enabled.
                //when Options.QueryIdentity = True the newly added identity field ID is returned as Field[0], hence the code at the end of the EXECSQL
                // in the query the comand SELECT SCOPE_INDENTITY() must also be present following the last command
                ParamByName('log2').AsInteger:= LogID;
                ParamByName('cnbr').AsString:= sCL_MemberNbr;
                ParamByName('cal2').AsString:= cbCaller.Text;
                ParamByName('ldt2').AsDateTime:= Now; // if this is an existing log, this date will not get changed
                //if this is an existing log, then the original starter should remain.
                if stlGV_Staff.IndexOf(lblOpenedBy.Caption) > -1 then
                    iEmpID:= Integer(stlGV_Staff.Objects[stlGV_Staff.IndexOf(lblOpenedBy.Caption)])
                else
                    iEmpID:= iGV_empID;

                ParamByName('eid2').AsInteger:= iEmpId; //opendby comes from the name in the field. If this is a new log it will be the current user, otherwise it is the person who created the log
                ParamByName('rsvd').AsBoolean:= True;
                Execute;
                if LogID = 0 then
                    Result:= Fields[0].Asinteger //this will be a new log entry as assigned by SQL identity field
                else
                    Result:= LogId;
          finally

          end;



   //create an entry in the CustomerLog table
   //now create an entry in the customer log
   //there has to be at least on PID. If this does not exists (say the user has just created a new log, then create a blank PID
   {if stlCL_LogPages.COunt = 0 then
      begin
        //create a new blank log page
        t:= TLogPage.Create;
        t.PageID:= 0;
        t.LogID:= LogID;
        stlCL_LogPages.AddObject('N',t);
        iCL_LogPageIdx:= 0;
      end; }


   for x := 0 to Pred(stlCL_LogPages.Count) do
    if bCL_SavedCompletely then
         bCL_SavedCompletely:= SaveLogPageToDB(TLogPage(stlCL_LogPages.Objects[x])) > 0;




   //with the update insert into the grid
   if Result > 0 then
      begin
        lblLogID.Caption:= IntToStr(Result);
        //flag this as no longer being edited
        bCL_EditLog:= false;
        // add the results to the grid


        With sgLogs do
          try
             BeginUpdate;
             if bNew then
                begin
                  InsertRows(1,1);
                  iRow:= 1;
                end
             else //find the orignal log id
               begin
                  iRow:= 0;
                  for i := 1 to Pred(RowCOunt) do
                      if Cells[1,i] = IntToStr(Result) then
                         begin
                            iRow:= i;
                            break;
                         end;
                  if iROw = 0 then //not found, add a row
                   begin
                     InsertRows(1,1);
                     iRow:= 1;
                   end;

               end;
             Cells[0,iRow]:= FormatDateTime('mm dd yy h:nn AM/PM',Now); //if the log was updated, not created, then this date time is not correct, nor is it saved to the data. So it will be amended when scrolling the DB to the correct time
             Cells[1,iRow]:= IntToStr(Result);
             Cells[2,iRow]:= cbCtgy.Text;
             Cells[3,iRow]:= memDetail.Lines.Text;
             if not chkClosed.Checked then
                 Cells[4,iRow]:= sCL_Open
             else
                 Cells[4,iRow]:= '';
          finally
            EndUpdate;
          end;
      end;






end;

function TfrmCustomerLog.GetNewLogId : integer;
begin
  WIth dmMT2.qMT_Logid do
     try
       Active:= true;
       Result:= Fields[0].Asinteger + 1;

     finally
       Active:= false;
     end;

end;

procedure TfrmCustomerLog.ClearGrid;
var
  x,y : integer;
begin
       With sgLogs do
        for x:= 0 to Pred(ColCount) do
           for y:= 1 to Pred(RowCount) do
              Cells[x,y]:= '';
        sgLogs.RowCount:= 2;

end;

procedure TfrmCustomerLog.ClearLogPages;
var
  i : integer;
begin
     With stlCL_LogPages do
       for i:= 0 to Pred(count) do
           try
             Objects[i].Free;
             Objects[i]:= nil;
           except
           end;
     stlCL_logPages.Clear;
end;

procedure TfrmCustomerLog.DisplayLogPage(LogPage: TLogPage);
var
  sPicked : String;
  iPID : integer;
  s : String;
begin

    cbCaller.Text:= LogPage.Caller;
    lblLogDate.Caption:= FormatDateTime('mmm dd yyyy h:nn AM/PM',LogPage.LogDate);
    lblOpenedBy.Caption:= LogPage.OpenedBy;
    cbCtgy.ItemIndex:= cbCtgy.Items.IndexOf(LogPage.Category);
    cbShipMethod.ItemIndex:= cbSHipMethod.Items.IndexOf(LogPage.ShippingMethod);
    cbStaff.ItemIndex:= cbStaff.Items.IndexOf( LogPage.KeyedBy ) ;
    memDetail.Lines.Text:= LogPage.Problem;
    cbDept.ITemINdex:= cbDept.Items.IndexOf( LogPage.Department);
    iPID:= LogPage.PageID;
    if iPID = 0 then
       s:= 'New'
    else
       s:= IntToStr(iPID);


    lblLogPageID.Caption:=  s;
    chkClosed.Checked:= LogPage.Closed;
    memNotes.Lines.Text:= LogPage.Notes;
    sPicked:= LogPage.PickedBy;
    cbPickedBy.ItemIndex:= stlGV_Pickers.IndexOfName(sPicked);
    memInvoices.Lines.Assign(LogPage.InvoiceList);
    memWaybills.Lines.Assign(LogPage.TrackingList);

    If chkClosed.Checked then
          begin
           if LogPage.ClosedDate > 0 then
              dtpClosedOn.DateTime:= LogPage.ClosedDate;
           cbClosedBy.ItemIndex:= cbClosedBy.Items.IndexOf(LogPage.ClosedBy);
           if cbClosedBy.ItemIndex = -1 then //thry looking the emplyee up by their number
                  try
                      cbClosedBy.ItemIndex:= cbClosedBy.Items.IndexOfObject(TOBject(StrToInt(LogPage.ClosedBy)));
                   except
                       //this obviulsy aint an integer
                   end;
          end
    else
       begin
         dtpClosedOn.DateTime:= Now;
         cbClosedBy.ItemIndex:= -1;
       end;
end;

function TfrmCustomerLog.FindLogRow(LogID: string) : integer;
var
  i : integer;
begin
    Result:= -1;
    With sgLogs do
     for i:= 1 to  Pred(RowCount) do
         if Cells[1,i] = LogID then
           begin
             Result:= i;
             break;
           end;


end;
procedure TfrmCustomerLog.SaveLogPage(PageIndex: Integer);
var
  t : TLogPage;
  i: integer;
begin
   // adds or updates the content of the displayed page into the log page
   //first check that the supplued index is within the page index
   if (PageIndex > -1) and (PageIndex < stlCL_LogPages.Count)  then
      begin
          t:= TLogPage(stlCL_LogPages.Objects[PageIndex]);
          t.Category:= cbCtgy.Text;
          t.ShippingMethod:= cbShipMethod.Text;
          t.Department:= cbDept.Text;
          t.KeyedBy:= cbStaff.Text;
          t.Problem:= memDetail.Lines.Text;
          t.Notes:= memNotes.Lines.Text;
          t.InvoiceList.Assign(memInvoices.Lines);
          t.TrackingList.Assign(memWaybills.Lines);
          if t.OpenedBy = '' then
             t.OpenedBy:= sGV_EmpName;
          if cbPickedBy.ItemIndex > -1 then
               t.PickedBy:= stlGV_Pickers.Names[cbPickedBy.ItemIndex]
          else
               t.PickedBy:= '';
          t.Closed:= chkCLosed.Checked;
          if t.Closed then
               begin
                t.ClosedBy:= cbClosedBy.Text;
                t.ClosedDate:= dtpClosedOn.DateTIme;
               end
          else
             begin
               t.ClosedBy:= '';
               t.ClosedDate:= 0;
             end;

      end;

end;

function TfrmCustomerLog.SaveLogPageToDB(LogPageIn: TLogPage) : integer;
var
  iPickedBy, i : integer;
begin
     // a log page requirement is department and categor and since this is a foreign key, they must exist in the other tables

     Result:= 0;
     if stlGV_Dept.IndexOf(LogPageIn.Department) < 0  then
       begin
          MessageDlg('A department is required before saving a log page.',mtError,[mbOK],0);
          exit;
       end;
     if stlGV_CLCtgy.IndexOf(LogPAgeIn.Category) < 0 then
       begin
          MessageDlg('A category is required before saving a log page.',mtError,[mbOK],0);
          exit;
       end;


     With dmMT2.qMT_InsertCustomerLog do
             try
                ParamByName('log2').AsInteger:= LogPageIn.LogID;
                ParamByName('dep2').AsInteger:=  Integer(stlGV_Dept.Objects[stlGV_Dept.IndexOf(LogPageIn.Department)]);
                ParamByName('prb2').AsString:= LogPageIn.Problem;
                ParamByName('cgy2').AsInteger:= Integer(stlGV_CLCtgy.Objects[stlGV_CLCtgy.IndexOf(LogPageIn.Category)]);
                ParamByName('not2').AsString:= LogPageIn.Notes;
                ParamByName('smt2').AsString:= LogPageIN.ShippingMethod;
                if stlGV_Staff.IndexOf(LogPageIN.KeyedBy) > -1 then
                    ParamByName('kby2').AsInteger:= Integer(stlGV_Staff.Objects[stlGV_Staff.IndexOf(LogPageIn.KeyedBy)])
                else
                    ParamByName('kby2').AsINteger:= 0;
                ParamByName('cby2').AsString:= LogPageIn.ClosedBy;
                if LogPageIn.ClosedDate = 0 then
                   ParamByName('cdt2').AsDateTime:= 0
                else
                   ParamByName('cdt2').AsDateTime:= LogPageIn.ClosedDate;
                ParamByName('cls2').AsBoolean:= LogPageIn.Closed;
                ParamByName('pid1').AsInteger:= LogPageIn.PageID;
                //small problem here. In ASC the user id is varchar(20) , in MT its an integer; .. So..not necessarily will they translate over    . And even if it does, it cannot find the picker again because the conversion wil lhave removed the 00 prefixes
                // the t.picked by contains the user name
                try
                  iPickedBy:= StrToIntDef(stlGV_Pickers.Names[stlGV_Pickers.IndexOfName(LogPageIn.PickedBy)],0);
                except
                  iPickedBy:= 0;
                end;
                ParamByName('pby2').AsInteger:= iPickedBy;
                Execute;
                //we need the new Problem ID . This will only work as an insert, otherwise it returns 0
                if LogPageIn.PageID = 0 then //this was a new page, so lets add it
                    begin
                      Result:=  Fields[0].Asinteger ;
                      LogPageIn.PageID:= Result ;
                      lblLogPageID.Caption:= IntToStr(Result);
                    end
                else
                   Result:= LogPageIn.PageID;
              except
                //the reason for failure would be not having a valid department or caegory number
              end;
        if Result > 0 then
           With dmMT2.qMT_AddOther do
              try
                //invoices
                SQL.Text:= 'USE [MultiTracking];';
                SQL.Add('DELETE FROM dbo.tblInvoiceNumbers WHERE ProblemId=:pid2;');
                 //now if there are invoices, add them back in
                if LogPageIn.InvoiceList.Count > 0 then
                    begin
                       SQL.Add('INSERT INTO dbo.tblInvoiceNumbers (ProblemID,InvoiceNumber) VALUES');
                       for i:= 0 to Pred(LogPageIn.InvoiceList.Count) do
                           if i < Pred(LogPageIN.InvoiceList.Count) then //you need a comma after every record but the last
                               SQL.Add('(' + IntToStr(Result) + ',' + QuotedStr(LogPageIn.InvoiceList[i]) + '),')
                           else
                               SQL.Add('(' + IntToStr(Result) + ',' + QuotedStr(LogPageIn.InvoiceList[i]) + ');');
                    end;
                ParamByName('pid2').AsInteger:= Result;
                Execute;
                //waybills
                SQL.Text:= 'USE [MultiTracking];';
                SQL.Add('DELETE FROM dbo.tblWayBillNumbers WHERE ProblemId=:pid2;');
                //if there are waybills, add them back in
                ValidateTrackingList(LogPageIn.TrackingList);

                if LogPageIn.TrackingList.Count > 0 then
                     begin
                        SQL.Add('INSERT INTO dbo.tblWayBillNumbers (ProblemID,WayBillNbr) VALUES');
                        for i:= 0 to Pred(LogPageIn.TrackingList.Count) do
                          if i < Pred(LogPageIn.TrackingList.Count) then //you need a comma after every record but the last
                               SQL.Add('(' + IntToStr(Result) + ',' + QuotedStr(LogPageIn.TrackingList[i]) + '),')
                          else
                               SQL.Add('(' + IntToStr(Result) + ',' + QuotedStr(LogPageIn.TrackingList[i]) + ');');
                     end;
                ParamByName('pid2').AsInteger:= Result;
                Execute;
              finally
              end;


end;

function TfrmCustomerLog.CreateNewBlankPage(LogID: Integer) : integer;
var
  pg1 : TLogPage;
begin
        // anew blank page has to have a category and a department
        if (cbCtgy.ItemIndex > -1) and (cbDept.ItemIndex > -1) then
           begin
               pg1:= TLogPage.Create;
               pg1.LogID:= LogID;
               pg1.PageID:= 0;
               Result:= stlCL_LogPages.AddObject('1',pg1);
               iCL_LogPageCount:= stlCL_LogPages.Count;
               iCL_LogPageIdx:= Pred(iCL_LogPageCount);
           end;

end;

procedure TfrmCustomerLog.ShowSavedLabel(LogID: Integer);
var
  s : String;
begin
     if LogID > 0 then
       s:=  IntToStr(LogID) + ' '
     else
       s:= '';
     lblSaved.Caption:= 'LogID ' + s + 'Saved.';
     lblSaved.Visible:= true;
     tmrSaved.Enabled:= true;
end;

procedure TfrmCustomerLog.ValidateTrackingList(StringsIn: TStringList);
var
  i : integer;
  stl : TStringList;
begin
    //remove any blank strings
    WIth StringsIn do
      for i:= Pred(Count) downto 0 do
       begin
        Strings[i]:= Trim(Strings[i]); //clears out any spaces at the end
        if Strings[i] = '' then
           Delete(i);
       end;
    //now remove duplicates
    try
      stl:= TStringList.Create;
      for i:= 0 to Pred(StringsIn.COunt) do
         if stl.IndexOf(StringsIn[i]) = -1 then
           stl.Add(StringsIn[i]);

    finally
      begin
        StringsIn.Assign(stl);
        stl.Free;
      end;
    end;

end;

end.
