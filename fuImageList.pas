unit fuImageList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothSlideShow;

type
  TfrmImageList = class(TForm)
    cmpImageList: TAdvSmoothSlideShow;
    procedure ListLogImages(LogID : integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    iIL_LogID : integer;
  end;

var
  frmImageList: TfrmImageList;

implementation

{$R *.dfm}

uses uMT2GlobalVar;


procedure TfrmImageList.FormShow(Sender: TObject);
begin
     ListLogImages(iIL_LogID);
end;

procedure TfrmImageList.ListLogImages(LogID: Integer);
begin
     cmpImageList.AddItemsFromFolder(IncludeTrailingPathDelimiter(cstImageStorageURL + IntToStr(LogID)) + '*.bmp',ikImage);
end;

end.
