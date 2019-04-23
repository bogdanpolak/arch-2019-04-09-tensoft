object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 603
  ClientWidth = 635
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
  object PaintBox1: TPaintBox
    AlignWithMargins = True
    Left = 3
    Top = 58
    Width = 629
    Height = 175
    Align = alTop
  end
  object PaintBox2: TPaintBox
    AlignWithMargins = True
    Left = 3
    Top = 239
    Width = 629
    Height = 175
    Align = alTop
  end
  object PaintBox3: TPaintBox
    AlignWithMargins = True
    Left = 3
    Top = 420
    Width = 629
    Height = 175
    Align = alTop
    ExplicitLeft = 6
    ExplicitTop = 247
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 629
    Height = 49
    Align = alTop
    Caption = 'GroupBox1'
    Padding.Bottom = 1
    TabOrder = 0
    ExplicitLeft = -2
    object Label1: TLabel
      AlignWithMargins = True
      Left = 400
      Top = 23
      Width = 55
      Height = 20
      Margins.Left = 12
      Margins.Top = 8
      Align = alLeft
      Caption = 'Swap Time:'
      ExplicitHeight = 13
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 541
      Top = 23
      Width = 13
      Height = 20
      Margins.Top = 8
      Align = alLeft
      Caption = 'ms'
      ExplicitLeft = 517
      ExplicitHeight = 13
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 116
      Height = 25
      Align = alLeft
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 127
      Top = 18
      Width = 116
      Height = 25
      Align = alLeft
      Caption = 'Button2'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 249
      Top = 18
      Width = 136
      Height = 25
      Align = alLeft
      Caption = 'Button3'
      TabOrder = 2
      OnClick = Button3Click
    end
    object edtSwapTime: TEdit
      AlignWithMargins = True
      Left = 461
      Top = 19
      Width = 74
      Height = 22
      Margins.Top = 4
      Margins.Bottom = 5
      Align = alLeft
      Alignment = taCenter
      TabOrder = 3
      Text = '1.3'
      OnChange = edtSwapTimeChange
      ExplicitLeft = 391
      ExplicitHeight = 21
    end
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 224
    Top = 104
  end
end
