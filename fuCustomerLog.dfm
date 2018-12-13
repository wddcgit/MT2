object frmCustomerLog: TfrmCustomerLog
  Left = 0
  Top = 0
  Caption = 'Customer Log'
  ClientHeight = 689
  ClientWidth = 1163
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblClient: THTMLabel
    Left = 30
    Top = 72
    Width = 435
    Height = 113
    HTMLText.Strings = (
      'TMS <b>HTML</b> label ')
    Transparent = True
    Version = '1.9.2.1'
  end
  object Label9: TLabel
    Left = 232
    Top = 16
    Width = 64
    Height = 13
    Caption = 'Member Nbr'
  end
  object eMember: TAdvEdit
    Left = 30
    Top = 32
    Width = 187
    Height = 21
    EmptyTextStyle = []
    LabelCaption = 'Search for member name or number'
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
    OnChange = eMemberChange
    OnExit = eMemberExit
    OnKeyPress = eMemberKeyPress
    Version = '3.3.6.1'
  end
  object sgLogs: TAdvStringGrid
    AlignWithMargins = True
    Left = 30
    Top = 200
    Width = 571
    Height = 461
    Cursor = crDefault
    Margins.Left = 30
    Margins.Top = 200
    Margins.Right = 0
    Align = alClient
    DrawingStyle = gdsClassic
    FixedCols = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [goRowSelect]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    GridLineColor = 15527152
    GridFixedLineColor = 13947601
    HoverRowCells = [hcNormal, hcSelected]
    OnGetColumnFilter = sgLogsGetColumnFilter
    OnFilterSelect = sgLogsFilterSelect
    OnRowChanging = sgLogsRowChanging
    OnClickCell = sgLogsClickCell
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = 16575452
    ActiveCellColorTo = 16571329
    ColumnHeaders.Strings = (
      'Date'
      'Log ID'
      'Category'
      'Problem'
      'Status')
    ColumnSize.Stretch = True
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
    FixedColWidth = 101
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
    SearchFooter.Visible = True
    SortSettings.DefaultFormat = ssAutomatic
    SortSettings.HeaderColor = 16579058
    SortSettings.HeaderColorTo = 16579058
    SortSettings.HeaderMirrorColor = 16380385
    SortSettings.HeaderMirrorColorTo = 16182488
    Version = '7.8.7.0'
    ExplicitWidth = 747
    ExplicitHeight = 469
    ColWidths = (
      101
      50
      147
      207
      62)
  end
  object ibCLInfo: TW7InformationBar
    Left = 0
    Top = 664
    Width = 1163
    Height = 25
    Version = '1.0.2.0'
    object lblStatus: TLabel
      AlignWithMargins = True
      Left = 30
      Top = 0
      Width = 45
      Height = 25
      Margins.Left = 30
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'lblStatus'
      ExplicitHeight = 15
    end
    object lblSaved: TLabel
      Left = 849
      Top = 3
      Width = 69
      Height = 20
      Caption = 'Log Saved'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
  end
  object cbMember: TComboBox
    Left = 232
    Top = 32
    Width = 145
    Height = 21
    Style = csDropDownList
    TabOrder = 3
    OnChange = cbMemberChange
  end
  object pnlLog: TPanel
    Left = 601
    Top = 0
    Width = 562
    Height = 664
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 4
    object Label1: TLabel
      Left = 20
      Top = 39
      Width = 33
      Height = 13
      Caption = 'Log ID'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblLogID: TLabel
      Left = 20
      Top = 52
      Width = 58
      Height = 21
      Caption = 'lblLogID'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8861484
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 288
      Top = 36
      Width = 29
      Height = 13
      Caption = 'Caller'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 112
      Top = 39
      Width = 46
      Height = 13
      Caption = 'Log Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblOpenedBy: TLabel
      Left = 440
      Top = 56
      Width = 74
      Height = 17
      Caption = 'lblOpenedBy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 440
      Top = 40
      Width = 54
      Height = 13
      Caption = 'Logged By'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblLogDate: TLabel
      Left = 112
      Top = 56
      Width = 63
      Height = 17
      Caption = 'lblLogDate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object pnlButtons: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 559
      Height = 33
      Margins.Left = 0
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object btnSave: TAdvGlowButton
        AlignWithMargins = True
        Left = 98
        Top = 3
        Width = 78
        Height = 27
        Margins.Left = 0
        Margins.Right = 0
        Align = alLeft
        Caption = 'Save'
        ImageIndex = 3
        Images = dmMT2.iml16x16
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        Position = bpMiddle
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
      object btnNewLog: TAdvGlowButton
        AlignWithMargins = True
        Left = 20
        Top = 3
        Width = 78
        Height = 27
        Margins.Left = 20
        Margins.Right = 0
        Align = alLeft
        Caption = 'New'
        ImageIndex = 7
        Images = dmMT2.iml16x16
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        Position = bpLeft
        TabOrder = 1
        OnClick = btnNewLogClick
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
      object btnClearLog: TAdvGlowButton
        AlignWithMargins = True
        Left = 176
        Top = 3
        Width = 78
        Height = 27
        Margins.Left = 0
        Margins.Right = 0
        Align = alLeft
        Caption = 'Clear'
        ImageIndex = 8
        Images = dmMT2.iml16x16
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        Position = bpMiddle
        TabOrder = 2
        OnClick = btnClearLogClick
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
      object btnDeleteLog: TAdvGlowButton
        AlignWithMargins = True
        Left = 254
        Top = 3
        Width = 78
        Height = 27
        Margins.Left = 0
        Margins.Right = 0
        Align = alLeft
        Caption = 'Delete'
        ImageIndex = 5
        Images = dmMT2.iml16x16
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        Position = bpMiddle
        TabOrder = 3
        OnClick = btnDeleteLogClick
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
      object btnPrintLog: TAdvGlowButton
        AlignWithMargins = True
        Left = 332
        Top = 3
        Width = 78
        Height = 27
        Margins.Left = 0
        Margins.Right = 0
        Align = alLeft
        Caption = 'Print'
        ImageIndex = 6
        Images = dmMT2.iml16x16
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        Position = bpMiddle
        TabOrder = 4
        OnClick = btnPrintLogClick
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
      object btnPreview: TAdvGlowButton
        AlignWithMargins = True
        Left = 410
        Top = 3
        Width = 78
        Height = 27
        Margins.Left = 0
        Margins.Right = 0
        Align = alLeft
        Caption = 'Preview'
        ImageIndex = 4
        Images = dmMT2.iml16x16
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        Position = bpMiddle
        TabOrder = 5
        OnClick = btnPreviewClick
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
    object cbCaller: TComboBox
      Left = 288
      Top = 53
      Width = 129
      Height = 21
      TabOrder = 1
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 86
      Width = 556
      Height = 575
      Margins.Top = 50
      Align = alClient
      TabOrder = 2
      object Label2: TLabel
        Left = 20
        Top = 32
        Width = 46
        Height = 13
        Caption = 'Category'
      end
      object Label4: TLabel
        Left = 392
        Top = 32
        Width = 91
        Height = 13
        Caption = 'Shipping Method'
      end
      object Label3: TLabel
        Left = 215
        Top = 32
        Width = 61
        Height = 13
        Caption = 'Department'
      end
      object Label5: TLabel
        Left = 20
        Top = 78
        Width = 45
        Height = 13
        Caption = 'Keyed By'
      end
      object HTMLabel1: THTMLabel
        Left = 20
        Top = 129
        Width = 61
        Height = 17
        HTMLText.Strings = (
          'Invoice(s)')
        Transparent = True
        Version = '1.9.2.1'
      end
      object lblBoL: THTMLabel
        Left = 332
        Top = 129
        Width = 120
        Height = 17
        HTMLText.Strings = (
          'Tracking Nbr(s)')
        Transparent = True
        OnAnchorClick = lblBoLAnchorClick
        Version = '1.9.2.1'
      end
      object Label10: TLabel
        Left = 328
        Top = 201
        Width = 48
        Height = 13
        Caption = 'Picked By'
      end
      object Label6: TLabel
        Left = 20
        Top = 247
        Width = 30
        Height = 13
        Caption = 'Detail'
      end
      object Label11: TLabel
        Left = 20
        Top = 437
        Width = 30
        Height = 13
        Caption = 'Notes'
      end
      object Label12: TLabel
        Left = 104
        Top = 522
        Width = 50
        Height = 13
        Caption = 'Closed By'
      end
      object Label13: TLabel
        Left = 352
        Top = 522
        Width = 54
        Height = 13
        Caption = 'Closed On'
      end
      object lblLogPageID: TLabel
        Left = 20
        Top = 5
        Width = 59
        Height = 21
        Caption = 'LogPage'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8861484
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblPageCnt: TLabel
        Left = 512
        Top = 5
        Width = 25
        Height = 13
        Alignment = taRightJustify
        Caption = 'Page'
      end
      object cbCtgy: TComboBox
        Left = 20
        Top = 51
        Width = 181
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = cbCtgyChange
      end
      object cbShipMethod: TComboBox
        Left = 392
        Top = 51
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 2
      end
      object cbDept: TComboBox
        Left = 216
        Top = 51
        Width = 161
        Height = 21
        Style = csDropDownList
        TabOrder = 1
        OnChange = cbDeptChange
      end
      object cbStaff: TComboBox
        Left = 20
        Top = 102
        Width = 181
        Height = 21
        Style = csDropDownList
        TabOrder = 3
      end
      object memInvoices: TMemo
        Left = 20
        Top = 152
        Width = 185
        Height = 89
        Lines.Strings = (
          '')
        TabOrder = 4
      end
      object btnInvoicesandTracking: TAdvGlowButton
        Left = 211
        Top = 152
        Width = 111
        Height = 33
        Hint = 'Locate invoices and tracking numbers'
        Caption = 'Invoices and Tracking'
        ImageIndex = 4
        Images = dmMT2.iml16x16
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = btnInvoicesandTrackingClick
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
      object memWaybills: TMemo
        Left = 328
        Top = 152
        Width = 209
        Height = 43
        Lines.Strings = (
          '')
        TabOrder = 6
      end
      object cbPickedBy: TColumnComboBox
        Left = 328
        Top = 220
        Width = 209
        Height = 21
        Color = clWindow
        Version = '1.5.0.0'
        Visible = True
        Columns = <
          item
            Color = clWindow
            ColumnType = ctText
            Width = 100
            Alignment = taLeftJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          item
            Color = clWindow
            ColumnType = ctText
            Width = 100
            Alignment = taLeftJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end>
        ComboItems = <
          item
            ImageIndex = -1
            Strings.Strings = (
              'Col0Item1'
              'Col0Tiem2')
            Tag = 0
          end
          item
            ImageIndex = -1
            Strings.Strings = (
              'Col1Item1'
              'Col1Item2')
            Tag = 0
          end>
        EditColumn = -1
        EditHeight = 15
        EmptyText = ''
        EmptyTextStyle = []
        DropWidth = 0
        DropHeight = 200
        Enabled = True
        GridLines = False
        ItemIndex = 0
        LookupColumn = 0
        LabelCaption = ''
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        SortColumn = 0
        TabOrder = 7
      end
      object memDetail: TMemo
        Left = 20
        Top = 266
        Width = 517
        Height = 159
        ScrollBars = ssVertical
        TabOrder = 8
      end
      object memNotes: TMemo
        Left = 20
        Top = 456
        Width = 517
        Height = 65
        ScrollBars = ssVertical
        TabOrder = 9
      end
      object chkClosed: TAdvOfficeCheckBox
        Left = 20
        Top = 543
        Width = 61
        Height = 20
        TabOrder = 10
        Alignment = taLeftJustify
        Caption = 'Closed'
        ReturnIsTab = False
        Version = '1.4.0.0'
      end
      object cbClosedBy: TComboBox
        Left = 104
        Top = 541
        Width = 193
        Height = 21
        Style = csDropDownList
        TabOrder = 11
      end
      object dtpClosedOn: TDateTimePicker
        Left = 352
        Top = 541
        Width = 186
        Height = 21
        Date = 42212.688716550920000000
        Time = 42212.688716550920000000
        TabOrder = 12
      end
      object btnPrior: TAdvGlowButton
        Left = 150
        Top = 8
        Width = 20
        Height = 20
        ImageIndex = 9
        Images = dmMT2.iml16x16
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        TabOrder = 13
        OnClick = btnPriorClick
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
      object btnNext: TAdvGlowButton
        Left = 176
        Top = 8
        Width = 20
        Height = 20
        ImageIndex = 10
        Images = dmMT2.iml16x16
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        TabOrder = 14
        OnClick = btnNextClick
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
      object btnNewPage: TAdvGlowButton
        Left = 202
        Top = 8
        Width = 20
        Height = 20
        Hint = 'Add New Page'
        ImageIndex = 7
        Images = dmMT2.iml16x16
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentShowHint = False
        ShowHint = True
        TabOrder = 15
        OnClick = btnNewPageClick
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
  end
  object tmrSaved: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmrSavedTimer
    Left = 488
    Top = 32
  end
end
