unit fuCreateNewLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, Vcl.StdCtrls,  ShellAPI, ActiveX, ShlObj,
  AdvSmoothPanel, Vcl.ExtCtrls, Vcl.ComCtrls, CurvyControls, htmcombo, AdvMemo,
   uMT2Classes, AdvSmoothListBox,CLIPBRD, DB,
  AdvRichEditorSpellCheck, AdvScrollControl, AdvRichEditorBase, AdvRichEditor,
  TMSSpellCheckCorrectForm, AdvToolBar, AdvToolBarExt, AdvRichEditorToolBar,
  HTMLabel, AdvPolyPager, AdvCombo, Vcl.OleCtnrs, RVScroll, RichView, RVEdit,
  RVStyle, RichViewActions, Vcl.PlatformDefaultStyleActnCtrls, Vcl.Menus,
  Vcl.ActnPopup, RVAPopupActionBar, System.Actions, Vcl.ActnList, Vcl.ActnMan,
  RVFontCombos, RVStyleFuncs, Vcl.ToolWin, W7Classes, W7Buttons, AdvFontCombo,
  HTMListB, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid;
type
   TValidationResults = (vtNoCaller, vtNoCategory, vtNoAssignedTo,vtNoSummary, vtSuccess,vtNoDept);
type
   TEMailResults = (erSuccess, erNoRecipient, erSendError);

type
  TfrmCreateNewLog = class(TForm)
    Panel1: TPanel;
    pnlLog: TAdvSmoothPanel;
    cbCNL_Caller: TComboBox;
    Label7: TLabel;
    cbLogSummary: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cbCNL_Ctgy: TComboBox;
    btnSaveAndNotify: TAdvGlowButton;
    cbDepartment: TComboBox;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    dtpDue: TDateTimePicker;
    Label6: TLabel;
    cbPriority: THTMLComboBox;
    cbStatus: THTMLComboBox;
    odAttachment: TOpenDialog;
    lblTicketNbr: TLabel;
    btnSave: TAdvGlowButton;
    RVStyle1: TRVStyle;
    RVAPopupMenu1: TRVAPopupMenu;
    pnlDescirption: TPanel;
    memDescription: TRichViewEdit;
    pnlFont: TPanel;
    RVFontComboBox1: TRVFontComboBox;
    btnBold: TW7ToolButton;
    RVFontSizeComboBox1: TRVFontSizeComboBox;
    lblShippingMethod: THTMLabel;
    W7ToolButton1: TW7ToolButton;
    W7ToolButton2: TW7ToolButton;
    W7ToolButton3: TW7ToolButton;
    Label8: TLabel;
    Panel2: TPanel;
    CurvyPanel1: TCurvyPanel;
    Label9: TLabel;
    CurvyPanel2: TCurvyPanel;
    Label10: TLabel;
    pnlDrop: TPanel;
    shpDrop: TShape;
    pnlDrop2: TPanel;
    lblAttachments: THTMLabel;
    lblAttachList: THTMLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lbTrackNbrToTrack: THTMListBox;
    lbInvoiceToTrack: THTMListBox;
    sgItemsToTrack: TAdvStringGrid;
    btnInvoices: TAdvGlowButton;
    procedure btnSaveAndNotifyClick(Sender: TObject);
    function ValidateUSerInput : TValidationResults;
    procedure FormCreate(Sender: TObject);
    procedure LoadAttachment(PathAndFileIn : String);
    procedure lblAttachmentsAnchorClick(Sender: TObject; Anchor: string);
    procedure SaveAttachments;
    function SaveAttachmentAndReturnNewFileName(FileIn : String) : String;
    function SaveNewLogSummaryToDB : integer;
    function SaveNewLog : integer;
    procedure SaveLogEntryToDB;
    procedure CheckAttachCount;
    procedure lblAttachListAnchorClick(Sender: TObject; Anchor: string);
    function GetFileType(FileIn : String) : integer;
    procedure btnInvoicesClick(Sender: TObject);
    procedure cbCNL_CtgyChange(Sender: TObject);
    procedure GetShipMethods;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function IsMouseOverDropBox : boolean;
    procedure pnlDrop2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlDrop2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lvTestDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure pnlDrop2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlDrop2DragDrop(Sender, Source: TObject; X, Y: Integer);
    function IsFormModified : boolean;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ResetModifiedFlags;
    procedure lbInvoiceListAnchorClick(Sender: TObject; index: Integer;
      anchor: string);
    function SendNotification : TEmailResults;
    procedure sgItemsToTrackCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure lbInvoiceToTrackAnchorClick(Sender: TObject; index: Integer;
      anchor: string);
    procedure sgItemsToTrackAnchorClick(Sender: TObject; ARow, ACol: Integer;
      Anchor: string; var AutoHandle: Boolean);
    procedure SaveLinks;
    procedure SaveInvoices;
    procedure SaveTrackingNumbers;
    procedure SaveItems;
    procedure SelectUsersDefaultDepartment;

  private
    { Private declarations }
  public
    { Public declarations }
    vNL_Attachments : TAttachments;
    iNL_LogID : integer;
    iNL_ProblemID : integer;
    sNL_CustomerID : String;
    sNL_CustomerName : String;
    stlNL_ShipMethods : TStringList;
    iNL_SiteID : integer;
    bNL_Saved : boolean;
    sCL_RecipEmail : String;

  protected
     procedure WMDropFiles(var Msg: TMessage); message WM_DROPFILES;
  end;

