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
    procedure cmpImageListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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

uses uMT2GlobalVar, duMT2;


procedure TfrmImageList.cmpImageListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

   var
  iIndex : integer;
  sFileName : String;
begin
 if (Key = VK_DELETE) and (cmpImageList.ItemIndex > -1) then
      begin
        iIndex := cmpImageList.ItemIndex;
        sFileName:= cmpImageList.Items[iIndex].Location;
        if MessageDlg('Delete file ' + sFileName + '?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
            begin
              DeleteFile(sFileName);

              cmpImageList.Items.Delete(iIndex);
            end;

      end;
end;

procedure TfrmImageList.FormShow(Sender: TObject);
begin
     ListLogImages(iIL_LogID);
end;

procedure TfrmImageList.ListLogImages(LogID: Integer);
begin
     cmpImageList.AddItemsFromFolder(IncludeTrailingPathDelimiter(cstImageStorageURL + IntToStr(LogID)) + '*.bmp',ikImage);
end;

end.
