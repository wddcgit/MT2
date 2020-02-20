object frmMTSearch: TfrmMTSearch
  Left = 0
  Top = 0
  Caption = 'Search Multi-Tracking'
  ClientHeight = 685
  ClientWidth = 1150
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
  PixelsPerInch = 96
  TextHeight = 13
  object sgSearch: TAdvStringGrid
    AlignWithMargins = True
    Left = 10
    Top = 243
    Width = 1130
    Height = 411
    Cursor = crDefault
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    BorderStyle = bsNone
    DefaultRowHeight = 28
    DrawingStyle = gdsClassic
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goRangeSelect]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    GridLineColor = 15527152
    GridFixedLineColor = 13947601
    HoverRowCells = [hcNormal, hcSelected]
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = 16575452
    ActiveCellColorTo = 16571329
    Bands.Active = True
    Bands.PrimaryColor = 16775408
    ColumnHeaders.Strings = (
      'Log Date'
      'Log ID'
      'Client Name'
      'Category'
      'Summary')
    ColumnSize.Stretch = True
    ControlLook.FixedGradientFrom = clWhite
    ControlLook.FixedGradientTo = clWhite
    ControlLook.FixedGradientMirrorFrom = clWhite
    ControlLook.FixedGradientMirrorTo = clWhite
    ControlLook.FixedGradientHoverFrom = 16710648
    ControlLook.FixedGradientHoverTo = 16446189
    ControlLook.FixedGradientHoverMirrorFrom = 16049367
    ControlLook.FixedGradientHoverMirrorTo = 15258305
    ControlLook.FixedGradientHoverBorder = clWhite
    ControlLook.FixedGradientDownFrom = 15853789
    ControlLook.FixedGradientDownTo = clWhite
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
    FixedColWidth = 126
    FixedRowHeight = 28
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clGray
    FixedFont.Height = -13
    FixedFont.Name = 'Segoe UI'
    FixedFont.Style = []
    FloatFormat = '%.2f'
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
    SortSettings.DefaultFormat = ssAutomatic
    SortSettings.HeaderColor = 16579058
    SortSettings.HeaderColorTo = 16579058
    SortSettings.HeaderMirrorColor = 16380385
    SortSettings.HeaderMirrorColorTo = 16182488
    Version = '8.4.8.5'
    ColWidths = (
      126
      101
      251
      191
      461)
    RowHeights = (
      28
      28)
    object pdfSave: TAdvGridPDFIO
      Left = 880
      Top = 64
      Width = 26
      Height = 26
      Visible = True
      Grid = sgSearch
      Options.DefaultFont.Name = 'Arial'
      Options.Header = 'TMS PDF Header'
      Options.Footer = 'TMS PDF Footer'
      Options.Margins.Left = 20.000000000000000000
      Options.Margins.Top = 50.000000000000000000
      Options.Margins.Right = 20.000000000000000000
      Options.Margins.Bottom = 50.000000000000000000
      Options.HeaderFont.Name = 'Arial'
      Options.FooterFont.Name = 'Arial'
      Options.HeaderMargins.Left = 5.000000000000000000
      Options.HeaderMargins.Top = 5.000000000000000000
      Options.HeaderMargins.Right = 5.000000000000000000
      Options.HeaderMargins.Bottom = 5.000000000000000000
      Options.FooterMargins.Left = 5.000000000000000000
      Options.FooterMargins.Top = 5.000000000000000000
      Options.FooterMargins.Right = 5.000000000000000000
      Options.FooterMargins.Bottom = 5.000000000000000000
      Options.PageNumberMargins.Left = 10.000000000000000000
      Options.PageNumberMargins.Top = 5.000000000000000000
      Options.PageNumberMargins.Right = 10.000000000000000000
      Options.PageNumberMargins.Bottom = 5.000000000000000000
      Options.PageNumberFormat = '%d'
      Options.PageNumberFont.Name = 'Arial'
    end
  end
  object W7InformationBar1: TW7InformationBar
    Left = 0
    Top = 664
    Width = 1150
    Height = 21
    Version = '1.0.2.0'
    object lblRecordCount: TLabel
      AlignWithMargins = True
      Left = 40
      Top = 3
      Width = 83
      Height = 15
      Margins.Left = 40
      Align = alLeft
      Caption = 'lblRecordCount'
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 51
    Width = 1130
    Height = 182
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 21
      Width = 142
      Height = 13
      Caption = 'What do you want to find ?'
    end
    object cbCriteria: TComboBox
      Left = 8
      Top = 40
      Width = 193
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbCriteriaChange
      Items.Strings = (
        'Logs assigned to a group'
        'A Log ID'
        'Logs containing an Invoice Number'
        'Logs containg an item'
        'A word in the text'
        'Logs open longer than x days'
        'A word in the Summary '
        'Logs created by me'
        'Logs created by a selected name')
    end
    object chkOpenOnly: TAdvOfficeCheckBox
      Left = 8
      Top = 67
      Width = 161
      Height = 20
      Checked = True
      TabOrder = 1
      Alignment = taLeftJustify
      Caption = 'Show only Open Logs'
      ReturnIsTab = False
      State = cbChecked
      Version = '1.6.1.0'
    end
    object btnSearch: TAdvGlowButton
      Left = 8
      Top = 133
      Width = 100
      Height = 33
      Caption = 'Search'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ImageIndex = 4
      Images = dmMT2.iml16x16
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnSearchClick
      Appearance.BorderColor = 16744448
      Appearance.Color = 16744448
      Appearance.ColorTo = 16744448
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirror = 16744448
      Appearance.ColorMirrorTo = 16744448
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16744448
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
    end
    object eSearch: TComboBox
      Left = 224
      Top = 40
      Width = 145
      Height = 21
      TabOrder = 3
      OnKeyPress = eSearchKeyPress
    end
    object chtResults: TChart
      AlignWithMargins = True
      Left = 400
      Top = 0
      Width = 727
      Height = 182
      Margins.Left = 400
      Margins.Top = 0
      Margins.Bottom = 0
      BackWall.Color = clWhite
      BackWall.Visible = False
      LeftWall.Visible = False
      Legend.Visible = False
      MarginBottom = 0
      MarginLeft = 0
      MarginRight = 0
      MarginTop = 0
      Title.Font.Name = 'Segoe UI'
      Title.Text.Strings = (
        'TChart')
      OnClickSeries = chtResultsClickSeries
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      View3DWalls = False
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 4
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 17
      object Series1: TPieSeries
        Marks.Font.Name = 'Segoe UI'
        Marks.Frame.Visible = False
        Marks.Style = smsLabelValue
        Marks.BackColor = 15987699
        Marks.Color = 15987699
        XValues.Order = loAscending
        YValues.Name = 'Pie'
        YValues.Order = loNone
        Frame.InnerBrush.BackColor = clRed
        Frame.InnerBrush.Gradient.EndColor = clGray
        Frame.InnerBrush.Gradient.MidColor = clWhite
        Frame.InnerBrush.Gradient.StartColor = 4210752
        Frame.InnerBrush.Gradient.Visible = True
        Frame.MiddleBrush.BackColor = clYellow
        Frame.MiddleBrush.Gradient.EndColor = 8553090
        Frame.MiddleBrush.Gradient.MidColor = clWhite
        Frame.MiddleBrush.Gradient.StartColor = clGray
        Frame.MiddleBrush.Gradient.Visible = True
        Frame.OuterBrush.BackColor = clGreen
        Frame.OuterBrush.Gradient.EndColor = 4210752
        Frame.OuterBrush.Gradient.MidColor = clWhite
        Frame.OuterBrush.Gradient.StartColor = clSilver
        Frame.OuterBrush.Gradient.Visible = True
        Frame.Width = 4
        Bevel.UseBorder = False
        OtherSlice.Legend.Visible = False
        PiePen.Visible = False
        RotationAngle = 2
      end
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 0
    Width = 1130
    Height = 41
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    Color = clBlack
    ParentBackground = False
    TabOrder = 3
    object AdvGlowButton1: TAdvGlowButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 100
      Height = 35
      Align = alLeft
      Caption = 'Save As..'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      TabOrder = 0
      Appearance.BorderColor = clBlack
      Appearance.Color = clBlack
      Appearance.ColorTo = clBlack
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirror = clBlack
      Appearance.ColorMirrorTo = clBlack
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16102556
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
      DropDownButton = True
      DropDownSplit = False
      DropDownMenu = popSave
    end
  end
  object TeeGDIPlus1: TTeeGDIPlus
    Active = True
    TeePanel = chtResults
    Left = 554
    Top = 50
  end
  object popSave: TAdvPopupMenu
    Version = '2.6.6.1'
    Left = 282
    Top = 131
    object PDF1: TMenuItem
      Caption = 'PDF'
      OnClick = PDF1Click
    end
    object xlsx1: TMenuItem
      Caption = 'Excel'
      OnClick = xlsx1Click
    end
  end
  object sd1: TSaveDialog
    Filter = 'PDF|*.pdf'
    Left = 434
    Top = 131
  end
end
