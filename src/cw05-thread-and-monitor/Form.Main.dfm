object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 366
  ClientWidth = 313
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
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 58
    Width = 307
    Height = 305
    Align = alClient
    ColCount = 3
    DefaultColWidth = 72
    DefaultRowHeight = 21
    FixedCols = 0
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitHeight = 260
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 307
    Height = 49
    Align = alTop
    Caption = 'GroupBox1'
    TabOrder = 1
    ExplicitLeft = 48
    ExplicitTop = 0
    ExplicitWidth = 185
    object Label1: TLabel
      AlignWithMargins = True
      Left = 118
      Top = 18
      Width = 73
      Height = 26
      Margins.Left = 10
      Align = alLeft
      Caption = 'Liczba w'#261'tk'#243'w:'
      Layout = tlCenter
      ExplicitHeight = 13
    end
    object btnStart: TButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 100
      Height = 26
      Align = alLeft
      Caption = 'btnStart'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object Edit1: TEdit
      AlignWithMargins = True
      Left = 197
      Top = 20
      Width = 44
      Height = 21
      Margins.Top = 5
      Margins.Bottom = 6
      Align = alLeft
      Alignment = taCenter
      TabOrder = 1
      Text = '10'
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 248
    Top = 80
  end
end
