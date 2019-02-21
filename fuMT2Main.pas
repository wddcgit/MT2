unit fuMT2Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvGlowButton, Registry,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, AdvOfficeButtons;

type
  TfrmMT2Main = class(TForm)
    Button1: TButton;
    Button2: TButton;
    btnCustomerLog: TAdvGlowButton;
    cbEmployee: TComboBox;
    Label1: TLabel;
    Image1: TImage;
    btnSearch: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckForConnection;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnCustomerLogClick(Sender: TObject);
    function CheckIfStaffSelected : boolean;
    procedure cbEmployeeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  frmMT2Main: TfrmMT2Main;

implementation

{$R *.dfm}

uses  duMT2, fuCustomerLog, uMT2GlobalVar, uCommon, fuMTSearch;

procedure TfrmMT2Main.FormClose(Sender: TObject; var Action: TCloseAction);
var
  stl : TStringList;
begin
   //save the connect strings
   if dmMT2.mscMT2.ConnectString <> '' then
       try
         stl:= TStringList.Create;
         stl.text:=dmMT2.mscMT2.ConnectString;
         stl.SaveToFile(ExtractFilePath(ParamStr(0)) + 'MT2CP.txt');

     finally
       stl.Free;
     end;
        //save the connect strings
   if dmMT2.mscDBSERVER.ConnectString <> '' then
       try
         stl:= TStringList.Create;
         stl.text:=dmMT2.mscDBserver.ConnectString;
         stl.SaveToFile(ExtractFilePath(ParamStr(0)) + 'DBSERVERCP.txt');

     finally
       stl.Free;
     end;

     //now see if the staff has logged in before
   With TRegIniFile.Create do
     try
       RootKey:= HKEY_CURRENT_USER;
       OpenKey('Software\WDDC\MT2',True);
       WriteString('','EmpName',sGV_EmpName);
       WriteBool('','AutoPrint',bGV_AutoPrint);
     finally
       Free;
     end;


end;

procedure TfrmMT2Main.FormCreate(Sender: TObject);
begin
   //initiate variable

   stlGV_CLCtgy:= TStringList.Create;
   stlGV_Dept:= TStringList.Create;
   stlGV_Staff:= TStringList.Create;

   stlGV_Callers:= TStringList.Create;
   stlGV_Log_Summary_List:= TStringList.Create;
   stlGV_LogImageList:= TStringList.Create;

end;

procedure TfrmMT2Main.FormDestroy(Sender: TObject);
begin

   stlGV_CLCtgy.Free;
   stlGV_Dept.Free;
   stlGV_Staff.Free;
   stlGV_Callers.Free;
   stlGV_Log_Summary_List.Free;
   stlGV_LogImageList.Free;
end;

procedure TfrmMT2Main.FormShow(Sender: TObject);
var
  stl : TStringList;

begin
   //do this OnShow as the data module will not be ready on create
   //first see if there is a connect string saved and if there is , load it, if not, prompt for connection
   if FileExists(ExtractFilePath(ParamStr(0)) + 'MT2CP.txt') then
     try
       stl:= TStringList.Create;
       stl.LoadFromFIle(ExtractFilePath(ParamStr(0)) + 'MT2CP.txt');
       dmMT2.mscMT2.ConnectString:= stl.text;
       if POS('Prompt',stl.Text) = 0 then
            stl.Text:= stl.Text + ';Login Prompt = False';
       dmMT2.mscMT2.Connected:= true;
     finally
       stl.Free;
     end;

     //check for WDDC path
   if FileExists(ExtractFilePath(ParamStr(0)) + 'DBSERVERCP.txt') then
     try
       stl:= TStringList.Create;
       stl.LoadFromFIle(ExtractFilePath(ParamStr(0)) + 'DBSERVERCP.txt');
       if POS('Prompt',stl.Text) = 0 then
            stl.Text:= stl.Text + ';Login Prompt = False';
       dmMT2.mscDBServer.ConnectString:= stl.text;

       dmMT2.mscDBServer.Connected:= true;
     finally
       stl.Free;
     end;

   //check for list of summary
    if FileExists(ExtractFilePath(ParamStr(0)) + cnstSummaryFile) then
       stlGV_Log_Summary_List.LoadFromFile(ExtractFilePath(ParamStr(0)) + cnstSummaryFile);


   // add the eployees to the liust
   if dmMT2.mscMT2.Connected then
     With dmMT2.qMT_Employee do
       try
         Active:= true;
         while not EOF do
           begin

             stlGV_Staff.AddObject(Fields[1].AsString,TObject(Fields[0].AsInteger));
             Next;
           end;
       finally
         Active:= false;
       end;
    cbEmployee.Items.Assign(stlGV_Staff);
   //now see if the staff has logged in before
   With TRegIniFile.Create do
     try
       RootKey:= HKEY_CURRENT_USER;
       OpenKey('Software\WDDC\MT2',True);
       sGV_EmpName:= ReadString('','EmpName','');

       bGV_AutoPrint:= false;
     finally
       Free;
     end;
   cbEmployee.ItemIndex:= cbEmployee.Items.IndexOf(sGV_EmpName);
   if cbEmployee.ItemIndex > -1 then
      iGV_EmpId:= INteger(cbEmployee.Items.Objects[cbEmployee.ItemIndex]);
   //now load session info into memory
   LoadOneTimeSettings;

end;

procedure TfrmMT2Main.btnCustomerLogClick(Sender: TObject);
begin

   if CheckIfStaffSelected then
       frmCustomerLog.Show;
end;

procedure TfrmMT2Main.btnSearchClick(Sender: TObject);
begin
    frmMTSearch.SHow;
end;

procedure TfrmMT2Main.Button1Click(Sender: TObject);
begin
  CheckForConnection;
end;

procedure TfrmMT2Main.Button2Click(Sender: TObject);
begin
   dmMT2.cdDBserver.Execute;
end;

procedure TfrmMT2Main.cbEmployeeChange(Sender: TObject);
begin
   if cbEmployee.ItemIndex > -1 then
      begin
        sGV_EmpName:= cbEmployee.Items[cbEmployee.ItemIndex];
        iGV_EmpId:= INteger(cbEmployee.Items.Objects[cbEmployee.ItemIndex]);
      end;
end;

procedure TfrmMT2Main.CheckForConnection;
begin
    if dmMT2.mscMT2.ConnectString = '' then
       dmMT2.cdMT2.Execute;
    if dmMT2.mscDBServer.ConnectString = '' then
       dmMT2.cdDBserver.Execute;
end;

function TfrmMT2Main.CheckIfStaffSelected : boolean;
begin
    Result:= cbEmployee.ItemIndex > -1;
    if not Result then
      MessageDlg('Please select a staff name before continuing.',mtInformation,[mbOK],0);
end;

end.
