unit uCommon;

interface
uses Classes, AdvObj, BaseGrid, AdvGrid;


procedure LoadOneTimeSettings;
function IsValidInt(StringIn : String) : boolean;
function IndexFromValues(StringList : TStrings;ValueIn : String) : integer;
function GetCategoryName(CategoryID: integer) : String;
function PhoneDataToString(PhoneDataIn : String) : String;
procedure ClearGrid(GridIn : TADVStringGrid; RowStartIn, RowCountIN : integer);

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


procedure LoadOneTimeSettings;
var
  sUserId : String;
begin
    //this is used to load information into memory that would typically gathered only one time in a session
    //the first is items retreived from DBServer

    //this section is for items retrieved from the MT DB
    With dmMT2.qMT_Session do
       try
         //categories
         Active:= false;
         stlGV_CLCtgy.Clear;
         SQL.Text:= 'SELECT category,categoryid FROM [MT2].dbo.tblLogCategories ORDER BY category';
         Active:= true;
         while not EOF do
           begin
             stlGV_CLCtgy.AddObject(Fields[0].AsString,TObject(Fields[1].AsInteger));
             Next;
           end;
         //Departments
         Active:= false;
         stlGV_Dept.Clear;
         SQL.Text:= 'SELECT department,departmentid FROM [MT2].dbo.tblDepartments ORDER BY department';
         Active:= true;
         while not EOF do
           begin
             stlGV_Dept.AddObject(Fields[0].AsString,TObject(Fields[1].AsInteger));
             Next;
           end;
       finally
         Active:= false;
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

function GetCategoryName(CategoryID : integer) : String;
begin
    try
        if stlGV_CLCtgy.IndexOfObject(TObject(CategoryID)) > -1 then
           Result:= stlGV_CLCtgy[stlGV_CLCtgy.IndexOfObject(TObject(CategoryID))]
        else
            Result:= '';
    except
       Result:= 'N/A';
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




end.
