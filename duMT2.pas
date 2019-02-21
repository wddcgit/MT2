unit duMT2;

interface

uses
  System.SysUtils, System.Classes, DBAccess, SdacVcl, Data.DB, MSAccess, MemDS,  Dialogs,
  Vcl.ImgList, Vcl.Controls, RpCon, RpConDS, RpRave, RpDefine, RpBase, RpSystem,
  System.ImageList;

type
  TdmMT2 = class(TDataModule)
    mscMT2: TMSConnection;
    mscDBServer: TMSConnection;
    cdMT2: TMSConnectDialog;
    cdDBServer: TMSConnectDialog;
    qMembers: TMSQuery;
    qMT_Logs: TMSQuery;
    iml16x16: TImageList;
    qMT_Employee: TMSQuery;
    qDB_Session: TMSQuery;
    qMT_Session: TMSQuery;
    iml12x12: TImageList;
    qMT_LogDet: TMSQuery;
    qMT_CallerList: TMSQuery;
    qDB_InvoiceList: TMSQuery;
    qDB_InvoiceDet: TMSQuery;
    qMT_InvoiceList: TMSQuery;
    qDB_InvoiceByItem: TMSQuery;
    qDB_Pickers: TMSQuery;
    qMT_LogId: TMSQuery;
    qMT_AddOther: TMSQuery;
    qMT_Select: TMSQuery;
    qDB_MemberName: TMSQuery;
    qDB_TrackingNum: TMSQuery;
    qDB_ItemPerCntr: TMSQuery;
    qDB_CntrPicker: TMSQuery;
    qMT_Search: TMSQuery;
    qDB_MemberSearch: TMSQuery;
    qRPTLog: TMSQuery;
    rvsMT2: TRvSystem;
    rvMT2: TRvProject;
    rdsRptLog: TRvDataSetConnection;
    qRPTInvoiceList: TMSQuery;
    rdsRptInvoiceList: TRvDataSetConnection;
    qMT_InsertCustomerLogInfo: TMSQuery;
    qMT_InsertCustomerLog: TMSQuery;
    qMT_LowestPID: TMSQuery;
    qMT_TrackingList: TMSQuery;
    qRptTrackingList: TMSQuery;
    rdsTrackingList: TRvDataSetConnection;
    qDB_Supplier: TMSQuery;
    qDB_Select: TMSQuery;
    qDB_ItemLookup: TMSQuery;
    qMT_SelectShippingMemo: TMSQuery;
    qMT_SelectSMIDItems: TMSQuery;
    qMT_InsertSM: TMSQuery;
    qMT_Exec: TMSQuery;
    qMT_InsertRID: TMSSQL;
    qMT_ErrLog: TMSSQL;
    procedure PrintLog(LogId : integer; PreviewLog : boolean);
    function GetLowestPID(LogId : integer) : integer;
    function CheckForShippingMemo(SMID : integer) : boolean;
    function AddToErrorLog(SectionIn, ErrorIn : String) : String;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  dmMT2: TdmMT2;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uCommon;

{$R *.dfm}

procedure TdmMT2.PrintLog(LogId : integer; PreviewLog : boolean);
var
  sCID , sName, sContactNo : String;
begin
    rvMT2.ClearParams;




    try
    With qRptLog do
      begin
       Active:= false;
       SQL.Text:= 'USE [MT2]';
       SQL.Add(' SELECT a.CustomerID,a.caller,a.logdate,e.empname,b.logid,b.problemid,');
       SQl.Add(' b.problem,b.notes,b.shippingmethod,b.orderkeyedby,b.closedby,b.closeddate,b.closed,');
       SQL.Add(' b.orderpickedby,d.department,c.category');
       SQL.Add(',a.summary,a.status,a.JIRAId, b.entrydate');
       SQL.Add(' FROM dbo.tblCustomerLogInfo a');
       SQL.Add(' LEFT OUTER JOIN dbo.tblCustomerLog b ON (a.logid = b.logid)');
       SQL.Add(' LEFT OUTER JOIN dbo.tblDepartments d ON (b.departmentid = d.departmentid)');
       SQL.Add(' LEFT OUTER JOIN dbo.tblLogCategories c ON (b.categoryid = c.categoryid)');
       SQL.Add(' LEFT OUTER JOIN dbo.tblEmployees e on (a.empid = e.empid)');
       SQL.Add(' WHERE a.logid = :lid1');
       SQL.Add('ORDER BY b.entrydate');
       ParamByName('lid1').AsInteger:= LogID;
       Active:= true;
       sCID:= Fields[0].AsString;
      end;

    //the clinc name and contact info is not retained in the MT log , so it has to come from WDDC which means a different database
    With qMembers do
       try
         Active:= false;
         ParamByName('cnbr').AsString:= sCID + '%';
         Active:= true;
         if RecordCOunt > 0 then
           begin
             sName:= Fields[1].AsString;
             sContactNo:= PhoneDataToString(Fields[6].AsString);
           end;

       finally
         Active:= false;
       end;




    rvMT2.Open;
    rvMT2.SetParam('ClientName',sName);
    rvMT2.SetParam('ContactNo',sContactNo);

    if PreviewLog then
       begin
         rvsMT2.SystemSetups:= rvsMT2.SystemSetups +[ssAllowSetup];
         rvsMT2.DefaultDest:= rdPreview;
         rvsMT2.ReportDest:= rdPreview;
       end
    else
      begin
        rvsMT2.ReportDest:= rdPrinter;
        rvsMT2.DefaultDest:= rdPrinter;
        rvsMT2.SystemSetups:= rvsMT2.SystemSetups -[ssAllowSetup];
      end;
    rvMT2.ExecuteReport('rptLog');


    finally
      begin
        rvMT2.Close;
        qRptLog.Active:= false;
        qRptInvoiceList.Active:= false;
        qRptTrackingList.Active:= false;
       end;
    end;

end;

function TdmMT2.GetLowestPID(LogId: Integer) : integer;

begin
     With qMT_LowestPID do
       try
         Active:= false;
         ParamByName('lid1').AsInteger:= LogId;
         Active:= true;
         if RecordCount > 0 then
            Result:= FIelds[0].AsInteger
         else
            Result:= 0;
       finally
         Active:= false;
       end;
end;

function TdmMT2.CheckForShippingMemo(SMID: Integer) : boolean;
begin
     With qMT_Select do
        try
          Active:= false;
          SQL.Text:= 'SELECT shippingmemo FROM [MT2].dbo.tblReturns WHERE shippingmemo = :smid';
          ParamByName('smid').AsInteger:= SMID;
          Active:= true;
          Result:= RecordCount > 0;

        finally
          Active:= false;
        end;

end;

function TdmMT2.AddToErrorLog(SectionIn: string; ErrorIn: string) : String;
begin
     try

       With qMT_ErrLog do
          begin
             ParamByName('ldt1').AsDateTime:= Now;
             ParamByName('unm1').AsString:= GetEnvironmentVariable('USERNAME');
             ParamByName('wst1').AsString:= GetEnvironmentVariable('COMPUTERNAME');
             ParamByName('fnm1').AsString:= SectionIn;
             ParamByName('err1').AsString:= ErrorIn;
             Execute;
          end;
     Result:= '';  //clears out the error used as LastError
     except on E: Exception do
       ShowMessage('That error was so bad we could not even add it to the log. The error is : ' + #13 + ErrorIn);

     end;
end;

end.
