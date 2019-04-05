object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 433
  ClientWidth = 741
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 169
    Top = 0
    Width = 5
    Height = 433
    ExplicitLeft = 252
    ExplicitHeight = 399
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 166
    Height = 427
    Margins.Right = 0
    Align = alLeft
    Caption = 'GroupBox1'
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitTop = 8
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 46
      Width = 156
      Height = 26
      Margins.Top = 0
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Tworzenie JSON Array oraz JSON Object'
      WordWrap = True
      ExplicitWidth = 135
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 113
      Width = 156
      Height = 13
      Margins.Top = 0
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Dodanie elementu do tablicy'
      WordWrap = True
      ExplicitWidth = 135
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 167
      Width = 156
      Height = 26
      Margins.Top = 0
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Zaminia obiektu na JSON i odwrotnie'
      WordWrap = True
      ExplicitWidth = 126
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 234
      Width = 156
      Height = 26
      Margins.Top = 0
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Zamiana TDataSet na TJSONArray'
      WordWrap = True
      ExplicitWidth = 106
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 301
      Width = 156
      Height = 39
      Margins.Top = 0
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Zamiana TDataSet na TJSONArray za pomoc'#261' TFDBatchMove'
      WordWrap = True
      ExplicitWidth = 116
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 156
      Height = 25
      Align = alTop
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 5
      Top = 85
      Width = 156
      Height = 25
      Align = alTop
      Caption = 'Button2'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 5
      Top = 139
      Width = 156
      Height = 25
      Align = alTop
      Caption = 'Button3'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      AlignWithMargins = True
      Left = 5
      Top = 206
      Width = 156
      Height = 25
      Align = alTop
      Caption = 'Button4'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      AlignWithMargins = True
      Left = 5
      Top = 273
      Width = 156
      Height = 25
      Align = alTop
      Caption = 'Button5'
      TabOrder = 4
      OnClick = Button5Click
      ExplicitLeft = 40
      ExplicitTop = 296
      ExplicitWidth = 75
    end
    object btnClearMemo: TButton
      AlignWithMargins = True
      Left = 5
      Top = 397
      Width = 156
      Height = 25
      Align = alBottom
      Caption = 'btnClearMemo'
      TabOrder = 5
      OnClick = btnClearMemoClick
      ExplicitLeft = 91
      ExplicitTop = 232
      ExplicitWidth = 75
    end
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 174
    Top = 3
    Width = 564
    Height = 427
    Margins.Left = 0
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitLeft = 177
    ExplicitTop = -2
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=SQLite_Demo')
    LoginPrompt = False
    Left = 224
    Top = 96
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      '')
    Left = 224
    Top = 152
  end
end
