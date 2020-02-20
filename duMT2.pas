unit duMT2;

interface

uses
  System.SysUtils, System.Classes, DBAccess, SdacVcl, Data.DB, MSAccess, MemDS,  Dialogs,
  Vcl.ImgList, Vcl.Controls, RpCon, RpConDS, RpRave, RpDefine, RpBase, RpSystem, uMT2Classes,
  System.ImageList, RpRender, RpRenderPDF, GDIPPictureContainer,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, Vcl.ActnList,
  Vcl.ExtActns, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  Data.Win.ADODB, RichViewActions;

type
  TdmMT2 = class(TDataModule)
    iml16x16: TImageList;
    iml12x12: TImageList;
    qMT_InvoiceList: TMSQuery;
    qDB_Pickers: TMSQuery;
    qDB_ItemPerCntr: TMSQuery;
    rvsMT2: TRvSystem;
    rvMT2: TRvProject;
    rdsRptLogSum: TRvDataSetConnection;
    rdsRptInvoiceList: TRvDataSetConnection;
    qMT_InsertCustomerLog: TMSQuery;
    qMT_TrackingList: TMSQuery;
    qRptTrackingList: TMSQuery;
    rdsTrackingList: TRvDataSetConnection;
    qDB_Supplier: TMSQuery;
    qDB_ItemLookup: TMSQuery;
    qMT_SelectShippingMemo: TMSQuery;
    qMT_SelectSMIDItems: TMSQuery;
    qMT_InsertSM: TMSQuery;
    RvRenderPDF1: TRvRenderPDF;
    pcLogs: TGDIPPictureContainer;
    fdDBServer: TFDConnection;
    fqMemberSearchByNumber: TFDQuery;
    fqMemberSearchByName: TFDQuery;
    fqMember: TFDQuery;
    fqCallerList: TFDQuery;
    fqLogs: TFDQuery;
    imlStatus: TImageList;
    fqSelect: TFDQuery;
    fqTicketCountByCustomer: TFDQuery;
    fqAddAttachment: TFDQuery;
    fqNewLogSummary: TFDQuery;
    fqNewLogEntry: TFDQuery;
    fdASCTrac: TFDConnection;
    fqInvoiceDetail: TFDQuery;
    fqInvoiceDetailByItem: TFDQuery;
    fqDB_TrackingNbr: TFDQuery;
    fqPicker: TFDQuery;
    fqTrackingNbrByItem: TFDQuery;
    fqDB_InvoiceList: TFDQuery;
    iml16Gray: TImageList;
    fqDB_InvoiceByITem: TFDQuery;
    fqExec: TFDQuery;
    ActionList1: TActionList;
    InternetSendMail1: TSendMail;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    adoLDAP: TADOConnection;
    qLDAP: TADOQuery;
    qLDAP_Group: TADOQuery;
    dsLDAP: TDataSource;
    FDManager1: TFDManager;
    fdaNotifyLogChange: TFDEventAlerter;
    fqUpdateInvoice: TFDQuery;
    fqNotifications: TFDQuery;
    qLDAPGrpName: TADOQuery;
    fqLogSummary: TFDQuery;
    fqLogEvents: TFDQuery;
    fqAttachments: TFDQuery;
    fqUpdateLogEntry: TFDQuery;
    fqEventLogByProblemID: TFDQuery;
    fqUpdateTrackingNumber: TFDQuery;
    fqUpdateItems: TFDQuery;
    fqTotalOpenTicketCount: TFDQuery;
    fqUpdateActivity: TFDQuery;
    fqWatchDML: TFDQuery;
    fqWatchDQL: TFDQuery;
    fqLastUpdate: TFDQuery;
    fqMTSearch: TFDQuery;
    pcMIsc: TGDIPPictureContainer;
    qRPTLogSum: TFDQuery;
    qRPTLogDet: TFDQuery;
    rdsRptLogDet: TRvDataSetConnection;
    qRPTInvoiceList: TFDQuery;
    function PrintLog(LogId : integer; Destination : ShortInt) : String;
    function CheckForShippingMemo(SMID : integer) : boolean;
    function UpdateDept(DeptID : integer; DeptName,EMail : String) : boolean;
    function DeleteDept(DeptID: Integer) : boolean;
    function HasDeptIDBeenUsed(DeptID: integer) : boolean;
    function GetDeptEMail(DeptName : String) : String;
    procedure LogNotification(LogID : integer; SentTo : String);
    function GetUserEMail(FullName : String ) : String;
    function GetCustNbrFromLogID(LogID : integer) : String;
    function IsMemberOfDistGroup(GroupName, UserName : String) : boolean;
    procedure GetDistGroupMemberList(GroupName : String ; var MemberList : TStringList);
    procedure DataModuleCreate(Sender: TObject);
    function GetDistNameCNFromMailNickName(NickName : String) : String;
    function GetTotalOpenTicketCount : TDataSet;
    procedure UpdateLogPriority(LogID, PriorityID : integer);
    procedure UpdateLogStatus(LogID: Integer; StatusID: Integer);
    function LoadMember(MemberNbr : String ) : TMember;
    procedure SetInvoiceListQuery;
    procedure SetInvoiceListQueryBySOP;
    procedure SetCtgyListQuery(ShowOnlyActive : boolean);
    procedure SetCategoryActiveStatus(CtgyID : integer; Inactivate :boolean);
    procedure AddToActivityLog(LogID : integer; ActType : integer ;  Activity : String; EventID : integer);
    procedure AddLogWatch(LogID : integer; Reminder, Expy : TDateTime);
    procedure RemoveLogWatch(LogID : integer);
    function OpenWatchListQuery : TDataSet;
    function IsLogBeingWatched(LogID : integer ) : boolean;
    function GetSingleEvent(LogID , EventID : Integer) : String;
    function GetLogSummary(LogID : integer) : TLogSummary;
    function GetLastUpdate : TDateTime;
    function CreateNewCategory(NameIn : String) : integer;
    procedure UpdateCategoryLink(CtgyID, LinkState : integer);
    function GetUserDistList : String;

  private
    { Private declarations }
  public
    { Public declarations }
    function CheckForDuplicateDept(DeptDesc : String) : boolean;
    function AcknowledgeLog(LogID: integer) : boolean;
    function IsUserInAssignedDepartment(LogIn : TLogSummary) : boolean;
    function GetUserAssignedDeptID : integer;
  end;


