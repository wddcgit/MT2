unit fuSMSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  AdvGlowButton, Vcl.StdCtrls, AdvEdit;

type
  TfrmSMSearch = class(TForm)
    cbSearchBy: TComboBox;
    Label1: TLabel;
    eSearch: TAdvEdit;
    btnSearch: TAdvGlowButton;
    sgSearch: TAdvStringGrid;
    procedure btnSearchClick(Sender: TObject);
    procedure sgSearchDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iSMS_SMID : integer;
  end;

var
  frmSMSearch: TfrmSMSearch;

implementation

{$R *.dfm}

uses duMT2, uCommon;

procedure TfrmSMSearch.btnSearchClick(Sender: TObject);
var
  iRow : integer;
begin
   if eSearch.Text = '' then
     exit;
   WIth dmMT2.qMT_Select do
      try
        Active:= false;
        DisableControls;
        SQL.Text:= 'USE [MultiTracking]';
        case cbSearchBy.ItemIndex of
        0: SQL.Add('SELECT ShippingMemo, DateReceived,Comments FROM dbo.tblReturns WHERE shippingmemo IN (SELECT shippingmemo from dbo.tblReturnDescriptions WHERE product = :prm1)');
        1: SQL.Add('SELECT ShippingMemo, DateReceived,Comments FROM dbo.tblReturns WHERE purchaseorder = :prm1');
        end;
        ParamByName('prm1').AsString:= eSearch.Text;
        Active:= true;
        With sgSearch do
          try
            BeginUpdate;
            ClearGrid(sgSearch,1,2);
            iRow:= 1;
            while not EOF do
               begin
                 if iRow > 1 then
                   AddRow;
                 Cells[0,iRow]:= Fields[0].AsString;
                 Cells[1,iRow]:= Fields[1].AsString;
                 cells[2,iRow]:= Fields[2].AsString;
                 Next;
                 Inc(iRow);
               end;

          finally
           begin
            EndUpdate;
            AutoSizeRows(false,3);
           end;
          end;

      finally
        Active:= false;
      end;
end;

procedure TfrmSMSearch.FormCreate(Sender: TObject);
begin
  iSMS_SMID:= 0;
end;

procedure TfrmSMSearch.sgSearchDblClick(Sender: TObject);
begin
     With sgSearch do
       if (Row > 0) and (Cells[0,Row] <> '') then
          try
            iSMS_SMID:= StrToIntDef(Cells[0,Row],0);
            if iSMS_SMID > 0 then
               ModalResult:= mrOK;
          finally

          end;

end;

end.
