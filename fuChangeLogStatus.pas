unit fuChangeLogStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, Vcl.ComCtrls,
  Vcl.StdCtrls;

type
   TUpdateLogStatusValidation = (clSuccess,clNoChangedBy,clNoChangedDate);

type
  TfrmChangeLogStatus = class(TForm)
    cbStatus: TComboBox;
    Label1: TLabel;
    eChangedBy: TEdit;
    Label2: TLabel;
    dtpChangedOn: TDateTimePicker;
    Label3: TLabel;
    AdvGlowButton1: TAdvGlowButton;
    procedure FormCreate(Sender: TObject);
    function ValidateChangeLogDataEntry : TUpdateLogStatusValidation;
    procedure AdvGlowButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChangeLogStatus: TfrmChangeLogStatus;

implementation

{$R *.dfm}

procedure TfrmChangeLogStatus.AdvGlowButton1Click(Sender: TObject);
begin
    if ValidateChangeLogDataEntry = clSuccess then
        ModalResult:= mrOK
    else
        MessageDlg('Please complete all fields before submitting the changes to the log status.',mtInformation,[mbOK],0);
end;

procedure TfrmChangeLogStatus.FormCreate(Sender: TObject);
begin
   dtpCHangedOn.DateTime:= Now;
end;

function TfrmChangeLogStatus.ValidateChangeLogDataEntry : TUpdateLogStatusValidation;
begin
     Result:= clSuccess;
     if (Result = clSuccess) and (eChangedBy.Text = '')  then
        Result:= clNoChangedBy;
end;




end.
