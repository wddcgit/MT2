unit uCommon;

interface
uses Classes, AdvObj, BaseGrid, AdvGrid, SysUtils, Forms, fuDim, HTMListB, uMT2Classes;



function IsValidInt(StringIn : String) : boolean;
function IndexFromValues(StringList : TStrings;ValueIn : String) : integer;
function PhoneDataToString(PhoneDataIn : String) : String;
procedure ClearGrid(GridIn : TADVStringGrid; RowStartIn, RowCountIN : integer);
function GetGUIDName : String;
function GetShipMethodsByMember(MemberNbr : String; SiteID : integer) : TStringList;
function ExtractRecipNameFromEmailAddress(EmailIn : String) : String;
procedure ShowDimForm(CallingForm : TCustomForm);
procedure HideDimForm;
function GetCharsBeforeTab(StringIn : String) : String;
function FindIndexOfPlainTextInHTMList(ListIn : THTMListBox ;PlainText : String) : integer;
function IsPossibleItem(ItemIn : String) : boolean;
function GetStatusName(StatusID : integer) : String;
function GetPriorityName(PriorityID : integer) : String;
function GetListIndexFromIntegerAsObject(ListIn : TStringList; IDIn : integer) : integer;
function GetCategoryName(CtgyID : integer) : String;
function GetCategoryIDFromName(CtgyName : String) : integer;
function GetCategoryFromCtgyID(CtgyID : integer) : TCategory;

implementation

uses duMT2, uMT2GlobalVar;



function IndexFromValues(StringList : TStrings; ValueIn : String) : integer;
var
  i : integer;
begin
    Result:= -1;
    for i:= 0 to Pred(StringList.Count) do
        if StringList.ValueFromIndex[i] = ValueIn then
             begin
               Result:= i;
               break;
             end;

end;




function IsValidInt(StringIn : String) : boolean;
var
  i : integer;
begin
     Result:= True;
     for  i:= 1 to Length(StringIn) do
        if not (StringIn[i] IN ['0','1','2','3','4','5','6','7','8','9']) then
            begin
              Result:= false;
              break;
            end;


end;


function PhoneDataToString(PhoneDataIn : String) : String;
begin
    // this takes a sold string of numbers and returns a formatted display for phones
    Result:= Copy(PhoneDataIn,1,10); //sometime the string includes an extention which we don't want
    if length(Result) = 10 then  //contains an area cod
       begin
           Insert('(',Result,1);
           Insert(') ',Result,5);
           Insert(' ',Result,10);
       end
    else
      // no area code so just add the space
      Insert(' ',Result,4);

end;

procedure ClearGrid(GridIn : TADVStringGrid; RowStartIn, RowCountIn : integer);
var
  x, y : integer;
begin
     With GridIn do
       begin
          for x:= 0 to Pred(ColCOunt) do
             for y:= RowStartIn to RowCount do
                Cells[x,y]:= '';
          RowCount:= RowCOuntIn;
       end;
end;

function GetGUIDName : String;
var
   Guid : TGuid;
begin
     CreateGUID(guid);
     Result:= GUIDToString(Guid);
     Result:= StringReplace(Result,'-','',[rfReplaceAll]);
     Result:= StringReplace(Result,'{','',[rfReplaceAll]);
     Result:= StringReplace(Result,'}','',[rfReplaceAll]);

end;

function GetShipMethodsByMember(MemberNbr : String; SiteID : integer) : TStringList;
var
  sShipVia : String;
begin
    WIth dmMT2.fqSelect do
       try
          Active:= false;
          SQL.Text:= 'SELECT a.carrier_id,a.shipvia,b.sequence';
          SQL.Add('FROM [ASCTrac].dbo.CARRIERACCT a');
          SQL.Add('LEFT OUTER JOIN [ASCTrac].dbo.RTCUSTS b ON(a.shipvia = b.routeid AND b.customerid=:cnbr)');
          SQL.Add('WHERE entity_id = :cnbr');

          Params[0].AsString:= MemberNbr + '-MAIN';

          Active:= true;
          Result:= TStringList.Create;
          if RecordCount > 0 then
            begin
               sShipVia:=  '<font face="segoe ui" size="10" color="clGray">Carrier </font><font face="segoe ui" size="12" color="clBlack">' + Fields[0].AsString + '</font>';
               sShipVia:= sShipVia +  '<font face="segoe ui" size="10" color="clGray">  Route </font><font face="segoe ui" size="12" color="clBlack">' + Fields[1].AsString + '</font>';
               if FIelds[2].AsString <> '' then
                   sShipVia:= sShipVia + '<font face="segoe ui" size="10" color="clGray"> Stop </font><font face="segoe ui" size="12" color="clBlack">' + Fields[2].AsString + '</font>';
             Result.Add(sShipVia);
           end;
       finally
          Active:= false;
       end;
