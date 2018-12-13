unit fuMT2Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvGlowButton, Registry,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, AdvOfficeButtons, GDIPImageTextItem,
  GDIPCustomItem, GDIPTextItem, AdvPolyPager, AdvUtil, AdvEdit, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid;

type
  TfrmMT2Main = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    ppMT: TAdvPolyPager;
    AdvPolyPage1: TAdvPolyPage;
    AdvPolyPage2: TAdvPolyPage;
    AdvPage_PriceTagLog1: TAdvPolyPage;
    extItem_PriceTagLog1: TTextItem;
    pgMT2: TAdvPolyPage;
    ImageTextItem_MT21: TImageTextItem;
    btnCustomerLog: TAdvGlowButton;
    btnSearch: TAdvGlowButton;
    btnShipMemo: TAdvGlowButton;
    cbEmployee: TComboBox;
    chkAutoPrint: TAdvOfficeCheckBox;
    Label2: TLabel;
    sgPTLog: TAdvStringGrid;
    eMember: TAdvEdit;
    AdvGlowButton1: TAdvGlowButton;
    Image1: TImage;
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
    procedure chkAutoPrintClick(Sender: TObject);
    procedure btnShipMemoClick(Sender: TObject);
    procedure ShowTagLog(Member : String);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure sgPTLogAnchorClick(Sender: TObject; ARow, ACol: Integer;
      Anchor: string; var AutoHandle: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMT2Main: TfrmMT2Main;

implementation

{$R *.dfm}

uses  duMT2, fuCustomerLog, uMT2GlobalVar, uCommon, fuMTSearch, fuShippingMemo,
  fuPTOrder;

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
   stlGV_ShipMethod:= TStringList.Create;
   stlGV_CLCtgy:= TStringList.Create;
   stlGV_Dept:= TStringList.Create;
   stlGV_Staff:= TStringList.Create;
   stlGV_pickers:= TStringList.Create;
   ppMT.ActivePage:= pgMT2;

end;

procedure TfrmMT2Main.FormDestroy(Sender: TObject);
begin
   stlGV_ShipMethod.Free;
   stlGV_CLCtgy.Free;
   stlGV_Dept.Free;
   stlGV_Staff.Free;
   stlGV_Pickers.Free;
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
       chkAutoPrint.Checked:= ReadBool('','AutoPrint',false);
       bGV_AutoPrint:= chkAutoPrint.Checked;
     finally
       Free;
     end;
   cbEmployee.ItemIndex:= cbEmployee.Items.IndexOf(sGV_EmpName);
   if cbEmployee.ItemIndex > -1 then
      iGV_EmpId:= INteger(cbEmployee.Items.Objects[cbEmployee.ItemIndex]);
   //now load session info into memory
   LoadOneTimeSettings;

end;

procedure TfrmMT2Main.sgPTLogAnchorClick(Sender: TObject; ARow, ACol: Integer;
  Anchor: string; var AutoHandle: Boolean);
var
  sMbr : String;
  sDate : String;
  dDate : TDateTime;
begin
    if Anchor = 'view' then // try to find the order placed at the same time
       begin
          sMbr:= sgPTLog.Cells[1,ARow];
          sDate:= sgPTLog.Cells[0,ARow]; //this will be in the format coming from SQL Server, typicall yyyy-mm-dd hh-mm-ss . With luck we can convert this back
          try
          dDate:= VarToDateTime(sDate);
          except
            exit;
          end;

          //having verified the data, pass it to the form and show
          With TfrmPTORder.Create(nil) do
            try
              dPTO:= dDate;
              sPTO_Mbr:= sMbr;
              Show;
            finally

            end;
       end;


end;

procedure TfrmMT2Main.AdvGlowButton1Click(Sender: TObject);
begin
   ShowTagLog(eMember.Text);
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

procedure TfrmMT2Main.btnShipMemoClick(Sender: TObject);
begin
     frmShippingMemo.Show;
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

procedure TfrmMT2Main.chkAutoPrintClick(Sender: TObject);
begin
    bGV_AutoPrint:= chkAutoPrint.Checked;
end;

procedure TfrmMT2Main.ShowTagLog(Member : String);
var
 iRow : integer;
begin
     iRow:= 1;
     With dmMT2.qPLG001 do
       try
         sgPTLog.BeginUpdate;
         sgPTLog.RowCount:= 2;
         sgPTLog.ClearRows(1,1);

         Active:= false;
         SQL.Text:= 'SELECT pl01_time_Stmp,pl01_mbr_nbr,pl01_msg_type,pl01_msg FROM [WebOrdering]..PLG001';
         SQL.Add('WHERE pl01_msg_type IN (1,2)');
         if Member <> '' then
          begin
             SQL.Add('AND pl01_mbr_nbr = :mbr');
             ParamByName('mbr').AsString:= Member;
          end;
         SQL.Add('ORDER BY pl01_time_stmp DESC');
         Active:= true;
         while not EOF do
           begin
             With sgPTLog do

               begin
                  if iRow > 1 then
                     AddRow;
                  Cells[0,iRow]:= Fields[0].AsString;
                  Cells[1,iRow]:= Fields[1].AsString;
                  case Fields[2].AsINteger of
                  1: Cells[2,iRow]:= 'Ordered';
                  2: Cells[2,iRow]:= 'Printed';
                  end;
                  //check to see if there needs to be a link
                  Cells[3,iRow]:= Fields[3].AsString;
                  case Fields[2].AsINteger of
                  1: Cells[3,iRow]:= Cells[3,iRow] + '  <A HREF="view">View</A>';
                  end;
                  Inc(iRow);
               end;
              Next;
           end;


       finally
        begin
          Active:= false;
          sgPTLog.EndUpdate;
        end;
       end;
end;

end.
