unit fuImages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ClipBrd, Vcl.ExtCtrls, Vcl.ComCtrls,  JPEG,
  Vcl.StdCtrls, AdvEdit, HTMLText, AdvGlowButton;

type
  TfrmImages = class(TForm)
    pnlImageHeader: TPanel;
    lvImage: TListView;
    imgImport: TImage;
    eImageTitle: TAdvEdit;
    eImageNotes: TAdvEdit;
    lblHowToAddImage: THTMLStaticText;
    btnSelectImage: TAdvGlowButton;
    btnClear: TAdvGlowButton;
    btnSaveImage: TAdvGlowButton;
    odSelectImage: TOpenDialog;
    procedure lvImageKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSelectImageClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure SetComponentsAndButtonsStateToImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImages: TfrmImages;

implementation

{$R *.dfm}

procedure TfrmImages.btnSelectImageClick(Sender: TObject);
var
  jpgIncoming : TJPEGImage;
  sFileIn : String;
begin
   if odSelectImage.Execute then
           begin
             sFileIn:= odSelectImage.FileName;
             if (POS('.jpg',LowerCase(sFileIn)) > 0)  or (POS('.jpeg',LowerCase(sFileIn)) > 0)  then
                try
                   jpgIncoming:= TJPEGImage.Create;
                   jpgIncoming.LoadFromFile(sFileIn);
                   imgImport.Picture.Bitmap.Assign(jpgIncoming);

                finally
                  jpgIncoming.Free;
                end
             else
                imgImport.Picture.LoadFromFile(odSelectImage.FileName);
             SetComponentsAndButtonsStateToImage;
        end;
end;

procedure TfrmImages.btnClearClick(Sender: TObject);
begin
         lvImage.Visible:= true;
         lblHowToAddImage.Visible:= true;
         imgImport.Picture:= nil;
         btnSaveImage.Enabled:= false;


end;

procedure TfrmImages.lvImageKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if (ssCtrl in Shift) and ((Key = Ord('V')) or (Key = Ord('v'))) and Clipboard.HasFormat(CF_BITMAP) then
        begin
         imgImport.Picture.Bitmap.Assign(Clipboard) ;
         SetComponentsAndButtonsStateToImage;
        end;
end;

procedure TfrmImages.SetComponentsAndButtonsStateToImage;
begin
        lvImage.Visible:= false;
        lblHowToAddImage.Visible:= false;
        btnSaveImage.Enabled:= true;
end;

end.
