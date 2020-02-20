unit fuCustomerLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, HTMLabel, AdvEdit,  ShellAPI,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DateUtils, W7Classes, W7Bars, ComObj, uADSI,
  Vcl.ExtCtrls, AdvGlowButton, Vcl.ComCtrls, AdvCombo, ColCombo, uMT2Classes,  ActiveDS_TLB,
  AdvOfficeButtons, Data.DB, MemDS, DBAccess, MSAccess, AdvUtil, GDIPPictureContainer,
  AdvSmoothListBox, Vcl.Menus, AdvMenus, AdvSmoothTileList, Generics.Collections,
  AdvSmoothTileListImageVisualizer, AdvSmoothTileListHTMLVisualizer,
  AdvSmoothComboBox, GDIPCustomItem, GDIPTextItem, GDIPImageTextItem,
  GDIPImageTextButtonItem, GDIPImageTextButtonSectionItem,  MAPI,
  GDIPLargeButtonedItem, GDIPLargeButtonedHTMLItem, CustomItemsContainer,
  AdvHorizontalPolyList;
type
   TBeforeNewLogValidation = (vlSuccess,vlNoClientSelected);

type
   TSearchType = (stMember, stLogId);



type
  TfrmCustomerLog = class(TForm)
    pnlButtons: TPanel;
    tmrDeleteEntry: TTimer;
    popImages: TAdvPopupMenu;
    miAddIMge: TMenuItem;
    AdvSmoothTileListHTMLVisualizer1: TAdvSmoothTileListHTMLVisualizer;
    pnlTop: TPanel;
    Label5: TLabel;
    btnMemberSearch: TAdvGlowButton;
    Panel1: TPanel;
    lblClient: THTMLabel;
    lbStatusesFilter: TListBox;
    Label1: TLabel;
    tmrByCategory: TTimer;
    lbCategory: TAdvSmoothComboBox;
    AdvSmoothTileListHTMLVisualizer2: TAdvSmoothTileListHTMLVisualizer;
    AdvSmoothTileListImageVisualizer1: TAdvSmoothTileListImageVisualizer;
    Panel2: TPanel;
    tlLogs: TAdvSmoothTileList;
    lblSummary: THTMLabel;
    Label2: TLabel;
    btnNewLog: TAdvGlowButton;
    pnlAdmin: TPanel;
    btnMTAlert: TAdvGlowButton;
    tmrValidateADSI: TTimer;
    btnMTSearch: TAdvGlowButton;
    btnMTReports: TAdvGlowButton;
    btnMTAdmin: TAdvGlowButton;
    eSearch: TAdvEdit;
    procedure FormCreate(Sender: TObject);
    procedure GetLogs(LogID : integer);
    procedure FormShow(Sender: TObject);
    procedure OpenMemberSearchForm(Sender : TObject);
    procedure FindMember(MemberSearch : String; LogID : integer);
    procedure FormDestroy(Sender: TObject);
    procedure btnPrintLogClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    function UpdateLogStatus(LogID , NewStatus : integer; StatusChangedBy : String; StatusChangedDate : TDateTime ) : shortint;
    procedure sgLogsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure UpdateEntryinDB;
    procedure lbLogsGraphicRightClick(Sender: TObject; itemindex: Integer);
    procedure DeleteLogEntryFromDB(EntryID : integer);
    procedure UpDateEntry;
    procedure lbLogsItemDeleteClicked(Sender: TObject;
      Item: TAdvSmoothListBoxItem; var Allow: Boolean);
    procedure FreePendingEntryToBeDeletedClass;
    procedure ADGGlowButton1Click(Sender: TObject);
    procedure chkOnlyOpenClick(Sender: TObject);
    function FormatPhone(PhoneIn : String) : String;
    procedure DisplayMember;
    procedure DisplayNoMemberFound;
    procedure FillLogPanelDisplay(LogItem : TLogSummary);
    procedure GetCategoryList;
    procedure tmrByCategoryTimer(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure lbCategoryChange(Sender: TObject);
    procedure lbCategoryItemSelected(Sender: TObject; itemindex: Integer);
    procedure GetLogStatusCount(MemberNbr : String);
    procedure lblClientAnchorClick(Sender: TObject; Anchor: string);
    procedure btnNewLogClick(Sender: TObject);
    procedure GetCallerListByClinic(MemberNbr : String);
    procedure ListStatuses;
    procedure GetDepartmentList;
    procedure btnMTAdminClick(Sender: TObject);
    function IsMemberOfMTAdminGroup : boolean;
    procedure tmrValidateADSITimer(Sender: TObject);
    procedure GetEMailGroup ;
    procedure btnMTReportsClick(Sender: TObject);
    procedure CheckForNewTickets;
    procedure StartUpTasks;
    procedure tlLogsDblClick(Sender: TObject);
    procedure btnMTSearchClick(Sender: TObject);
    procedure eSearchKeyPress(Sender: TObject; var Key: Char);
    procedure DisplayAllLogs;
    procedure GetAllOpenLogs;
    procedure GetOpenTicketCount;
    procedure FilterLogs(LogID : integer);
    procedure CheckForWatches;
    procedure btnMTAlertClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function GetSearchStatus : smallint;
    procedure tlLogsTileAnchorClick(Sender: TObject; Tile: TAdvSmoothTile;
      State: TTileState; Anchor: string);
  private
    { Private declarations }
  public
    { Public declarations }

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
    iCL_PopUpProblemID : integer;
    vCL_SelectedMember : TMember;
    vCL_ADSI  : TADSI;
    vCL_ADSIUser  : TADSIUserInfo;
  end;

const
  cstLogStatusColumn = 5;
  cstLogIDColumn = 1;
  cstDefaultTileListHeight = 110;


var
  frmCustomerLog: TfrmCustomerLog;

implementation

{$R *.dfm}

uses duMT2, uMT2GlobalVar, fuDateSelection, fuCustomerInvoices, uCommon, fuBoL,
  fuCreateNewLog, fuChangeLogStatus, fuImages, fuEMail,
  fuMemberSearch, fuMTAdmin, fuLDAP, fuLog, fuAlerts, fuMTSearch;


procedure TfrmCustomerLog.OpenMemberSearchForm(Sender : TObject);

begin

   btnNewLog.Visible:= false;
   With TfrmMemberSearch.Create(nil) do
         try
            Left:= ClientToScreen(Point(self.Left,self.Top)).X + btnMemberSearch.Left;
            Top:= ClientToScreen(Point(self.Left,self.Top)).Y + btnMemberSearch.Top + btnMemberSearch.Height;
            ShowDimForm(TCustomForm(Self));
            ShowModal;
            if ModalResult = mrOK then
               FindMember(sMS_MemberNbr,0);
         finally
           begin
            Free;
            HideDimForm;
           end;
         end;

end;

procedure TfrmCustomerLog.FindMember(MemberSearch: string; LogID : integer);
begin
     if (MemberSearch = '') and (LogID > 0) then
        MemberSearch:= dmMT2.GetCustNbrFromLogID(LogID);

     if MemberSearch <> '' then
         begin
           vCL_SelectedMember:= dmMT2.LoadMember(MemberSearch);
           vCL_SelectedMember.Phone:= FormatPhone(vCL_SelectedMember.Phone);
           vCL_SelectedMember.Fax:= FormatPhone(vCL_SelectedMember.Fax);
           btnNewLog.Visible:= true;
           DisplayMember;
           GetLogStatusCount(vCL_SelectedMember.Nbr);
           Application.ProcessMessages;
           GetLogs(LogID);
           GetCallerListByClinic(vCL_SelectedMember.Nbr);
        end
      else
        begin
         DisplayNoMemberFound;
         tlLogs.Clear;
        end;
end;

procedure TfrmCustomerLog.FormCreate(Sender: TObject);
begin
    lblClient.HTMLText.Text:= '';

    //add a bitmap to the first colmun

    dCL_Start:= IncYear(Now,-10);
    dCL_End:= Now;

    stlGV_ActiveCtgy:= TStringList.Create;
    stlGV_ActiveCtgy.OwnsObjects:= true;
    stlGV_AllCtgy:= TStringList.Create;
    stlGV_AllCtgy.OwnsObjects:= true;

    stlGV_CLDept:= TStringList.Create;
    stlGV_DeptEmail:= TStringList.Create;


    stlCL_LogPages:= TStringList.Create;
    iCL_LogPageIdx:= -1;
    iCL_EntryIDBeingEdited:= 0;
    iCL_EntryWindowIndexBeingEdited:= -1;
    iCL_EntryWindowIndexBeingDeleted:= -1;



    stlGv_Callers:= TStringList.Create;

    tlLogs.Tiles.Clear;
    tlLogs.AnimationFactor:= 0;
    tlLogs.PageAnimationFactor:= 0;
    lblSummary.HTMLText.Text:= '';

    rGV_MTUser.UserName:= GetEnvironmentVariable('USERNAME');

    vCL_ADSI:= TADSI.Create(Self);

    lstGV_UnAckList:= TList<TMTNotification>.Create;
    dtGV_LastUpdateCheck:= 0;


end;

procedure TfrmCustomerLog.FormDestroy(Sender: TObject);
begin
    stlCL_LogPages.Free;
    stlGV_DeptEmail.Free;
    vCL_ADSI.Free;
end;

procedure TfrmCustomerLog.FormResize(Sender: TObject);
begin
    try
      tlLogs.BeginUpdate;
      tlLogs.Rows:= Round(tlLogs.ClientHeight div cstDefaultTileListHeight);
    finally
      tlLogs.EndUpdate;
    end;
end;

procedure TfrmCustomerLog.FormShow(Sender: TObject);

begin
   GetCategoryList;

   ListStatuses;

   GetDepartmentList;

   tmrValidateADSI.Enabled:= true;

   StartupTasks;

   if ParamCount > 1 then
     try
     FindMember('',StrToInt(ParamStr(1)))
     except
       DisplayAllLogs
     end
   else
      DisplayAllLogs;



end;

procedure TfrmCustomerLog.GetLogs(LogID : integer);
var
  x, y : integer;
  sCaller : String;
  vLog : TLogSummary;
  LogPanel : TADVSmoothListBoxItem;
  sSummary : String;
  iStatusParam : integer;
  sSumStatus : String;



procedure SetQuery;
begin

     With dmMT2.fqLogs do
        begin
          SQL.Text:= UseDB;
          SQL.Add('SELECT a.logid,a.caller,a.logdate,a.summary,');
          SQL.Add('c.category,d.Department,a.assignedto,a.status,a.priority,a.duedate');
          SQL.Add(' FROM dbo.tblCustomerLogInfo a');
          SQL.Add('LEFT OUTER JOIN dbo.tblLogCategories c ON (a.ctgyid = c.categoryid)');
          SQL.Add('LEFT OUTER JOIN dbo.tblDepartments d ON(a.deptid = d.DepartmentID)');
          SQL.Add('WHERE a.customerid = :cnbr');
          Params[0].AsString:= vCL_SelectedMember.Nbr;

          if LogID > 0 then
            begin
             SQL.Add(' AND LogID=:lgid');
             ParamByName('lgid').AsInteger:= LogID;
            end
          else
            begin
              if lbCategory.SelectedItemIndex > 0 then
                 begin
                   SQL.Add(' AND a.ctgyid = :ctgy');
                   ParamByName('ctgy').AsInteger:= Integer(lbCategory.Items[lbCategory.selecteditemindex].ItemObject);
                 end;
              if lbStatusesFilter.ItemIndex > 0 then
                 begin
                    SQL.Add(' AND a.status = :stas');
                    iStatusParam:= lbStatusesFilter.ItemIndex -1;
                    ParamByName('stas').AsInteger:= iStatusParam;
                 end;

               SQL.Add('ORDER BY a.logdate DESC');
            end;

        end;
end;
begin
    ///get the log for the customer
    ///
    ///

    With tlLogs do
      try
        bCL_Clear:= false;
        bCL_UpdateLog:= True;
        BeginUpdate;

        Tiles.Clear;
        lblSummary.HTMLText.Text:= '';
        x:= 1;
        With dmMT2.fqLogs do
           try
             Active:= false;
             SetQuery;
             DisableControls;
             Active:= true;
             case lbStatusesFilter.ItemIndex of
             5: sSumStatus:= 'Complete';
             4: sSumStatus:= 'Waiting on Client';
             3: sSumStatus:= 'On Hold';
             2: sSumStatus:= 'In Progress';
             1: sSumStatus:= 'New';
             else
                sSumStatus:= ''; //this would be all tickets

             end;


             sSummary:= 'All ' + sSumStatus +  ' Tickets';
             if lbCategory.SelectedItemIndex > 0 then
                sSummary:= sSummary + ' tagged as ' + lbCategory.Items[lbCategory.SelectedItemIndex].Caption;

             lblSummary.HTMLText.Text:= '<font face="Segoe ui" size="14" color="clGray">' + sSummary + '</font><ind x="600">' +  IntToStr(RecordCount) + ' records found';

             while not EOF do
               begin


                 vLog:= TLogSummary.Create;
                 vLog.LogID:= Fields[0].AsInteger;
                 vLog.LogDate:=Fields[2].AsDateTime;
                 vLog.CategoryName:= Fields[4].AsString;
                 vLog.Summary:= Fields[3].AsString;
                 vLog.Caller:= Fields[1].AsString;
                 vLog.AssignedToName:= Fields[6].AsString;
                 vLog.StatusID:= Fields[7].AsINteger;
                 vLog.DeptName:= Fields[5].AsString;
                 vLog.PriorityID:= Fields[8].AsInteger;
                 vLog.DueDate:= Fields[9].AsDateTime;

                 FillLogPanelDisplay(vLog);
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



end;

procedure TfrmCustomerLog.sgLogsSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
     CanSelect:= ARow > 0;
end;

procedure TfrmCustomerLog.tlLogsDblClick(Sender: TObject);
var
  vLogSum : TLogSummary;
begin

    vLogSum:= TLogSummary(tlLogs.SelectedTile.ItemOject);
    With frmLog do
       begin
         iLG_LogID:= vLogSum.LogID;
         if vCL_SelectedMember.Nbr <> '' then
            vLG_Member:=vCL_SelectedMember
         else
            vLG_Member.Nbr:= vLogSum.MemberNbr;
         Show;
       end;
end;

procedure TfrmCustomerLog.tlLogsTileAnchorClick(Sender: TObject;
  Tile: TAdvSmoothTile; State: TTileState; Anchor: string);
begin
     dmMT2.PrintLog(StrToInt(Copy(Anchor,4,Length(Anchor))),0);
end;

procedure TfrmCustomerLog.tmrByCategoryTimer(Sender: TObject);
begin
   tmrByCategory.Enabled:= false;
   GetLogs(0);
end;

procedure TfrmCustomerLog.tmrValidateADSITimer(Sender: TObject);
begin
    tmrValidateADSI.Enabled:= false;
    vCL_ADSI.GetUser('','',vCL_ADSIUser);
    rGV_MTUser.FullName:= vCL_ADSIUser.UserName;
    rGV_MTUSer.SecurityGroup:= vCL_ADSIUser.Groups;
    Caption:= 'Customer Log - Staff : ' + rGV_MTUser.FullName;

    //get other bits
    rGV_MTUser.EMail:= dmMT2.GetUserEMail(rGV_MTUser.FullName);
    rGV_MTUser.EMailGroup:= dmMT2.GetUserDistList;



end;

procedure TfrmCustomerLog.btnMTAdminClick(Sender: TObject);
begin

    if IsMemberOfMTAdminGroup then
       With TfrmMTAdmin.Create(nil) do
         try
            ShowModal;
         finally
         Free;
         end
      else
        MessageDlg('You must be a member of the MultiTracking Admin Group to access this area. Please contact your manager to authorize access,',mtInformation,[mbOK],0);
end;

procedure TfrmCustomerLog.btnMTAlertClick(Sender: TObject);
begin
    With TfrmAlerts.Create(nil) do
       try
         ShowModal;
       finally
         Free;
       end;
end;

procedure TfrmCustomerLog.btnMTReportsClick(Sender: TObject);
begin
    frmMTSearch.Show;
end;

procedure TfrmCustomerLog.btnMTSearchClick(Sender: TObject);
var
  sSearchText : String;
  WhatToLookFor : TSearchType;
begin
     sSearchText:= eSearch.Text;
     if (Length(sSearchText) = 6) AND IsValidInt(Copy(sSearchText,1,6)) then
        WhatToLookFor:= stLogID
     else
       if ((Length(sSearchText) = 5) and IsValidInt(sSearchText)) OR ((IsValidInt(Copy(sSearchText,1,5)) AND (Copy(sSearchText,1,6) = '_'))) then
           WhatToLookFor:= stMember;
     Case WhatToLookFor of
     stMember :  FindMember(sSearchText,0);
     stLogID :  FindMember('',StrToInt(sSearchText));
     End;




end;

procedure TfrmCustomerLog.btnNewLogClick(Sender: TObject);
begin
    With TfrmCreateNewLog.Create(nil) do
       try
         pnlLog.Caption.HTMLText:= '<Font face="segoe UI" size="14" color="clGray">' + vCL_SelectedMember.Nbr + '  ' + vCL_SelectedMember.Name + '</font>';
         cbCNL_Caller.Items.Assign(stlGV_Callers);
         cbCNL_Ctgy.Items.Assign(stlGV_ActiveCtgy);
         cbDepartment.Items.Assign(stlGV_CLDept);
         sNL_CustomerID:= vCL_SelectedMember.Nbr;
         sNL_CustomerName:= vCL_SelectedMember.Name;
         iNL_SiteID:= vCL_SelectedMember.SiteID;
         ShowModal;
         //refresh log
         GetLogStatusCount(vCL_SelectedMember.Nbr);
         Application.ProcessMessages;
         GetLogs(0);
       finally
         Free;
       end;
end;

procedure TfrmCustomerLog.btnPreviewClick(Sender: TObject);
begin
   try
    dmMT2.PrintLog(iCL_LogID,0);
   except on E: Exception do
    MessageDlg('An error printing has occured. The nature of the error states "' + e.Message + '"' + #13 +'The error has been forwarded to the appropriate authorities.',mtError,[mbOK],0);

   end;
end;

procedure TfrmCustomerLog.btnPrintLogClick(Sender: TObject);
begin
   try
    dmMT2.PrintLog(iCL_LogID,1);
   except on E: Exception do
    MessageDlg('An error printing has occured. The nature of the error states "' + e.Message + '"' + #13 +'The error has been forwarded to the appropriate authorities.',mtError,[mbOK],0);

   end;
end;

procedure TfrmCustomerLog.Label1Click(Sender: TObject);
begin
     FilterLogs(0);
end;

procedure TfrmCustomerLog.lbCategoryChange(Sender: TObject);
begin
     FilterLogs(0);
end;

procedure TfrmCustomerLog.lbCategoryItemSelected(Sender: TObject;
  itemindex: Integer);
begin
        FilterLogs(0);
end;

procedure TfrmCustomerLog.lblClientAnchorClick(Sender: TObject; Anchor: string);
var
  sEMail : String;
begin
   if anchor = 'emal' then
     begin
         sEMail:= 'mailto:' + vCL_SelectedMember.email;
         ShellExecute(Self.Handle, 'open',PWideChar(sEMail),nil,nil,SW_SHOWNORMAL);
     end;
 if anchor = 'Phone' then
     begin
         sEMail:= 'callto:' + vCL_SelectedMember.Phone;
         ShellExecute(Self.Handle, 'open',PWideChar(sEMail),nil,nil,SW_SHOWNORMAL);
     end;

end;

procedure TfrmCustomerLog.lbLogsGraphicRightClick(Sender: TObject;
  itemindex: Integer);
begin
    if iCL_EntryWIndowIndexBeingDeleted > -1 then exit;
    iCL_EntryWindowIndexBeingDeleted:= itemindex;





end;

procedure TfrmCustomerLog.lbLogsItemDeleteClicked(Sender: TObject;
  Item: TAdvSmoothListBoxItem; var Allow: Boolean);
begin
      Allow:= false;

end;

procedure TfrmCustomerLog.ADGGlowButton1Click(Sender: TObject);
const
  olMailItem = 0;
var
   sAttach  : String;
   bSuccess : boolean;
   sRecipient , sSubject,sMessage : String;
   sEMail : String;
    Outlook, MailItem: OLEVariant;
begin

     sAttach:= dmMT2.PrintLog(iCL_LogID,2);
     With TfrmEMail.Create(nil) do
       try
          eSubject.Text:= 'TV2 Log ' + IntToStr(iCL_LogID);
          ShowModal;
          bSuccess:= ModalResult = mrOK;
          if bSuccess then
             begin
                sRecipient:= eRecipient.Text;
                sSubject:= eSubject.Text;
                if TRIM(memBody.Lines.Text) = '' then
                   sMessage:= sSubject
                else
                   sMessage:= memBody.Lines.Text;
             end;


       finally
          Free;
       end;

     if bSuccess then
       begin
            sEMail:= 'mailto:' + sRecipient + '?Subject= ' + sSubject + '&Body=' + sMessage + '&ATTACH=' + sAttach  ;
            // ShellExecute(Self.Handle, 'open',PWideChar(sEMail),nil,nil,SW_SHOWNORMAL);
            try
              Outlook := GetActiveOleObject('Outlook.Application');
            except
               Outlook := CreateOleObject('Outlook.Application');
            end;
            try
            MailItem := Outlook.CreateItem(olMailItem);
            MailItem.Recipients.Add(sRecipient);
            MailItem.Subject := sSubject;
            MailItem.Body := sMessage ;
            MailItem.Attachments.Add(sAttach);
            MailItem.Send;
            finally
              begin
                Outlook := Unassigned;
                DeleteFile(sAttach);
              end;
            end;

       end;

end;

function TfrmCustomerLog.UpdateLogStatus(LogID , NewStatus : integer; StatusChangedBy : String; StatusChangedDate : TDateTime ) : shortint;
begin
     Result:= 0; //success
     With dmMT2.fqExec do
        try
           SQL.Text:= UseDB;
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

procedure TfrmCustomerLog.chkOnlyOpenClick(Sender: TObject);
begin
   GetLogs(0);
end;

procedure TfrmCustomerLog.UpdateEntryInDB;
begin
     With dmMT2.fqExec do
        try
           SQL.Text:= UseDB;
           SQL.Add('UPDATE tblCustomerLog SET Problem=:entry WHERE LogID = :lgid AND ProblemID = :pbid');
           ParamByName('lgid').AsInteger:= iCL_LogID;
           ParamByName('pbid').AsInteger:= iCL_EntryIDBeingEdited;
           ParamByName('entry').AsString:= 'Big Problem';
           ExecSQL;


        except on E: Exception do


        end;
end;

procedure TfrmCustomerLog.DeleteLogEntryFromDB(EntryID: Integer);
begin
     With dmMT2.fqExec do
        try
           SQL.Text:= UseDB;
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


    iCL_EntryWindowIndexBeingEdited:= -1;

end;

procedure TfrmCustomerLog.FreePendingEntryToBeDeletedClass;
begin
     try
        vCL_PendingEntryToBeDeleted.Free;
     finally
        vCL_PendingEntryToBeDeleted:= nil;
     end;
end;

procedure TfrmCustomerLog.FormActivate(Sender: TObject);
var
  dtLast : TDateTime;
begin
    //check for any log changes
    dtLast:= dmMT2.GetLastUpdate;
    if dtLast > dtGV_LastUpDateCheck then
       begin
         dtGV_LastUpdateCheck:= dtLast;
         if GetSearchStatus = 0 then
          begin
           DisplayAllLogs;
          end
         else
          begin
           GetLogStatusCount(vCL_SelectedMember.Nbr);
           GetLogs(0);
          end;

       end;

end;

function TfrmCustomerLog.FormatPhone(PhoneIn : String) : String;
begin
        Result:= PhoneIn;
        if Length(Result) > 10 then
           Result:= Copy(Result,1,10);
        if Length(Result) = 10 then
            begin

               System.Insert('(',Result,1);
               System.Insert(')',Result,5);
               System.Insert(' ',Result,9);
            end;
end;

procedure TfrmCustomerLog.DisplayMember;
begin


          With lblClient.HTMLText do
            begin
               Clear;

               Add('<font size="14" face="segoe ui" color="clWHite">' + vCL_SelectedMember.Nbr + '</font><br>');
               Add('<FONT face="segoe ui" size="9"><b>' + vCL_SelectedMember.Name + '</b></FONT><br>');
               Add(vCL_SelectedMember.Address1 + '<br>');
               Add(vCL_SelectedMember.City + ', ' + vCL_SelectedMember.Prov + ' ' + vCL_SelectedMember.PostalCode + '<br><br>');
               Add('<Font face="segoe ui" size="8">Phone : <b><A HREF="Phone">' + vCL_SelectedMember.Phone + '</a></b><br>Fax : <b>' + vCL_SelectedMember.Fax + '</b></font>');
               If vCL_SelectedMember.email  <> '' then
                   Add('<br><A HREF="emal">' + vCL_SelectedMember.email + '</A>');
               if vCL_SelectedMember.WDDCRep <> '' then
                  Add('<br><br><font face="segoe ui" size="8">WDDC Rep : ' + vCL_SelectedMember.WDDCRep + '</font>');

           end;

end;
procedure TfrmCustomerLog.DisplayNoMemberFound;
begin

     lblClient.HTMLText.Text:= 'No member selected';
end;

procedure TfrmCustomerLog.eSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
     btnMTSearchClick(btnMTSearch);
end;

procedure TfrmCustomerLog.FillLogPanelDisplay(LogItem: TLogSummary);
const
    FontTitle = '<font face="segoe ui" size="8" color="clGray">';
    FontContent = '<font face="segoe ui" size="12" color="clBlack">';
var
   sCaption : String;
   sMember  : String;
   sNotesLine1 : String;
   sNotesLine2 : String;
   sPriority : String;
   iStatusIdx : integer;
   sFontPriority : String;
   MyTile : TADVSmoothTile;
   sDate : String;
   sDueDate : String;
   sStatus : String;

begin
          iStatusIDX:= LogItem.StatusID;
          sMember:= '';
          case LogItem.PriorityID of
          0: sFontPriority:= '<font face="segoe ui" size="12" color="clBlack">Low';
          1: sFontPriority:= '<font face="segoe ui" size="12" color="clBlack">Medium';
          2: sFontPriority:= '<font face="segoe ui" size="12" color="clBlack"><b>High</b>';
          3: sFontPriority:= '<font face="segoe ui" size="12" color="clRed"><b>CRITICAL</b>';
          end;
          sDate:= FormatDateTIme('mmm dd yyyy hh:nn am/pm',LogItem.LogDate);
          if LogItem.DueDate > 0 then
            begin
             if DateOf(LogItem.DueDate) = DateOf(now) then
                sDueDate:= 'Today'
             else
                sDueDate:= FormatDateTime('mmm dd yyyy',LogItem.DueDate)
            end
          else
             sDueDate:= '';
          if vCL_SelectedMember.Nbr = '' then
              sMember:= '<font face="segoe ui" size="10" color="clGray">' + LogItem.MemberNbr + ' ' + LogItem.MemberName + '</font>';

          sStatus:= '<font face="Segoe UI" color="clWhite" size="10" bgColor="' + StatusColors[iStatusIdx] + '">'  + GetStatusName(iStatusIDX) +  '</font>';

          if sMember <> '' then
             // sCaption:= '<ind x="10"><font face="segoe ui" color="clNavy" size="10"> ' + IntToStr(LogItem.LogID) + '</font><ind x="100">' + sMember +  '<ind x="740"><font face="Segoe UI" size = "10">' + sDate + '</font><br><img src="idx:' + IntToStr(iStatusIdx) + '"><ind x="100"><font face="Segoe UI" size="14">' + Copy(LogItem.Summary,1,45) + '</font>'
             sCaption:= '<ind x="10"><font face="segoe ui" color="clNavy" size="10"> ' + IntToStr(LogItem.LogID) + '</font><ind x="140">' + sMember +  '<ind x="700"><font face="Segoe UI" size = "10">' + sDate + '</font><ind x="880"><A HREF="PRT' + IntToStr(LogItem.LogID) + '"><img src="print16.png"></A><br>'  + sStatus + '<ind x="140"><font face="Segoe UI" size="14">' + Copy(LogItem.Summary,1,45) + '</font>'
          else
             //sCaption:= '<ind x="10"><font face="segoe ui" size="10"> ' + IntToStr(LogItem.LogID) + '</font><ind x="100"><font face="Segoe UI" size="14">' + Copy(LogItem.Summary,1,45) + '</font><ind x="740"><font face="Segoe UI" size = "10">' + sDate + '</font><br><img src="idx:' + IntToStr(iStatusIdx) + '">';
             sCaption:= '<ind x="10"><font face="segoe ui" size="10"> ' + IntToStr(LogItem.LogID) + '</font><ind x="140"><font face="Segoe UI" size="14">' + Copy(LogItem.Summary,1,45) + '</font><ind x="700"><font face="Segoe UI" size = "10">' + sDate + '</font><ind x="880"><A HREF="PRT' + IntToStr(LogItem.LogID) + '"><img src="print16.png"></A><br>' + sStatus ;
          sNotesLine1:= FontTitle + 'Caller</font><ind x="100">' + FontTitle + 'Assigned</font><ind x="250">' + FontTitle + 'Category</font><ind x="500">' + FontTitle + 'Department</font><ind x="700">' + FontTitle +  'Priority</font><ind x="800">' + FontTitle + 'Due Date</font><br>';
          With LogItem do
            sNotesLine2:= FontContent + Copy(Caller,1,10) +  '</font><ind x="100">' + FontContent +  AssignedToName +  '</font><ind x="250">' + FontContent + CategoryName +  '</font><ind x="500">' + FontContent + DeptName +  '</font><ind x="700">' + sFontPriority + '</font><ind x="800">' + FontContent + sDueDate  + '</font>';
          MyTile:= tlLogs.Tiles.Add;
          MyTile.Content.TextPosition:= tpTopLeft;
          MyTile.Content.Text:= sCaption + '<br>' + sNotesLine1 + sNotesLine2;
          MyTile.ItemOject:= LogItem;

end;

procedure TfrmCustomerLog.GetCategoryList;
var
  CtgyItem : TAdvSmoothListBoxItem;
  AllCtgy, ActiveCtgy    : TCategory;
begin
    With dmMT2.fqSelect do
      try
        Active:= false;
        SQL.Text:= UseDB;
        SQL.Add('SELECT category, categoryid,inactive,invoicelink');
        SQL.Add(' from dbo.tblLogCategories');
        SQL.Add('ORDER BY category');
        Active:= true;
        lbCategory.Items.Clear;
        stlGV_ActiveCtgy.Clear;
        stlGV_AllCtgy.Clear;
        CtgyItem:=  lbCategory.Items.Add ;
        CtgyItem.Caption:= 'All';
        CtgyItem.ItemObject:= TObject(0);
        while not EOF do
          begin

            AllCtgy:= TCategory.Create;
            AllCtgy.CtgyID:= Fields[1].AsInteger;
            AllCtgy.CtgyName:= Fields[0].AsString;
            AllCtgy.InvoiceLink:= Fields[3].AsInteger = 1;

            stlGV_AllCtgy.AddObject(Fields[0].AsString,AllCtgy);
            if Fields[2].AsInteger = 0 then
              begin
                CtgyItem:=  lbCategory.Items.Add ;
                CtgyItem.Caption:= Fields[0].AsString;
                CtgyItem.ItemObject:= TObject(Fields[1].AsInteger);

                ActiveCtgy:= TCategory.Create;
                ActiveCtgy.CtgyID:= Fields[1].AsInteger;
                ActiveCtgy.CtgyName:= Fields[0].AsString;
                ActiveCtgy.InvoiceLink:= Fields[3].AsInteger = 1;

                stlGV_ActiveCtgy.AddObject(Fields[0].AsString,ActiveCtgy);

              end;
            Next;
          end;
      finally
        Active:= false;
      end;
     lbCategory.SelectedItemIndex:= 0;
 end;


procedure TfrmCustomerLog.GetDepartmentList;

begin
    With dmMT2.fqSelect do
      try
        Active:= false;
        SQL.Text:= UseDB;
        SQL.Add('SELECT department, departmentid,ContactEMail from dbo.tblDepartments');
        SQL.Add('ORDER BY department');
        Active:= true;
        stlGV_CLDept.Clear;
        stlGV_DeptEMail.Clear;

        while not EOF do
          begin
            stlGV_CLDept.AddObject(Fields[0].AsString,TOBject(Fields[1].AsINteger));
            stlGV_DeptEMail.Add(Fields[0].AsString + '=' + Fields[2].AsString);
            Next;
          end;
      finally
        Active:= false;
      end;

 end;

procedure TfrmCustomerLog.GetLogStatusCount(MemberNbr: string);
var
  aTicketCount : Array[0..4] of integer;
  iLoop : integer;
  iTotal : integer;
  sWhere : String;
begin
    for iLoop:= 0 to 5 do
        aTicketCount[iLoop]:= 0;
    sWhere:= '';
    With dmMT2.fqTicketCountByCustomer do
       try
         Active:= false;
         if MemberNbr = '' then
           begin
             sWhere:= SQL[5];
             SQL[5]:= '';
           end
         else
            Params[0].AsString:= MemberNbr;
         Active:= true;
         while not EOF do
            begin
              if Fields[0].AsInteger IN [0,1,2,3,4] then
                   aTicketCount[Fields[0].AsInteger]:= Fields[1].AsInteger;
              Next;
            end;

       finally
        begin
         Active:= false;
         if sWhere <> '' then
           SQL[5]:= sWhere;
        end;
       end;
     iTotal:= 0;
     for iLoop:= 0 to 5 do
       iTotal:= iTotal + aTicketCount[iLoop];

     //show the fixed statuses
     WIth lbStatusesFilter do
        begin

           ITems.Clear;
           Items.AddObject('All' + #9 + IntToStr(iTotal),TObject(0));
           Items.AddObject('New' + #9 + IntTOStr(aTicketCount[0]),TObject(0));
           Items.AddObject('In Progress' + #9 + IntToStr(aTicketCount[1]),TObject(1));
           Items.AddObject('On Hold'+ #9 + IntToStr(aTicketCount[2]) ,TObject(2));
           Items.AddObject('Waiting for Client'+ #9 + IntToStr(aTicketCount[3]) ,TObject(3));
           Items.AddObject('Complete' + #9 + IntToStr(aTicketCount[4]),TObject(4));

        end;


end;

procedure TfrmCustomerLog.GetCallerListByClinic(MemberNbr : String);
var
  sCaller : String;
begin
     //get a list of unique callers
       With dmMT2.fqCallerList do
         try
           Active:= false;
           ParamByName('cid1').AsString:= vCL_SelectedMember.Nbr;
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

procedure TfrmCustomerLog.ListStatuses;
begin
       //show the fixed statuses
     WIth lbStatusesFilter do
        begin
           ITems.Clear;
           Items.AddObject('All',TObject(0));
           Items.AddObject('New',TObject(0));
           Items.AddObject('In Progress',TObject(1));
           Items.AddObject('On Hold',TObject(2));
           Items.AddObject('Waiting for Client',TObject(3));
           Items.AddObject('Complete',TObject(4));

        end;


     ShowScrollBar(lbStatusesFilter.Handle, SB_VERT, false);
end;

function TfrmCustomerLog.IsMemberOfMTAdminGroup : boolean;

begin

    Result:= (POS('MTAdmin',vCL_ADSIUser.groups) > 0)or (POS('Domain Admin',vCL_ADSIUser.groups) > 0);

end;

procedure TfrmCustomerLog.GetEmailGroup;
begin
    //do some stuff here
end;

procedure TfrmCustomerLog.CheckForNewTickets;
var
  stlDistMembers : TStringList;
  sGroup : String;
  iDx : integer;
  rTest : TMTNotification;
  sGroupFullName : String;
begin
      lstGV_UnAckList.Clear;
      stlDistMembers:= TStringList.Create;
      dmMT2.fqNotifications.Active:= true;
      try
      while not dmMT2.fqNotifications.EOF do

        begin
           sGroup:= dmMT2.fqNotifications.Fields[2].AsString;
           sGroup:= ExtractRecipNameFromEMailAddress(sGroup);
           sGroupFullName:= dmMT2.GetDistNameCNFromMailNickName(sGroup);

           dmMT2.GetDistGroupMemberList(sGroupFullName,stlDistMembers);
           if stlDistMembers.IndexOf(rGV_MTUser.UserName) > -1 then
               begin
                 rTest:= TMTNotification.Create;
                 lstGV_UnAckList.Add(rTest);
                 rTest.LogID:= dmMT2.fqNotifications.Fields[0].AsInteger;
                 rTest.SentOn:= dmMT2.fqNotifications.Fields[1].AsDateTime;
                 rTest.SentTo:= dmMT2.fqNotifications.Fields[2].AsString;

               end;


          dmMT2.fqNotifications.Next;
        end;
      finally
          dmMT2.fqNotifications.Active:= false;
      end;
      btnMTAlert.Visible:=  lstGV_UnAckList.Count > 0;
end;


procedure TfrmCustomerLog.CheckForWatches;
var
  dsWatch : TDataSet;
begin
        dsWatch:= dmMT2.OpenWatchListQuery;
        if not btnMTAlert.Visible then
            btnMTAlert.Visible:=  dsWatch.RecordCount > 0;
end;


procedure TfrmCustomerLog.StartUpTasks;
begin
    CheckForNewTickets;
    CheckForWatches;
end;

procedure TfrmCustomerLog.DisplayAllLogs;
begin

        lblClient.HTMLText.Text:= '<FONT face="segoe ui" size="14" color="clWhite">All Clients</font>';
        GetOpenTicketCount;

        GetAllOpenLogs;
        //GetCallerListByClinic(vCL_SelectedMember.Nbr);
        dtGV_LastUpdateCheck:= Now;

end;

procedure TfrmCustomerLog.GetAllOpenLogs;
var
  x, y : integer;
  sCaller : String;
  vLog : TLogSummary;
  LogPanel : TADVSmoothListBoxItem;
  sSummary : String;
  iStatusParam : integer;
  sSumStatus : String;


procedure SetQuery;
begin

     With dmMT2.fqLogs do
        begin
          SQL.Text:= UseDB;
          SQL.Add('SELECT a.logid,a.caller,a.logdate,a.summary,');
          SQL.Add('c.category,d.Department,a.assignedto,a.status,a.priority,a.duedate');
          SQL.Add(',e.custname,e.custnmbr');
          SQL.Add(' FROM dbo.tblCustomerLogInfo a');
          SQL.Add('LEFT OUTER JOIN dbo.tblLogCategories c ON (a.ctgyid = c.categoryid)');
          SQL.Add('LEFT OUTER JOIN dbo.tblDepartments d ON(a.deptid = d.DepartmentID)');
          SQL.Add('LEFT OUTER JOIN [WDDC].dbo.RM00101 e ON (a.customerid = e.custnmbr AND e.ADRSCODE = ' + QuotedStr('MAIN') + ')') ;
          SQL.Add('WHERE a.status < 4');
          if lbCategory.SelectedItemIndex > 0 then
                 begin

                   SQL.Add(' AND a.ctgyid = :ctgy');
                   ParamByName('ctgy').AsInteger:= Integer(lbCategory.Items[lbCategory.selecteditemindex].ItemObject);
                 end;
          if lbStatusesFilter.ItemIndex > 0 then
                 begin

                    SQL.Add(' AND a.status = :stas');
                    iStatusParam:= Integer(lbStatusesFilter.Items.Objects[lbStatusesFilter.ItemIndex]);
                    ParamByName('stas').AsInteger:= iStatusParam;
                 end;

               SQL.Add('ORDER BY a.logdate DESC');
            end;

end;
begin
    ///get the log for the customer
    ///
    ///

    With tlLogs do
      try
        bCL_Clear:= false;
        bCL_UpdateLog:= True;
        BeginUpdate;

        Tiles.Clear;
        lblSummary.HTMLText.Text:= '';
        x:= 1;
        With dmMT2.fqLogs do
           try
             Active:= false;
             SetQuery;
             DisableControls;
             Active:= true;
             if (lbStatusesFilter.Count > 0) and (lbStatusesFilter.ItemIndex = -1) then
                lbStatusesFilter.ItemIndex:= 0;
             sSumStatus:= lbStatusesFilter.Items[lbStatusesFilter.ItemIndex];
             sSumStatus:= GetCharsBeforeTab(sSumStatus);

             If Uppercase(sSumStatus) = 'ALL' then //this would be all tickets
                sSumStatus:= 'Open';




             sSummary:= 'All ' + sSumStatus +  ' Tickets';
             if lbCategory.SelectedItemIndex > 0 then
                sSummary:= sSummary + ' tagged as ' + lbCategory.Items[lbCategory.SelectedItemIndex].Caption;

             lblSummary.HTMLText.Text:= '<font face="Segoe ui" size="14" color="clGray">' + sSummary + '</font><ind x="600">' +  IntToStr(RecordCount) + ' records found';

             while not EOF do
               begin


                 vLog:= TLogSummary.Create;
                 vLog.LogID:= Fields[0].AsInteger;
                 vLog.LogDate:=Fields[2].AsDateTime;
                 vLog.CategoryName:= Fields[4].AsString;
                 vLog.MemberName:= Fields[10].AsString;
                 vLog.MemberNbr:= Fields[11].AsString;
                 vLog.Summary:= Fields[3].AsString;
                 vLog.Caller:= Fields[1].AsString;
                 vLog.AssignedToName:= Fields[6].AsString;
                 vLog.StatusID:= Fields[7].AsINteger;
                 vLog.DeptName:= Fields[5].AsString;
                 vLog.PriorityID:= Fields[8].AsInteger;
                 vLog.DueDate:= Fields[9].AsDateTime;

                 FillLogPanelDisplay(vLog);
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



end;

procedure TfrmCustomerLOg.GetOpenTicketCount;
var
   dsTicketCount : TDataSet;
   iTotalOpen : integer;

begin

           dsTicketCount:= dmMT2.GetTotalOpenTicketCount;
           iTotalOpen:= 0;
           lbStatusesFilter.Clear;

           if Assigned(dsTicketCount) then
               try
                  while not dsTicketCount.Eof do
                      begin
                       WIth lbStatusesFilter do
                           begin
                             Items.AddObject(dsTicketCount.Fields[0].AsString + #9 + dsTicketCount.Fields[1].AsString,TObject(dsTicketCount.Fields[2].AsInteger));
                             iTotalOpen:= iTotalOpen + dsTicketCount.Fields[1].AsInteger;

                           end;
                         dsTicketCount.Next;
                       end;
                  //insert the total
                  lbStatusesFilter.Items.InsertObject(0,'All' + #9 + IntToStr(iTotalOpen),TObject(0));


               finally
                 dsTicketCount.Active:= false;
               end;
end;

procedure TfrmCustomerLog.FilterLogs(LogID : integer);
begin
    if vCL_SelectedMember.Nbr = ''  then
       GetAllOpenLogs
    else
       GetLogs(LogID);
end;

function TfrmCustomerLog.GetSearchStatus : smallInt;
begin
     if vCL_SelectedMember.Nbr = '' then
        Result:= 0
     else
        Result:= 1;
end;

end.