end;

function ExtractRecipNameFromEmailAddress(EmailIn : String) : String;
var
  iPos : integer;
begin
     iPos:= POS('@',EMailIn);
     if iPos > 0 then
        Result:= Copy(EmailIn,1,iPos -1)
     else
       Result:= emailin;
end;

procedure ShowDimForm(CallingForm : TCustomForm);
begin
    frmDim.Width:= CallingForm.Width;
    frmDim.Height:= CallingForm.Height;
    frmDim.left:= CallingForm.Left;
    frmDim.top:= CallingForm.top;
    frmDim.Show;
end;
procedure HideDimForm;
begin
     frmDim.Hide;
end;

function GetCharsBeforeTab(StringIn : String ) : String;
var
  iPos : integer;
begin
     iPOS:= POS(#9,StringIn);
     if iPos > 0 then
        Result:= Copy(StringIn,1,iPos-1)
     else
        Result:= StringIn;
end;

function FindIndexOfPlainTextInHTMList(ListIn : THTMListBox ;PlainText : String) : integer;
var
 iInc : integer;
 begin
     Result:= -1;
     for iInc:= 0 to Pred(ListIn.COunt) do
         if ListIn.TextItems[iInc] = PlainText then
               begin
                 result:= iInc;
                 break;
               end;
 end;


 function IsPossibleItem(ItemIn : String) : boolean;
 begin
     Result:= Length(ItemIn) = 6;
     if Result  then
       Result:= IsValidInt(ItemIn);
 end;

 function GetStatusName(StatusID : integer) : String;
 begin
     case StatusID of
     0: Result:= 'New';
     1: Result:= 'In Progress';
     2: Result:= 'On Hold';
     3: Result:= 'Wating for Client';
     4: Result:= 'Complete';
     end;
 end;

function GetPriorityName(PriorityID : integer) : String;
 begin
     case PriorityID of
     0: Result:= 'Low';
     1: Result:= 'Medium';
     2: Result:= 'High';
     3: Result:= 'Critical';
     end;
 end;

 function GetListIndexFromIntegerAsObject(ListIn : TStringList; IDIn : integer) : integer;
 var
   iDx : integer;
  I: Integer;
 begin
      Result:= -1; //assumes no match by default
      With ListIn do
        for iDx := 0 to Pred(Count) do
          if IDIn = Integer(ListIn.Objects[iDx]) then
             begin
               Result:= iDx;
               Break;
             end;

 end;

 function GetCategoryName(CtgyID : integer) : String;
 var
   iDx : integer;
   MyCategory : TCategory;
 begin
     Result:= '';
     With stlGV_AllCtgy do
       for iDx:= 0 to PRed(Count) do
         begin
          MyCategory:= TCategory(Objects[iDx]);
          if CtgyID = MyCategory.CtgyID then
            begin
               Result:= stlGV_AllCtgy[iDx];
               Break;
            end;
         end;

 end;

 function GetCategoryIDFromName(CtgyName : String) : Integer;
 var
   iDx : integer;
   MyCategory : TCategory;
 begin
     Result:= 0;
     With stlGV_AllCtgy do
       for iDx:= 0 to PRed(Count) do
          if CtgyNAme = Strings[iDx] then
            begin
               MyCategory:= TCategory(stlGV_AllCtgy.Objects[iDx]);
               Result:= MyCategory.CtgyID;
               Break;
            end;

 end;

function GetCategoryFromCtgyID(CtgyID : integer) : TCategory;
 var
   iDx : integer;
   MyCategory : TCategory;
 begin
     Result:= nil;
     With stlGV_AllCtgy do
       for iDx:= 0 to PRed(Count) do
         begin
          MyCategory:= TCategory(Objects[iDx]);
          if CtgyID = MyCategory.CtgyID then
            begin
               Result:= MyCategory;
               Break;
            end;
         end;

 end;




end.
