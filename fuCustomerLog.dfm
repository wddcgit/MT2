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
    Height = 86
    HTMLText.Strings = (
      'TMS <b>HTML</b> label ')
    Transparent = True
    Version = '2.1.0.0'
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
    DefaultHandling = True
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
    Version = '3.4.6.6'
  end
  object sgLogs: TAdvStringGrid
    AlignWithMargins = True
    Left = 30
    Top = 200
    Width = 650
    Height = 461
    Cursor = crDefault
    Margins.Left = 30
    Margins.Top = 200
    Margins.Right = 0
    Align = alClient
    ColCount = 6
    DrawingStyle = gdsClassic
    FixedCols = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    OnSelectCell = sgLogsSelectCell
    GridLineColor = 15527152
    GridFixedLineColor = 13947601
    HoverRowCells = [hcNormal, hcSelected]
    OnGetColumnFilter = sgLogsGetColumnFilter
    OnFilterSelect = sgLogsFilterSelect
    OnRowChanging = sgLogsRowChanging
    OnClickCell = sgLogsClickCell
    OnDblClickCell = sgLogsDblClickCell
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
      'Assigned'
      'Status')
    ColumnSize.Stretch = True
    ControlLook.FixedGradientFrom = 16744448
    ControlLook.FixedGradientTo = 16744448
    ControlLook.FixedGradientMirrorFrom = 16744448
    ControlLook.FixedGradientMirrorTo = 16744448
    ControlLook.FixedGradientHoverFrom = 16710648
    ControlLook.FixedGradientHoverTo = 16446189
    ControlLook.FixedGradientHoverMirrorFrom = 16049367
    ControlLook.FixedGradientHoverMirrorTo = 15258305
    ControlLook.FixedGradientHoverBorder = 16744448
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
    FixedFont.Color = clWhite
    FixedFont.Height = -13
    FixedFont.Name = 'Segoe UI'
    FixedFont.Style = []
    FloatFormat = '%.2f'
    GridImages = dmMT2.iml12x12
    HoverButtons.Buttons = <>
    HoverButtons.Position = hbLeftFromColumnLeft
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    Look = glCustom
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
    SearchFooter.ResultFormat = '(%d of %d)'
    SearchFooter.Visible = True
    SortSettings.DefaultFormat = ssAutomatic
    SortSettings.HeaderColor = 16579058
    SortSettings.HeaderColorTo = 16579058
    SortSettings.HeaderMirrorColor = 16380385
    SortSettings.HeaderMirrorColorTo = 16182488
    Version = '8.4.2.0'
    ExplicitWidth = 747
    ExplicitHeight = 469
    ColWidths = (
      101
      50
      109
      207
      105
      74)
    RowHeights = (
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22)
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
    Left = 680
    Top = 0
    Width = 483
    Height = 664
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 4
    object Label1: TLabel
      Left = 20
      Top = 14
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
      Top = 30
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
      Left = 280
      Top = 14
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
      Top = 14
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
    object lblLogDate: TLabel
      Left = 112
      Top = 30
      Width = 75
      Height = 21
      Caption = 'lblLogDate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9527808
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblCaller: TLabel
      Left = 280
      Top = 30
      Width = 57
      Height = 21
      Caption = 'lblCaller'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9527808
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 416
      Top = 14
      Width = 21
      Height = 13
      Caption = 'JIRA'
    end
    object lblJIRALink: THTMLabel
      Left = 416
      Top = 30
      Width = 120
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      HTMLText.Strings = (
        'TMS <b>HTML</b> label ')
      ParentFont = False
      Transparent = True
      Version = '2.1.0.0'
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 66
      Width = 480
      Height = 595
      Margins.Left = 0
      Margins.Top = 66
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Label2: TLabel
        Left = 20
        Top = 0
        Width = 46
        Height = 13
        Caption = 'Category'
      end
      object Label3: TLabel
        Left = 280
        Top = 0
        Width = 61
        Height = 13
        Caption = 'Assigned to'
      end
      object lblPageCnt: TLabel
        Left = 512
        Top = 5
        Width = 25
        Height = 13
        Alignment = taRightJustify
        Caption = 'Page'
      end
      object lblCategory: TLabel
        Left = 20
        Top = 15
        Width = 80
        Height = 21
        Caption = 'lblCategory'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9527808
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblAssignedTo: TLabel
        Left = 280
        Top = 15
        Width = 95
        Height = 21
        Caption = 'lblAssignedTo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 9527808
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblSummary: TLabel
        Left = 20
        Top = 55
        Width = 67
        Height = 17
        Caption = 'lblCategory'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4194368
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbLogs: TAdvSmoothListBox
        AlignWithMargins = True
        Left = 20
        Top = 100
        Width = 440
        Height = 393
        Cursor = crDefault
        Margins.Left = 20
        Margins.Top = 100
        Margins.Right = 20
        Margins.Bottom = 0
        Fill.Color = 16776443
        Fill.ColorMirror = clNone
        Fill.ColorMirrorTo = clNone
        Fill.GradientType = gtSolid
        Fill.GradientMirrorType = gtSolid
        Fill.BorderColor = clNone
        Fill.Rounding = 0
        Fill.ShadowOffset = 0
        Fill.Glow = gmNone
        Images = dmMT2.iml16x16
        Items = <
          item
            Caption = 'Item 0'
            GraphicRightType = gtCommonImage
            GraphicRightIndex = 5
            GraphicRight.Data = {
              424D360300000000000036000000280000001000000010000000010018000000
              000000030000C30E0000C30E000000000000000000001C9CA41898BE1898BE18
              98BE1898BE1898BE1898BE1898BE1898BE1898BE1898BE1898BE1898BE1898BE
              1898BE1C9CA41D9CC019AAD319AAD319AAD319AAD319AAD319AAD319AAD319AA
              D319AAD319AAD319AAD319AAD319AAD319AAD31D9CC023A1C31EAED51EAED51E
              AED43C45483E3F3F3E3F403E3F3F3E3F3F3E3F403E3F3F3C45481EAED41EAED5
              1EAED523A1C32AA7C723B2D823B2D823B2D742434342434327A5C64243434243
              4327A5C642434342434323B2D723B2D823B2D82AA7C732ADCB28B8DB28B8DB28
              B8DA47484847484828B7D947484847484828B7D947484847484828B8DA28B8DB
              28B8DB32ADCB3AB3CE2FBDDF2FBDDF2FBDDE4C4D4E4C4D4E2FBCDD4C4D4E4C4D
              4E2FBCDD4C4D4E4C4D4E2FBDDE2FBDDF2FBDDF3AB3CE44BBD336C3E236C3E236
              C3E153545453545436C2E053545453545436C2E053545453545436C3E136C3E2
              36C3E244BBD34DC2D83DCAE63DCAE63DCAE5595A5B595A5B40BCD5595A5B595A
              5B40BCD5595A5B595A5B3DCAE53DCAE63DCAE64DC2D856C9DD44D0EA44D0EA44
              D0E95E67696061616061626061616061616061626061615E676944D0E944D0EA
              44D0EA56C9DD5FD0E14BD6EE4BD6EE4BD6ED4BD5EC4BD5EC4BD5EC4BD5EC4BD5
              EC4BD5EC4BD5EC4BD5EC4BD6ED4BD6EE4BD6EE5FD0E169D7E651DCF151DCF16A
              73766C6D6E6C6D6E6C6D6E6C6D6E6C6D6E6C6D6E6C6D6E6C6D6E6A737651DCF1
              51DCF169D7E671DEEB58E2F558E2F570797B7273747272747273747273747273
              7472737472727472737470797B58E2F558E2F571DEEB79E4EE5EE7F85EE7F85E
              E7F75EE6F6767A7B5EE5F65EE6F65EE6F65EE5F5767A7B5EE6F65EE7F75EE7F8
              5EE7F879E4EE80EAF163ECFB63ECFB63ECFB63ECFB6ACAD57A7E7F7B7D7D7B7D
              7D7A7E7E6AC7D163ECFB63ECFB63ECFB63ECFB80EAF186EEF467EFFD67EFFD67
              EFFD67EFFD67EFFD67EFFD67EFFD67EFFD67EFFD67EFFD67EFFD67EFFD67EFFD
              67EFFD86EEF486ECD88BF2F88BF2F88BF2F88BF2F88BF2F88BF2F88BF2F88BF2
              F88BF2F88BF2F88BF2F88BF2F88BF2F88BF2F886ECD9}
            CaptionFont.Charset = DEFAULT_CHARSET
            CaptionFont.Color = clWindowText
            CaptionFont.Height = -13
            CaptionFont.Name = 'Segoe UI'
            CaptionFont.Style = [fsBold]
            ProgressMaximum = 100.000000000000000000
            ButtonColor = 16765615
            DeleteButton = True
            DeleteButtonVisible = True
          end
          item
            Caption = 'Item 1'
            Notes = '<P align="alLeft" bgcolor="clRed">Undo</P>'
            ProgressMaximum = 100.000000000000000000
            ButtonColor = clRed
            ButtonCaption = 'Peter Sux'
          end>
        ItemAppearance.FillAlternate.Color = 13497542
        ItemAppearance.FillAlternate.ColorTo = 13497542
        ItemAppearance.FillAlternate.ColorMirror = 13497542
        ItemAppearance.FillAlternate.ColorMirrorTo = 13497542
        ItemAppearance.FillAlternate.GradientType = gtVertical
        ItemAppearance.FillAlternate.GradientMirrorType = gtVertical
        ItemAppearance.FillAlternate.BorderColor = 4315430
        ItemAppearance.FillAlternate.Rounding = 4
        ItemAppearance.FillAlternate.ShadowOffset = 0
        ItemAppearance.FillAlternate.Glow = gmGradient
        ItemAppearance.FillAlternate.GlowGradientColor = 13497542
        ItemAppearance.FillAlternate.GlowRadialColor = 13497542
        ItemAppearance.Fill.Color = 16775410
        ItemAppearance.Fill.ColorTo = 16775410
        ItemAppearance.Fill.ColorMirror = 16775410
        ItemAppearance.Fill.ColorMirrorTo = 16775410
        ItemAppearance.Fill.GradientType = gtVertical
        ItemAppearance.Fill.GradientMirrorType = gtVertical
        ItemAppearance.Fill.BorderColor = 16765357
        ItemAppearance.Fill.Rounding = 4
        ItemAppearance.Fill.ShadowOffset = 0
        ItemAppearance.Fill.Glow = gmGradient
        ItemAppearance.Fill.GlowGradientColor = 16775410
        ItemAppearance.Fill.GlowRadialColor = 16775410
        ItemAppearance.FillSelected.Color = 11196927
        ItemAppearance.FillSelected.ColorTo = 7257087
        ItemAppearance.FillSelected.ColorMirror = 4370174
        ItemAppearance.FillSelected.ColorMirrorTo = 8053246
        ItemAppearance.FillSelected.GradientType = gtVertical
        ItemAppearance.FillSelected.GradientMirrorType = gtVertical
        ItemAppearance.FillSelected.BorderColor = 16765357
        ItemAppearance.FillSelected.Rounding = 4
        ItemAppearance.FillSelected.ShadowOffset = 0
        ItemAppearance.FillSelected.Glow = gmGradient
        ItemAppearance.FillSelectedAlternate.Color = 11196927
        ItemAppearance.FillSelectedAlternate.ColorTo = 7257087
        ItemAppearance.FillSelectedAlternate.ColorMirror = 4370174
        ItemAppearance.FillSelectedAlternate.ColorMirrorTo = 8053246
        ItemAppearance.FillSelectedAlternate.GradientType = gtVertical
        ItemAppearance.FillSelectedAlternate.GradientMirrorType = gtVertical
        ItemAppearance.FillSelectedAlternate.BorderColor = 16765357
        ItemAppearance.FillSelectedAlternate.Rounding = 4
        ItemAppearance.FillSelectedAlternate.ShadowOffset = 0
        ItemAppearance.FillSelectedAlternate.Glow = gmGradient
        ItemAppearance.FillDisabled.Color = 15921906
        ItemAppearance.FillDisabled.ColorTo = 11974326
        ItemAppearance.FillDisabled.ColorMirror = 11974326
        ItemAppearance.FillDisabled.ColorMirrorTo = 15921906
        ItemAppearance.FillDisabled.GradientType = gtVertical
        ItemAppearance.FillDisabled.GradientMirrorType = gtVertical
        ItemAppearance.FillDisabled.BorderColor = 16765357
        ItemAppearance.FillDisabled.Rounding = 0
        ItemAppearance.FillDisabled.ShadowOffset = 0
        ItemAppearance.FillDisabled.Glow = gmNone
        ItemAppearance.ProgressAppearance.BackGroundFill.Color = 16765615
        ItemAppearance.ProgressAppearance.BackGroundFill.ColorTo = 16765615
        ItemAppearance.ProgressAppearance.BackGroundFill.ColorMirror = clNone
        ItemAppearance.ProgressAppearance.BackGroundFill.ColorMirrorTo = clNone
        ItemAppearance.ProgressAppearance.BackGroundFill.GradientType = gtVertical
        ItemAppearance.ProgressAppearance.BackGroundFill.GradientMirrorType = gtSolid
        ItemAppearance.ProgressAppearance.BackGroundFill.BorderColor = clSilver
        ItemAppearance.ProgressAppearance.BackGroundFill.Rounding = 0
        ItemAppearance.ProgressAppearance.BackGroundFill.ShadowOffset = 0
        ItemAppearance.ProgressAppearance.BackGroundFill.Glow = gmNone
        ItemAppearance.ProgressAppearance.ProgressFill.Color = 16773091
        ItemAppearance.ProgressAppearance.ProgressFill.ColorTo = 16768452
        ItemAppearance.ProgressAppearance.ProgressFill.ColorMirror = 16765357
        ItemAppearance.ProgressAppearance.ProgressFill.ColorMirrorTo = 16767936
        ItemAppearance.ProgressAppearance.ProgressFill.GradientType = gtVertical
        ItemAppearance.ProgressAppearance.ProgressFill.GradientMirrorType = gtVertical
        ItemAppearance.ProgressAppearance.ProgressFill.BorderColor = 16765357
        ItemAppearance.ProgressAppearance.ProgressFill.Rounding = 0
        ItemAppearance.ProgressAppearance.ProgressFill.ShadowOffset = 0
        ItemAppearance.ProgressAppearance.ProgressFill.Glow = gmNone
        ItemAppearance.ProgressAppearance.Font.Charset = DEFAULT_CHARSET
        ItemAppearance.ProgressAppearance.Font.Color = clWindowText
        ItemAppearance.ProgressAppearance.Font.Height = -11
        ItemAppearance.ProgressAppearance.Font.Name = 'Tahoma'
        ItemAppearance.ProgressAppearance.Font.Style = []
        ItemAppearance.ProgressAppearance.ProgressFont.Charset = DEFAULT_CHARSET
        ItemAppearance.ProgressAppearance.ProgressFont.Color = clWindowText
        ItemAppearance.ProgressAppearance.ProgressFont.Height = -11
        ItemAppearance.ProgressAppearance.ProgressFont.Name = 'Tahoma'
        ItemAppearance.ProgressAppearance.ProgressFont.Style = []
        ItemAppearance.ProgressAppearance.ValueFormat = '%.0f%%'
        ItemAppearance.ButtonAppearance.Font.Charset = DEFAULT_CHARSET
        ItemAppearance.ButtonAppearance.Font.Color = clWindowText
        ItemAppearance.ButtonAppearance.Font.Height = -11
        ItemAppearance.ButtonAppearance.Font.Name = 'Tahoma'
        ItemAppearance.ButtonAppearance.Font.Style = []
        ItemAppearance.VerticalSpacing = 10
        ItemAppearance.HorizontalSpacing = 5
        ItemAppearance.Height = 50
        ItemAppearance.InfoFill.ColorMirror = clNone
        ItemAppearance.InfoFill.ColorMirrorTo = clNone
        ItemAppearance.InfoFill.GradientType = gtVertical
        ItemAppearance.InfoFill.GradientMirrorType = gtSolid
        ItemAppearance.InfoFill.BorderColor = clNone
        ItemAppearance.InfoFill.Rounding = 0
        ItemAppearance.InfoFill.ShadowOffset = 0
        ItemAppearance.InfoFill.Glow = gmNone
        ItemAppearance.InfoFillSelected.ColorMirror = clNone
        ItemAppearance.InfoFillSelected.ColorMirrorTo = clNone
        ItemAppearance.InfoFillSelected.GradientType = gtVertical
        ItemAppearance.InfoFillSelected.GradientMirrorType = gtSolid
        ItemAppearance.InfoFillSelected.BorderColor = clNone
        ItemAppearance.InfoFillSelected.Rounding = 0
        ItemAppearance.InfoFillSelected.ShadowOffset = 0
        ItemAppearance.InfoFillSelected.Glow = gmNone
        ItemAppearance.InfoFillDisabled.ColorMirror = clNone
        ItemAppearance.InfoFillDisabled.ColorMirrorTo = clNone
        ItemAppearance.InfoFillDisabled.GradientType = gtVertical
        ItemAppearance.InfoFillDisabled.GradientMirrorType = gtSolid
        ItemAppearance.InfoFillDisabled.BorderColor = clNone
        ItemAppearance.InfoFillDisabled.Rounding = 0
        ItemAppearance.InfoFillDisabled.ShadowOffset = 0
        ItemAppearance.InfoFillDisabled.Glow = gmNone
        ItemAppearance.DeleteButtonCaption = 'Undo'
        ItemAppearance.DeleteButtonFont.Charset = DEFAULT_CHARSET
        ItemAppearance.DeleteButtonFont.Color = clWhite
        ItemAppearance.DeleteButtonFont.Height = -11
        ItemAppearance.DeleteButtonFont.Name = 'Tahoma'
        ItemAppearance.DeleteButtonFont.Style = [fsBold]
        LookupBar.DisabledFont.Charset = DEFAULT_CHARSET
        LookupBar.DisabledFont.Color = clSilver
        LookupBar.DisabledFont.Height = -11
        LookupBar.DisabledFont.Name = 'Tahoma'
        LookupBar.DisabledFont.Style = []
        LookupBar.Font.Charset = DEFAULT_CHARSET
        LookupBar.Font.Color = clWindowText
        LookupBar.Font.Height = -11
        LookupBar.Font.Name = 'Tahoma'
        LookupBar.Font.Style = []
        LookupBar.Visible = False
        Sections.Font.Charset = DEFAULT_CHARSET
        Sections.Font.Color = clWindowText
        Sections.Font.Height = -11
        Sections.Font.Name = 'Tahoma'
        Sections.Font.Style = []
        Sections.BorderColor = clBlack
        SelectedItemIndex = -1
        Header.Fill.Color = 16773091
        Header.Fill.ColorTo = 16765615
        Header.Fill.ColorMirror = clNone
        Header.Fill.ColorMirrorTo = clNone
        Header.Fill.GradientType = gtVertical
        Header.Fill.GradientMirrorType = gtSolid
        Header.Fill.BorderColor = 16765615
        Header.Fill.Rounding = 0
        Header.Fill.ShadowOffset = 0
        Header.Fill.Glow = gmNone
        Header.Caption = 'Header'
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = 7485192
        Header.Font.Height = -13
        Header.Font.Name = 'Tahoma'
        Header.Font.Style = []
        Header.Visible = False
        Filter.Fill.Color = 16773091
        Filter.Fill.ColorMirror = clNone
        Filter.Fill.ColorMirrorTo = clNone
        Filter.Fill.GradientType = gtSolid
        Filter.Fill.GradientMirrorType = gtSolid
        Filter.Fill.BorderColor = 16765615
        Filter.Fill.Rounding = 0
        Filter.Fill.ShadowOffset = 0
        Filter.Fill.Glow = gmNone
        Footer.Fill.Color = 16771315
        Footer.Fill.ColorTo = 16771315
        Footer.Fill.ColorMirror = clNone
        Footer.Fill.ColorMirrorTo = clNone
        Footer.Fill.GradientType = gtVertical
        Footer.Fill.GradientMirrorType = gtSolid
        Footer.Fill.BorderColor = 16764646
        Footer.Fill.Rounding = 0
        Footer.Fill.ShadowOffset = 0
        Footer.Fill.Glow = gmNone
        Footer.Caption = 'This Log has <A HREF="IMGS"> Images</A>'
        Footer.Font.Charset = DEFAULT_CHARSET
        Footer.Font.Color = 7485192
        Footer.Font.Height = -13
        Footer.Font.Name = 'Tahoma'
        Footer.Font.Style = []
        Footer.Visible = False
        OnFooterClick = lbLogsFooterClick
        OnItemDblClick = lbLogsItemDblClick
        OnGraphicRightClick = lbLogsGraphicRightClick
        OnItemDeleteClicked = lbLogsItemDeleteClicked
        OnItemInfoClick = lbLogsGraphicRightClick
        DefaultItem.AutoSize = True
        DefaultItem.Caption = 'Item 0'
        DefaultItem.NotesLocation = plTopLeft
        DefaultItem.NotesLeft = 5
        DefaultItem.NotesTop = 5
        DefaultItem.Info = 'Delete'
        DefaultItem.GraphicRightIndex = 5
        DefaultItem.GraphicRight.Data = {
          89504E470D0A1A0A0000000D494844520000000C0000000C080600000056755C
          E70000020D49444154289135D2CF4B93711C07F0F7E7EB9E6DCEA69BCDAD9A21
          D94F91A9855124548414065EBA44780ABA8487EA68B7A063508728E850B73288
          E8174178E8D032A24B84289B0399CC895BCFCCF9ECD9B3E7FBE3D3A5FE85172F
          626600C0B72BE723BEDBBA2E82E1CBA1586C98D9C0ADD9BFA4D7980D44ACC7E7
          5E655D00206646F6D2A93EE6F0FBF4E8BE4C98CB6C364B3006445D696E208995
          EF4B0B30CDC9894F0B45FA7C21D30EABF36BFF80394A761EDA73A1BD268C0658
          848060143AD68F7C7EFB27FBCE9868BA6A3A195D1B819DE7D49D2F48CD7C64B6
          A2CCA21D7B665E73DFBD79D61B452402B5E1BAE34D07A45453AA52849788C348
          89F0E019ECBEFD16C66BA0637402CD620EF506C32E57E0716C8ADE9DE8F5D3A1
          92A50D2062291C7930878EFD190080B392C3FCB57138E51294066AD42185348A
          94064B0D76B7B6E0ADAF32FFA3F3AA656E6EFE61A900A5C1CA68124D4D8BBE11
          5014C4C0DD97E81EBB88C66A01F5E505EC3C7E16271FBE018211680848602920
          B57A51B71243D1683B3A87C6D0582D50F6EA38A42F71FAD91CC5078F21984CC3
          ADFD2676DD597A3AD2B3431BFEB13719391CEAEA26B75A65677D0D4A8382DD29
          0EEFEA85636F50D9B67302182566C693E1C44165F487644FFC5058102BAF056D
          406485D8D506956A6559089ABCB9E4E4E97F8D479978542A758B095396651D00
          335ABE5F60E6E781B6B6FB3716B7EB00F017AEE61AC3063D505E000000004945
          4E44AE426082}
        DefaultItem.GraphicRightWidth = 12
        DefaultItem.GraphicRightHeight = 12
        DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
        DefaultItem.CaptionFont.Color = clWindowText
        DefaultItem.CaptionFont.Height = -13
        DefaultItem.CaptionFont.Name = 'Segoe UI'
        DefaultItem.CaptionFont.Style = [fsBold]
        DefaultItem.CaptionSelectedFont.Charset = DEFAULT_CHARSET
        DefaultItem.CaptionSelectedFont.Color = clBlue
        DefaultItem.CaptionSelectedFont.Height = -13
        DefaultItem.CaptionSelectedFont.Name = 'Segoe UI'
        DefaultItem.CaptionSelectedFont.Style = [fsBold]
        DefaultItem.InfoFont.Charset = DEFAULT_CHARSET
        DefaultItem.InfoFont.Color = clNavy
        DefaultItem.InfoFont.Height = -11
        DefaultItem.InfoFont.Name = 'Tahoma'
        DefaultItem.InfoFont.Style = [fsUnderline]
        DefaultItem.InfoSelectedFont.Charset = DEFAULT_CHARSET
        DefaultItem.InfoSelectedFont.Color = clBlue
        DefaultItem.InfoSelectedFont.Height = -11
        DefaultItem.InfoSelectedFont.Name = 'Tahoma'
        DefaultItem.InfoSelectedFont.Style = [fsUnderline]
        DefaultItem.NotesFont.Charset = DEFAULT_CHARSET
        DefaultItem.NotesFont.Color = clWindowText
        DefaultItem.NotesFont.Height = -11
        DefaultItem.NotesFont.Name = 'Segoe UI'
        DefaultItem.NotesFont.Style = []
        DefaultItem.ProgressMaximum = 100.000000000000000000
        Layout = lblBubble
        Categories = <>
        Align = alClient
        PopupMenu = popImages
        TabOrder = 0
        TMSStyle = 4
      end
      object pnlLogInput: TPanel
        AlignWithMargins = True
        Left = 20
        Top = 496
        Width = 440
        Height = 89
        Margins.Left = 20
        Margins.Right = 20
        Margins.Bottom = 10
        Align = alBottom
        BevelOuter = bvNone
        Color = 33023
        ParentBackground = False
        TabOrder = 1
        object memDetail: TMemo
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 417
          Height = 87
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          BorderStyle = bsNone
          TabOrder = 0
        end
        object btnAddNewOrUpdateEntry: TAdvGlowButton
          AlignWithMargins = True
          Left = 419
          Top = 1
          Width = 20
          Height = 87
          Hint = 'Add new or updated entry'
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alRight
          ImageIndex = 7
          Images = dmMT2.iml16x16
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnAddNewOrUpdateEntryClick
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
  end
  object btnNewLog: TAdvGlowButton
    AlignWithMargins = True
    Left = 30
    Top = 164
    Width = 91
    Height = 27
    Margins.Left = 20
    Margins.Right = 0
    Caption = 'New Log'
    ImageIndex = 7
    Images = dmMT2.iml16x16
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    Position = bpLeft
    TabOrder = 5
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
  object btnDeleteLog: TAdvGlowButton
    AlignWithMargins = True
    Left = 136
    Top = 164
    Width = 97
    Height = 27
    Margins.Left = 0
    Margins.Right = 0
    Caption = 'Delete'
    ImageIndex = 5
    Images = dmMT2.iml16x16
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    Position = bpMiddle
    TabOrder = 6
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
  object pnlButtons: TPanel
    AlignWithMargins = True
    Left = 322
    Top = 161
    Width = 295
    Height = 33
    Margins.Left = 0
    Margins.Top = 0
    BevelOuter = bvNone
    TabOrder = 7
    object btnClearLog: TAdvGlowButton
      AlignWithMargins = True
      Left = 0
      Top = 3
      Width = 64
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
      TabOrder = 0
      Visible = False
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
    object btnPrintLog: TAdvGlowButton
      AlignWithMargins = True
      Left = 64
      Top = 3
      Width = 64
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
      TabOrder = 1
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
      Left = 128
      Top = 3
      Width = 72
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
      TabOrder = 2
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
  object tmrSaved: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmrSavedTimer
    Left = 488
    Top = 32
  end
  object tmrDeleteEntry: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmrDeleteEntryTimer
    Left = 592
    Top = 32
  end
  object popImages: TAdvPopupMenu
    Version = '2.6.5.11'
    Left = 568
    Top = 104
    object miAddIMge: TMenuItem
      Caption = 'Add an Image'
      OnClick = OpenImageForm
    end
  end
end
