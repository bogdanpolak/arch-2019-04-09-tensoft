object FrameDataSet: TFrameDataSet
  Left = 0
  Top = 0
  Width = 419
  Height = 320
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 0
    Top = 195
    Width = 419
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 225
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 413
    Height = 54
    Align = alTop
    Caption = 'GroupBox1'
    Padding.Top = 4
    Padding.Bottom = 1
    TabOrder = 0
    ExplicitWidth = 314
    object btnExportToJSON: TButton
      AlignWithMargins = True
      Left = 5
      Top = 22
      Width = 132
      Height = 26
      Align = alLeft
      Caption = 'btnExportToJSON'
      TabOrder = 0
      OnClick = btnExportToJSONClick
    end
    object btnGridColumnsAutoSize: TButton
      AlignWithMargins = True
      Left = 143
      Top = 22
      Width = 178
      Height = 26
      Align = alLeft
      Caption = 'btnGridColumnsAutoSize'
      TabOrder = 1
      OnClick = btnGridColumnsAutoSizeClick
    end
  end
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 63
    Width = 413
    Height = 132
    Margins.Bottom = 0
    Align = alClient
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 200
    Width = 413
    Height = 117
    Margins.Top = 0
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=SQLite_Demo')
    Left = 128
    Top = 112
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT EmployeeID as ID, FirstName||'#39' '#39'||LastName as FullName, '
      '  Title as JobTitle, TitleOfCourtesy as Prefix, '
      '  BirthDate, HireDate, HireDate-BirthDate as HiredAtAge, '
      '  Address, City, Country  '
      'FROM Employees')
    Left = 208
    Top = 112
    object FDQuery1ID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'EmployeeID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDQuery1FullName: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'FullName'
      Origin = 'FullName'
      ProviderFlags = []
      ReadOnly = True
      Size = 32767
    end
    object FDQuery1JobTitle: TStringField
      FieldName = 'JobTitle'
      Origin = 'Title'
      Size = 30
    end
    object FDQuery1Prefix: TStringField
      FieldName = 'Prefix'
      Origin = 'TitleOfCourtesy'
      Size = 25
    end
    object FDQuery1BirthDate: TDateTimeField
      FieldName = 'BirthDate'
      Origin = 'BirthDate'
    end
    object FDQuery1HireDate: TDateTimeField
      FieldName = 'HireDate'
      Origin = 'HireDate'
    end
    object FDQuery1HiredAtAge: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'HiredAtAge'
      Origin = 'HiredAtAge'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQuery1Address: TStringField
      FieldName = 'Address'
      Origin = 'Address'
      Size = 60
    end
    object FDQuery1City: TStringField
      FieldName = 'City'
      Origin = 'City'
      Size = 15
    end
    object FDQuery1Country: TStringField
      FieldName = 'Country'
      Origin = 'Country'
      Size = 15
    end
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 280
    Top = 112
  end
end
