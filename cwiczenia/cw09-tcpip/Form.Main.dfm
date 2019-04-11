object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 398
  ClientWidth = 461
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
  object Splitter1: TSplitter
    Left = 193
    Top = 54
    Width = 5
    Height = 344
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 57
    Width = 190
    Height = 338
    Margins.Right = 0
    Align = alLeft
    Caption = 'TCP Client'
    TabOrder = 1
    ExplicitLeft = 6
    object GroupBoxSend: TGroupBox
      AlignWithMargins = True
      Left = 7
      Top = 143
      Width = 176
      Height = 96
      Margins.Left = 5
      Margins.Top = 10
      Margins.Right = 5
      Align = alTop
      Caption = 'Wy'#347'lij tekst'
      TabOrder = 1
      ExplicitLeft = 5
      ExplicitTop = 49
      ExplicitWidth = 175
      object btnSend: TButton
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 166
        Height = 25
        Align = alTop
        Caption = 'btnSend'
        TabOrder = 0
        OnClick = btnSendClick
        ExplicitTop = 49
        ExplicitWidth = 175
      end
      object Edit1: TEdit
        AlignWithMargins = True
        Left = 5
        Top = 49
        Width = 166
        Height = 21
        Align = alTop
        TabOrder = 1
        Text = 'Akademia BSC Polska'
        OnKeyPress = Edit1KeyPress
        ExplicitLeft = 24
        ExplicitTop = 40
        ExplicitWidth = 121
      end
    end
    object GroupBoxConnect: TGroupBox
      AlignWithMargins = True
      Left = 7
      Top = 25
      Width = 176
      Height = 105
      Margins.Left = 5
      Margins.Top = 10
      Margins.Right = 5
      Align = alTop
      Caption = 'Po'#322#261'cz'
      TabOrder = 0
      ExplicitLeft = 9
      object Label2: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 49
        Width = 166
        Height = 13
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Host:'
        ExplicitWidth = 26
      end
      object btnConnect: TButton
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 166
        Height = 25
        Align = alTop
        Caption = 'btnConnect'
        TabOrder = 0
        OnClick = btnConnectClick
        ExplicitWidth = 175
      end
      object edtHost: TEdit
        AlignWithMargins = True
        Left = 5
        Top = 65
        Width = 166
        Height = 21
        Align = alTop
        TabOrder = 1
        Text = 'localhost'
        ExplicitLeft = 35
        ExplicitTop = 68
        ExplicitWidth = 121
      end
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 198
    Top = 57
    Width = 260
    Height = 338
    Margins.Left = 0
    Align = alClient
    Caption = 'TCP Server'
    TabOrder = 2
    ExplicitLeft = 196
    ExplicitWidth = 259
    object btnStartServer: TButton
      AlignWithMargins = True
      Left = 5
      Top = 56
      Width = 250
      Height = 25
      Align = alTop
      Caption = 'btnStartServer'
      TabOrder = 0
      OnClick = btnStartServerClick
      ExplicitLeft = 0
      ExplicitTop = 80
      ExplicitWidth = 175
    end
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 94
      Width = 250
      Height = 239
      Margins.Top = 10
      Align = alClient
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssVertical
      TabOrder = 1
      ExplicitTop = 49
      ExplicitWidth = 175
      ExplicitHeight = 188
    end
    object pnServerStatus: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 25
      Width = 250
      Height = 25
      Margins.Top = 10
      Align = alTop
      BevelOuter = bvLowered
      Caption = 'Server Status'
      TabOrder = 2
      ExplicitLeft = 7
      ExplicitTop = 18
      ExplicitWidth = 197
      object Shape1: TShape
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 45
        Height = 17
        Align = alLeft
      end
    end
  end
  object GroupBoxParams: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 455
    Height = 46
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Parametry po'#322#261'czenia'
    TabOrder = 0
    ExplicitWidth = 444
    object Label1: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 18
      Width = 24
      Height = 21
      Margins.Left = 10
      Margins.Bottom = 5
      Align = alLeft
      Caption = 'Port:'
      Layout = tlCenter
      ExplicitHeight = 13
    end
    object edtPort: TEdit
      AlignWithMargins = True
      Left = 42
      Top = 18
      Width = 50
      Height = 23
      Align = alLeft
      TabOrder = 0
      Text = '12345'
      ExplicitLeft = 31
    end
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 88
    Top = 320
  end
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    OnConnect = IdTCPServer1Connect
    OnExecute = IdTCPServer1Execute
    Left = 312
    Top = 320
  end
end
