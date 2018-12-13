unit fuShippingMemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, AdvEdit,
  Vcl.ComCtrls, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, AdvGlowButton,
  AdvOfficeButtons;

type
  TfrmShippingMemo = class(TForm)
    Label1: TLabel;
    pnlTop: TPanel;
    Label2: TLabel;
    cbIssued: TComboBox;
    gbSupplier: TGroupBox;
    gbReturns: TGroupBox;
    eSMNbr: TAdvEdit;
    cbSupplier: TComboBox;
    Label3: TLabel;
    ePSNbr: TAdvEdit;
    eCarrier: TAdvEdit;
    eAttention: TAdvEdit;
    eWaybill: TAdvEdit;
    dtpReceived: TDateTimePicker;
    Label4: TLabel;
    eAddress: TAdvEdit;
    eAuthNbr: TAdvEdit;
    eShipMethod: TAdvEdit;
    eWaybill2: TAdvEdit;
    eAttention2: TAdvEdit;
    eRTV: TAdvEdit;
    bgAddItem: TGroupBox;
    cbLocation: TComboBox;
    Label5: TLabel;
    cbCode: TComboBox;
    Label6: TLabel;
    eItemNbr: TAdvEdit;
    eItemDesc: TAdvEdit;
    eLotNbr: TAdvEdit;
    dtpWatch: TDateTimePicker;
    eQty: TAdvEdit;
    eUCost: TAdvEdit;
    eECost: TAdvEdit;
    btnAdd: TAdvGlowButton;
    sgItems: TAdvStringGrid;
    memComments: TMemo;
    Label8: TLabel;
    chkCLosed: TAdvOfficeCheckBox;
    ePONbr: TAdvEdit;
    btnSave: TAdvGlowButton;
    pnlClosed: TPanel;
    Label9: TLabel;
    cbCLosedBy: TComboBox;
    Label10: TLabel;
    dtpClosed: TDateTimePicker;
    chkWatch: TAdvOfficeCheckBox;
    btnSMLookUp: TAdvGlowButton;
    btnSearch: TAdvGlowButton;
    btnNew: TAdvGlowButton;
    procedure FormCreate(Sender: TObject);
    procedure GetReturnCodes;
    procedure GetLocationCodes;
    procedure FormShow(Sender: TObject);
    function ValidateItem(ItemCode : String; ShowResult : boolean) : String;
    procedure eItemNbrKeyPress(Sender: TObject; var Key: Char);
    procedure eItemNbrExit(Sender: TObject);
    procedure GetSMID(SMID : integer);
    procedure GetSMIDItems(SMID : integer);
    procedure eSMNbrKeyPress(Sender: TObject; var Key: Char);
    function SaveSM(SMIDin : integer) : integer;
    procedure btnAddClick(Sender: TObject);
    procedure chkCLosedClick(Sender: TObject);
    procedure ClearLineItemPanel ;
    procedure sgItemsAnchorClick(Sender: TObject; ARow, ACol: Integer;
      Anchor: string; var AutoHandle: Boolean);
    procedure FillSuppliers;
    procedure FormDestroy(Sender: TObject);
    function SaveLineItems(SMID : integer) : integer;
    function GetNextRID : integer;
    procedure eUCostChange(Sender: TObject);
    procedure eECostChange(Sender: TObject);
    procedure chkWatchClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSMLookUpClick(Sender: TObject);
    procedure ClearAll(SMIDIN : integer);
    procedure btnSearchClick(Sender: TObject);
    procedure eQtyChange(Sender: TObject);
    function NeedSaving : boolean;
    procedure btnNewClick(Sender: TObject);
    function SaveThisSM : integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    bSM_ValidItem : boolean; // used as a form variable to validate all items before they can be added
    iSM_SMID : integer; // hold the currently working shipping memo , default is 0 (no memo)
    iSM_RID : integer; // hold the returnid of the currently selected item.
    stlSM_Suppliers : TStringLIst;
    bSM_LoadedSM : boolean;
    sSM_LastError : String;
  end;

var
  frmShippingMemo: TfrmShippingMemo;

implementation

{$R *.dfm}

uses duMT2, uMT2GlobalVar, uCommon, fuSMSearch;

