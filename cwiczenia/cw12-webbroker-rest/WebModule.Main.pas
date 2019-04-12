unit WebModule.Main;

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  Web.HTTPApp;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    function CreateJsonData: TJSONArray;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


var
  Data: array of string =
    ['"release=2018-11-21","product=10.3 Rio","ver=26.0","bds=20","months=20","codename=Carnival"',
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
    '"release=2009-08-15","product=2010","ver=14.0","bds=7","months=9","codename=Weaver"'];

function TWebModule1.CreateJsonData(): TJSONArray;
var
  i: Integer;
  sl: TStringList;
  jProduct: TJSONObject;
begin
  Result := TJSONArray.Create;
  sl := TStringList.Create;
  for i := 1 to High(Data) do
  begin
    sl.CommaText := Data[i];
    jProduct := TJSONObject.Create;
    jProduct.AddPair('product', sl.Values['product']);
    jProduct.AddPair('release', sl.Values['release']);
    jProduct.AddPair('ver', sl.Values['ver']);
    jProduct.AddPair('months', TJSONNumber.Create((sl.Values['months'])));
    jProduct.AddPair('codename', sl.Values['codename']);
    Result.AddElement(jProduct);
  end;
  sl.Free; // TODO: try-finally
end;

function JsonToData (jo: TJSONObject): string;
var
  sl: TStringList;
  s: string;
begin
  sl := TStringList.Create;
  sl.Values['product'] := jo.GetValue('product').Value;
  sl.Values['release'] := jo.GetValue('release').Value;
  sl.Values['ver'] :=  jo.GetValue('ver').Value;
  sl.Values['months'] :=  jo.GetValue('months').Value;
  sl.Values['codename'] :=  jo.GetValue('codename').Value;
  Result := sl.CommaText;
  sl.Free;
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  newJson: TJSONObject;
  count: Integer;
begin
  Response.ContentType := 'application/json';
  case Request.MethodType of
    mtGet: Response.Content := CreateJsonData.ToString;
    mtPut: begin
      // if Request.ContentType <> 'aaplication/json'  then exception!!!!!
      newJson := TJSONObject.ParseJSONValue(Request.Content) as TJSONObject;
      count := Length(Data)+1;
      SetLength(Data,count);
      Data[count-1] := JsonToData (newJson);
    end;
    mtPost: ;
    mtDelete: ;
    else
      raise Exception.Create('Error Message');
  end;

end;

end.