var
  frmCreateNewLog: TfrmCreateNewLog;

implementation

{$R *.dfm}

uses duMT2, uCommon, uMT2GlobalVar, fuAttachList, fuCustomerInvoices ,  uMailAttachmentDragAndDrop,
  dmActions;


procedure TfrmCreateNewLog.btnSaveAndNotifyClick(Sender: TObject);

begin
     Case ValidateUserInput of
     vtSuccess : begin
                    SaveNewLog;
                    if Sender = btnSaveAndNotify then
                      begin
                       Application.ProcessMessages;
                       If SendNotification = erSuccess then
                          dmMT2.LogNotification(iNL_LogID,sCL_RecipEMail);
                      end;
                 end;
     vtNoCaller : MessageDlg('You must select or add a caller before creating a new log,',mtError,[mbOK],0);
     vtNoCategory : MessageDlg('You must select a category before creating a new log,',mtError,[mbOK],0);
     vtNoSummary :  MessageDlg('You must enter a subject before creating a new log,',mtError,[mbOK],0);
     vtNoDept    : MessageDlg('You must select a department before creating a new log,',mtError,[mbOK],0);
     End;



end;

procedure TfrmCreateNewLog.btnInvoicesClick(Sender: TObject);
var
 iInc : integer;
 iRow : integer;
begin
    With TfrmCustomerInvoices.Create(nil) do
      try
        sCI_CustomerNbr:= sNL_CustomerID;
        ShowModal;
        iRow:= 0;
        if ModalResult = mrOK then
         begin
          for iInc:= 0 to Pred(lbInvoicesToAdd.Items.Count)do
             lbInvoiceToTrack.Items.Add('<A HREF="I' + lbInvoicesToAdd.Items[iInc] + '"><font face="Segoe UI" size="10" color="clGray"></u>' + lbInvoicesToAdd.Items[iInc] + '</font></A><ind x="' + IntToStr(lbInvoiceToTrack.ClientWidth - 30) + '"><A HREF="DEL"><IMG SRC="IDX:5"></A>'  );
          for iInc:= 0 to Pred(lbTrackingNbr.Items.Count)do
             lbTrackNbrToTrack.Items.Add('<A HREF="T' + lbTrackingNbr.Items[iInc] + '"><font face="Segoe UI" size="10" color="clGray"></u>' + lbTrackingNbr.Items[iInc] + '</font></A><ind x="' + IntToStr(lbTrackNbrToTrack.ClientWidth - 30) + '"><A HREF="DEL"><IMG SRC="IDX:5"></A>'  );
          for iInc:= 0 to Pred(lbItemsList.Items.Count)do
            begin
             if iRow > 0 then
               sgItemsToTrack.AddRow;
             sgITemsToTrack.Cells[1,iRow]:= Copy(lbItemsList.Items[iInc],1,6);
             sgItemsToTrack.Cells[2,iRow]:= Copy(lbItemsList.Items[iInc],8,Length(lbItemsList.Items[iInc]));
             sgItemsToTrack.Cells[3,iRow]:= '<A HREF="DEL"><IMG SRC="IDX:5"></A>' ;
             Inc(iRow);
            end;
         end;


      finally
        Free;
      end;
