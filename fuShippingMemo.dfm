object frmShippingMemo: TfrmShippingMemo
  Left = 0
  Top = 0
  Caption = 'Shipping Memo'
  ClientHeight = 652
  ClientWidth = 1101
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 47
    Width = 104
    Height = 13
    Caption = 'Shipping Memo Nbr'
  end
  object Label2: TLabel
    Left = 232
    Top = 47
    Width = 48
    Height = 13
    Caption = 'Issued By'
  end
  object Label8: TLabel
    Left = 32
    Top = 504
    Width = 54
    Height = 13
    Caption = 'Comments'
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1101
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnSave: TAdvGlowButton
      AlignWithMargins = True
      Left = 32
      Top = 8
      Width = 100
      Height = 30
      Margins.Left = 32
      Margins.Top = 8
      Margins.Right = 0
      Align = alLeft
      Caption = 'Save'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ImageIndex = 3
      Images = dmMT2.iml16x16
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Position = bpLeft
      TabOrder = 0
      OnClick = btnSaveClick
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16102556
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
    end
    object btnSearch: TAdvGlowButton
      AlignWithMargins = True
      Left = 236
      Top = 8
      Width = 100
      Height = 30
      Margins.Left = 32
      Margins.Top = 8
      Align = alLeft
      Caption = 'Search'
      ImageIndex = 4
      Images = dmMT2.iml16x16
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      TabOrder = 1
      OnClick = btnSearchClick
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16102556
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
    end
    object btnNew: TAdvGlowButton
      AlignWithMargins = True
      Left = 132
      Top = 8
      Width = 69
      Height = 30
      Margins.Left = 0
      Margins.Top = 8
      Align = alLeft
      Caption = 'New'
      ImageIndex = 7
      Images = dmMT2.iml16x16
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Position = bpRight
      TabOrder = 2
      OnClick = btnNewClick
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16102556
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
    end
  end
  object cbIssued: TComboBox
    Left = 232
    Top = 66
    Width = 145
    Height = 21
    TabOrder = 3
  end
  object gbSupplier: TGroupBox
    Left = 32
    Top = 104
    Width = 545
    Height = 161
    Caption = 'Supplier Info'
    TabOrder = 4
    object Label3: TLabel
      Left = 19
      Top = 18
      Width = 43
      Height = 13
      Caption = 'Supplier'
    end
    object Label4: TLabel
      Left = 15
      Top = 109
      Width = 72
      Height = 13
      Caption = 'Date Received'
    end
    object cbSupplier: TComboBox
      Left = 16
      Top = 32
      Width = 313
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object ePSNbr: TAdvEdit
      Left = 16
      Top = 80
      Width = 121
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Invoice/Packing Slip Nbr'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 1
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
    object eCarrier: TAdvEdit
      Left = 272
      Top = 80
      Width = 121
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Carrier'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 3
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
    object eAttention: TAdvEdit
      Left = 145
      Top = 128
      Width = 121
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Attention'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 6
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
    object eWaybill: TAdvEdit
      Left = 413
      Top = 80
      Width = 121
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Waybill Nbr'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 4
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
    object dtpReceived: TDateTimePicker
      Left = 15
      Top = 128
      Width = 121
      Height = 21
      Date = 42276.685586041670000000
      Time = 42276.685586041670000000
      TabOrder = 5
    end
    object ePONbr: TAdvEdit
      Left = 145
      Top = 80
      Width = 121
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Purchase Order Nbr'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 2
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
  end
  object gbReturns: TGroupBox
    Left = 592
    Top = 104
    Width = 502
    Height = 161
    Caption = 'For WDDC Return Use'
    TabOrder = 5
    object eAddress: TAdvEdit
      Left = 24
      Top = 40
      Width = 305
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Address'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 0
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
    object eAuthNbr: TAdvEdit
      Left = 335
      Top = 40
      Width = 161
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Authorization Nbr'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 1
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
    object eShipMethod: TAdvEdit
      Left = 24
      Top = 80
      Width = 129
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Ship Method'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 2
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
    object eWaybill2: TAdvEdit
      Left = 159
      Top = 80
      Width = 161
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Waybill Nbr.'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 3
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
    object eAttention2: TAdvEdit
      Left = 336
      Top = 80
      Width = 161
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Attention'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 4
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
    object eRTV: TAdvEdit
      Left = 24
      Top = 120
      Width = 129
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'RTV Nbr.'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 5
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
  end
  object eSMNbr: TAdvEdit
    Left = 32
    Top = 66
    Width = 121
    Height = 21
    AllowNumericNullValue = True
    EditAlign = eaRight
    EditType = etNumeric
    EmptyText = ' '
    EmptyTextStyle = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    TabOrder = 1
    Text = ''
    Visible = True
    OnKeyPress = eSMNbrKeyPress
    Version = '3.3.5.3'
  end
  object bgAddItem: TGroupBox
    Left = 31
    Top = 271
    Width = 1062
    Height = 66
    Caption = 'Add Item'
    TabOrder = 6
    object Label5: TLabel
      Left = 16
      Top = 16
      Width = 44
      Height = 13
      Caption = 'Location'
    end
    object Label6: TLabel
      Left = 143
      Top = 13
      Width = 27
      Height = 13
      Caption = 'Code'
    end
    object cbLocation: TComboBox
      Left = 16
      Top = 32
      Width = 121
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object cbCode: TComboBox
      Left = 143
      Top = 32
      Width = 105
      Height = 21
      Style = csDropDownList
      TabOrder = 1
    end
    object eItemNbr: TAdvEdit
      Left = 254
      Top = 32
      Width = 75
      Height = 21
      AllowNumericNullValue = True
      EditAlign = eaRight
      EditType = etNumeric
      EmptyTextStyle = []
      LabelCaption = 'Item Nmbr'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      MaxLength = 6
      TabOrder = 2
      Text = ''
      Visible = True
      OnExit = eItemNbrExit
      OnKeyPress = eItemNbrKeyPress
      Version = '3.3.5.3'
    end
    object eItemDesc: TAdvEdit
      Left = 335
      Top = 32
      Width = 186
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Description'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 3
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
    object eLotNbr: TAdvEdit
      Left = 527
      Top = 32
      Width = 121
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Lot Nbr'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 4
      Text = ''
      Visible = True
      Version = '3.3.5.3'
    end
    object dtpWatch: TDateTimePicker
      Left = 654
      Top = 32
      Width = 115
      Height = 21
      Date = 42276.712313900460000000
      Time = 42276.712313900460000000
      TabOrder = 5
      Visible = False
    end
    object eQty: TAdvEdit
      Left = 775
      Top = 32
      Width = 41
      Height = 21
      EditAlign = eaRight
      EditType = etNumeric
      EmptyTextStyle = []
      LabelCaption = 'Qty'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Signed = True
      TabOrder = 6
      Text = '0'
      Visible = True
      OnChange = eQtyChange
      Version = '3.3.5.3'
    end
    object eUCost: TAdvEdit
      Left = 822
      Top = 32
      Width = 83
      Height = 21
      EditAlign = eaRight
      EditType = etMoney
      EmptyTextStyle = []
      Precision = 2
      Prefix = '$ '
      LabelCaption = 'Unit Cost'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 7
      Text = '0.00'
      Visible = True
      OnChange = eUCostChange
      Version = '3.3.5.3'
    end
    object eECost: TAdvEdit
      Left = 911
      Top = 32
      Width = 82
      Height = 21
      EditAlign = eaRight
      EditType = etMoney
      EmptyTextStyle = []
      Precision = 2
      Prefix = '$ '
      LabelCaption = 'Extended Cost'
      LabelPosition = lpTopLeft
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 8
      Text = '0.00'
      Visible = True
      OnChange = eECostChange
      Version = '3.3.5.3'
    end
    object btnAdd: TAdvGlowButton
      Left = 1007
      Top = 19
      Width = 42
      Height = 38
      ImageIndex = 7
      Images = dmMT2.iml16x16
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      TabOrder = 9
      OnClick = btnAddClick
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16102556
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
    end
    object chkWatch: TAdvOfficeCheckBox
      Left = 654
      Top = 12
      Width = 120
      Height = 20
      TabOrder = 10
      OnClick = chkWatchClick
      Alignment = taLeftJustify
      Caption = 'Watch Date'
      ReturnIsTab = False
      Version = '1.3.9.0'
    end
  end
  object sgItems: TAdvStringGrid
    Left = 32
    Top = 352
    Width = 1061
    Height = 137
    Cursor = crDefault
    ColCount = 10
    DrawingStyle = gdsClassic
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRangeSelect]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 7
    GridLineColor = 15527152
    GridFixedLineColor = 13947601
    HoverRowCells = [hcNormal, hcSelected]
    OnAnchorClick = sgItemsAnchorClick
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = 16575452
    ActiveCellColorTo = 16571329
    ColumnHeaders.Strings = (
      'Location'
      'Code'
      'Product Nbr'
      'Description'
      'Quantity'
      'Unit Cost'
      'Ext Cost '
      'Watch Date'
      'Lot Nbr')
    ColumnSize.Stretch = True
    ColumnSize.StretchColumn = 3
    ControlLook.FixedGradientMirrorFrom = 16049884
    ControlLook.FixedGradientMirrorTo = 16247261
    ControlLook.FixedGradientHoverFrom = 16710648
    ControlLook.FixedGradientHoverTo = 16446189
    ControlLook.FixedGradientHoverMirrorFrom = 16049367
    ControlLook.FixedGradientHoverMirrorTo = 15258305
    ControlLook.FixedGradientDownFrom = 15853789
    ControlLook.FixedGradientDownTo = 15852760
    ControlLook.FixedGradientDownMirrorFrom = 15522767
    ControlLook.FixedGradientDownMirrorTo = 15588559
    ControlLook.FixedGradientDownBorder = 14007466
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'Tahoma'
    FilterDropDown.Font.Style = []
    FilterDropDown.TextChecked = 'Checked'
    FilterDropDown.TextUnChecked = 'Unchecked'
    FilterDropDownClear = '(All)'
    FilterEdit.TypeNames.Strings = (
      'Starts with'
      'Ends with'
      'Contains'
      'Not contains'
      'Equal'
      'Not equal'
      'Larger than'
      'Smaller than'
      'Clear')
    FixedColWidth = 104
    FixedRowHeight = 22
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clBlack
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    GridImages = dmMT2.iml12x12
    HoverButtons.Buttons = <>
    HoverButtons.Position = hbLeftFromColumnLeft
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    Look = glWin7
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'Tahoma'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    SearchFooter.Color = 16645370
    SearchFooter.ColorTo = 16247261
    SearchFooter.FindNextCaption = 'Find &next'
    SearchFooter.FindPrevCaption = 'Find &previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'Tahoma'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurrence'
    SearchFooter.HintFindPrev = 'Find previous occurrence'
    SearchFooter.HintHighlight = 'Highlight occurrences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SortSettings.DefaultFormat = ssAutomatic
    SortSettings.HeaderColor = 16579058
    SortSettings.HeaderColorTo = 16579058
    SortSettings.HeaderMirrorColor = 16380385
    SortSettings.HeaderMirrorColorTo = 16182488
    Version = '7.8.0.1'
    ColWidths = (
      104
      77
      92
      308
      61
      82
      82
      102
      108
      41)
  end
  object memComments: TMemo
    Left = 32
    Top = 523
    Width = 441
    Height = 121
    TabOrder = 8
  end
  object chkCLosed: TAdvOfficeCheckBox
    Left = 544
    Top = 524
    Width = 73
    Height = 20
    TabOrder = 9
    OnClick = chkCLosedClick
    Alignment = taLeftJustify
    Caption = 'Closed'
    ReturnIsTab = False
    Version = '1.3.9.0'
  end
  object pnlClosed: TPanel
    Left = 611
    Top = 524
    Width = 482
    Height = 57
    TabOrder = 10
    Visible = False
    object Label9: TLabel
      Left = 40
      Top = 4
      Width = 50
      Height = 13
      Caption = 'Closed By'
    end
    object Label10: TLabel
      Left = 276
      Top = 6
      Width = 54
      Height = 13
      Caption = 'Closed On'
    end
    object cbCLosedBy: TComboBox
      Left = 40
      Top = 23
      Width = 210
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object dtpClosed: TDateTimePicker
      Left = 272
      Top = 23
      Width = 186
      Height = 21
      Date = 42277.337894803240000000
      Time = 42277.337894803240000000
      TabOrder = 1
    end
  end
  object btnSMLookUp: TAdvGlowButton
    Left = 159
    Top = 66
    Width = 26
    Height = 21
    ImageIndex = 4
    Images = dmMT2.iml16x16
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    TabOrder = 2
    TabStop = True
    OnClick = btnSMLookUpClick
    Appearance.ColorChecked = 16111818
    Appearance.ColorCheckedTo = 16367008
    Appearance.ColorDisabled = 15921906
    Appearance.ColorDisabledTo = 15921906
    Appearance.ColorDown = 16111818
    Appearance.ColorDownTo = 16367008
    Appearance.ColorHot = 16117985
    Appearance.ColorHotTo = 16372402
    Appearance.ColorMirrorHot = 16107693
    Appearance.ColorMirrorHotTo = 16775412
    Appearance.ColorMirrorDown = 16102556
    Appearance.ColorMirrorDownTo = 16768988
    Appearance.ColorMirrorChecked = 16102556
    Appearance.ColorMirrorCheckedTo = 16768988
    Appearance.ColorMirrorDisabled = 11974326
    Appearance.ColorMirrorDisabledTo = 15921906
  end
end
