object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Hello, Delphi :)'
  ClientHeight = 289
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 0
    Top = 41
    Width = 554
    Height = 248
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 168
    ExplicitTop = 120
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 41
    Align = alTop
    Caption = 'TopPanel'
    ShowCaption = False
    TabOrder = 1
    ExplicitWidth = 185
    object bSerialize: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 88
      Height = 33
      Align = alLeft
      Caption = 'Serialize'
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitHeight = 39
    end
    object bDesirialize: TButton
      AlignWithMargins = True
      Left = 98
      Top = 4
      Width = 88
      Height = 33
      Align = alLeft
      Caption = 'Deserialize'
      TabOrder = 1
      ExplicitLeft = 180
      ExplicitTop = 2
    end
  end
end
