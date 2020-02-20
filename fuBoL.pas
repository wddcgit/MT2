unit fuBoL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, AdvObj,
  BaseGrid, AdvGrid, AdvGlowButton, AdvUtil;

type
  TfrmBOL = class(TForm)
    sgBoL: TAdvStringGrid;
    lbBoL: TListBox;
    AdvGlowButton1: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure ListBoL;
    procedure ClearGrid;
    procedure sgBoLDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure lbBoLKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    sBL_MemberNbr : String;
  end;

var
  frmBOL: TfrmBOL;

implementation

{$R *.dfm}

uses duMT2;

procedure TfrmBOL.FormShow(Sender: TObject);
begin
     //fins the bill of lading for the client
     ListBoL;
end;

procedure TfrmBOL.lbBoLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (lbBoL.ItemIndex > -1) and (Key = VK_DELETE) then
         lbBol.Items.Delete(lbBol.ItemIndex);
end;

procedure TfrmBoL.ListBoL;
var
  iROw : integer;
begin
     With sgBol do
       try
         BeginUpdate;
         iRow:= 1;
         With dmMT2.fqDB_TrackingNbr do
            try
              Active:= false;
              ParamBYName('cnbr').AsString:= sBL_MemberNbr + '%';
              Active:= true;
              while not EOF do
                begin
                  if iRow > 1 then
                     AddROw;
                  Cells[0,iRow]:= FormatDateTime('mmm dd yy',Fields[2].AsDateTime);
                  Cells[1,iRow]:= Fields[3].AsString;
                  Cells[2,iRow]:= FIelds[0].AsString;
                  Cells[3,iRow]:= Fields[1].AsString;
                  Cells[4,iRow]:= FloatToStrF(Fields[4].AsFloat,ffGeneral,3,1);
                  Next;
                  Inc(iRow);
                end;
            finally

            end;
       finally
         EndUpdate;
       end;
end;

procedure TfrmBOL.sgBoLDblClickCell(Sender: TObject; ARow, ACol: Integer);
begin
    With sgBoL do
      if (Cells[3,ARow] <> '') and (lbBoL.Items.IndexOf(Cells[3,ARow]) = -1) then
          lbBoL.Items.Add(Cells[3,ARow]);

end;

procedure TfrmBol.ClearGrid;
var
  x,y : integer;
begin
       With sgBol do
        for x:= 0 to Pred(ColCount) do
           for y:= 1 to Pred(RowCount) do
              Cells[x,y]:= '';
        sgBol.RowCount:= 2;

end;

end.