end;

procedure TfrmCreateNewLog.cbCNL_CtgyChange(Sender: TObject);
begin
    btnInvoices.Visible:=  cbCNL_Ctgy.ItemIndex in [4,5,6,8];
end;

procedure TfrmCreateNewLog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    CanClose:= bNL_Saved or (not IsFormModified) or (MessageDlg('Do you want to save changes before closing?',mtWarning,[mbYes,mbNo],0) = mrNo);

end;

procedure TfrmCreateNewLog.FormCreate(Sender: TObject);
var
  MyTest : TOLMailDragDrop;
begin
    dtpDue.DateTime:= now;

    vNL_Attachments:= nil;
    lblTicketNbr.Caption:= '';
    lblAttachList.HTMLText.Text:= '';
    btnInvoices.Visible:= false;
    stlNL_ShipMethods:= TStringList.Create;
    DragAcceptFiles(Handle,true);
    bNL_Saved:= false;
    lbInvoiceToTrack.Items.Clear;
   

    //OLE Drag Drop
     TOlMailDragDrop.Create(pnlDrop2);

end;

procedure TfrmCreateNewLog.FormDestroy(Sender: TObject);
begin
    DragAcceptFiles(Handle, False);
end;

procedure TfrmCreateNewLog.FormShow(Sender: TObject);
begin
     GetShipMethods;
     SelectUsersDefaultDepartment;
end;

procedure TfrmCreateNewLog.lbInvoiceListAnchorClick(Sender: TObject;
  index: Integer; anchor: string);
begin
    if copy(Anchor,1,3) = 'DEL' then
       TListBox(Sender).Items.Delete(index);
end;

procedure TfrmCreateNewLog.lbInvoiceToTrackAnchorClick(Sender: TObject;
  index: Integer; anchor: string);
begin
    //delete the line item
    if Anchor = 'DEL' then
       TListBox(Sender).Items.Delete(TListBox(Sender).ItemIndex);

end;

procedure TfrmCreateNewLog.lblAttachListAnchorClick(Sender: TObject;
  Anchor: string);
var
   Attach : TADVSmoothListBoxItem;
   iInc : integer;
   sFileTypeIDX : integer;
   iDx : integer;

procedure RemoveFileAndPath(FileIn : String);
var
  i : integer;
begin
    for i:= 0 to Pred(vNL_Attachments.Count) do
          if vNL_Attachments[i].PathAndFileName = FileIn then
            begin
              vNL_Attachments.Delete(i);
              break;
            end;
end;

begin

    With TfrmAttachList.Create(nil) do
       try
         for iInc:= 0 to Pred(vNL_Attachments.Count) do
             begin
               sFileTypeIDX:= GetFileType(vNL_Attachments[iInc].PathAndFileName);
               case sFileTypeIDX of
               1: iDx:= 14;
               else
                 iDx:= 15;
               end;
               Attach:= lbAttachList.Items.Add;
               Attach.Caption:= '<IMG SRC="idx:' + IntToStr(iDx) + '"><IND x="24"><font face="segoe ui" size="10">' +  vNL_Attachments[iInc].Title + '</font>';
               stlAT_PathAndFile.Add(vNL_Attachments[iInc].PathAndFileName);
             end;
         ShowModal;
         if stlAT_FilesToDelete.Count > 0 then
           begin
             for iInc:= Pred(stlAT_FilesToDelete.Count) downto 0 do
               RemoveFileAndPath(stlAT_FilesToDelete[iInc]);
             CheckAttachCount;

           end;



       finally
         Free;
       end;
