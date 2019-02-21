program MT2;

uses
  Vcl.Forms,
  fuMT2Main in 'fuMT2Main.pas' {frmMT2Main},
  duMT2 in 'duMT2.pas' {dmMT2: TDataModule},
  fuCustomerLog in 'fuCustomerLog.pas' {frmCustomerLog},
  uCommon in 'uCommon.pas',
  uMT2GlobalVar in 'uMT2GlobalVar.pas',
  fuDateSelection in 'fuDateSelection.pas' {frmDateSelection},
  fuCustomerInvoices in 'fuCustomerInvoices.pas' {frmCustomerInvoices},
  fuBoL in 'fuBoL.pas' {frmBOL},
  uMT2Classes in 'uMT2Classes.pas',
  fuMTSearch in 'fuMTSearch.pas' {frmMTSearch},
  fuCreateNewLog in 'fuCreateNewLog.pas' {frmCreateNewLog},
  fuChangeLogStatus in 'fuChangeLogStatus.pas' {frmChangeLogStatus},
  fuImages in 'fuImages.pas' {frmImages},
  fuImageList in 'fuImageList.pas' {frmImageList};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMT2Main, frmMT2Main);
  Application.CreateForm(TdmMT2, dmMT2);
  Application.CreateForm(TfrmCustomerLog, frmCustomerLog);
  Application.CreateForm(TfrmMTSearch, frmMTSearch);
  Application.CreateForm(TfrmImages, frmImages);
  Application.CreateForm(TfrmImageList, frmImageList);
  Application.Run;
end.
