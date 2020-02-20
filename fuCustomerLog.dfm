object frmCustomerLog: TfrmCustomerLog
  Left = 0
  Top = 0
  Caption = 'Customer Log'
  ClientHeight = 689
  ClientWidth = 1163
  Color = 6249821
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    AlignWithMargins = True
    Left = 489
    Top = 152
    Width = 295
    Height = 33
    Margins.Left = 0
    Margins.Top = 0
    BevelOuter = bvNone
    TabOrder = 0
  end
  object pnlTop: TPanel
    Left = 0
    Top = 25
    Width = 1163
    Height = 41
    Margins.Top = 66
    Align = alTop
    BevelOuter = bvNone
    Color = 5328719
    ParentBackground = False
    TabOrder = 1
    object Label5: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 3
      Width = 49
      Height = 35
      Margins.Left = 10
      Align = alLeft
      Caption = 'Client'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 25
    end
    object btnMemberSearch: TAdvGlowButton
      Left = 168
      Top = 8
      Width = 35
      Height = 27
      Hint = 'Member Search'
      BorderStyle = bsNone
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000097048597300000B1300000B1301009A9C18000005FA69545874584D
        4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B6574206265
        67696E3D22EFBBBF222069643D2257354D304D7043656869487A7265537A4E54
        637A6B633964223F3E203C783A786D706D65746120786D6C6E733A783D226164
        6F62653A6E733A6D6574612F2220783A786D70746B3D2241646F626520584D50
        20436F726520352E362D633134352037392E3136333439392C20323031382F30
        382F31332D31363A34303A32322020202020202020223E203C7264663A524446
        20786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F3139
        39392F30322F32322D7264662D73796E7461782D6E7323223E203C7264663A44
        65736372697074696F6E207264663A61626F75743D222220786D6C6E733A786D
        703D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F22
        20786D6C6E733A64633D22687474703A2F2F7075726C2E6F72672F64632F656C
        656D656E74732F312E312F2220786D6C6E733A70686F746F73686F703D226874
        74703A2F2F6E732E61646F62652E636F6D2F70686F746F73686F702F312E302F
        2220786D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E63
        6F6D2F7861702F312E302F6D6D2F2220786D6C6E733A73744576743D22687474
        703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F73547970652F52
        65736F757263654576656E74232220786D703A43726561746F72546F6F6C3D22
        41646F62652050686F746F73686F702043432032303139202857696E646F7773
        292220786D703A437265617465446174653D22323031392D31302D3130543135
        3A32353A32362D30363A30302220786D703A4D6F64696679446174653D223230
        31392D31302D31305431353A33313A33382D30363A30302220786D703A4D6574
        6164617461446174653D22323031392D31302D31305431353A33313A33382D30
        363A3030222064633A666F726D61743D22696D6167652F706E67222070686F74
        6F73686F703A436F6C6F724D6F64653D2233222070686F746F73686F703A4943
        4350726F66696C653D22735247422049454336313936362D322E312220786D70
        4D4D3A496E7374616E636549443D22786D702E6969643A38363431326663322D
        643037362D363334332D613236332D3031363839336566316139652220786D70
        4D4D3A446F63756D656E7449443D2261646F62653A646F6369643A70686F746F
        73686F703A33613136383531322D363736612D613234642D623963372D353439
        6338316230303732612220786D704D4D3A4F726967696E616C446F63756D656E
        7449443D22786D702E6469643A65633765303932612D373531362D666134332D
        393836642D613236346466393561396161223E203C786D704D4D3A486973746F
        72793E203C7264663A5365713E203C7264663A6C692073744576743A61637469
        6F6E3D2263726561746564222073744576743A696E7374616E636549443D2278
        6D702E6969643A65633765303932612D373531362D666134332D393836642D61
        3236346466393561396161222073744576743A7768656E3D22323031392D3130
        2D31305431353A32353A32362D30363A3030222073744576743A736F66747761
        72654167656E743D2241646F62652050686F746F73686F702043432032303139
        202857696E646F777329222F3E203C7264663A6C692073744576743A61637469
        6F6E3D227361766564222073744576743A696E7374616E636549443D22786D70
        2E6969643A38363431326663322D643037362D363334332D613236332D303136
        383933656631613965222073744576743A7768656E3D22323031392D31302D31
        305431353A33313A33382D30363A3030222073744576743A736F667477617265
        4167656E743D2241646F62652050686F746F73686F7020434320323031392028
        57696E646F777329222073744576743A6368616E6765643D222F222F3E203C2F
        7264663A5365713E203C2F786D704D4D3A486973746F72793E203C2F7264663A
        4465736372697074696F6E3E203C2F7264663A5244463E203C2F783A786D706D
        6574613E203C3F787061636B657420656E643D2272223F3EB0BD39A90000011C
        49444154388DA5934D2BC45114C67F23C5D28A89B5CF602B3E8085ACBC2CA688
        64A169B66C95C882AF602129CA46369AB09B5236B2506425252F0B4DFA59CC49
        7FD3FF8EF0D459DCE73E3D9D7B9E7B0A2AFF417B0E370E8C0275A00FD8053692
        0E6AB6A6D56BF5443D53EFD4BA5A6AD27D55F63067039B6A55DD0F7E2AF8C556
        0693EAB3BAAD5EA83BEA5846580A9362CAE038DABE524F13EDDEAB9566BE2D46
        F1027C0035A09C18D72D30984AA11FE8028680DE844111A8A65228C71B97D481
        9CF687E3BEBB550AB3219A68128D04BFFE538CA80B21BE510F63A8AFEA4A2474
        AECEB43240ED51E7D53D753913DDBB7AA9BE05DF91324855457DB2F1A1548FD4
        DC5D486115E804D66844FE0850F0F7DB78003C005B40ED2F06DFF0093963F10D
        E31EC94E0000000049454E44AE426082}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = OpenMemberSearchForm
      Appearance.Color = 6249821
      Appearance.ColorTo = 6249821
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirror = 6249821
      Appearance.ColorMirrorTo = 6249821
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
      Left = 1064
      Top = 3
      Width = 96
      Height = 35
      Align = alRight
      Caption = 'New Log'
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
      TabOrder = 1
      Visible = False
      OnClick = btnNewLogClick
      Appearance.BorderColor = 5328719
      Appearance.Color = 5328719
      Appearance.ColorTo = 5328719
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirror = 5328719
      Appearance.ColorMirrorTo = 5328719
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
  object Panel1: TPanel
    Left = 0
    Top = 66
    Width = 217
    Height = 623
    Align = alLeft
    BevelOuter = bvNone
    Color = 6249821
    ParentBackground = False
    TabOrder = 2
    object lblClient: THTMLabel
      AlignWithMargins = True
      Left = 10
      Top = 20
      Width = 197
      Height = 19
      Margins.Left = 10
      Margins.Top = 20
      Margins.Right = 10
      Align = alTop
      AutoSizing = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      HTMLText.Strings = (
        'TMS <b>HTML</b> label ')
      ParentFont = False
      Transparent = True
      URLColor = clWhite
      OnAnchorClick = lblClientAnchorClick
      Version = '2.2.1.2'
    end
    object Label1: TLabel
      Left = 10
      Top = 440
      Width = 89
      Height = 21
      Caption = 'CATEGORIES'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = Label1Click
    end
    object Label2: TLabel
      Left = 10
      Top = 240
      Width = 70
      Height = 21
      Caption = 'STATUSES'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbStatusesFilter: TListBox
      AlignWithMargins = True
      Left = 10
      Top = 286
      Width = 197
      Height = 131
      Margins.Left = 10
      Margins.Top = 180
      Margins.Right = 10
      BorderStyle = bsNone
      Color = 6249821
      Columns = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemHeight = 17
      ParentFont = False
      TabOrder = 0
      TabWidth = 80
      OnClick = Label1Click
    end
    object lbCategory: TAdvSmoothComboBox
      Left = 10
      Top = 476
      Width = 193
      Height = 30
      Cursor = crDefault
      Fill.Color = 6249821
      Fill.ColorTo = 6249821
      Fill.ColorMirror = clNone
      Fill.ColorMirrorTo = clNone
      Fill.GradientType = gtSolid
      Fill.GradientMirrorType = gtSolid
      Fill.BorderColor = clNone
      Fill.Rounding = 0
      Fill.ShadowOffset = 0
      Fill.Glow = gmNone
      Items = <
        item
          Caption = 'Item 0'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 1'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 2'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 3'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 4'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 5'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 6'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 7'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 8'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 9'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 10'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 11'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 12'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 13'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 14'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 15'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 16'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 17'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 18'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 19'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end
        item
          Caption = 'Item 20'
          ProgressMaximum = 100.000000000000000000
          ButtonColor = 16765615
        end>
      ItemAppearance.FillAlternate.Color = 16773091
      ItemAppearance.FillAlternate.ColorTo = 16768452
      ItemAppearance.FillAlternate.ColorMirror = 16765357
      ItemAppearance.FillAlternate.ColorMirrorTo = 16767936
      ItemAppearance.FillAlternate.GradientType = gtVertical
      ItemAppearance.FillAlternate.GradientMirrorType = gtVertical
      ItemAppearance.FillAlternate.BorderColor = 16765357
      ItemAppearance.FillAlternate.Rounding = 0
      ItemAppearance.FillAlternate.ShadowOffset = 0
      ItemAppearance.FillAlternate.Glow = gmNone
      ItemAppearance.Fill.Color = 6249821
      ItemAppearance.Fill.ColorTo = 6249821
      ItemAppearance.Fill.ColorMirror = 6249821
      ItemAppearance.Fill.ColorMirrorTo = 6249821
      ItemAppearance.Fill.GradientType = gtVertical
      ItemAppearance.Fill.GradientMirrorType = gtVertical
      ItemAppearance.Fill.BorderColor = 6249821
      ItemAppearance.Fill.Rounding = 0
      ItemAppearance.Fill.ShadowOffset = 0
      ItemAppearance.Fill.Glow = gmNone
      ItemAppearance.FillSelected.Color = 11196927
      ItemAppearance.FillSelected.ColorTo = 7257087
      ItemAppearance.FillSelected.ColorMirror = 4370174
      ItemAppearance.FillSelected.ColorMirrorTo = 8053246
      ItemAppearance.FillSelected.GradientType = gtVertical
      ItemAppearance.FillSelected.GradientMirrorType = gtVertical
      ItemAppearance.FillSelected.BorderColor = 16765357
      ItemAppearance.FillSelected.Rounding = 0
      ItemAppearance.FillSelected.ShadowOffset = 0
      ItemAppearance.FillSelected.Glow = gmNone
      ItemAppearance.FillSelectedAlternate.Color = 11196927
      ItemAppearance.FillSelectedAlternate.ColorTo = 7257087
      ItemAppearance.FillSelectedAlternate.ColorMirror = 4370174
      ItemAppearance.FillSelectedAlternate.ColorMirrorTo = 8053246
      ItemAppearance.FillSelectedAlternate.GradientType = gtVertical
      ItemAppearance.FillSelectedAlternate.GradientMirrorType = gtVertical
      ItemAppearance.FillSelectedAlternate.BorderColor = 16765357
      ItemAppearance.FillSelectedAlternate.Rounding = 0
      ItemAppearance.FillSelectedAlternate.ShadowOffset = 0
      ItemAppearance.FillSelectedAlternate.Glow = gmNone
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
      ItemAppearance.DeleteButtonCaption = 'Delete'
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
      Footer.Fill.Color = 16773091
      Footer.Fill.ColorTo = 16765615
      Footer.Fill.ColorMirror = clNone
      Footer.Fill.ColorMirrorTo = clNone
      Footer.Fill.GradientType = gtVertical
      Footer.Fill.GradientMirrorType = gtSolid
      Footer.Fill.BorderColor = 16765615
      Footer.Fill.Rounding = 0
      Footer.Fill.ShadowOffset = 0
      Footer.Fill.Glow = gmNone
      Footer.Caption = 'Footer'
      Footer.Font.Charset = DEFAULT_CHARSET
      Footer.Font.Color = 7485192
      Footer.Font.Height = -13
      Footer.Font.Name = 'Tahoma'
      Footer.Font.Style = []
      Footer.Visible = False
      OnItemSelected = lbCategoryItemSelected
      DefaultItem.Caption = 'Item 0'
      DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
      DefaultItem.CaptionFont.Color = clWhite
      DefaultItem.CaptionFont.Height = -13
      DefaultItem.CaptionFont.Name = 'Segoe UI'
      DefaultItem.CaptionFont.Style = []
      DefaultItem.ProgressMaximum = 100.000000000000000000
      Categories = <>
      TabOrder = 1
      Text = ''
      ItemBackGroundFill.Color = 6249821
      ItemBackGroundFill.ColorTo = 6249821
      ItemBackGroundFill.ColorMirror = 6249821
      ItemBackGroundFill.ColorMirrorTo = 6249821
      ItemBackGroundFill.GradientType = gtVertical
      ItemBackGroundFill.GradientMirrorType = gtVertical
      ItemBackGroundFill.BorderColor = 6249821
      ItemBackGroundFill.Rounding = 0
      ItemBackGroundFill.ShadowOffset = 0
      ItemBackGroundFill.Glow = gmNone
      ButtonAppearance.ArrowColor = clWhite
      ButtonAppearance.ArrowColorHover = clWhite
      ButtonAppearance.ArrowColorDown = clWhite
      ButtonAppearance.Fill.Color = 6249821
      ButtonAppearance.Fill.ColorTo = 6249821
      ButtonAppearance.Fill.ColorMirror = 6249821
      ButtonAppearance.Fill.ColorMirrorTo = 6249821
      ButtonAppearance.Fill.GradientType = gtVertical
      ButtonAppearance.Fill.GradientMirrorType = gtVertical
      ButtonAppearance.Fill.BorderColor = 6249821
      ButtonAppearance.Fill.Rounding = 0
      ButtonAppearance.Fill.ShadowOffset = 0
      ButtonAppearance.Fill.Glow = gmNone
      ButtonAppearance.FillDown.Color = 11196927
      ButtonAppearance.FillDown.ColorTo = 7257087
      ButtonAppearance.FillDown.ColorMirror = 4370174
      ButtonAppearance.FillDown.ColorMirrorTo = 8053246
      ButtonAppearance.FillDown.GradientType = gtVertical
      ButtonAppearance.FillDown.GradientMirrorType = gtVertical
      ButtonAppearance.FillDown.BorderColor = 16765615
      ButtonAppearance.FillDown.Rounding = 0
      ButtonAppearance.FillDown.ShadowOffset = 0
      ButtonAppearance.FillDown.Glow = gmNone
      ButtonAppearance.FillHover.Color = 15465983
      ButtonAppearance.FillHover.ColorTo = 11332863
      ButtonAppearance.FillHover.ColorMirror = 5888767
      ButtonAppearance.FillHover.ColorMirrorTo = 10807807
      ButtonAppearance.FillHover.GradientType = gtVertical
      ButtonAppearance.FillHover.GradientMirrorType = gtVertical
      ButtonAppearance.FillHover.BorderColor = 16765615
      ButtonAppearance.FillHover.Rounding = 0
      ButtonAppearance.FillHover.ShadowOffset = 0
      ButtonAppearance.FillHover.Glow = gmNone
      TMSStyle = 4
    end
  end
  object Panel2: TPanel
    Left = 217
    Top = 66
    Width = 946
    Height = 623
    Align = alClient
    BevelOuter = bvNone
    Color = 15197154
    ParentBackground = False
    TabOrder = 3
    object lblSummary: THTMLabel
      AlignWithMargins = True
      Left = 20
      Top = 10
      Width = 923
      Height = 19
      Margins.Left = 20
      Margins.Top = 10
      Align = alTop
      AutoSizing = True
      HTMLText.Strings = (
        'TMS <b>HTML</b> label ')
      Transparent = True
      Version = '2.2.1.2'
    end
    object tlLogs: TAdvSmoothTileList
      AlignWithMargins = True
      Left = 0
      Top = 32
      Width = 946
      Height = 591
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      PictureContainer = dmMT2.pcMIsc
      ImageList = dmMT2.imlStatus
      AnimationFactor = 4.000000000000000000
      Fill.Color = 15197154
      Fill.ColorTo = 15197154
      Fill.ColorMirror = clNone
      Fill.ColorMirrorTo = clNone
      Fill.GradientType = gtSolid
      Fill.GradientMirrorType = gtSolid
      Fill.BorderColor = 15197154
      Fill.Rounding = 0
      Fill.ShadowOffset = 0
      Fill.Glow = gmNone
      Tiles = <
        item
          Content.Text = '<b>Tile 1</b>'
          Content.TextPosition = tpTopLeft
          Content.CheckBoxEnabled = False
          ContentMaximized.Text = 'Description for Tile 1'
          Visualizer = AdvSmoothTileListHTMLVisualizer1
          VisualizerMaximized = AdvSmoothTileListHTMLVisualizer2
          DeleteIndicator = 'X'
          SubTiles = <>
          Tag = 0
        end>
      Columns = 1
      Rows = 5
      TileAppearance.LargeViewFill.Color = 12369084
      TileAppearance.LargeViewFill.ColorMirror = clNone
      TileAppearance.LargeViewFill.ColorMirrorTo = clNone
      TileAppearance.LargeViewFill.GradientType = gtSolid
      TileAppearance.LargeViewFill.GradientMirrorType = gtNone
      TileAppearance.LargeViewFill.Opacity = 180
      TileAppearance.LargeViewFill.BorderColor = 10987431
      TileAppearance.LargeViewFill.Rounding = 0
      TileAppearance.LargeViewFill.ShadowOffset = 0
      TileAppearance.LargeViewFill.Glow = gmNone
      TileAppearance.SmallViewFill.Color = clWhite
      TileAppearance.SmallViewFill.ColorTo = clWhite
      TileAppearance.SmallViewFill.ColorMirror = 15790320
      TileAppearance.SmallViewFill.ColorMirrorTo = 15790320
      TileAppearance.SmallViewFill.GradientType = gtHorizontal
      TileAppearance.SmallViewFill.GradientMirrorType = gtHorizontal
      TileAppearance.SmallViewFill.Opacity = 180
      TileAppearance.SmallViewFill.BorderColor = 12566463
      TileAppearance.SmallViewFill.Rounding = 5
      TileAppearance.SmallViewFill.ShadowOffset = 0
      TileAppearance.SmallViewFill.Glow = gmNone
      TileAppearance.SmallViewFillSelected.Color = 11196927
      TileAppearance.SmallViewFillSelected.ColorTo = 7257087
      TileAppearance.SmallViewFillSelected.ColorMirror = 4370174
      TileAppearance.SmallViewFillSelected.ColorMirrorTo = 8053246
      TileAppearance.SmallViewFillSelected.GradientType = gtVertical
      TileAppearance.SmallViewFillSelected.GradientMirrorType = gtVertical
      TileAppearance.SmallViewFillSelected.BorderColor = 6973542
      TileAppearance.SmallViewFillSelected.Rounding = 0
      TileAppearance.SmallViewFillSelected.ShadowOffset = 0
      TileAppearance.SmallViewFillSelected.Glow = gmNone
      TileAppearance.SmallViewFillDisabled.Color = clGray
      TileAppearance.SmallViewFillDisabled.ColorMirror = clNone
      TileAppearance.SmallViewFillDisabled.ColorMirrorTo = clNone
      TileAppearance.SmallViewFillDisabled.GradientType = gtSolid
      TileAppearance.SmallViewFillDisabled.GradientMirrorType = gtSolid
      TileAppearance.SmallViewFillDisabled.BorderColor = 10987431
      TileAppearance.SmallViewFillDisabled.Rounding = 0
      TileAppearance.SmallViewFillDisabled.ShadowOffset = 0
      TileAppearance.SmallViewFillDisabled.Glow = gmNone
      TileAppearance.SmallViewFillHover.Color = 12369084
      TileAppearance.SmallViewFillHover.ColorMirror = clNone
      TileAppearance.SmallViewFillHover.ColorMirrorTo = clNone
      TileAppearance.SmallViewFillHover.GradientType = gtSolid
      TileAppearance.SmallViewFillHover.GradientMirrorType = gtNone
      TileAppearance.SmallViewFillHover.Opacity = 220
      TileAppearance.SmallViewFillHover.BorderColor = 10987431
      TileAppearance.SmallViewFillHover.Rounding = 0
      TileAppearance.SmallViewFillHover.ShadowOffset = 0
      TileAppearance.SmallViewFillHover.Glow = gmNone
      TileAppearance.LargeViewFont.Charset = DEFAULT_CHARSET
      TileAppearance.LargeViewFont.Color = clWindowText
      TileAppearance.LargeViewFont.Height = -11
      TileAppearance.LargeViewFont.Name = 'Tahoma'
      TileAppearance.LargeViewFont.Style = []
      TileAppearance.SmallViewFont.Charset = DEFAULT_CHARSET
      TileAppearance.SmallViewFont.Color = clWindowText
      TileAppearance.SmallViewFont.Height = -11
      TileAppearance.SmallViewFont.Name = 'Segoe UI'
      TileAppearance.SmallViewFont.Style = []
      TileAppearance.SmallViewFontSelected.Charset = DEFAULT_CHARSET
      TileAppearance.SmallViewFontSelected.Color = clWindowText
      TileAppearance.SmallViewFontSelected.Height = -11
      TileAppearance.SmallViewFontSelected.Name = 'Tahoma'
      TileAppearance.SmallViewFontSelected.Style = []
      TileAppearance.SmallViewFontDisabled.Charset = DEFAULT_CHARSET
      TileAppearance.SmallViewFontDisabled.Color = clWindowText
      TileAppearance.SmallViewFontDisabled.Height = -11
      TileAppearance.SmallViewFontDisabled.Name = 'Tahoma'
      TileAppearance.SmallViewFontDisabled.Style = []
      TileAppearance.SmallViewFontHover.Charset = DEFAULT_CHARSET
      TileAppearance.SmallViewFontHover.Color = clWindowText
      TileAppearance.SmallViewFontHover.Height = -11
      TileAppearance.SmallViewFontHover.Name = 'Tahoma'
      TileAppearance.SmallViewFontHover.Style = []
      TileAppearance.StatusIndicatorAppearance.Fill.Color = clRed
      TileAppearance.StatusIndicatorAppearance.Fill.ColorMirror = clNone
      TileAppearance.StatusIndicatorAppearance.Fill.ColorMirrorTo = clNone
      TileAppearance.StatusIndicatorAppearance.Fill.GradientType = gtSolid
      TileAppearance.StatusIndicatorAppearance.Fill.GradientMirrorType = gtSolid
      TileAppearance.StatusIndicatorAppearance.Fill.BorderColor = clGray
      TileAppearance.StatusIndicatorAppearance.Fill.Rounding = 0
      TileAppearance.StatusIndicatorAppearance.Fill.ShadowOffset = 0
      TileAppearance.StatusIndicatorAppearance.Fill.Glow = gmNone
      TileAppearance.StatusIndicatorAppearance.Font.Charset = DEFAULT_CHARSET
      TileAppearance.StatusIndicatorAppearance.Font.Color = clWhite
      TileAppearance.StatusIndicatorAppearance.Font.Height = -11
      TileAppearance.StatusIndicatorAppearance.Font.Name = 'Tahoma'
      TileAppearance.StatusIndicatorAppearance.Font.Style = []
      TileAppearance.DeleteIndicatorAppearance.Fill.Color = clBlack
      TileAppearance.DeleteIndicatorAppearance.Fill.ColorMirror = clNone
      TileAppearance.DeleteIndicatorAppearance.Fill.ColorMirrorTo = clNone
      TileAppearance.DeleteIndicatorAppearance.Fill.GradientType = gtSolid
      TileAppearance.DeleteIndicatorAppearance.Fill.GradientMirrorType = gtSolid
      TileAppearance.DeleteIndicatorAppearance.Fill.BorderColor = clWhite
      TileAppearance.DeleteIndicatorAppearance.Fill.Rounding = 0
      TileAppearance.DeleteIndicatorAppearance.Fill.ShadowOffset = 0
      TileAppearance.DeleteIndicatorAppearance.Fill.Glow = gmNone
      TileAppearance.DeleteIndicatorAppearance.Font.Charset = DEFAULT_CHARSET
      TileAppearance.DeleteIndicatorAppearance.Font.Color = clWhite
      TileAppearance.DeleteIndicatorAppearance.Font.Height = -11
      TileAppearance.DeleteIndicatorAppearance.Font.Name = 'Tahoma'
      TileAppearance.DeleteIndicatorAppearance.Font.Style = []
      Header.Visible = False
      Header.Fill.Color = 15197154
      Header.Fill.ColorTo = 15197154
      Header.Fill.ColorMirror = 15197154
      Header.Fill.ColorMirrorTo = 15197154
      Header.Fill.GradientType = gtVertical
      Header.Fill.GradientMirrorType = gtVertical
      Header.Fill.BorderColor = 15197154
      Header.Fill.Rounding = 0
      Header.Fill.ShadowOffset = 0
      Header.Fill.Glow = gmNone
      Header.Navigation = False
      Header.ArrowNavigation = False
      Header.ShowPages = False
      Header.Caption = '<b>Nbr of Records</b>'
      Header.CaptionLeft = 5
      Header.CaptionTop = 5
      Header.CaptionPosition = tpCenterRight
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Segoe UI'
      Header.Font.Style = []
      Footer.Fill.Color = 10655892
      Footer.Fill.ColorTo = 8749179
      Footer.Fill.ColorMirror = 8156785
      Footer.Fill.ColorMirrorTo = 6775131
      Footer.Fill.GradientType = gtVertical
      Footer.Fill.GradientMirrorType = gtVertical
      Footer.Fill.BorderColor = 6973542
      Footer.Fill.Rounding = 0
      Footer.Fill.ShadowOffset = 0
      Footer.Fill.Glow = gmNone
      Footer.Font.Charset = DEFAULT_CHARSET
      Footer.Font.Color = clWindowText
      Footer.Font.Height = -11
      Footer.Font.Name = 'Tahoma'
      Footer.Font.Style = []
      Visualizer = AdvSmoothTileListHTMLVisualizer1
      VisualizerMaximized = AdvSmoothTileListHTMLVisualizer2
      Options = []
      OnTileAnchorClick = tlLogsTileAnchorClick
      Align = alClient
      TabOrder = 0
      OnDblClick = tlLogsDblClick
      DoubleBuffered = True
      ExplicitTop = 19
      ExplicitHeight = 604
      TMSStyle = 0
    end
  end
  object pnlAdmin: TPanel
    Left = 0
    Top = 0
    Width = 1163
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Color = 13948116
    ParentBackground = False
    TabOrder = 4
    object btnMTAlert: TAdvGlowButton
      AlignWithMargins = True
      Left = 776
      Top = 3
      Width = 195
      Height = 19
      Margins.Right = 30
      Align = alRight
      Caption = 'New Notifications'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 64
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ImageIndex = 6
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000018849444154388D9DD3BF6B535118C6F1CFB989495BC448D29849840E
        4275100745FC0304A7147514DC1DA44AD1C50E82E0E8EEEE2A15874E8E4E0EC5
        450741705182FD45D1C4FC3C0E3726243771F09DCE3DEFF37C79DEC37B03C407
        D5BADF1EA382817F57823D454FC3F31FAF43BC5FAD6BDB9A291DF48796DC6C54
        D15A5EDB66A6112307BB2C14D2EF5687F232214CEADA36F32867CC8D5D9EBDE3
        ECD5F4EECB7B1E5EE65406524E4CCFDC3CE4D6C6D80C2B97B8FD845F07992193
        4CFC568F6BF7B2F35EDFA0D9CF5C4F0262A48DCAE92CA0B894AA07938127019D
        26ABE7B3E6BF75EE4AAA9909E877693479F4763EE0EE4BBEB5E8F7A600831E21
        C79BC8C9DA7C407585ED8830DA911410721CEDCD374ED7CF7D426ACDA78040A9
        C2CDC0EA45CE5CE0B0C1A03BCC792C4DF6F5039F76A85546FB901FA748A82DD3
        F8CCC71D5E450EBE9324946ADC08548EA79AF1322509F647D142A0B048A9C08B
        3BC3B6F45C2AA4BDC94DDC0F71BD5AD7B5254ECDD93AA2D94ECF4B45164F64DF
        62C15A80B85EADEBFCDFEFFC072B9E7144D3B991800000000049454E44AE4260
        82}
      TabOrder = 0
      Visible = False
      OnClick = btnMTAlertClick
      Appearance.BorderColor = 13948116
      Appearance.Color = 13948116
      Appearance.ColorTo = 13948116
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirror = 13948116
      Appearance.ColorMirrorTo = 13948116
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16102556
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
    end
    object btnMTSearch: TAdvGlowButton
      Left = 1122
      Top = 0
      Width = 41
      Height = 25
      Align = alRight
      ImageIndex = 4
      Images = dmMT2.iml16Gray
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      TabOrder = 1
      OnClick = btnMTSearchClick
      Appearance.BorderColor = 13948116
      Appearance.Color = 13948116
      Appearance.ColorTo = 13948116
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirror = 13948116
      Appearance.ColorMirrorTo = 13948116
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16102556
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
    end
    object btnMTReports: TAdvGlowButton
      Left = 41
      Top = 0
      Width = 41
      Height = 25
      Align = alLeft
      ImageIndex = 3
      Images = dmMT2.iml16Gray
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      TabOrder = 2
      OnClick = btnMTReportsClick
      Appearance.BorderColor = 13948116
      Appearance.Color = 13948116
      Appearance.ColorTo = 13948116
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirror = 13948116
      Appearance.ColorMirrorTo = 13948116
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16102556
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
    end
    object btnMTAdmin: TAdvGlowButton
      Left = 0
      Top = 0
      Width = 41
      Height = 25
      Align = alLeft
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000097048597300000EC400000EC401952B0E1B000001C54944415438CB
        95523D8B1351143D37234E46084854D204C4C6B559B4592CC58505D74658ACF4
        0F4C98A4C8072992E225904C11304148DEFB09361676367EA0B508E964AB954D
        15DC88A0C9F2C8BC6B93198661B2E88507EF9DFBF1EEB9E71233639B954A2506
        805C2EB733180C8ED3622EC51FAD56EBA9EFFBAF01A05EAFEF86B8D6FA00C031
        0074BB5D4B0811843E0A3B2897CB1C040188E813804700A6CC7C1B0088E84C4A
        79DDF3BC7D63CCFB4C2683C964425101DFF733B3D92CB8884ED2F2F9FCB37EBF
        FF2ADEC1C320083EFC4B32117D96523E48CEE04B4AEC6F00160027813F8E8A35
        9BCD9B5AEB7DADF5D818732574388E7375381CFEDA0CB4B85C2E4F631D7CB76D
        FB68341A7D25D775D3889F28A56E25243D0390BF50C6989DA760CBD4024A296A
        341ABBABD5EAA331E6DA06BF9352A018A3F0279BCD566DDB7E17A9E079DE8E31
        E65B22690A8001DC4BA870434AF92349E145CAAF77B750DC03F0365A2421C493
        F97CFE06FF618542C1E9743AE711854AA5C2EBF51A96651D023861E6A931E6F2
        A6E59F44741FC04B63CCA16559188FC7040060E6E8F47A3D3BBCD76AB5E7AEEB
        B2EBBA5CAD56F7425C087114CFA16DFBDF6EB78B8BC5E214009452B48DCA5F34
        79D80D6250134B0000000049454E44AE426082}
      TabOrder = 3
      OnClick = btnMTAdminClick
      Appearance.BorderColor = 13948116
      Appearance.Color = 13948116
      Appearance.ColorTo = 13948116
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirror = 13948116
      Appearance.ColorMirrorTo = 13948116
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16102556
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
    end
    object eSearch: TAdvEdit
      Left = 1001
      Top = 0
      Width = 121
      Height = 25
      BorderColor = 13948116
      EmptyText = 'Type Search'
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
      BevelInner = bvNone
      BevelOuter = bvNone
      Align = alRight
      BorderStyle = bsNone
      Color = 13948116
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = ''
      Visible = True
      OnKeyPress = eSearchKeyPress
      Version = '3.5.0.3'
    end
  end
  object tmrDeleteEntry: TTimer
    Enabled = False
    Interval = 3000
    Left = 1136
    Top = 64
  end
  object popImages: TAdvPopupMenu
    Version = '2.6.6.1'
    Left = 944
    Top = 176
    object miAddIMge: TMenuItem
      Caption = 'Add an Image'
    end
  end
  object AdvSmoothTileListHTMLVisualizer1: TAdvSmoothTileListHTMLVisualizer
    Left = 1072
    Top = 80
  end
  object tmrByCategory: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrByCategoryTimer
    Left = 1041
    Top = 353
  end
  object AdvSmoothTileListHTMLVisualizer2: TAdvSmoothTileListHTMLVisualizer
    Left = 1088
    Top = 480
  end
  object AdvSmoothTileListImageVisualizer1: TAdvSmoothTileListImageVisualizer
    Left = 1088
    Top = 568
  end
  object tmrValidateADSI: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrValidateADSITimer
    Left = 873
    Top = 410
  end
end