end;

procedure TfrmCreateNewLog.lblAttachmentsAnchorClick(Sender: TObject;
  Anchor: string);
begin
  if odAttachment.Execute then
    begin
      LoadAttachment(odAttachment.Filename);
      CheckAttachCount;
    end;
end;

function TfrmCreateNewLog.ValidateUserInput : TValidationResults;
begin
      Result:= vtSuccess;
      If cbCNL_Caller.Text = '' then
        Result:= vtNoCaller;
      if (Result = vtSuccess) and (cbCNL_Ctgy.Text = '') then
        Result:= vtNoCategory;
      if (Result = vtSuccess) and (cbLogSummary.Text = '') then
         Result:= vtNoSummary;
      if (Result = vtSuccess) and (cbDepartment.ItemIndex  = -1) then
         Result:= vtNoDept;
end;

procedure TfrmCreateNewLog.LoadAttachment(PathAndFileIn : String);
var
   NewAttachment : TAttachment;
   testlist : tlist;
   sTitle : String;
begin
       if not Assigned(vNL_attachments) then
        begin
          vNL_Attachments:= TAttachments.Create();
          vNL_Attachments.OwnsObjects:= true;
        end;
       NewAttachment:= TAttachment.Create;
       NewAttachment.PathAndFileName:= PathAndFileIn;
       sTitle:= ChangeFileExt(ExtractFileName(PathAndFileIn),'');
       InputQuery('New Title','Enter a name for the attachment',sTitle);
       NewAttachment.Title:= sTitle;
       vNL_Attachments.Add(NewAttachment);
 end;

 procedure TfrmCreateNewLog.lvTestDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
   Accept:= True;
end;

procedure TfrmCreateNewLog.pnlDrop2DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
      if sGV_OLEFileAdded <> '' then
         try
             LoadAttachment(sGV_OLEFileAdded);
             CheckAttachCount;
         finally
           sGV_OLEFileAdded:= '';
         end;
end;

procedure TfrmCreateNewLog.pnlDrop2DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:= true;
end;

procedure TfrmCreateNewLog.pnlDrop2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   DataObj  : IDataObject;
   FETC : tagFormatETC;
   stg : tagSTGMedium;
   Group : Pointer;
   iInc : integer;
   sFile : String;
   CF_FILECONTENTS :  UINT;

begin
    {   if (button = mbRight) and (ClipBoard.Formats[0] = 49161) then
         begin

            Fetc.cfFormat := CF_FILECONTENTS;
            Fetc.ptd := nil;
            Fetc.dwAspect := DVASPECT_CONTENT;
            Fetc.lindex := -1;
            Fetc.tymed := TYMED_HGLOBAL or TYMED_ISTREAM;
            OLEGetClipboard(DataObj);


            DataObj.GetData(FETC,stg);
            Group:= GlobalLock(stg.hGlobal);
            //for iInc:= 0 to Pred(PFileGroupDescriptorW(Group^).cItems) do
             //     sFile:= PFileGroupDescriptorW(Group^).fgd[iInc].cFileName;
         end;}


end;

procedure TfrmCreateNewLog.pnlDrop2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   t : TPoint;
begin
    GetCursorPos(t);

end;