var
  dmMT2: TdmMT2;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uCommon, uMT2GlobalVar;

{$R *.dfm}

function TdmMT2.PrintLog(LogId : integer; Destination : ShortInt) : String;
var
  sCID , sName, sContactNo : String;
  sPath , sFile :String;
begin
    rvMT2.ClearParams;
    Result:= '';




    try
      With qRptLogSum do
         begin
           Active:= false;
           ParamByName('lid1').AsInteger:= LogID;
           Active:= true;
           sCID:= Fields[0].AsString;
         end;
      With qRptLogDet do
         begin
           Active:= false;
           Params[0].AsInteger:= LogID;
           Active:= true;
         end;
      With qRptInvoiceList do
         begin
           Active:= false;
           Params[0].AsInteger:= LogID;
           Active:= true;
         end;



    rvMT2.Open;
    rvMT2.SetParam('sImagePath',IncludeTrailingPathDelimiter(cstImageStorageURL + IntToStr(LogID)));

    case Destination of
    0: begin
         rvsMT2.SystemSetups:= rvsMT2.SystemSetups +[ssAllowSetup];
         rvsMT2.DefaultDest:= rdPreview;
         rvsMT2.ReportDest:= rdPreview;
       end;
    1: begin
         rvsMT2.ReportDest:= rdPrinter;
         rvsMT2.DefaultDest:= rdPrinter;
         rvsMT2.SystemSetups:= rvsMT2.SystemSetups -[ssAllowSetup];
       end;
    2: try
         sPath:= IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'TempPrt';
         sFile:= 'EL' + FormatDateTime('mdyhnsz',Now) + '.pdf';
         if not DirectoryExists(sPath) then
            ForceDirectories(sPath);
         Result:= IncludeTrailingPathDelimiter(sPath) + sFile;
         rvsMT2.DefaultDest := rdFile;
         rvsMT2.DoNativeOutput := false;
         rvsMT2.RenderObject := RvRenderPDF1;
         rvsMT2.OutputFileName := Result;
         rvsMT2.SystemSetups := rvsMT2.SystemSetups - [ssAllowSetup];
       except on E: Exception do
         Result:= '';
       end;
    end;
    rvMT2.ExecuteReport('rptLog');


    finally
      begin
        rvMT2.Close;
        qRptLogSum.Active:= false;
        qRptLogDet.Active:= false;
        qRptInvoiceList.Active:= false;
        qRptTrackingList.Active:= false;
        qRptInvoiceList.Active:= false;
       end;
    end;

