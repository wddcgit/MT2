unit uMT2GlobalVar;

interface

uses Classes;

var
   iGV_EmpId : integer;
   sGV_EmpName : String;
   stlGV_ShipMethod : TStringList; //holds the shipping method which only needs to be loaded once
   stlGV_CLCtgy : TStringList; // holds the customer log variables - THis is a name and object = ID list
   stlGV_Dept  : TStringList; //holds the customer departments name and object = ID
   stlGV_Staff : TStringList; //holds the list of employees  name , object  = eomplyee ID
   stlGV_Pickers : TStringList; //this goes in a userid=username name =value pariing
   bGV_AutoPrint : Boolean; //this is a local (user) setting to determine whether to print logs or not

implementation



end.
