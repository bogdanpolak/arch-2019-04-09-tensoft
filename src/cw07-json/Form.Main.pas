unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Splitter1: TSplitter;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.JSON;

const
  data: array of string = [
    // ver: Delphi conditional VER
    // prod: Product Name
    // prVer: Product Version
    // pgVer: Package Version
    // coVer: CompilerVersion
    '"ver=VER330","prod=10.3 Rio","prVer=26","pgVer=260","coVer=33.0"',
    '"ver=VER320","prod=10.2 Tokyo","prVer=25","pgVer=250","coVer=32.0"',
    '"ver=VER310","prod=10.1 Berlin","prVer=24","pgVer=240","coVer=31.0"',
    '"ver=VER300","prod=10 Seattle","prVer=23","pgVer=230","coVer=30.0"',
    '"ver=VER290","prod=XE8","prVer=22","pgVer=220","coVer=29.0"',
    '"ver=VER280","prod=XE7","prVer=21","pgVer=210","coVer=28.0"',
    '"ver=VER270","prod=XE6","prVer=20","pgVer=200","coVer=27.0"',
    '"ver=VER260","prod=XE5","prVer=19","pgVer=190","coVer=26.0"',
    '"ver=VER250","prod=XE4","prVer=18","pgVer=180","coVer=25.0"'
  ];

procedure TForm1.Button1Click(Sender: TObject);
var
  jVersions: TJSONArray;
  i: Integer;
  sl: TStringList;
  jv: TJSONValue;
begin
  jVersions := TJSONArray.Create;
  sl := TStringList.Create;
  for i := 1 to High(data) do begin
    sl.CommaText := data[i];
    jVersions.Add(sl.Values['prod']);
  end;
  for jv in jVersions do
    Memo1.Lines.Add('   '+jv.Value);
  sl.Free;  // TODO: try-finally
end;

end.