end;

function TdmMT2.CheckForShippingMemo(SMID: Integer) : boolean;
begin
     With fqSelect do
        try
          Active:= false;
          SQL.Text:= UseDB + ' SELECT shippingmemo FROM dbo.tblReturns WHERE shippingmemo = :smid';
          ParamByName('smid').AsInteger:= SMID;
          Active:= true;
          Result:= RecordCount > 0;

        finally
          Active:= false;
        end;

end;

function TdmMT2.CheckForDuplicateDept(DeptDesc: string) : boolean;
begin
    With fqSelect do
        try
          Active:= false;
          SQL.Text:= UseDB + ' SELECT count(*) FROM dbo.tblDepartments WHERE Department = :dpnm';
          ParamByName('dpnm').AsString:= DeptDesc;
          Active:= true;
          Result:= Fields[0].AsInteger > 0;
        finally
          Active:= false;
        end;

end;

function TdmMT2.UpdateDept(DeptID: Integer; DeptName: string; EMail: string) : boolean;
begin
    Result:= true;
    With fqExec do
        try
          Active:= false;
          SQL.Text:= UseDB;
          SQL.Add('UPDATE dbo.tblDepartments SET Department=:prm0,ContactEMail=:prm1');
          SQL.Add('WHERE DepartmentID =:prm2');
          Params[0].AsString:= DeptName;
          Params[1].AsString:= EMail;
          Params[2].AsInteger:= DeptID;
          ExecSQL;

        except on E: Exception do
          Result:= false;

        end;

end;
procedure TdmMT2.DataModuleCreate(Sender: TObject);
var
  iInc : integer;
  q1 : TFDQuery;
begin
     //set up the queries
     With fqNotifications do
       begin
         SQL.Text:= UseDB;
         SQL.Add('SELECT logid,senton,sentto');
         SQL.Add('FROM NotifyLog');
         SQL.Add('WHERE ackstatus = 0');
       end;

     for iInc:= 0 to Pred(ComponentCount) do
       if Components[iInc] is TFDQuery then
          try
             q1:= TFDQuery(Components[iInc]);
             if (q1.SQL.Count > 0) AND (POS('USE',UpperCase(q1.SQL[0])) > 0) then
                 q1.SQL[0]:= UseDB;
          except
          end;

end;

function TdmMT2.DeleteDept(DeptID: Integer) : boolean;
begin
    Result:= true;
    With fqExec do
        try
          Active:= false;
          SQL.Text:= UseDB;
          SQL.Add('DELETE FROM dbo.tblDepartments ');
          SQL.Add('WHERE DepartmentID =:prm2');
          Params[0].AsInteger:= DeptID;
          ExecSQL;

        except on E: Exception do
          Result:= false;

        end;

end;

function TdmMT2.HasDeptIDBeenUsed(DeptID: integer) : boolean;
begin
    With fqSelect do
        try
          Active:= false;
          SQL.Text:= UseDB + ' SELECT TOP 1 DeptID FROM dbo.tblCustomerLogInfo WHERE DeptID = :prm0';
          ParamByName('prm0').AsInteger:= DeptID;
          Active:= true;
          Result:= RecordCount > 0;
        finally
          Active:= false;
        end;

end;