procedure TfrmShippingMemo.btnAddClick(Sender: TObject);
var
   iRow : integer;
   i : integer;
begin
   // this can either update an existing row or add a new one
   iRow:= -1;
   ActiveControl:= sgItems;
   WIth sgItems do
    begin
      if iSM_RID = 0 then //this is a new item , there amy be no items in the fist line if this is true, so check
           begin
              if Cells[0,1] = '' then
                iRow:= 1
              else
                begin
                  AddRow;
                  iRow:= Pred(RowCount);
                end;
              iSM_RID:= iRow; // this assigns a temporary RID number to the record. Permanent RID numbers are in the xxxx range. Temp are x-xx
           end
      else
        for i:= 1 to Pred(RowCount) do
           if Integer(Objects[0,i]) = iSM_RID then
              begin
                iRow:= i;
                break;
              end;
      if iRow > 0 then
         begin
               Cells[0,iRow]:= cbLocation.Text; //location
               //the code is a number. Its stored in the cbCode drop down in a name= string, number = object
               if cbCode.ItemIndex > -1 then
                    Cells[1,iRow]:= cbCode.Items[cbCode.ItemIndex];
               Cells[2,iRow]:= eItemNbr.Text;
               //place holder for description
               Cells[3,iRow]:= eItemDesc.Text; // hate this because it needs to do a lookup for each description for each line item
               Ints[4,iRow]:= eQty.IntValue;
               Floats[6,iRow]:= eECost.FloatValue;
               if chkWatch.Checked then
                   Cells[7,iRow]:= FormatDateTIme('mm/dd/yyyy',dtpWatch.DateTime)
               else
                   Cells[7,iRow]:= '';
               Cells[8,iRow]:= eLotNbr.Text;
               Cells[9,iRow]:= '<A href="edit1"><IMG SRC="idx:2"></A><IND x="20"><A href="remove1"><IMG SRC="idx:1"></A>';
               //store the returnid in the objects in COl 0
               Objects[0,iRow]:= TObject(iSM_RID);
         end;
    end;

    //clear the line out
    ClearLineItemPanel;

end;

