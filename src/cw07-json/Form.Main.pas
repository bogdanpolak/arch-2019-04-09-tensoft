unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.JSON,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Splitter1: TSplitter;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


const
  data: array of string = [
    '"release=2018-11-21","product=10.3 Rio","ver=26.0","bds=20","months=20","codename=Carnival"',
    '"release=2017-03-22","product=10.2 Tokyo","ver=25.0","bds=19","months=11","codename=Godzilla"',
    '"release=2016-04-20","product=10.1 Berlin","ver=24.0","bds=18","months=8","codename=Big Ben"',
    '"release=2015-08-31","product=10.0 Seattle","ver=23.0","bds=17","months=5","codename=Aitana"',
    '"release=2015-04-07","product=XE8","ver=22.0","bds=16","months=7","codename=Elbrus"',
    '"release=2014-09-02","product=XE7","ver=21.0","bds=15","months=5","codename=Carpathia"',
    '"release=2014-04-15","product=XE6","ver=20.0","bds=14","months=7","codename=Proteus"',
    '"release=2013-09-11","product=XE5","ver=19.0","bds=12","months=5","codename=Zephyr"',
    '"release=2013-04-22","product=XE4","ver=18.0","bds=11","months=7","codename=Quintessence"',
    '"release=2012-09-03","product=XE3","ver=17.0","bds=10","months=12","codename=WaterDragon"',
    '"release=2011-09-02","product=XE2","ver=16.0","bds=9","months=13","codename=Pulsar"',
    '"release=2010-08-30","product=XE","ver=15.0","bds=8","months=12","codename=Fulcrum"',
    '"release=2009-08-15","product=2010","ver=14.0","bds=7","months=9","codename=Weaver"'
  ];

function CreateJsonData(): TJSONArray;
var
  i: Integer;
  sl: TStringList;
  jProduct: TJSONObject;
begin
  Result := TJSONArray.Create;
  sl := TStringList.Create;
  for i := 1 to High(data) do
  begin
    sl.CommaText := data[i];
    jProduct := TJSONObject.Create;
    jProduct.AddPair('product', sl.Values['product']);
    jProduct.AddPair('release', sl.Values['release']);
    jProduct.AddPair('ver', sl.Values['ver']);
    jProduct.AddPair('months', TJSONNumber.Create((sl.Values['months'])));
    jProduct.AddPair('codename', sl.Values['codename']);
    Result.AddElement(jProduct);
  end;
  sl.Free;  // TODO: try-finally
end;

procedure WriteJsonDataToMemo (data: TJSONArray; aMemo: TMemo);
var
  jv: TJSONValue;
begin
  for jv in data do
    aMemo.Lines.Add('   ' + (jv as TJSONObject).ToString);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  JsonDelphiVersions: TJSONArray;
begin
  Memo1.Lines.Add('------------------------------------------------------');
  JsonDelphiVersions := CreateJsonData();
  WriteJsonDataToMemo (JsonDelphiVersions, Memo1);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  JsonDelphiVersions: TJSONArray;
  s: string;
  delphi2009: TJSONObject;
begin
  Memo1.Lines.Add('------------------------------------------------------');
  JsonDelphiVersions := CreateJsonData();
  s := '{'+
    '"product":"2009",'+
    '"release":"2008-09-25",'+
    '"ver":"12.0",'+
    '"bdsver":"6",'+
    '"months":14,'+
    '"codename":"Tiburón"'+
  '}';
  delphi2009 := TJSONObject.ParseJSONValue(s) as TJSONObject;
  if not Assigned(delphi2009) then
    raise Exception.Create('Not a valid JSON');
  JsonDelphiVersions.Add(delphi2009);
  WriteJsonDataToMemo(JsonDelphiVersions, Memo1);
end;

end.