function TdmMT2.GetDeptEMail(DeptName: string) : String;
begin
    With fqSelect do
        try
          Active:= false;
          SQL.Text:= UseDB + ' SELECT contactemail FROM dbo.tblDepartments WHERE Department= :prm0';
          ParamByName('prm0').AsString:= DeptName;
          Active:= true;
          if RecordCount > 0 then
               Result:= Fields[0].AsString
          else
               Result:= '';
        finally
          Active:= false;
        end;

end;

function TdmMT2.GetCustNbrFromLogID(LogID : integer) : String;
begin
    With fqSelect do
        try
          Active:= false;
          SQL.Text:= UseDB + ' SELECT customerid FROM dbo.tblCustomerLogInfo WHERE LogID= :prm0';
          ParamByName('prm0').AsInteger:= LogID;
          Active:= true;
          if RecordCount > 0 then
               Result:= Fields[0].AsString
          else
               Result:= '';
        finally
          Active:= false;
        end;

end;

procedure TdmMT2.LogNotification(LogID: Integer; SentTo: string);
begin

    With fqExec do
        try
          Active:= false;
          SQL.Text:= UseDB;
          SQL.Add('INSERT INTO NotifyLog (logid,SentOn,SentTo,AckStatus) VALUES(:prm0,GetDate(),:prm1,0)');
          Params[0].AsInteger:= LogID;
          Params[1].AsString:= SentTo;
          ExecSQL;

        except on E: Exception do
          //log the error

        end;
end;

function TdmMT2.GetUserEMail(FullName: string) : String;
begin
     With qLDAP do
        try
          Active:= false;
          SQL[3]:= 'AND cn=' + QuotedStr(FullName);
          Active:= true;
          Result:= FieldByName('mail').AsString;

        finally
          Active:= false;
        end;
end;

function TdmMT2.IsMemberOfDistGroup(GroupName, UserName : String) : boolean;
begin
       Result:= false;
       With qLDAP_Group do
         try
           DisableControls;
           Active:= false;
           SQL[2]:= 'WHERE memberOf= ' + QuotedStr('cn=' + GroupName + ',cn=Users,dc=wddcho,dc=com');
           Active:= true;
           while not EOF do
              begin
                if not Result then
                  Result:= Fields[0].AsString = UserName;
                Next;
              end;
         finally
           begin
             Active:= false;
             EnableControls;
           end;
         end;
end;

procedure TdmMT2.GetDistGroupMemberList(GroupName : String ; var MemberList : TStringList);
begin
       MemberList.Clear;
       With qLDAP_Group do
         try
           DisableControls;
           Active:= false;
           SQL[2]:= 'WHERE memberOf= ' + QuotedStr('cn=' + GroupName + ',cn=Users,dc=wddcho,dc=com');
           Active:= true;
           while not EOF do
              begin
                MemberList.Add(Fields[0].AsString);
                Next;
              end;
         finally
           begin
             Active:= false;
             EnableControls;
           end;
         end;
end;

function TdmMT2.GetDistNameCNFromMailNickName(NickName : String) : String;
begin
      Result:= '';
      if Length(NickName) > 0 then

      With qLDAP_Group do
         try
           DisableControls;
           Active:= false;
           SQL[2]:= 'WHERE mailNickName= ' + QuotedStr(NickName);
           Active:= true;
           if RecordCount > 0 then
              Result:= Fields[0].AsString;
         finally
           begin
             Active:= false;
             EnableControls;
           end;
         end;
end;

function TdmMT2.GetTotalOpenTicketCount: TDataSet;
begin

      With fqTotalOpenTicketCount do
       begin
          Active:= false;
          Active:= true;
          Result:= fqTotalOpenTicketCount;
       end;
end;

procedure TdmMT2.UpdateLogPriority(LogID: Integer; PriorityID: Integer);
begin
    With fqExec do
       begin
         Active:= false;
         SQL.Text:= UseDB;
         SQL.Add('UPDATE tblCustomerLogInfo SET Priority =:prm0 WHERE logid=:prm1');
         Params[0].AsInteger:= PriorityID;
         Params[1].AsInteger:= LogID;
         ExecSQL;

         AddToActivityLog(LogID,1,'Changed log priority to ' + GetPriorityName(PriorityID),0);
       end;
