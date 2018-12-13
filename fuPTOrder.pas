unit fuPTOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid;

type
  TfrmPTOrder = class(TForm)
    sgPTOrder: TAdvStringGrid;
    procedure FormDeactivate(Sender: TObject);
    procedure ShowOrder;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dPTO : TDateTime;
    sPTO_Mbr : String;
  end;

var
  frmPTOrder: TfrmPTOrder;

implementation

{$R *.dfm}

uses duMT2;

procedure TfrmPTOrder.FormDeactivate(Sender: TObject);
begin
   Free;
end;

procedure TfrmPTOrder.FormShow(Sender: TObject);
begin
  ShowOrder;
end;

procedure TfrmPTOrder.SHowOrder;
var
  iRow : integer;
begin
     iRow:= 1;
     With dmMT2.qPRT001 do
        try
          sgPTOrder.BeginUpdate;
          Active:= false;
          ParamByName('mbr1').AsString:= sPTO_mbr;
          ParamByName('dbeg').AsDateTime:= IncMinute(dPTO,-1);
          ParamByName('dend').AsDateTime:= IncMinute(dPTO,2);
          Active:= true;
          while not EOF do
            begin
               With sgPTORder do
                  begin
                    if iRow > 1 then
                       AddRow;
                    Cells[0,iRow]:= Fields[1].AsString; // item number
                    case Fields[5].Asinteger of
                    1: begin
                         Cells[1,iRow]:= 'Price Tag';
                         Cells[2,iRow]:=  Fields[2].AsString;
                       end;
                    2: begin
                         Cells[1,iRow]:= 'Shelf Label';
                         Cells[2,iRow]:=  Fields[3].AsString;
                       end;
                    end;
                    Cells[3,iRow]:= Format('%m',[Fields[4].AsCurrency]);
                    Cells[4,iRow]:= Fields[6].AsString;

                  end;
               Next;
               Inc(iRow);
            end;

        finally
         begin
          Active:= false;
          sgPTORder.EndUpdate;
         end;
        end;

end;

end.
