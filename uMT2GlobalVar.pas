unit uMT2GlobalVar;

interface

uses Classes;

const
  cnstSummaryFile = 'MT2SummaryList.txt';
  cstCL_OpenStatus =  '<IMG SRC="idx:0"><IND x="20">Open';
  cstCL_ClosedStatus =  '<IMG SRC="idx:1"><IND x="20">Closed';
  clOrange = $000080FF;
  cstApollo = 'HTTP://apollo:8080/browse/';
  cstImageStorageURL = '\\FILESRVR1\Common\Images\TV2\';

var
   iGV_EmpId : integer;
   sGV_EmpName : String;
   stlGV_CLCtgy : TStringList; // holds the customer log variables - THis is a name and object = ID list
   stlGV_Dept  : TStringList; //holds the customer departments name and object = ID
   stlGV_Staff : TStringList; //holds the list of employees  name , object  = eomplyee ID
   stlGV_Callers : TStringList;
   bGV_AutoPrint : Boolean; //this is a local (user) setting to determine whether to print logs or not
   sGV_Log_Summary : String;
   stlGV_Log_Summary_List : TStringList;
   stlGV_LogImageList : TStringList;

implementation



end.