end;

procedure TdmMT2.UpdateLogStatus(LogID: Integer; StatusID: Integer);
begin
    With fqExec do
       begin
         Active:= false;
         SQL.Text:= UseDB;
         SQL.Add('UPDATE tblCustomerLogInfo SET Status =:prm0 WHERE logid=:prm1');
         Params[0].AsInteger:= StatusID;
         Params[1].AsInteger:= LogID;
         ExecSQL;
         AddToActivityLog(LogID,1,'Changed log status to ' + GetStatusName(StatusID),0);
       end;
end;

function TdmMT2.LoadMember(MemberNbr : String ) : TMember;
begin
        With fqMember do
         try
           Active:= false;
           Params[0].AsString:= MemberNbr;
           Active:= true;
           if recordcount >= 1 then
              begin

                result.Nbr:= Fields[0].AsString;
                Result.Name:= Fields[1].AsString;
                Result.Address1:= Fields[2].AsString;
                Result.City:= Fields[3].AsString;
                Result.Prov:= Fields[4].AsString;
                Result.PostalCode:= Fields[5].AsString;
                Result.Phone:= Fields[6].AsString;
                Result.email:= Fields[7].AsString;
                Result.Fax:= Fields[8].AsString;
                Result.WDDCRep:= Fields[9].AsString;
                Result.SiteID:= Fields[10].AsInteger;
              end;
         finally
           Active:= false;
         end;
end;

procedure TdmMT2.SetInvoiceListQuery;
begin
 With fqDB_InvoiceList do
   begin
     Active:= false;
     SQL.Text:= 'SELECT sopnumbe,docdate,subtotal,taxamnt,docamnt';
     SQL.Add('FROM [WDDC].dbo.SOP30200');
     SQL.Add('WHERE custnmbr = :cnbr');
     SQL.Add('AND docdate > :sdat');
     SQL.Add('AND soptype IN (3,4)');
     SQL.Add('ORDER BY docdate DESC');
   end;
end;

procedure TdmMT2.SetInvoiceListQueryBySOP;
begin
   With fqDB_InvoiceList do
     begin
        Active:= false;
        SQL.Text:= 'SELECT sopnumbe,docdate,subtotal,taxamnt,docamnt';
        SQL.Add('FROM [WDDC].dbo.SOP30200');
        SQL.Add('WHERE custnmbr = :cnbr');
        SQL.Add('AND sopnumbe LIKE :sop');
        SQL.Add('AND soptype IN (3,4)');
        SQL.Add('ORDER BY docdate DESC');
     end;

end;

procedure TdmMT2.SetCtgyListQuery(ShowOnlyActive : boolean);
begin
   With fqSelect do
     begin
       Active:= false;
       Params.Clear;
       SQL.Text:= UseDB;
       SQL.Add('SELECT CategoryID,Category FROM tblLogCategories');
       if ShowOnlyActive then
          SQL.Add('WHERE inactive = 0')
       else
          SQL.Add('WHERE inactive = 1');
       SQL.Add(' ORDER BY Category');

     end;

end;

procedure TdmMT2.SetCategoryActiveStatus(CtgyID: Integer; Inactivate : boolean);
var
  ActiveStatus : integer;
begin
    if Inactivate then
      ActiveStatus:= 1
    else
      ActiveStatus:= 0;
    With fqExec do
       begin
         Params.Clear;
         SQL.Text:= UseDB;
         SQL.Add('UPDATE tblLogCategories SET inactive = :prm0');
         SQL.Add('WHERE CategoryID = :prm1');
         Params[1].AsInteger:= CtgyID;
         Params[0].AsInteger:= ActiveStatus;
         ExecSQL;
       end;


end;

procedure TdmMT2.AddToActivityLog(LogID: Integer; ActType: Integer; Activity: string; EventID : integer);
begin
   With fqUpdateActivity do
      begin
        Params[0].AsInteger:= LogID;
        Params[1].AsString:= rGV_MTUser.UserName;
        Params[2].AsInteger:= ActType;
        Params[3].AsString:= Activity;
        Params[4].AsInteger:= EventID;
        ExecSQL;
      end;