procedure TfrmCreateNewLog.SaveAttachments;
 var
   iInc : integer;
   sNewFileName : String;
   iSuccessCount : integer;
 begin
     iSuccessCount:= 0;
     if Assigned(vNL_Attachments) then
      for iInc:= 0 to Pred(vNL_Attachments.Count) do
         begin
            sNewFileName:= SaveAttachmentAndReturnNewFileName(vnl_Attachments[iInc].PathAndFileName);
            if sNewFileName <> '' then
               with dmMT2.fqAddAttachment do
                  begin
                    Params[0].AsInteger:= iNL_LogID;
                    Params[1].AsInteger:= iNL_ProblemID;
                    Params[2].AsString:= vNL_Attachments[iInc].Title;
                    Params[3].AsString:= cstAttachmentStorageURL;
                    Params[4].AsString:= sNewFileName;
                    ExecSQL;
                    Inc(iSuccessCount);
                  end;
         end;

 end;

 function TfrmCreateNewLog.SaveAttachmentAndReturnNewFileName(FileIn: string) : String;
 var
    sNewFile : String;
    sExt : String;
    sSource , sDest : String;
 begin
        Result:= GetGUIDName;
        Result:= Result + ExtractFileExt(FileIn);
        sSource:= FileIn;
        sDest:= cstAttachmentStorageURL + Result;

        If not CopyFile(PChar(sSource),PChar(sDest),false) then
           RaiseLastOSERror;



 end;

 function TfrmCreateNewLog.SaveNewLogSummaryToDB : integer;
 begin
     Result:= 0;
     With dmMT2.fqNewLogSummary do
             try
                Params[0].AsString:= sNL_CustomerID;
                Params[1].AsString:= cbCNL_Caller.Text;
                Params[2].AsDateTime:= Now;
                Params[3].AsString:= cbLogSummary.Text;
                Params[4].AsInteger :=  Integer(cbCNL_ctgy.Items.Objects[cbCNL_Ctgy.ItemIndex]);
                Params[5].AsInteger:= TCategory(cbDepartment.Items.Objects[cbDepartment.ItemIndex]).CtgyID;
                Params[6].AsInteger:= cbStatus.ItemIndex;
                Params[7].AsInteger:= cbPriority.ItemIndex;
                Params[8].AsString:= rGV_MTUser.FullName; //assigned to (Can change)
                Params[9].AsInteger:= 0;
                Params[10].AsDateTime:= dtpDue.DateTime;
                Params[11].AsString:= rGV_MTUser.FullName; //Creator (cannot change)
                Active:= true;
                //we need the new Problem ID . This will only work as an insert, otherwise it returns 0
                Result:= Fields[0].AsInteger;
                iNL_LogID:= Result;
              finally
                //the reason for failure would be not having a valid department or caegory number
                Active:= false;
              end;
 end;

procedure TfrmCreateNewLog.SaveLogEntryToDB;
var
   strmDescription : TStringStream;

begin

     With dmMT2.fqNewLogEntry do
             try
                strmDescription:= TStringStream.Create;
                memDescription.SaveRTFToStream(strmDescription,false);

                Params[0].AsInteger:= iNL_LogID;
                Params[1].AsInteger:= INteger(cbDepartment.Items.Objects[cbDepartment.ItemIndex]);
                Params[2].LoadFromStream(strmDescription,ftMemo);
                Params[3].AsInteger:= INteger(cbCNL_ctgy.Items.Objects[cbCNL_Ctgy.ItemIndex]);
                Params[4].AsString:= strmDescription.DataString;
                Params[5].AsString:= '';
                Params[6].AsInteger:= 0;
                Params[7].AsInteger:= 0;
                Params[8].Asinteger:= 0;
                Params[9].AsDateTime:= Now;
                Params[10].AsString:= rGV_MTUser.UserName;
                Active:= true;
                //we need the new Problem ID . This will only work as an insert, otherwise it returns 0
                iNL_ProblemID:= Fields[0].AsInteger;

              finally
                //the reason for failure would be not having a valid department or caegory number
                  begin
                     Active:= false;
                     strmDescription.Free;
                  end;
              end;
 end;

 function TfrmCreateNewLog.SaveNewLog : integer;
 begin
       Result:= SaveNewLogSummaryToDB;
       SaveLogEntryToDB;
       SaveAttachments;
       SaveLinks;
       lblTicketNbr.Caption:= 'Ticket : ' + IntToStr(Result);
       ResetModifiedFlags;
       dmMT2.AddToActivityLog(Result,0,'Created new log',iNL_ProblemID);
       iNL_LogID:= Result;
       bNL_Saved:= true;

 end;

 procedure TfrmCreateNewLog.CheckAttachCount;
 begin
      if vNL_Attachments.Count = 0 then
         lblAttachList.HTMLText.Clear
      else
         lblAttachList.HTMLText.Text:= '<A HREF="attachlist"><font face="segoe UI" size="10">' + IntToStr(vNL_Attachments.Count) + ' attachments</font></a>';
 end;

 function TfrmCreateNewLog.GetFileType(FileIn: string) : integer;
 var
    sExt : String;
 begin
       sExt:= ExtractFileExt(FileIn);
       if (POS('jpg',lowercase(sExt)) > 0) OR (POS('png',lowercase(sExt)) > 0) or (POS('bmp',lowercase(sExt)) > 0) then
         Result:= 1
       else
         Result:= 0;

 end;

 procedure TfrmCreateNewLog.GetShipMethods;

 begin
      stlNL_ShipMethods.Assign(GetShipMethodsByMember(sNL_CustomerID,iNL_SiteID));
      if stlNL_ShipMethods.Count > 0 then
        lblShippingMethod.HTMLText.Text:= stlNL_ShipMethods[0]
      else
        lblShippingMethod.HTMLText.Text:= '';


 end;

