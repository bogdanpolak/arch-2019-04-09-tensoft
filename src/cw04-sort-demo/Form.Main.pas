unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    GroupBox1: TGroupBox;
    Button1: TButton;
    tmrReady: TTimer;
    Timer1: TTimer;
    procedure tmrReadyTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    EnableSorting: Boolean;
    procedure RunSortPrototype;
    procedure BubbleSort(data: TArray<Integer>);
    procedure swap (i, j: Integer; data: TArray<Integer>);
    procedure DrawBoard(paintbox: TPaintBox; data: TArray<Integer>);
    procedure DrawItem(paintbox: TPaintBox; index, value: integer);
    procedure GenerateData(var data: TArray<Integer>; items: Integer);
    procedure DrawResults(paintbox: TPaintBox; const msg: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.Diagnostics, Colors.Hsl;

const
  MaxValue = 100;

procedure TForm1.Button1Click(Sender: TObject);
begin
  RunSortPrototype
end;

var
  SwapPaintBox: TPaintBox;

procedure WaitMilisecond( timeMs: double );
var
  startTime64, endTime64, frequency64: Int64;
begin
  QueryPerformanceFrequency(frequency64);
  QueryPerformanceCounter(startTime64);
  QueryPerformanceCounter(endTime64);
  while ((endTime64 - startTime64) / frequency64 * 1000 < timeMs) do
    QueryPerformanceCounter(endTime64);
end;

procedure TForm1.swap (i, j: Integer; data: TArray<Integer>);
var
  v: Integer;
begin
  v := data[i];
  data[i] := data [j];
  data[j] := v;
  DrawItem (SwapPaintBox, i, data[i]);
  DrawItem (SwapPaintBox, j, data[j]);
  Application.ProcessMessages;
  WaitMilisecond (1.5);
end;

procedure TForm1.BubbleSort (data: TArray<Integer>);
var
  i: Integer;
  j: Integer;
  sw: TStopwatch;
begin
  sw := TStopwatch.StartNew;
  for i := 0 to Length(data)-1 do
    for j := 0 to Length(data)-2 do
      if data[j] > data [j+1] then begin
        swap( j, j+1, data );
        if not(EnableSorting) then
          break;
      end;
  DrawResults (SwapPaintBox, Format('[%d] ',[Length(data)])+sw.Elapsed.ToString);
end;

function GetColor (value: integer): TColor;
var
  Hue: Integer;
  col: TRgbColor;
begin
  Hue := round(value*256/(MaxValue+1));
  col := HSLtoRGB (Hue, 220, 120);
  Result := RGB (col.r, col.g, col.b);
end;

procedure TForm1.DrawItem (paintbox: TPaintBox; index, value: integer);
var
  c: TCanvas;
  x: Integer;
  maxhg: Integer;
  j: Integer;
begin
  maxhg := paintbox.Height;
  j := round( value * maxhg / MaxValue);
  c := paintbox.Canvas;
  x := index * 6;
  c.Pen.Style := psClear;
  c.Brush.Color := paintbox.Color;
  c.Rectangle( x, 0, x+5, maxhg-(j) );
  c.Brush.Color := GetColor(value);
  c.Rectangle( x, maxhg-(j), x+5, maxhg );
end;

procedure TForm1.DrawBoard (paintbox: TPaintBox; data: TArray<Integer>);
var
  i: Integer;
begin
  paintbox.Canvas.Brush.Color := paintbox.Color;
  paintbox.Canvas.FillRect( Rect(0,0,paintbox.Width,paintbox.Height) );
  for i := 0 to Length(data)-1 do
    DrawItem(paintbox, i, data[i]);
end;

procedure TForm1.DrawResults (paintbox: TPaintBox; const msg: string);
begin
  paintbox.Canvas.Brush.Style := bsClear;
  paintbox.Canvas.Font.Height := 20;
  paintbox.Canvas.TextOut( 15,10, msg );
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  EnableSorting := false;
end;

procedure TForm1.GenerateData (var data: TArray<Integer>; items:Integer);
var
  i: Integer;
begin
  randomize;
  SetLength(data, items);
  for i := 0 to Length(data)-1 do
    data[i] := random(MaxValue)+1;
end;

procedure TForm1.RunSortPrototype;
var
  data: TArray<Integer>;
  paintbox: TPaintBox;
  items: Integer;
begin
  paintbox := PaintBox1;
  EnableSorting := true;
  items := round (paintbox.Width / 6) -1;
  GenerateData (data, items);
  DrawBoard(paintbox, data);
  SwapPaintBox := paintbox;
  BubbleSort (data);
end;

procedure TForm1.tmrReadyTimer(Sender: TObject);
begin
  tmrReady.Enabled := false;
end;

end.
