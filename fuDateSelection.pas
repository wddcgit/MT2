unit fuDateSelection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, Vcl.StdCtrls,
  Vcl.ComCtrls;

type
  TfrmDateSelection = class(TForm)
    dtpStart: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    AdvGlowButton1: TAdvGlowButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDateSelection: TfrmDateSelection;

implementation

{$R *.dfm}

end.