procedure TfrmCreateNewLog.WMDropFiles(var Msg: TMessage);
var
  hDrop: THandle;
  FileCount: Integer;
  NameLen: Integer;

  sFile: string;

begin
 if IsMouseOverDropBox then
      begin
       hDrop:= Msg.wParam;
       FileCount:= DragQueryFile (hDrop , $FFFFFFFF, nil, 0);
       NameLen:= DragQueryFile(hDrop, 0, nil, 0) + 1;
       SetLength(sFile, NameLen);
       DragQueryFile(hDrop, 0, Pointer(sFile), NameLen);
       DragFinish(hDrop);
       LoadAttachment(sFile);
       CheckAttachCount;
      end;

end;

function TfrmCreateNewLog.IsMouseOverDropBox : boolean;
var
  ptMouse, ptClient : TPoint;
begin
     Application.ProcessMessages;
     If GetCursorPos(ptMouse) then
       begin
         ptClient:= pnlDrop.ClientOrigin;
         Result:= (ptMouse.X >= ptClient.x) and (ptMouse.X <= ptClient.X + pnlDrop.Width) and (ptMouse.y >= ptClient.Y) and (ptMouse.Y <= ptClient.Y + pnlDrop.Height);
       end
     else
       RaiseLastOSError;

end;

function TfrmCreateNewLog.IsFormModified : boolean;
begin

       Result:= cbCNL_Caller.Text <> '';
       if not Result then
          Result:= cbLogSummary.Text <> '';
       if not Result then
          Result:= cbCNL_Ctgy.ItemIndex > -1;
       if not Result then
         Result:= cbDepartment.ItemIndex > -1;
       if not Result then
          Result:= memDescription.Modified;
       if not Result and Assigned(vNL_Attachments) then
         Result:= vNL_Attachments.Count > 0;


end;

procedure TfrmCreateNewLog.ResetModifiedFlags;
begin
    memDescription.Modified:= false;

end;

function TfrmCreateNewLog.SendNotification : TEmailResults;
var

  sMessage : String;
