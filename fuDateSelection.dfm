object frmDateSelection: TfrmDateSelection
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select Date Time'
  ClientHeight = 104
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 51
    Height = 13
    Caption = 'Start Date'
  end
  object Label2: TLabel
    Left = 192
    Top = 8
    Width = 47
    Height = 13
    Caption = 'End Date'
  end
  object dtpStart: TDateTimePicker
    Left = 8
    Top = 29
    Width = 160
    Height = 21
    Date = 42209.435355150460000000
    Time = 42209.435355150460000000
    TabOrder = 0
  end
  object dtpEnd: TDateTimePicker
    Left = 190
    Top = 29
    Width = 155
    Height = 21
    Date = 42209.435369803240000000
    Time = 42209.435369803240000000
    TabOrder = 1
  end
  object AdvGlowButton1: TAdvGlowButton
    Left = 280
    Top = 72
    Width = 65
    Height = 24
    Caption = 'OK'
    ModalResult = 1
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    TabOrder = 2
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