end;

procedure TdmMT2.AddLogWatch(LogID: Integer; Reminder: TDateTime; Expy: TDateTime);


begin
    //
    With fqWatchDML do
        begin
          Params.Clear;
          SQL.Text:= UseDB;
          SQL.Add('INSERT INTO tblWatchList (LogID,UserID,ExpyDate,Reminder) VALUES (:prm0,:prm1,:prm2,:prm3)');
          Params[0].AsInteger:= LogID;
          Params[1].AsString:= rGV_MTUser.UserName;
          if Expy <> 0 then
            Params[2].AsDateTime:= Expy
          else
            Params[2].DataType:= ftDateTime;
          if reminder <> 0 then
            Params[3].AsDateTime:= Reminder
          else
            Params[3].DataType:= ftDateTime;
          ExecSQL;



        end;
end;

procedure TdmMT2.RemoveLogWatch(LogID: Integer);


begin
    //
    With fqWatchDML do
        begin
          Params.Clear;
          SQL.Text:= UseDB;
          SQL.Add('DELETE FROM tblWatchList WHERE LogID=:prm0 AND UserID=:prm1');
          Params[0].AsInteger:= LogID;
          Params[1].AsString:= rGV_MTUser.UserName;
          ExecSQL;
        end;
end;

function TdmMT2.OpenWatchListQuery : TDataSet;
begin
       With fqWatchDQL do
         begin
           Active:= false;
           Params[0].AsString:= rGV_MTUser.UserName;
           Active:= true;
           Result:= fqWatchDQL;
         end;
end;

function TdmMT2.IsLogBeingWatched(LogID: Integer) : boolean;
begin
     With fqSelect do
       try
         Params.Clear;
         SQL.Text:= UseDB;
         SQL.Add('SELECT TOP 1 logid FROM tblWatchList WHERE logid=:prm0 AND userid=:prm1');
         Params[0].AsInteger:= LogID;
         Params[1].AsString:= rGV_MTUser.UserName;
         Active:= true;
         Result:= RecordCount > 0;
       finally
         Active:= false;
       end;
end;

function TdmMT2.GetSingleEvent(LogID, EventID : integer) : String;
begin
     With fqSelect do
       try
         Params.Clear;
         SQL.Text:= UseDB;
         SQL.Add('SELECT problem FROM tblCustomerLog WHERE logid=:prm0 AND problemid=:prm1');
         Params[0].AsInteger:= LogID;
         Params[1].AsINteger:= EventID;
         Active:= true;
         Result:= Fields[0].AsString;
       finally
         Active:= false;
       end;
end;

function TdmMT2.GetLogSummary(LogID: Integer) : TLogSummary;
begin
      With fqSelect do
       try
         Params.Clear;
         SQL.Text:= UseDB;
         SQL.Add('SELECT a.summary,a.customerid');
         SQL.Add(',b.custname');
         SQL.Add('FROM tblCustomerLogInfo a');
         SQL.Add('JOIN [wddc].dbo.RM00101 b ON (a.customerid = b.custnmbr AND b.adrscode=:prm0)');
         SQL.Add('WHERE a.logid=:prm1');
         Params[0].AsString:= 'MAIN';
         Params[1].AsInteger:= LogID;
         Active:= true;
         if RecordCount > 0 then
           begin
              Result:= TLogSummary.Create;
              Result.LogID:= LogID;
              Result.Summary:= Fields[0].AsString;
              Result.MemberNbr:= Fields[1].AsString;
              Result.MemberName:= Fields[2].AsString;
           end
         else
           Result:= nil;
       finally
         Active:= false;
       end;
end;

function TdmMT2.GetLastUpdate : TDateTime;
begin
     if fqLastUpdate.Active then
        fqLastUpdate.Refresh
     else
        fqLastUpdate.OpenOrExecute;
     Result:= fqLastUpdate.Fields[0].AsDateTime;

end;

