unit fuCustomerLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, HTMLabel, AdvEdit,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DateUtils, W7Classes, W7Bars,
  Vcl.ExtCtrls, AdvGlowButton, Vcl.ComCtrls, AdvCombo, ColCombo, uMT2Classes,
  AdvOfficeButtons, Data.DB, MemDS, DBAccess, MSAccess, AdvUtil,
  AdvSmoothListBox, Vcl.Menus, AdvMenus;
type
   TBeforeNewLogValidation = (vlSuccess,vlNoClientSelected);

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
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    lblPageCnt: TLabel;
    lblLogDate: TLabel;
    lblSaved: TLabel;
    tmrSaved: TTimer;
    lbLogs: TAdvSmoothListBox;
    btnNewLog: TAdvGlowButton;
    btnDeleteLog: TAdvGlowButton;
    pnlButtons: TPanel;
    btnClearLog: TAdvGlowButton;
    btnPrintLog: TAdvGlowButton;
    btnPreview: TAdvGlowButton;
    pnlLogInput: TPanel;
    memDetail: TMemo;
    btnAddNewOrUpdateEntry: TAdvGlowButton;
    tmrDeleteEntry: TTimer;
    lblCaller: TLabel;
    lblCategory: TLabel;
    lblAssignedTo: TLabel;
    Label4: TLabel;
    lblSummary: TLabel;
    lblJIRALink: THTMLabel;
    popImages: TAdvPopupMenu;
    miAddIMge: TMenuItem;
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
    function GetNewLogId : integer;
    procedure btnClearLogClick(Sender: TObject);
    procedure eMemberKeyPress(Sender: TObject; var Key: Char);
    procedure ClearGrid;
    procedure btnDeleteLogClick(Sender: TObject);
    function FindMember(SearchText : String; FromMemberBox : boolean) : boolean;
    procedure cbMemberChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ClearLogPages;
    procedure DisplayLogPage(LogPage : TLogPage);
    procedure btnAddNewOrUpdateEntryClick(Sender: TObject);
    function FindLogRow(LogID : String) : integer;
    procedure btnPrintLogClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    function SaveLogPageToDB(LogPageIn : TLogPage) : integer;
    procedure tmrSavedTimer(Sender: TObject);
    function CreateOrUpdateLogSummaryInDB(DataSourceIn : TLogSummary)  : integer;
    procedure AddToLogGrid(NewLogSummary : TLogSummary);
    function BeforeNewLogValidation : TBeforeNewLogValidation;
    procedure OpenNewLogForm;
    procedure OpenChangeLogStatusForm(LogID : integer ; CurrentStatus : String);
    function UpdateLogStatus(LogID , NewStatus : integer; StatusChangedBy : String; StatusChangedDate : TDateTime ) : shortint;
    procedure sgLogsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgLogsDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure lbLogsItemDblClick(Sender: TObject; itemindex: Integer);
    function DoesTheItemEditMemoContainText : boolean;
    procedure SaveNewLogEntry;
    procedure ChangeMemoStatusToEditing;
    procedure UpdateEntryinDB;
    procedure lbLogsGraphicRightClick(Sender: TObject; itemindex: Integer);
    procedure DeleteLogEntryFromDB(EntryID : integer);
    procedure UpDateEntry;
    procedure UpdateEntryWindow;
    procedure tmrDeleteEntryTimer(Sender: TObject);
    procedure ShowUndoEntryWindow(EntryIndex : integer);
    procedure lbLogsItemDeleteClicked(Sender: TObject;
      Item: TAdvSmoothListBoxItem; var Allow: Boolean);
    procedure SavePendingDeletedItemToTemporaryHolder(EntryIndex : integer);
    procedure CancelPendingDeletion;
    procedure FreePendingEntryToBeDeletedClass;
    procedure OpenEditLogForm;
    procedure UpdateRowInLogGrid(RowIndex : integer);
    procedure ClearLogSummaryGrid;
    procedure ClearSummaryHeader;
    procedure ShowLogHeader(LogSummaryIn : TLogSummary);
    procedure OpenImageForm(Sender : TObject) ;
    function AddImageToLog(LogID : integer; LogTitle,LogName : String) : String;
    function ListImagesForLog(LogID : integer) : boolean;
    procedure ShowImageListForm(LogID : integer);
    procedure lbLogsFooterClick(Sender: TObject; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    sCL_MemberNbr : String; //holds the selected memer num ber
    sCL_MemberName : String;
    dCL_Start, dCL_End : TDateTime;
    bCL_UpdateLog : boolean;
    bCL_EditLog : boolean;
    iCL_LogID : integer;
    bCL_Clear : boolean;
    stlCL_LogPages : TStringList;
    iCL_LogPageIdx : integer;
    iCL_LogPageCount : integer;
    bCL_SavedCompletely : boolean;
    iCL_EntryIDBeingEdited : integer;
    iCL_EntryWindowIndexBeingEdited : integer;
    iCL_EntryWindowIndexBeingDeleted : integer;
    vCL_PendingEntryToBeDeleted : TLogPage;

  end;

const
  cstLogStatusColumn = 5;
  cstLogIDColumn = 1;


var
  frmCustomerLog: TfrmCustomerLog;

implementation

{$R *.dfm}

uses duMT2, uMT2GlobalVar, fuDateSelection, fuCustomerInvoices, uCommon, fuBoL,
  fuCreateNewLog, fuChangeLogStatus, fuImages, fuImageList;


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

    lblLogDate.Caption:= '';
    stlCL_LogPages:= TStringList.Create;
    iCL_LogPageIdx:= -1;
    iCL_EntryIDBeingEdited:= 0;
    iCL_EntryWindowIndexBeingEdited:= -1;
    iCL_EntryWindowIndexBeingDeleted:= -1;

    lbLogs.Items.Clear;


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
   ClearSummaryHeader;

end;

procedure TfrmCustomerLog.GetLogs;
var
  x, y : integer;
  sCaller : String;
  vLog : TLogSummary;
begin
    ///get the log for the customer
    ///
    ///
    lbLogs.Items.Clear;
    With sgLogs do
      try
        bCL_Clear:= false;
        bCL_UpdateLog:= True;
        BeginUpdate;
        ClearLogSummaryGrid;

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
                 vLog:= TLogSummary.Create;
                 vLog.LogID:= Fields[0].AsInteger;
                 vLog.LogDate:=Fields[2].AsDateTime;
                 vLog.CategoryName:= Fields[4].AsString;
                 vLog.Summary:= Fields[3].AsString;
                 vLog.Caller:= Fields[1].AsString;
                 vLog.AssignedToName:= Fields[6].AsString;
                 vLog.Status:= Fields[7].AsINteger;
                 vLog.JIRAID:= Fields[8].AsString;
                 Objects[0,x]:= vLog;

                 Cells[0,x]:= FormatDateTime('mm/dd/yy h:nn AM/PM',Fields[2].AsDateTime);   // call time
                 Cells[1,x]:= Fields[0].AsString;
                 Cells[2,x]:= Fields[4].AsString; //summary
                 Cells[3,x]:= Fields[3].AsString;  //problem
                 Objects[3,x]:= TObject(Fields[0].AsInteger); // holds the log id
                 if Fields[7].AsINteger = 0 then //still open
                     Cells[5,x]:= cstCL_OpenStatus
                 else
                     Cells[5,x]:= cstCL_ClosedStatus;
                 Cells[4,x]:= Fields[6].AsString; //assigned
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
               if (sCaller <> '') and (stlGV_Callers.IndexOf(sCaller) = -1) then
                   stlGV_Callers.Add(sCaller);
               Next;
             end;
         finally

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

procedure TfrmCustomerLog.sgLogsDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
      if arOW > 0 then
      case ACol of
      cstLogStatusColumn:  OpenChangeLogStatusForm(StrToInt(sgLogs.Cells[1,ARow]),sgLogs.Cells[5,ARow]);
      cstLogIDColumn : OpenEditLogForm;
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
      5: FilterCondition:= ' = *Open*';
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
    5: begin
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
         begin
           if memDetail.Lines.Text <> '' then
               btnAddNewOrUpdateEntryClick(nil); // if the user has
           ShowLogDetails(StrToIntDef(sgLogs.Cells[1,NewRow],0),NewRow);
         end;
end;

procedure TfrmCustomerLog.sgLogsSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
     CanSelect:= ARow > 0;
end;

procedure TfrmCustomerLog.ShowLogDetails(LogId, RowID : integer);
var
  iRow : integer;

  sPicked : String;
  iPageCnt : integer;
  tPage : TLogPage;
  iPage : integer;
  iLoop : integer;
  vLog : TLogSummary;



procedure AddRecordPage;
var
  pg1 : TLogPage;
begin

     pg1:= TLogPage.Create;
     pg1.LogID:= LogID;
     With dmMT2.qMT_LogDet do
        try

            pg1.PageID:= Fields[4].AsINteger;
            pg1.Category:=  Fields[2].AsString;
            pg1.ShippingMethod:= '';
            pg1.Department:= '';
            pg1.KeyedBy:= '';
            pg1.Problem:= Fields[1].AsString;
            pg1.Notes:= Fields[6].AsString;
            pg1.KeyedBy:= Fields[5].AsString;
            pg1.EntryDate:= Fields[0].AsDateTime;

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
     //clear out the pages and display

     ClearLogPages;
     iPageCnt:= 0;
     lbLogs.Items.Clear;

     vLog:= TLogSummary(sgLogs.Objects[0,iRow]);
     ShowLogHeader(vLog);

     //get the list of details
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
               // if iPage > 0 then //we are looking for a specific page
                //   iPage:= FindLogPageIndex(iPage);
                //this will be sorted by the oldest record at the top, so display the informaitonm
                tPage:= TLogPage(stlCL_LogPages.Objects[0]);
                for iLoop := 0 to Pred(stlCL_LogPages.Count) do
                    begin
                      tPage:= TLogPage(stlCL_LogPages.Objects[iLoop]);
                      DisplayLogPage(tPage);
                    end;

          //      iCL_LogPageIdx:= iPage;

            end;

         lbLogs.Footer.Visible:= ListImagesForLog(LogID);
       finally
        begin
         Active:= false;
         EnableControls;
        end;
       end;



end;

procedure TfrmCustomerLog.tmrDeleteEntryTimer(Sender: TObject);
begin
   tmrDeleteEntry.Enabled:= false;
   DeleteLogEntryFromDB(lbLogs.Items[iCL_EntryWindowIndexBeingDeleted].Tag);
   lbLogs.Items.Delete(iCL_EntryWindowIndexBeingDeleted);
   iCL_EntryWindowIndexBeingDeleted:= -1;
   FreePendingEntryToBeDeletedClass;

end;

procedure TfrmCustomerLog.tmrSavedTimer(Sender: TObject);
begin
    lblSaved.Visible:= false;
    tmrSaved.Enabled:= false;
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
  sAdminPwd : String;
begin
   if iCL_LogId = 0 then exit;
   sAdminPwd:= '';
   if InputQuery('Confirm Log Deletion.','Please enter the admin password.',sAdminPwd) then
     begin
        If  ((sAdminPwd = 'ChrissyRocksMySocks') or (sAdminPwd = 'ABC123')) then
            With dmMT2.qMT_AddOther do
                  try
                      SQL.Text:= 'USE [MT2];';
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
                  end
         else
            MessageDlg('Invalid administrator password.',mtError,[mbOK],0);
     end;

          

end;

procedure TfrmCustomerLog.btnNewLogClick(Sender: TObject);
var
  ValidateLog  : TBeforeNewLogValidation;
begin
    ValidateLog:= BeforeNewLogValidation;
    Case ValidateLog of
    vlNoCLientSelected : MessageDLg('Please select a client before starting a log.',mtInformation,[mbOK],0);
    vlSuccess: OpenNewLogForm;
    End;
end;

procedure TfrmCustomerLog.btnAddNewOrUpdateEntryClick(Sender: TObject);
begin
    if memDetail.Lines.Text <> '' then
    if iCL_EntryIDBeingEdited > 0 then
        UpdateEntry
    else
        SaveNewLogEntry;




end;

procedure TfrmCustomerLog.btnPreviewClick(Sender: TObject);
begin
   try
    dmMT2.PrintLog(iCL_LogID,true);
   except on E: Exception do
    MessageDlg('An error printing has occured. The nature of the error states "' + e.Message + '"' + #13 +'The error has been forwarded to the appropriate authorities.',mtError,[mbOK],0);

   end;
end;

procedure TfrmCustomerLog.btnPrintLogClick(Sender: TObject);
begin
   try
    dmMT2.PrintLog(iCL_LogID,false);
   except on E: Exception do
    MessageDlg('An error printing has occured. The nature of the error states "' + e.Message + '"' + #13 +'The error has been forwarded to the appropriate authorities.',mtError,[mbOK],0);

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
     ClearSummaryHEader;
     memDetail.Lines.Clear;


     // now clear out the log pages
     ClearLogPages;




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

procedure TfrmCustomerLog.lbLogsFooterClick(Sender: TObject; X, Y: Integer);
begin
     ShowImageListForm(iCL_logID);
end;

procedure TfrmCustomerLog.lbLogsGraphicRightClick(Sender: TObject;
  itemindex: Integer);
begin
    if iCL_EntryWIndowIndexBeingDeleted > -1 then exit;
    iCL_EntryWindowIndexBeingDeleted:= itemindex;
    SavePendingDeletedItemToTemporaryHolder(itemindex);
    ShowUndoEntryWindow(itemindex);
    tmrDeleteEntry.Enabled:= true;


end;

procedure TfrmCustomerLog.lbLogsItemDblClick(Sender: TObject;
  itemindex: Integer);
var
  vSelectedItem : TADVSmoothListBoxItem;
begin
    if DoesTheItemEditMemoContainText and (MessageDlg('Save previous entry before editing this entry?',mtConfirmation,[mbYes,mbNo],0) = mrYes) then // automatically save the data
          SaveNewLogEntry;
    memDetail.Lines.Clear;
    vSelectedItem:= lbLogs.Items[itemindex];
    memDetail.Lines.Text:= vSelectedItem.Notes;
    iCL_EntryIDBeingEdited:= vSelectedItem.Tag;
    iCL_EntryWindowIndexBeingEdited:= itemindex;
    ChangeMemoStatusToEditing;



end;

procedure TfrmCustomerLog.lbLogsItemDeleteClicked(Sender: TObject;
  Item: TAdvSmoothListBoxItem; var Allow: Boolean);
begin
      Allow:= false;
      CancelPendingDeletion;
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
  itmLogPageItem : TADVSmoothListBoxItem;


begin

    itmLogPageItem:= lbLogs.Items.Add;
    itmLogPageItem.Caption:=  FormatDateTime('mmm dd yyyy h:nn AM/PM',LogPage.EntryDate) +  '      ' + LogPage.KeyedBy;
    itmLogPageItem.Notes:= LogPage.Problem;
    itmLogPageItem.Tag:= LogPage.PageID;
{    cbCaller.Text:= LogPage.Caller;
    lblLogDate.Caption:= FormatDateTime('mmm dd yyyy h:nn AM/PM',LogPage.LogDate);
    lblOpenedBy.Caption:= LogPage.OpenedBy;
    cbCtgy.ItemIndex:= cbCtgy.Items.IndexOf(LogPage.Category);

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

    sPicked:= LogPage.PickedBy;}
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
function TfrmCustomerLog.SaveLogPageToDB(LogPageIn: TLogPage) : integer;
var
  iPickedBy, i : integer;
begin
     // a log page requirement is department and categor and since this is a foreign key, they must exist in the other tables

     Result:= 0;



     With dmMT2.qMT_InsertCustomerLog do
             try
                ParamByName('log2').AsInteger:= LogPageIn.LogID;
                ParamByName('dep2').AsInteger:= 9; //in TV2 we dont nned to attach the departments to the log but referential intergrity demands that this field is completer
                ParamByName('prb2').AsString:= LogPageIn.Problem;
                ParamByName('cgy2').AsInteger:= 52; //in TV2 we dont need to attach the category to the log but referential intergrity demands that this field is complete with a legitimate numbver
                ParamByName('not2').AsString:= '';
                ParamByName('smt2').AsString:= '';
                ParamByName('kby2').AsINteger:= 0; //keyed by is not a required field
                ParamByName('cdt2').AsDateTime:= 0;
                ParamByName('cls2').AsBoolean:= LogPageIn.Closed;
                ParamByName('pid1').AsInteger:= LogPageIn.PageID;
                ParamByName('enby').AsString:= LogPageIn.KeyedBy;
                ParamByName('pby2').AsInteger:= 0;
                Execute;
                //we need the new Problem ID . This will only work as an insert, otherwise it returns 0
                Result:= LogPageIn.PageID;
              except
                //the reason for failure would be not having a valid department or caegory number
              end;


end;

function TfrmCustomerLog.CreateOrUpdateLogSummaryInDB(DataSourceIn : TLogSummary ) : integer;
var
  iEmployeeID : integer;
  iLogID : integer;

begin
   //create a new log . Data Validation will have occured

   iEmployeeID:= iGV_empID;

   With dmMT2.qMT_InsertCustomerLogInfo do
          try   //LogID is an autoinc field or in SQL an Identity field. One of the options with the TMSQuery tools must be enabled.
              //when Options.QueryIdentity = True the newly added identity field ID is returned as Field[0], hence the code at the end of the EXECSQL
               // in the query the comand SELECT SCOPE_INDENTITY() must also be present following the last command
              ParamByName('log2').AsInteger:= DataSourceIn.LogID;
              ParamByName('cnbr').AsString:= sCL_MemberNbr;
              ParamByName('cal2').AsString:= DataSourceIn.Caller;
              ParamByName('ldt2').AsDateTime:= DataSourceIn.LogDate; // if this is an existing log, this date will not get changed
              ParamByName('eid2').AsInteger:= iEmployeeId; //opendby comes from the name in the field. If this is a new log it will be the current user, otherwise it is the person who created the log
              ParamByName('rsvd').AsBoolean:= True;
              ParamByName('ctgy').AsInteger:= DataSourceIn.CategoryID;
              ParamByName('asgn').Asinteger:= DataSourceIn.AssignedToID;
              ParamByName('sumy').AsString:= DataSourceIn.Summary;
              ParamByName('stas').AsInteger:= 0 ;// be default all new records are flagged as open
              ParamByName('jira').AsString:= DataSourceIn.JIRAID;
              Execute;
              Result:= Fields[0].Asinteger; //this will be a new log entry as assigned by SQL identity field

          finally

          end;
end;
procedure TfrmCustomerLog.AddToLogGrid(NewLogSummary : TLogSummary);
var
  iRow : integer;
begin

        lblLogID.Caption:= IntToStr(NewLogSummary.LogID);
        iRow:= 1;
        With sgLogs do
          try
             BeginUpdate;
             InsertRows(iRow,1);
             Cells[0,iRow]:= FormatDateTime('mm dd yy h:nn AM/PM',NewLogSummary.LogDate); //if the log was updated, not created, then this date time is not correct, nor is it saved to the data. So it will be amended when scrolling the DB to the correct time
             Cells[1,iRow]:= IntToStr(NewLogSummary.LogID);
             Cells[2,iRow]:= NewLogSummary.CategoryName;
             Cells[3,iRow]:= NewLogSummary.Summary;
             Cells[4,iRow]:= NewLogSummary.AssignedToName;
             Cells[5,iRow]:= cstCL_OpenStatus;
             Objects[0,iRow]:= NewLogSummary;
          finally
            EndUpdate;
          end;


end;

procedure TfrmCustomerLog.UpdateRowInLogGrid(RowIndex : integer);
var
   clLogSum : TLogSummary;
   iRow : integer;
begin

        clLogSum:= TLogSummary(sgLogs.Objects[0,RowIndex]);
        lblLogID.Caption:= IntToStr(clLogSum.LogID);
        iRow:= RowIndex;

        With sgLogs do
          try
             BeginUpdate;
             Cells[0,iRow]:= FormatDateTime('mm dd yy h:nn AM/PM',clLogSum.LogDate); //if the log was updated, not created, then this date time is not correct, nor is it saved to the data. So it will be amended when scrolling the DB to the correct time
             Cells[1,iRow]:= IntToStr(clLogSum.LogID);
             Cells[2,iRow]:= clLogSum.CategoryName;
             Cells[3,iRow]:= clLogSum.Summary;
             Cells[4,iRow]:= clLogSum.AssignedToName;
             case clLogSum.Status of
             1: Cells[5,iRow]:= cstCL_ClosedStatus;
             else
                 Cells[5,iRow]:= cstCL_OpenStatus;
             end;

          finally
            EndUpdate;
          end;


end;


function TfrmCustomerLog.BeforeNewLogValidation : TBeforeNewLogValidation;
begin
   Result:= vlSuccess;
   if (Result = vlSuccess)  and (sCL_MemberNbr = '')  then
      Result:= vlNoClientSelected;


end;

procedure TfrmCustomerLog.OpenNewLogForm;
var
   bModalResult : boolean;
   iNewLog, iDx : integer;
   clLogSum : TLogSummary;
begin
       With TfrmCreateNewLog.Create(nil) do
               try
                    cbCNL_Caller.Items.Assign(stlGV_Callers);
                    cbCNL_Ctgy.Items.Assign(stlGV_CLCtgy);
                    cbCNL_AssignedTo.Items.Assign(stlGV_Dept);
                    cbLogSummary.Items.Assign(stlGV_Log_Summary_List);
                    ShowModal;
                    bModalResult:= ModalResult = mrOK;
                    if bModalResult then
                         begin
                            ClearDetails; //removes all the current information including clearing out the log pages
                            //now save this as a new blank log
                            clLogSum:= TLogSummary.Create;
                            clLogSum.Caller:= cbCNL_Caller.Text;
                            iDx:= cbCNL_Ctgy.ItemIndex;
                            if iDx > -1 then
                              begin
                               clLogSum.CategoryID:= Integer(cbCNL_Ctgy.Items.Objects[iDx]);
                               clLogSum.CategoryName:= cbCNL_Ctgy.Items[iDx];
                              end
                            else
                              begin
                                clLogSum.CategoryID:= -1;
                                clLogSum.CategoryName:= '';
                              end;
                            iDx:= cbCNL_AssignedTo.ItemIndex;
                            if iDx >  -1 then
                              begin
                                clLogSum.AssignedToID:=  Integer(cbCNL_AssignedTo.Items.Objects[iDx]);
                                clLogSum.AssignedToName:= cbCNL_AssignedTo.Items[iDx];
                              end
                            else
                              begin
                                clLogSum.AssignedToID:= -1;
                                clLogSum.AssignedToName:= '';
                              end;

                            clLogSum.Summary:= cbLogSummary.Text;
                            clLogSum.LogDate:= Now;
                            clLogSum.Status:= 0;
                            clLogSum.JIRAID:= eJIRA.Text;
                            sGV_Log_Summary:= cbLogSummary.Text;


                            clLogSum.LogID:= CreateOrUpdateLogSummaryInDB(clLogSum);
                            iNewLog:= clLogSum.LogID;
                            ShowLogHeader(clLogSum);
                            AddToLogGrid(clLogSum);




                            iCL_LogID:= iNewLog;
                            bCL_EditLog:= true;

                            if stlGv_Log_Summary_List.IndexOf(cbLogSummary.Text) = -1 then
                               begin
                                 stlGV_Log_Summary_List.Add(cbLogSummary.Text);
                                 stlGV_Log_Summary_List.SaveToFile(ExtractFilePath(ParamStr(0)) + cnstSummaryFile);
                               end;


                         end;

               finally
                     Free;
               end;

end;

procedure TfrmCustomerLog.OpenChangeLogStatusForm(LogID : integer  ; CurrentStatus : String);
var
   bModalResult : boolean;
   sChangedBy : String;
   dChangedOn  : TDateTIme;
   iNewStatus : integer;
begin

       if Pos('Closed',CurrentStatus) > 0 then
         iNewStatus:= 1
       else
         iNewStatus:= 0;
       With TfrmChangeLogStatus.Create(nil) do
               try
                    eChangedBy.Text:= sGV_EmpName;
                    cbStatus.ItemIndex:= iNewStatus;
                    ShowModal;
                    bModalResult:= (ModalResult = mrOK) and (iNewStatus <> cbStatus.ItemIndex) ; //make sure the status was changed
                    if bModalResult then
                         begin
                            sChangedBy:= eChangedBy.Text;
                            dChangedOn:= dtpChangedOn.DateTime;
                            iNewStatus:= cbStatus.ItemIndex;
                         end;

               finally
                   Free;
               end;
       if bModalResult then
        begin
          If UpdateLogStatus(LogID,iNewStatus,sChangedBy,dChangedOn) = 0 then
            // redisplay the line
            GetLogs;

        end;



end;

function TfrmCustomerLog.UpdateLogStatus(LogID , NewStatus : integer; StatusChangedBy : String; StatusChangedDate : TDateTime ) : shortint;
begin
     Result:= 0; //success
     With dmMT2.qMT_Exec do
        try
           SQL.Text:= 'Use [MT2]';
           SQL.Add('UPDATE tblCustomerLogInfo SET Status=:stas,ClosedBy=:clby,ClosedDate=:cldt WHERE LogID = :lgid');
           ParamByName('lgid').AsInteger:= LogID;
           ParamByName('stas').AsInteger:= NewStatus;
           ParamByName('clby').AsString:= StatusCHangedBy;
           ParamBYName('cldt').AsDateTime:= StatusChangedDate;
           ExecSQL;
        except on E: Exception do
          Result:= 1;

        end;
end;

function TfrmCustomerLog.DoesTheItemEditMemoContainText : boolean;
begin
    Result:= memDetail.Lines.Text <> '';
end;

procedure TfrmCustomerLog.SaveNewLogEntry;
var
  pg1 :  TLogPage;
begin
       pg1:= TLogPage.Create;
       pg1.LogID:= iCL_LogID;
       pg1.PageID:= 0;
       pg1.LogDate:= Now;
       pg1.Caller:= '';
       pg1.Category:= '';
       pg1.Department:= '';
       pg1.Problem:= memDetail.Lines.Text;
       pg1.EntryDate:= Now;
       pg1.KeyedBy:= sGV_EmpName;
       stlCL_LogPages.AddObject('1',pg1);
       iCL_LogPageCount:= stlCL_LogPages.Count;
       iCL_LogPageIdx:= Pred(iCL_LogPageCount);
       memDetail.Lines.Clear;
       SaveLogPagetoDB(pg1);
       DisplayLogPage(pg1);
end;

procedure TfrmCustomerLog.ChangeMemoStatusToEditing;
begin
     // set the panel color to blue
     pnlLogInput.Color:= clBlue;
end;


procedure TfrmCustomerLog.UpdateEntryInDB;
begin
     With dmMT2.qMT_Exec do
        try
           SQL.Text:= 'Use [MT2]';
           SQL.Add('UPDATE tblCustomerLog SET Problem=:entry WHERE LogID = :lgid AND ProblemID = :pbid');
           ParamByName('lgid').AsInteger:= iCL_LogID;
           ParamByName('pbid').AsInteger:= iCL_EntryIDBeingEdited;
           ParamByName('entry').AsString:= memDetail.Lines.Text;
           ExecSQL;


        except on E: Exception do


        end;
end;

procedure TfrmCustomerLog.DeleteLogEntryFromDB(EntryID: Integer);
begin
     With dmMT2.qMT_Exec do
        try
           SQL.Text:= 'Use [MT2]';
           SQL.Add('DELETE FROM tblCustomerLog WHERE LogID = :lgid AND ProblemID = :pbid');
           ParamByName('lgid').AsInteger:= iCL_LogID;
           ParamByName('pbid').AsInteger:= EntryID;

           ExecSQL;

        except on E: Exception do


        end;
end;

procedure TfrmCustomerLog.UpDateEntry;
begin
    UpdateEntryInDB;
    UpdateEntryWindow;
    memDetail.Lines.Clear;
    pnlLogInput.Color:= clOrange;
    iCL_EntryWindowIndexBeingEdited:= -1;

end;

procedure TfrmCustomerLog.UpdateEntryWindow;
begin
    //
    if iCL_EntryWindowIndexBeingEdited > -1 then
        lbLogs.Items[iCL_EntryWindowIndexBeingEdited].Notes:= memDetail.Lines.Text;
end;

procedure TfrmCustomerLog.ShowUndoEntryWindow(EntryIndex: Integer);
begin
     lbLogs.Items[EntryIndex].Caption:= '';
     lbLogs.Items[EntryIndex].Notes:= '';
     lbLogs.Items[EntryIndex].Info:= '';
     lbLogs.Items[EntryIndex].DeleteButton:= true;
     lbLogs.Items[EntryIndex].DeleteButtonVisible:= true;
end;

procedure TfrmCustomerLog.SavePendingDeletedItemToTemporaryHolder(EntryIndex: integer);
var
   vItemBeingDeleted : TADVSmoothListBoxItem;
begin
     if not Assigned(vCL_PendingEntryToBeDeleted) then
         vCL_PendingEntryToBeDeleted:= TLogPage.Create;

     vItemBeingDeleted:= lbLogs.Items[EntryIndex];
     vCL_PendingEntryToBeDeleted.Problem:= vItemBeingDeleted.Notes;
     vCL_PendingEntryToBeDeleted.PageID:= vItemBeingDeleted.Tag;
     vCL_PendingEntryToBeDeleted.LogID:= iCL_LogID;
     vCL_PendingEntryToBeDeleted.EntryIndex:= EntryIndex;
     vCL_PendingEntryToBeDeleted.Caption:= vItemBeingDeleted.Caption;
end;

procedure TfrmCustomerLog.CancelPendingDeletion;
var
  iDx : integer;
begin
     tmrDeleteEntry.Enabled:= false;
     if Assigned(vCL_PendingEntryToBeDeleted) then
        begin
          iDx:= vCL_PendingEntryToBeDeleted.EntryIndex;
          lbLogs.Items[iDx].Caption:= vCL_PendingEntryToBeDeleted.Caption;
          lbLogs.Items[iDx].Notes:= vCL_PendingEntryToBeDeleted.Problem;
          lbLogs.Items[iDx].Info:= 'Delete';
          lbLogs.Items[iDx].DeleteButton:= false;
          lbLogs.Items[iDx].DeleteButtonVisible:= false;
          FreePendingEntryToBeDeletedClass;
          iCL_EntryWIndowIndexBeingDeleted:= -1;
        end;
end;

procedure TfrmCustomerLog.FreePendingEntryToBeDeletedClass;
begin
     try
        vCL_PendingEntryToBeDeleted.Free;
     finally
        vCL_PendingEntryToBeDeleted:= nil;
     end;
end;

procedure TfrmCustomerLog.OpenEditLogForm;
var
  bModalResult : boolean;
  vLog : TLogSummary;
  iRow : integer;
begin
    //opens the log form for editing
           With TfrmCreateNewLog.Create(nil) do
               try
                    Caption:= 'Update Existing Log.';
                    btnCreateNewLog.Caption:= 'Update Log Now';
                    iRow:= sgLogs.Row;
                    cbCNL_Caller.Items.Assign(stlGV_Callers);
                    cbCNL_Ctgy.Items.Assign(stlGV_CLCtgy);
                    cbCNL_AssignedTo.Items.Assign(stlGV_Dept);
                    cbLogSummary.Items.Assign(stlGV_Log_Summary_List);
                    //display the previous selections
                    vLog:= TLogSummary(sgLogs.Objects[0,iRow]);
                    cbCNL_Caller.Text:= vLog.Caller;
                    cbCNL_Ctgy.ItemIndex:= cbCNL_Ctgy.Items.IndexOf(vLog.CategoryName);
                    cbCNL_AssignedTo.ItemIndex:= cbCNL_AssignedTo.Items.IndexOf(vLog.AssignedToName);
                    cbLogSummary.Text:= vLog.Summary;
                    eJIRA.Text:= vLog.JIRAID;

                    ShowModal;
                    bModalResult:= ModalResult = mrOK;
                    if bModalResult then
                         begin

                            //now save this as a new blank log
                            vLog.Caller:= cbCNL_Caller.Text;
                            vLog.CategoryName:= cbCNL_Ctgy.Text;
                            try
                            vLog.CategoryID:= Integer(cbCNL_Ctgy.Items.Objects[cbCNL_Ctgy.ItemIndex]);
                            except on Exception do
                              vLog.CategoryID:= -1;
                            end;
                            vLog.JIRAID:= eJira.Text;
                            vLog.AssignedToName:= cbCNL_AssignedTo.Text;
                            try
                               vLog.AssignedToID:= Integer(cbCNL_AssignedTo.Items.Objects[cbCNL_AssignedTo.ItemIndex]);
                            except on E: Exception do
                               vLog.AssignedToID:= -1;

                            end;
                            vLog.Summary:= cbLogSummary.Text;
                            vLog.JIRAID:= eJIRA.Text;
                            sGV_Log_Summary:= cbLogSummary.Text;
                            CreateOrUpdateLogSummaryInDB(vLog);
                            ShowLogHEader(vLog);
                            UpdateRowInLogGrid(iRow);
                            iCL_LogID:= vLog.LogID;
                            bCL_EditLog:= true;

                            if stlGv_Log_Summary_List.IndexOf(cbLogSummary.Text) = -1 then
                               begin
                                 stlGV_Log_Summary_List.Add(cbLogSummary.Text);
                                 stlGV_Log_Summary_List.SaveToFile(ExtractFilePath(ParamStr(0)) + cnstSummaryFile);
                               end;


                         end;

               finally
                     Free;
               end;
end;

procedure TfrmCustomerLog.ClearLogSummaryGrid;
var
  x, y  : integer;
begin

      With sgLogs do
        begin
          for y:= 1 to Pred(RowCOunt) do
             if Assigned(Objects[0,y]) then
                 try
                   TLogSummary(Objects[0,y]).Free;
                   Objects[0,y]:= nil;
                 except

                 end;


          for x:= 0 to Pred(ColCount) do
            for y:= 1 to Pred(RowCount) do
             Cells[x,y]:= '';
          RowCount:= 2;
        end;
end;

procedure TfrmCustomerLog.ClearSummaryHeader;
begin
     lblCategory.Caption:= '';
     lblJIRALink.HTMLText.Text:= '';
     lblCaller.Caption:= '';
     lblAssignedTo.Caption:= '';
     lblSummary.Caption:= '';
     lblLogDate.Caption:= '';
end;

procedure TfrmCustomerLog.ShowLogHeader(LogSummaryIn: TLogSummary);
begin
       lblLogId.Caption:= IntToStr(LogSummaryIn.LogID) ;
       lblLogDate.Caption:= FormatDateTime('mmm dd yyyy h:nn AM/PM',LogSummaryIn.LogDate);
       lblSummary.Caption:= LogSummaryIn.Summary;
       lblCategory.Caption:= LogSummaryIn.CategoryName;
       lblAssignedTo.Caption:= LogSummaryIn.AssignedToName;
       lblJIRALink.HTMLText.Text:= '<A HREF="' + cstApollo +  LogSummaryIn.JIRAID + '">'+ LogSummaryIn.JIRAID + '</A>' ;
       lblCaller.Caption:= LogSummaryIn.Caller;
end;

procedure TfrmCustomerLog.OpenImageForm(Sender: TObject);
var
  sFileName : String;
  sPath : string;
begin
    With TfrmImages.Create(nil) do
       try
         ShowModal;
         if ModalResult = mrOK  then
           begin
              sFileName:= AddImageToLog(iCL_LogID,eImageTitle.Text,eImageNotes.Text);
              if sFileName <> '' then
                begin
                  sPath:= cstImageStorageURL + IntToStr(iCL_LogID);
                  if not DirectoryExists(sPath) then
                     ForceDirectories(sPath);
                  imgImport.Picture.Bitmap.SaveToFile(IncludeTrailingPathDelimiter(cstImageStorageURL + IntToStr(iCL_LogID)) + sFileName + '.bmp');
                end;

           end;
       finally
         Free;
       end;
end;

function TfrmCustomerLog.AddImageToLog(LogID : integer; LogTitle,LogName : String) : String;
var
   sNewFileName : String;
   iUID : TGUID;
begin
      CreateGUID(iUID);
      sNewFileName:= GUIDToString(iUID);
      With dmMT2.qMT_Exec do
         try
           SQL.Text:= 'USE MT2';
           SQL.Add('INSERT INTO tblImages (LogID,ImageTitle,ImageNotes,ImageFileName) VALUES (:lgid,:titl,:nots,:fnam)');
           ParamByName('lgid').AsInteger:= LogID;
           ParamByName('titl').AsString:= LogTitle;
           ParamByName('nots').AsString:= LogName;
           ParamByName('fnam').AsString:= sNewFileName + '.bmp';
           ExecSQL;
           Result:= sNewFileName;



         except
            Result:= '';

         end;
end;

function TfrmCustomerLog.ListImagesForLog(LogID: Integer) : boolean;
begin
       Result:= false;
       stlGV_LogImageList.Clear;
       With dmMT2.qMT_Select do
         try
           Active:= false;
           SQL.Text:= 'USE MT2';
           SQL.Add('Select ImageFileName FROM tblImages WHERE logid = :lgid');
           ParamByName('lgid').AsInteger:= LogID;
           Active:= true;
           Result:= RecordCOunt > 0;
           if result  then
            while not EOF do
              begin
                  stlGV_LogImageList.Add(IncludeTrailingPathDelimiter(cstImageStorageURL + IntToStr(LogID))  + Fields[0].AsString);
                  Next;
              end;

         finally
            Active:= false;
         end;

end;

procedure TfrmCustomerLog.ShowImageListForm(LogID: Integer);
begin
    With TfrmImageList.Create(nil) do
      try
        iIL_LogID:= LogID;
        ShowModal
      finally
        Free;
      end;
end;




end.
