object frmCreateNewLog: TfrmCreateNewLog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Create New Log'
  ClientHeight = 187
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel
    Left = 24
    Top = 24
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
  object Label3: TLabel
    Left = 408
    Top = 24
    Width = 56
    Height = 13
    Caption = 'Assigned to'
  end
  object Label2: TLabel
    Left = 200
    Top = 24
    Width = 45
    Height = 13
    Caption = 'Category'
  end
  object Label1: TLabel
    Left = 24
    Top = 77
    Width = 44
    Height = 13
    Caption = 'Summary'
  end
  object Label4: TLabel
    Left = 24
    Top = 129
    Width = 23
    Height = 13
    Caption = 'JIRA'
  end
  object cbCNL_Caller: TComboBox
    Left = 24
    Top = 43
    Width = 153
    Height = 21
    TabOrder = 0
  end
  object cbCNL_Ctgy: TComboBox
    Left = 200
    Top = 43
    Width = 176
    Height = 21
    Style = csDropDownList
    TabOrder = 1
  end
  object cbCNL_AssignedTo: TComboBox
    Left = 408
    Top = 43
    Width = 153
    Height = 21
    Style = csDropDownList
    TabOrder = 2
  end
  object btnCreateNewLog: TAdvGlowButton
    Left = 440
    Top = 136
    Width = 121
    Height = 33
    Caption = 'Create New Log'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnCreateNewLogClick
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
    Appearance.ColorMirrorDown = 16102556
    Appearance.ColorMirrorDownTo = 16768988
    Appearance.ColorMirrorChecked = 16102556
    Appearance.ColorMirrorCheckedTo = 16768988
    Appearance.ColorMirrorDisabled = 11974326
    Appearance.ColorMirrorDisabledTo = 15921906
  end
  object cbLogSummary: TComboBox
    Left = 24
    Top = 96
    Width = 537
    Height = 21
    TabOrder = 4
  end
  object eJIRA: TEdit
    Left = 24
    Top = 148
    Width = 121
    Height = 21
    TabOrder = 5
  end
end
