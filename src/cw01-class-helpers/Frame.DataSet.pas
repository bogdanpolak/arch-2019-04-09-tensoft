unit Frame.DataSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.JSON;

type
  TFrameDataSet = class(TFrame)
    GroupBox1: TGroupBox;
    btnExportToJSON: TButton;
    btnGridColumnsAutoSize: TButton;
    DBGrid1: TDBGrid;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    FDQuery1ID: TFDAutoIncField;
    FDQuery1FullName: TWideStringField;
    FDQuery1JobTitle: TStringField;
    FDQuery1Prefix: TStringField;
    FDQuery1BirthDate: TDateTimeField;
    FDQuery1HireDate: TDateTimeField;
    FDQuery1HiredAtAge: TLargeintField;
    FDQuery1Address: TStringField;
    FDQuery1City: TStringField;
    FDQuery1Country: TStringField;
    Memo1: TMemo;
    Splitter1: TSplitter;
    procedure btnExportToJSONClick(Sender: TObject);
    procedure btnGridColumnsAutoSizeClick(Sender: TObject);
  private
    procedure EmployeesProcess(employees: TJSONArray);
    function ExportEmployeesToJSON: TJSONArray;
  public
    procedure ExecuteDemo();
  end;

implementation

{$R *.dfm}

uses
  Helper.TDBGrid,
  Helper.TDataSet;


// ----------------------------------------------------
// TJSONArrayHelper
// ----------------------------------------------------
(*
  type 
  TJSONArrayHelper = class helper for TJSONArray
  function AddObject: TJSONObject;
  end;

  function TJSONArrayHelper.AddObject: TJSONObject;
  begin
  Result := TJSONObject.Create;
  self.AddElement( Result );
  end;
*)
// ----------------------------------------------------
// ----------------------------------------------------

procedure TFrameDataSet.EmployeesProcess(employees: TJSONArray);
var
  elem: TJSONValue;
begin
  Memo1.Clear;
  Memo1.Lines.Add('[');
  for elem in employees do
    Memo1.Lines.Add('  ' + elem.ToString + ',');
  Memo1.Lines.Add(']');
end;

function TFrameDataSet.ExportEmployeesToJSON: TJSONArray;
var
  jarr: TJSONArray;
begin
  jarr := TJSONArray.Create;
  Result := jarr;
  FDQuery1.ForEachRow(
    procedure()
    var
      jobj: TJSONObject;
    begin
      jobj := TJSONObject.Create;
      with jobj do
      begin
        AddPair('id', FDQuery1['ID']);
        AddPair('fullname', FDQuery1['FullName']);
        AddPair('jobtitle', FDQuery1['JobTitle']);
        AddPair('birthdate', FDQuery1['BirthDate']);
        AddPair('hiredate', FDQuery1['HireDate']);
        AddPair('city', FDQuery1['City']);
        AddPair('country', FDQuery1['Country']);
      end;
      jarr.AddElement(jobj);
    end);
end;

procedure TFrameDataSet.btnExportToJSONClick(Sender: TObject);
var
  employees: TJSONArray;
begin
  employees := ExportEmployeesToJSON;
  EmployeesProcess(employees);
  employees.Free;
end;

procedure TFrameDataSet.btnGridColumnsAutoSizeClick(Sender: TObject);
begin
  DBGrid1.AutoSizeColumns();
end;

procedure TFrameDataSet.ExecuteDemo;
begin
  FDQuery1.Open();
end;

end.
