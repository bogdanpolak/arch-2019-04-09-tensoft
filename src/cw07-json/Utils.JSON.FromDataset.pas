unit Utils.JSON.FromDataset;

interface

uses
  System.SysUtils, Data.DB, System.JSON;

type
  EDataRowToJSONConvertError = class(Exception);

function DataRowToJSON(ds: TDataSet): TJSONObject;
function DataSetToJson(ds: TDataSet): TJSONArray;


implementation

uses
  System.Classes, System.DateUtils, Data.SqlTimSt, Data.FmtBcd,
  Data.DBXJSONCommon;

type
  TDataSetToJsonHelper = class helper for TDataSet
    function AsJSON(): TJSONArray;
  end;

function BooleanToJSON(const b: Boolean): TJSONValue;
begin
  if b then
    Result := TJSONTrue.Create
  else
    Result := TJSONFalse.Create;
end;

function BlobFieldToJSONArray(fld: TBlobField): TJSONArray;
var
  ms: TMemoryStream;
begin
  if fld.IsNull then
    raise EDataRowToJSONConvertError.Create
      ('Cant conver NULL stream into JSON.')
  else
  begin
    ms := TMemoryStream.Create;
    try
      TBlobField(fld).SaveToStream(ms);
      ms.Position := 0;
      Result := Data.DBXJSONCommon.TDBXJSONTools.StreamToJSON(ms, 0, ms.Size);
    finally
      FreeAndNil(ms);
    end;
  end;
end;

function DateToISODate(dt: TDateTime): string;
begin
  Result := System.SysUtils.FormatDateTime('yyyy-mm-dd', dt);
end;

function DataRowToJSON(ds: TDataSet): TJSONObject;
var
  i: Integer;
  fldName: string;
  fld: TField;
  jv: TJSONValue;
begin
  Result := TJSONObject.Create;
  for i := 0 to ds.FieldCount - 1 do
  begin
    fld := ds.Fields[i];
    fldName := ds.Fields[i].FieldName;
    if ds.Fields[i].IsNull then
      Result.AddPair(fldName, TJSONNull.Create)
    else
    begin
      case ds.Fields[i].DataType of
        TFieldType.ftBoolean:
          jv := BooleanToJSON(fld.AsBoolean);
        TFieldType.ftAutoInc, TFieldType.ftInteger, TFieldType.ftSmallint,
        TFieldType.ftShortint:
          jv := TJSONNumber.Create(fld.AsInteger);
        TFieldType.ftLargeint:
          jv := TJSONNumber.Create(fld.AsLargeInt);
        TFieldType.ftSingle, TFieldType.ftFloat:
          jv := TJSONNumber.Create(fld.AsFloat);
        ftString, ftWideString, ftMemo, ftWideMemo:
          jv := TJSONString.Create(fld.AsString);
        TFieldType.ftDate:
          jv := TJSONString.Create(DateToISODate(fld.AsDateTime));
        TFieldType.ftTimeStamp,
        TFieldType.ftDateTime:
          jv := TJSONString.Create(System.DateUtils.DateToISO8601(fld.AsDateTime, False));
        TFieldType.ftCurrency:
          jv := TJSONNumber.Create(fld.AsCurrency);
        TFieldType.ftBCD,
        TFieldType.ftFMTBcd:
          jv := TJSONNumber.Create(Data.FmtBcd.BcdToDouble(fld.AsBcd));
        TFieldType.ftGraphic, TFieldType.ftBlob, TFieldType.ftStream:
          jv := BlobFieldToJSONArray(fld as TBlobField);
        // TODO: complete support for some fields types in datarow to JSON
        // TFieldType.ftTime:   // unsupported field
        // TFieldType.ftDataSet:  // unsuppored nested datasets
      else
        raise EDataRowToJSONConvertError.CreateFmt
          ('Unsupported field type for: "%s"', [fldName]);
      end;
      Result.AddPair(fldName, jv);
    end;
  end;
end;

function DataSetToJson(ds: TDataSet): TJSONArray;
var
  bmk: TBookmark;
begin
  if not(ds.Active) or (ds = nil) or ds.IsEmpty then
    Result := nil
  else begin
    bmk := ds.GetBookmark;
    Result := TJSONArray.Create;
    try
      ds.First;
      while not ds.Eof do
      begin
        Result.AddElement( DataRowToJSON(ds) );
        ds.Next;
      end;
      if ds.BookmarkValid(bmk) then
        ds.GotoBookmark(bmk);
    finally
      if ds.BookmarkValid(bmk) then
        ds.FreeBookmark(bmk);
    end;
  end;
end;

{ TDataSetToJsonHelper }

function TDataSetToJsonHelper.AsJSON: TJSONArray;
var
  bmk: TBookmark;
begin
  if not(self.Active) or (self = nil) or self.IsEmpty then
    Result := nil
  else begin
    bmk := self.GetBookmark;
    Result := TJSONArray.Create;
    try
      self.First;
      while not self.Eof do
      begin
        Result.AddElement( DataRowToJSON(self) );
        self.Next;
      end;
      if self.BookmarkValid(bmk) then
        self.GotoBookmark(bmk);
    finally
      Result.Free;
      if self.BookmarkValid(bmk) then
        self.FreeBookmark(bmk);
    end;
  end;
end;

end.