begin
      // see if the department has an email address
      Result:= erSuccess;
      sCL_RecipEMail:= dmMT2.GetDeptEMail(cbDepartment.Text);
      if  sCL_RecipEMail <> '' then
        begin
           dmMT2.idMessage1.From.Address:= 'noreply@wddc.com' ;
           dmMT2.idMessage1.From.Name := 'MT Ticketing System';
           dmMT2.idMessage1.Subject := 'MT Ticket ' + IntToStr(iNL_LogID) + ' has been assigned to ' + cbDepartment.Items.Create[cbDepartment.ItemIndex];
           dmMT2.IdMessage1.ContentType:= 'text/html';
           dmMT2.idMessage1.Body.Text := '<html><body>' + sNL_CustomerID + ' - ' + sNL_CustomerName + '<br><br>' + 'Log <A href="' + PAramStr(0) + '">'  + IntTOStr(iNL_LogID) + '</A><br><br>' + cbLogSummary.Text + '</body></html>';
           dmMT2.idMessage1.Recipients.Add;
           dmMT2.idMessage1.Recipients[0].Text := sCL_RecipEMail;
             // DO IT
           try
              try
                 dmMT2.idSMTP1.Connect;
                 dmMT2.idSMTP1.Send(dmMT2.idMessage1);
              except on E: Exception do
                 Result:= erSendError;
              end;
           finally
              dmMT2.idSMTP1.Disconnect;
           end;
        end
      else
        Result:= erNoRecipient;

end;


procedure TfrmCreateNewLog.sgItemsToTrackAnchorClick(Sender: TObject; ARow,
  ACol: Integer; Anchor: string; var AutoHandle: Boolean);
begin
   if ACol = 3 then
     if ARow > 0 then
         TADVStringGrid(Sender).RemoveRows(ARow,1)
     else
        TADVStringGrid(Sender).ClearRows(ARow,1);


end;

procedure TfrmCreateNewLog.sgItemsToTrackCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
   CanEdit:= ACol = 0;
end;

procedure TfrmCreateNewLog.SaveLinks;
begin
      SaveInvoices;
      SaveTrackingNumbers;
      SaveItems;
end;


procedure TfrmCreateNewLog.SaveInvoices;
var
  iInc : integer;
  sInvoice : String;
begin
      for iInc:= 0 to PRed(lbInvoiceToTrack.Items.Count) do
         begin
             sInvoice:= lbInvoiceToTrack.TextItems[iInc];
             with dmMT2.fqUpdateInvoice do
               begin
                 Params[0].AsInteger:= iNL_LogID;
                 Params[1].AsString:= sInvoice;
                 ExecSQL;
               end;
         end;

end;

procedure TfrmCreateNewLog.SaveTrackingNumbers;
var
   iInc : integer;
   sTrackNbr : String;
begin
      for iInc:= 0 to PRed(lbTrackNbrToTrack.Items.Count) do
         begin
             sTrackNbr:= lbTrackNbrToTrack.TextItems[iInc];
             with dmMT2.fqUpdateTrackingNumber do
               begin
                 Params[0].AsInteger:= iNL_ProblemID;
                 Params[1].AsString:= sTrackNbr;
                 ExecSQL;
               end;
         end;

end;

procedure TfrmCreateNewLog.SaveItems;
var
 iInc : integer;
 sItemCode : String;
begin
    //
     for iInc:= 0 to Pred(sgItemsToTrack.RowCount) do
         begin
             sItemCode:= sgItemsToTrack.Cells[1,iInc];
             if (Length(sItemCode) = 6) and IsValidInt(sItemCode) then
                 with dmMT2.fqUpdateItems do
                    begin
                      Params[0].AsInteger:= iNL_LogID;
                      Params[1].AsInteger:= StrToInt(sITemCode);
                      Params[2].AsString:= sgITemsToTrack.Cells[2,iInc];
                      Params[1].AsInteger:= StrToIntDef(sgItemsToTrack.Cells[0,iInc],1);
                      ExecSQL;
                    end;
         end;

end;

procedure TfrmCreateNewLog.SelectUsersDefaultDepartment;
var
  iDeptID : integer;
  iDx , iResult: Integer;
begin
      iDeptID:= dmMT2.GetUserAssignedDeptID;
      iResult:= -1;
      if iDeptID > 0 then
         for iDx:= 0 to PRed(cbDepartment.Items.Count) do
           if iDeptID = Integer(cbDepartment.Items.Objects[iDx]) then
              begin
                iResult:= iDx;
                BReak;
              end;
      cbDepartment.ItemIndex:= iResult;




end;

end.