function TdmMT2.AcknowledgeLog(LogID: Integer) : boolean;
begin
     With fqExec do
        try
          Params.Clear;
          SQL.Text:= UseDB;
          SQL.Add('IF EXISTS (SELECT * FROM NotifyLog WHERE ackstatus = 0 AND logid = :prm1)' );
          SQL.Add('BEGIN');
          SQL.Add('UPDATE NotifyLog SET AckStatus = 1,AckOn=GetDate(),AckBy=:prm0 WHERE logid=:prm1');
          SQL.Add('SELECT 1');
          SQL.Add('END');
          SQL.Add('ELSE');
          SQL.Add('SELECT 0');


          ParamByName('prm0').AsString:=  rGV_MTUser.UserName;
          ParamByName('prm1').AsInteger:= LogID;
          Active:= true;
          Result:= Fields[0].AsInteger = 1; //log
        finally
          Active:= false;
        end;
end;

function TdmMT2.IsUserInAssignedDepartment(LogIn: TLogSummary) : boolean;
var
  DeptEMail : String ;
  sGroup, sGroupFullName : String;
begin
       DeptEMail:= stlGV_DeptEmail.ValueFromIndex[stlGV_DeptEMail.IndexOfName(LogIn.DeptName)];
       //check to see if the user is a member of this group
       sGroup:= ExtractRecipNameFromEMailAddress(DeptEMail);
       sGroupFullName:= GetDistNameCNFromMailNickName(sGroup);
       Result:= IsMemberOfDistGroup(sGroupFullName,rGV_MTUser.UserName);

end;

function TdmMT2.GetUserDistList : String;
var
  DeptEMail : String ;
  sGroup, sGroupFullName : String;
  iDx : integer;
begin

   Result:= '';
   for iDx:= 0 to Pred(stlGV_DeptEMail.Count) do
       begin
           DeptEMail:= stlGV_DeptEmail.ValueFromIndex[iDx];
           //check to see if the user is a member of this group
           sGroup:= ExtractRecipNameFromEMailAddress(DeptEMail);
           sGroupFullName:= GetDistNameCNFromMailNickName(sGroup);
           If IsMemberOfDistGroup(sGroupFullName,rGV_MTUser.UserName) then
              Result:= Result + DeptEMail + ',';
       end;
   if Copy(Result,Length(Result),1)= ',' then
      Result:= Copy(Result,1,Length(Result) -1);


end;

function TdmMT2.GetUserAssignedDeptID : integer;

begin

     With fqSelect do
         try
            Params.Clear;
            SQL.Text:= UseDB;
            SQL.Add('SELECT DepartmentID FROM tblDepartments WHERE ContactEMail=:prm0');
            Params[0].AsString:= rGV_MTUser.EMailGroup;
            Active:= true;
            if RecordCount > 0 then
               Result:= Fields[0].AsInteger
            else
               Result:= 0;
         finally
            Active:= false;
         end;

end;

function TdmMT2.CreateNewCategory(NameIn: string) : integer;
begin
    With fqExec do
      try
         SQL.Text:= UseDB;
         SQL.Add('INSERT INTO tblLogCategories');
         SQL.Add('(Category,SuperCategoryID,Inactive,InvoiceLink)');
         SQL.Add('OUTPUT IDENTITY.CategoryID  VALUES(:ctgy,:sgid,:inac,:ilnk)');
         Params[0].AsString:= NameIn;
         Params[1].AsInteger:= 1;
         Params[2].AsInteger:= 0;
         Params[3].AsInteger:= 0;
         Active:= true;
         Result:= Fields[0].AsInteger;


      finally
         Active:= false;
      end;
end;

procedure TdmMT2.UpdateCategoryLink(CtgyID, LinkState : integer);
begin
    //
    With fqExec do
      try
         SQL.Text:= UseDB;
         SQL.Add('UPDATE tblLogCategories');
         SQL.Add('SET InvoiceLink =:prm0');
         SQL.Add('WHERE categoryid =:prm1');
         Params[0].AsInteger:= CtgyID;
         Params[1].AsInteger:= LinkState;
         ExecSQL;

      finally

      end;
end;





end.
