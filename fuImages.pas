unit fuImages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ClipBrd, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, AdvEdit, HTMLText, AdvGlowButton;

type
  TfrmImages = class(TForm)
    pnlImageHeader: TPanel;
    lvImage: TListView;
    imgImport: TImage;
    eImageTitle: TAdvEdit;
    eImageNotes: TAdvEdit;
    lblHowToAddImage: THTMLStaticText;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    btnSaveImage: TAdvGlowButton;
    odSelectImage: TOpenDialog;
    procedure lvImageKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure AdvGlowButton2Click(Sender: TObject);
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

procedure TfrmImages.AdvGlowButton1Click(Sender: TObject);
begin
   if odSelectImage.Execute then
           begin
             imgImport.Picture.LoadFromFile(odSelectImage.FileName);
             SetComponentsAndButtonsStateToImage;
        end;
end;

procedure TfrmImages.AdvGlowButton2Click(Sender: TObject);
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
