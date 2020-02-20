unit uMT2GlobalVar;

interface

uses Classes, uMT2Classes, Generics.Collections;

const
  cnstSummaryFile = 'MT2SummaryList.txt';
  cstCL_OpenStatus =  '<IMG SRC="idx:0"><IND x="20">Open';
  cstCL_ClosedStatus =  '<IMG SRC="idx:1"><IND x="20">Closed';
  clOrange = $000080FF;
  cstImageStorageURL = '\\FILESRVR1\Common\Images\TV2\';
  cstAttachmentStorageURL = '\\FILESRVR1\Applications\Network Applications\MT2\Attachments\';
  cstAttachmentStorageURLTemp = '\\FILESRVR1\Applications\Network Applications\MT2\Attachments\Temp\';
  cstRootInvoiceURL = '\\RPRTSRVR\pdf_invoices\Additional\';
  //cstAttachmentStorageURL = 'D:\Attach\';
  UseDB = 'Use [MTTest];'  ;
  cnstDomain = 'wddc.com';


  NewColor = '#FE8000';
  InProgressColor='#0080FF';
  OnHoldColor='#F20000';
  WaitingForClientColor='#BF0060';
  CompleteColor='#74D810';

  StatusColors :  array [0..4] of String = (NewColor,InProgressColor,OnHoldColor,WaitingForClientColor,CompleteColor);

var

   stlGV_Callers : TStringList;
   bGV_AutoPrint : Boolean; //this is a local (user) setting to determine whether to print logs or not
   sGV_Log_Summary : String;
   stlGV_Log_Summary_List : TStringList;
   stlGV_LogImageList : TStringList;
   sGV_OLEFileAdded : String;
   rGV_MTUser : TMTUser;
   stlGV_ActiveCtgy : TStringList;
   stlGV_AllCtgy  : TStringList;
   stlGV_CLDept : TStringList;
   stlGV_DeptEmail : TStringList;
   lstGV_UnAckList : TList<TMTNotification>;
   dtGV_LastUpdateCheck : TDateTime;

implementation



end.