procedure TfrmShippingMemo.btnNewClick(Sender: TObject);
begin
   if NeedSaving then
      if SaveThisSM = 0 then
         ClearAll(0)
      else
        begin
          MessageDlg('Unable to save pending shipping memo. The error has been commited to the error log.' + #13 + 'The appropriate authorities have been notified.' + #13 + 'Please stand by for their immenent arrival.',mtError,[mbOK],0);
          if sSM_LastError <> '' then
           sSM_LastError:= dmMT2.AddToErrorLog('Save shipping memo',sSM_LastError);
        end;

end;

procedure TfrmShippingMemo.btnSaveClick(Sender: TObject);
begin
    if SaveThisSM = 0 then
       begin
          ClearAll(0);
          MessageDlg('Shipping Memo saved',mtInformation,[mbOK],0);
       end
   else
     begin
       MessageDlg('Unable to save shipping memo. The error has been commited to the error log.' + #13 + 'The appropriate authorities have been notified.' + #13 + 'Please stand by for their immenent arrival.',mtError,[mbOK],0);
       if sSM_LastError <> '' then
           sSM_LastError:= dmMT2.AddToErrorLog('Save shipping memo',sSM_LastError);

     end;

end;

procedure TfrmShippingMemo.btnSearchClick(Sender: TObject);
begin
     WIth TfrmSMSearch.Create(nil) do
        try
          ShowModal;
          if ModalResult = mrOK then
            begin
                eSMNbr.IntValue:= iSMS_SMID;
                btnSMLookUpClick(nil);
            end;
        finally
           Free;
        end;
end;

procedure TfrmShippingMemo.btnSMLookUpClick(Sender: TObject);
var
  i : integer;
begin
  if (eSMNbr.IntValue > 0) then
    If dmMT2.CheckForShippingMemo(eSMNbr.IntValue) then
       GetSMID(eSMNbr.IntValue)
    else
       ClearAll(eSMNbr.IntValue);


end;

procedure TfrmShippingMemo.chkCLosedClick(Sender: TObject);
begin
   pnlClosed.Visible:= chkClosed.Checked;
end;

procedure TfrmShippingMemo.chkWatchClick(Sender: TObject);
begin
   dtpWatch.Visible:= chkWatch.Checked;
end;

procedure TfrmShippingMemo.eECostChange(Sender: TObject);
begin
    try
    if (eECost.Focused) and (eQty.IntValue <> 0) then
        eUCost.FloatValue:= eECost.FloatValue / eQty.IntValue;
    except
        eUCost.FloatValue:= 0;
    end;
end;

procedure TfrmShippingMemo.eItemNbrExit(Sender: TObject);
begin
     bSM_ValidItem:= ValidateItem(IntTOStr(eITemNbr.IntValue),True) <> '';
end;

procedure TfrmShippingMemo.eItemNbrKeyPress(Sender: TObject; var Key: Char);

begin
    if Key = #13 then
         ValidateItem(IntTOStr(eITemNbr.IntValue),True);

end;

procedure TfrmShippingMemo.eQtyChange(Sender: TObject);
begin
      if eQty.Focused then
         try
             eEcost.FloatValue:= eQty.IntValue * eUCost.FloatValue;
         except

         end;
end;

procedure TfrmShippingMemo.eSMNbrKeyPress(Sender: TObject; var Key: Char);

begin
   if (Key = #13) and (eSMNbr.IntValue > 0) then
       if dmMT2.CheckForShippingMemo(eSMNbr.IntValue) then
           GetSMID(eSMNbr.IntValue)
        else
             ClearAll(eSMNbr.IntValue);
end;

procedure TfrmShippingMemo.eUCostChange(Sender: TObject);
begin

    //only automatically change if the user is actively modifiying this field
    if eUCost.Focused then
        eECost.FloatValue:= eUCost.FloatValue * eQty.IntValue;

end;

procedure TfrmShippingMemo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if NeedSaving and (MessageDlg('Save this shipping memo before closing?',mtConfirmation,[mbYes,mbNo],0) = mrYes) and (SaveThisSM = 0) then
         ClearAll(iSM_SMID);
end;

procedure TfrmShippingMemo.FormCreate(Sender: TObject);
begin
     dtpReceived.DateTime:= Now;
     dtpWatch.DateTIme:= Now;
     dtpClosed.DateTime:= Now;
     iSM_SMID:= 0;
     stlSM_Suppliers:= TStringList.Create;
     bSM_LoadedSM:= false;
     sSM_LastError:= '';

end;

procedure TfrmShippingMemo.FormDestroy(Sender: TObject);
begin
   stlSM_Suppliers.Free;
end;

procedure TfrmShippingMemo.FormShow(Sender: TObject);
begin
    if cbCode.Items.Count = 0 then
       GetReturnCodes;
    if cbLocation.Items.Count = 0 then
       GetLocationCodes;
    if cbClosedBy.Items.Count = 0 then
       cbClosedBy.Items.Assign(stlGV_Staff);
    if cbSupplier.Items.Count = 0 then
        FillSuppliers;
end;

procedure TfrmShippingMemo.GetReturnCodes;
begin
    With dmMT2.qMT_Select do
      try
        DisableControls;
        Active:= false;
        SQL.Text:= 'USE [MULTITRACKING]';
        SQL.Add('SELECT  CodeId,CodeDesc FROM dbo.tblReturnCodes ORDER BY CodeID');
        Active:= true;
        cbCode.Items.Clear;
        while not EOF do
          begin
            cbCode.Items.AddObject(Fields[0].AsString + '. ' + Fields[1].AsString,TObject(Fields[0].AsInteger));
            Next;
          end;

      finally
        begin
          Active:= false;
          EnableControls;
        end;

      end;
end;

procedure TfrmShippingMemo.GetLocationCodes;
begin
    With dmMT2.qDB_Select do
      try
        DisableControls;
        Active:= false;
        SQL.Text:= 'USE [WDDC]';
        SQL.Add('SELECT LOCNCODE FROM IV40700 ORDER BY LOCNCODE');
        Active:= true;
        cbLocation.Items.Clear;
        while not EOF do
          begin
            cbLocation.Items.Add(Fields[0].AsString);
            Next;
          end;

      finally
        begin
          Active:= false;
          EnableControls;
        end;

      end;
end;

function TfrmShippingMemo.ValidateItem(ItemCode: string; ShowResult : boolean) : String;
begin
       With dmMT2.qDB_ItemLookup do
         try
           DisableControls;
           Active:= false;
           ParamByName('itm1').AsString:= ItemCode;
           Active:= true;
           if RecordCount = 0 then
              Result:= ''
           else
              Result:= Fields[0].AsString;

          if ShowResult then
              begin
               If Result = '' then
                   eItemDesc.Text:= 'Invalid WDDC Code'
               else
                 begin
                   eItemDesc.Text:= Result;
                   eUCost.FloatValue:= Fields[1].AsCurrency;
                 end;
              end;
         finally
           begin
             Active:= false;
             EnableControls;
           end;
         end;
end;

procedure TfrmShippingMemo.GetSMID(SMID: Integer);
var
  iClosedBy : integer;
begin
   // retreives the smid and fills the info
   //since this query retrieves all the fields from the table, the quiery uses the SELECT * statement. Which means we have to name the fields
   With dmMT2.qMT_SelectShippingMemo do
      try
        Active:= false;
        DisableControls;
        ParamByName('smid').AsInteger:= SMID;
        Active:= true;
        if RecordCount > 0 then
           begin
             iSM_SMID:= SMID;
             if stlSM_Suppliers.IndexOf(FIeldByName('supplier').AsString) > -1 then
                cbSupplier.ItemIndex:= stlSM_Suppliers.IndexOf(FIeldByName('supplier').AsString);
             ePSNbr.Text:= FieldByName('Invoice').AsString;
             cbIssued.Text:= FieldBYName('IssuedBy').AsString;
             eCarrier.Text:= FieldByName('carrier').AsString;
             eWaybill.Text:= FieldByName('waybill').AsString;
             dtpReceived.DateTime:= FieldByName('datereceived').AsDateTime;
             eAttention.Text:= FieldByName('attention').AsString;
             eAddress.Text:= FieldByName('address').AsString;
             eAuthNbr.Text:= FieldByName('authorizationcode').AsString;
             eShipMethod.Text:= FieldByName('shipmethod').AsString;
             ePONbr.Text:= FieldByName('purchaseorder').AsString;
             eWayBill2.Text:= FieldByName('waybill2').AsString;
             eAttention2.Text:= FieldByName('attention2').AsString;
             eRTV.Text:= FieldByName('rtv').AsString;
             memComments.Lines.Text:= FieldByName('comments').AsString;
             chkCLosed.Checked:= FieldByName('closed').AsBoolean;
             chkClosedClick(nil);
             if not FieldBYName('closeddate').IsNull then
                  dtpClosed.DateTime:= FieldByName('closeddate').AsDateTime;
             //the system stores the employee number in a char field. So we have to make sure this is a valid numer
             iClosedBy:= StrToIntDef(FieldByName('closedby').AsString,0);
             cbClosedBy.ItemIndex:= cbClosedBy.Items.IndexOfObject(TObject(iClosedBy));
             bSM_LoadedSM:= true; // the user now has a loaded doucment
           end;
      finally
        begin
          Active:= false;
          Enablecontrols;
        end;

      end;
    //now you want to show the line items
    GetSMIDItems(SMID);

end;

procedure TfrmShippingMemo.GetSMIDItems(SMID: Integer);
var
  iRow : integer;

begin
     //FIELD IN ORDER shippingmemo,disposition,code,product,quantity,extcost,returnid,watchdate,lotnumber
     With sgItems do
       try
         BeginUpdate;
         ClearGrid(sgItems,1,2);
         iRow:= 1;
         With dmMT2.qMT_SelectSMIDItems do
            try
              Active:= false;
              DisableControls;
              ParamByName('smid').AsInteger:= SMID;
              Active:= true;
              while not EOF  do
                begin
                  if iRow > 1 then
                     AddROw;
                  Cells[0,iRow]:= Fields[1].AsString; //location

                  //the code is a number. Its stored in the cbCode drop down in a name= string, number = object
                  if cbCode.Items.IndexOfObject(TObject(Fields[2].AsString)) > -1 then
                    Cells[1,iRow]:= cbCode.Items[cbCode.Items.IndexOfObject(TObject(Fields[2].AsString))];
                  Cells[2,iRow]:= Fields[3].AsString;
                  //place holder for description
                  Cells[3,iRow]:= ValidateItem(Fields[3].AsString,false); // hate this because it needs to do a lookup for each description for each line item
                  Ints[4,iRow]:= Fields[4].AsINteger;
                  Floats[6,iRow]:= Fields[5].AsCurrency;
                  if not Fields[7].IsNull then
                     Cells[7,iRow]:= FormatDateTIme('mm/dd/yyyy',Fields[7].AsDateTime);
                  Cells[8,iRow]:= Fields[8].AsString;
                  //store the returnid in the objects in COl 0
                  Objects[0,iRow]:= TObject(FIelds[6].AsInteger);
                  Cells[9,iRow]:= '<A href="edit1"><IMG SRC="idx:2"></A><IND x="20"><A href="remove1"><IMG SRC="idx:1"></A>';
                  Next;
                  Inc(iRow);
                end;
            finally
               Active:= false;
               EnableControls;
            end;
       finally
         EndUpdate;
       end;
end;

function TfrmShippingMemo.SaveSM(SMIDin: Integer) : integer;
var
  sSupplier : String;
begin
      //the shipping memo has to be unique, but it is not an identity field. So if the supplied shipping memo number is 0, then
      // look up the highest number and add one.
      //this query will either edit the existing number or append a new one
      Result:= 0;
      if cbSupplier.ItemIndex > -1 then
         sSupplier:= stlSM_Suppliers[cbSupplier.ItemIndex]
      else
         sSupplier:= '';

      if SMIDIn = 0 then //this is a new SMID, so get the number the user entered
        begin
         SMIDIn:= eSMNbr.IntValue;
         iSM_SMID:= SMIDIn; //this should set the globale variable which should match
        end;

      if SMIDIn > 0 then

      With dmMT2.qMT_InsertSM do
       try
         ParamByName('smid').AsInteger:= SMIDIn;
         ParamByName('isby').AsString:= Copy(cbIssued.Text,1,50);
         ParamByName('iv01').AsString:= Copy(ePSNbr.Text,1,20);
         ParamByName('car1').AsString:= Copy(eCarrier.Text,1,20);
         ParamByName('wyb1').AsString:= Copy(eWaybill.Text,1,20);
         ParamByName('drcv').AsDateTime:= dtpReceived.DateTime;
         ParamByName('att1').AsString:= Copy(eAttention.Text,1,30);
         ParamByName('addr').AsString:= COpy(eAddress.Text,1,50);
         ParamByName('acod').AsString:= Copy(eAuthNbr.Text,1,20);
         ParamByName('smtd').AsString:= Copy(eShipMethod.Text,1,20);
         ParamByName('wyb2').AsString:= Copy(eWayBill2.Text,1,20);
         ParamByName('att2').AsString:= Copy(eAttention2.Text,1,30);
         ParamByName('rtv1').AsString:= Copy(eRTV.Text,1,20);
         ParamByName('cmnt').AsString:= memComments.Lines.Text;
         ParamByName('sup1').AsString:= Copy(sSupplier,1,10);
         ParamByName('po1').AsString:= Copy(ePONbr.Text,1,15);
         ParamByName('clsd').AsBoolean:= chkClosed.Checked;
         ParamByName('cby1').AsString:= cbClosedBy.Text;
         ParamByName('cdt1').AsDateTime:= dtpClosed.DateTime;
         ParamByName('ierr').AsBoolean:= false;
         Execute;
         Result:= SMIDIn;
         bSM_LoadedSM:= false; //indicates that any previously loaded SM will be saved
       except on E: Exception do
        begin
          Result:= 0;
          sSM_LastError:= E.Message;
        end;
       end;

end;

procedure TfrmShippingMemo.sgItemsAnchorClick(Sender: TObject; ARow,
  ACol: Integer; Anchor: string; var AutoHandle: Boolean);
var
  iRID : integer;
begin
   if Anchor = 'edit1' then
    With sgItems do
      begin
         cbLocation.ItemIndex:=  cbLocation.Items.IndexOf(Cells[0,ARow]) ; //location
         //the code is a number. Its stored in the cbCode drop down in a name= string, number = object
         cbCode.ItemIndex:=    cbCode.Items.IndexOf(Cells[1,ARow]);
         eItemNbr.Text:=   Cells[2,ARow];
         //place holder for description
         eItemDesc.Text:= Cells[3,ARow]; // hate this because it needs to do a lookup for each description for each line item
         eQty.IntValue:= Ints[4,ARow];
         eECost.FloatValue:= Floats[6,ARow];
         try
         chkWatch.Checked:= Cells[7,ARow] <> '';
         chkWatchClick(nil);
         if chkWatch.Checked then
              dtpWatch.DateTime:= VarToDateTime(Cells[7,ARow]);
         except
           dtpWatch.DateTime:= Now;
         end;
         eLotNbr.Text:= Cells[8,ARow];
         iSM_RID:= Integer(Objects[0,ARow]);
         btnAdd.ImageIndex:= 12;
      end;
    if Anchor = 'remove1' then
     With sgITems do
       begin
          //if this is a permanent record ( RecordID > 100) remove from DB
          iRID:= INteger(Objects[0,ARow]);
          if (iRID > 200) and (MessageDlg('This is an existing line item record. Are you sure you want to permanently delete it?',mtConfirmation,[mbYes,mbNo],0) = mrYes)  then //this is a permanent record
           begin
               WIth dmMT2.qMT_Exec do
                  try
                    SQL.Text:= 'DELETE FROM [MultiTracking].dbo.tblReturnsDescriptions WHERE ReturnID = :rid1';
                    ParamByName('rid1').AsInteger:= iRID;
                    Execute;
                    //remove the row
                    if ARow > 1 then
                       RemoveRows(ARow,1)
                    else
                       ClearRows(ARow,1);
                  except
                  end;
           end
          else
              //remove the row
              begin
               if ARow > 1 then
                   RemoveRows(ARow,1)
               else
                   ClearRows(ARow,1);
              end;



       end;
end;

procedure TfrmShippingMemo.ClearLineItemPanel;
begin
    iSM_RID:= 0;
    cbLocation.ItemIndex:= -1;
    cbCode.ItemIndex:= -1;
    eItemNbr.Text:= '';
    eItemDesc.Text:= '';
    eLotNbr.Text:= '';
    dtpWatch.DateTime:= Now;
    eQty.IntValue:= 0;
    eUCost.FloatValue:= 0;
    eECost.FloatValue:= 0;
    btnAdd.ImageIndex:= 7;
    chkWatch.Checked:= false;
    chkWatchClick(nil);
    dtpWatch.DateTime:= Now;
end;

procedure TfrmShippingMemo.FillSuppliers;
begin
   stlSM_Suppliers.Clear;
   cbSupplier.Items.Clear;
   With dmMT2.qDB_Supplier do
       try
         DisableControls;
         Active:= true;
         while not EOF do
           begin
              cbSupplier.Items.Add(Fields[0].AsString + '   ' + Fields[1].AsString);
              stlSM_Suppliers.Add(Fields[0].AsString);
              Next;
           end;

       finally
         Active:= false;
       end;
end;

function TfrmShippingMemo.SaveLineItems(SMID: Integer) : integer;
var
  i : integer;
  iRID : integer;
  iCode : integer;
  dWatch : TDateTime;
  iQty : integer;
  cECost : Currency;

begin
     Result:= 0; // good result
     With sgItems do
       for i:= 1 to PRed(RowCount) do    //the product code is the one requred field
          if Cells[2,i] <> '' then
             try
                //the code is an integer. Not necessary but needs to be translated otherwist A code of 0 means leav null
                try
                if (Cells[1,i] <> '') and (cbCode.Items.IndexOf(Cells[1,i]) > -1)  then
                   iCode:= Integer(cbCode.Items.Objects[cbCode.Items.IndexOf(Cells[1,i])])
                else
                   iCode:= 0;
                except
                   iCode:= 0;
                end;

                //IF qty is 0 , leave the field alone
                try
                    iQty:= Ints[4,i];
                except
                   iQty:= 0;
                end;

                //ext cost
                try
                   cECost:= Floats[6,i];
                except
                   cECost:= 0;
                end;

                //watch date
                dWatch:= 0;
                if Cells[7,i] <> '' then
                   try
                     dWatch:= VarToDateTime(Cells[7,i]);
                   except
                     dWatch:= 0;
                   end;



                iRID:= Integer(Objects[0,i]);
                if iRID < 200 then //this needs a new RID Number
                   iRID:= GetNextRID;



                WIth dmMT2.qMT_InsertRID do
                   try

                      ParamByName('smid').AsInteger:= SMID;
                      ParamByName('rid1').AsInteger:= iRID;
                      ParamByName('disp').AsString:= Copy(Cells[0,i],1,10);
                      if iCode > 0 then
                        ParamByName('cod1').AsInteger:= iCode;
                      ParamByName('prod').AsString:= Copy(cells[2,i],1,15);
                      ParamByName('qty1').AsInteger:= iQty;
                      ParamByName('ecst').AsCurrency:= cECost;
                      if dWatch > 0 then
                         ParamByName('wdat').AsDateTime:= dWatch;
                      ParamByName('lnbr').AsString:= Copy(Cells[8,i],1,10);
                      Execute;
                   finally

                   end;
             except on E: Exception do
              begin
                Result:= i; //this will indicate the row that failed.
                sSM_LastError:= e.Message;
              end;
             end;

end;

function TfrmSHippingMemo.GetNextRID;
begin
    With dmMT2.qMT_Select do
       try
         Active:= false;
         DIsableControls;
         SQL.Text:= 'SELECT MAX(ReturnID) FROM [multitracking].dbo.tblReturnDescriptions';
         Active:= true;
         if Fields[0].AsInteger = 0 then //there is not previous entries (not likely)
            Result:= 1000
          else
            Result:= Fields[0].AsInteger + 1;
       finally
         begin
           Active:= false;
           EnableControls;
         end;

       end;
end;

procedure TfrmShippingMemo.ClearAll(SMIDIN : integer);
var
  i : integer;
begin
    //used after a succesful save. Clears all info
    iSM_SMID:= 0;
    iSM_RID:= 0;

    eSMNbr.Clear;
    cbIssued.ITemIndex:= -1;

    With gbSupplier do
      for i:= 0 to Pred(ControlCount) do
          begin
            if Controls[i] is TADVEdit then
               TADVEdit(Controls[i]).Clear;
            if Controls[i] is TComboBox then
              TComboBox(Controls[i]).ItemIndex:= -1;
            if Controls[i] is TDateTimePicker then
              TDateTimePicker(Controls[i]).DateTime:= Now;

          end;
     With gbReturns do
      for i:= 0 to Pred(ControlCount) do
          begin
            if Controls[i] is TADVEdit then
               TADVEdit(Controls[i]).Clear;
            if Controls[i] is TComboBox then
              TComboBox(Controls[i]).ItemIndex:= -1;
            if Controls[i] is TDateTimePicker then
              TDateTimePicker(Controls[i]).DateTime:= Now;

          end;
      ClearLineItemPanel;
      ClearGrid(sgItems,1,2);
      memComments.Lines.Clear;
      chkCLosed.Checked:= false;
      chkCLosedCLick(nil);
      cbClosedBy.ItemIndex:= -1;
      dtpClosed.DateTime:= Now;

      if SMIDIN > 0 then //this is starting a new sm
         begin
            ActiveControl:= cbIssued;
            eSMNbr.IntValue:= SMIDIN;
            iSM_SMID:= SMIDIN;
         end;
end;

function TfrmShippingMemo.NeedSaving : boolean;
begin
    //the intent here is to determine if anything needs saving before moving to the next step
    // the various scenarios are... There is a number in the field and the user has loaded it
    // if the user has loaded a previous SM, then the bSM_LoadedSM will be true
    Result:= bSM_LoadedSM;
    //the other option is this is a new log
    // and therefor needs saving. How do we know its a new log? If the log ID has been inserted into the field.
    if not Result then
       Result:= eSMNbr.IntValue > 0;

end;

function TfrmShippingMemo.SaveThisSM : integer;
begin
       //a result of 0 is good , anthing higher is a problem
      Result:= 1;
      iSM_SMID:= SaveSM(iSM_SMID); //save the header  inot the form variable
      if iSM_SMID > 0 then  //the header was succesfgully saved
         Result:= SaveLineItems(iSM_SMID); //if this was succesully saved it will reutrun a 0

end;

end.
