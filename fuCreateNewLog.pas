unit fuCreateNewLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, Vcl.StdCtrls;
type
   TValidationResults = (vtNoCaller, vtNoCategory, vtNoAssignedTo,vtNoSummary, vtSuccess);

type
  TfrmCreateNewLog = class(TForm)
    cbCNL_Caller: TComboBox;
    Label7: TLabel;
    cbCNL_Ctgy: TComboBox;
    cbCNL_AssignedTo: TComboBox;
    Label3: TLabel;
    Label2: TLabel;
    btnCreateNewLog: TAdvGlowButton;
    cbLogSummary: TComboBox;
    Label1: TLabel;
    eJIRA: TEdit;
    Label4: TLabel;
    procedure btnCreateNewLogClick(Sender: TObject);
    function ValidateUSerInput : TValidationResults;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCreateNewLog: TfrmCreateNewLog;

implementation

{$R *.dfm}

procedure TfrmCreateNewLog.btnCreateNewLogClick(Sender: TObject);
begin
     if ValidateUserInput = vtSuccess then
        ModalResult:= mrOK
     else
       MessageDlg('You must complete all fields before creating a new log,',mtError,[mbOK],0);
end;

function TfrmCreateNewLog.ValidateUserInput : TValidationResults;
begin
      Result:= vtSuccess;
      If cbCNL_Caller.Text = '' then
        Result:= vtNoCaller;
      if (Result = vtSuccess) and (cbCNL_Ctgy.Text = '') then
        Result:= vtNoCategory;
      if (Result = vtSuccess) and (cbCNL_AssignedTo.Text = '') then
         Result:= vtNoAssignedTo;
      if (Result = vtSuccess) and (cbLogSummary.Text = '') then
         Result:= vtNoSummary;
end;

end.
