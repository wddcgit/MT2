object frmChangeLogStatus: TfrmChangeLogStatus
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Change Log Status'
  ClientHeight = 155
  ClientWidth = 507
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 29
    Width = 31
    Height = 13
    Caption = 'Status'
  end
  object Label2: TLabel
    Left = 128
    Top = 29
    Width = 58
    Height = 13
    Caption = 'Changed By'
  end
  object Label3: TLabel
    Left = 296
    Top = 29
    Width = 60
    Height = 13
    Caption = 'Changed On'
  end
  object cbStatus: TComboBox
    Left = 24
    Top = 48
    Width = 81
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 0
    Text = 'Open'
    Items.Strings = (
      'Open'
      'Closed')
  end
  object eChangedBy: TEdit
    Left = 128
    Top = 48
    Width = 153
    Height = 21
    TabOrder = 1
  end
  object dtpChangedOn: TDateTimePicker
    Left = 296
    Top = 48
    Width = 186
    Height = 21
    Date = 43510.380225023150000000
    Time = 43510.380225023150000000
    TabOrder = 2
  end
  object AdvGlowButton1: TAdvGlowButton
    Left = 382
    Top = 106
    Width = 100
    Height = 31
    Caption = 'Set Status'
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
    TabOrder = 3
    OnClick = AdvGlowButton1Click
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
end
