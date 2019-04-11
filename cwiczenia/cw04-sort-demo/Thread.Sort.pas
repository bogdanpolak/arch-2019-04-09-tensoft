unit Thread.Sort;

interface

uses
  System.Classes, System.TimeSpan,
  Vcl.Graphics, Vcl.ExtCtrls,
  Model.Board;

type
  TSortThread = class(TThread)
  private
    class function GetColor(value: Integer): TColor;
  protected
    FSwapPaintBox: TPaintBox;
    FBoard: TBoard;
    procedure DoSwap(i, j: Integer);
  public
    class procedure DrawItem(paintbox: TPaintBox; index, value: Integer);
    class procedure DrawBoard(paintbox: TPaintBox; Board:TBoard);
    class procedure DrawResults(paintbox: TPaintBox; const name: string;
      Board: TBoard; enlapsed: TTimeSpan);
    constructor Create(Count: Integer; ASwapPaintBox: TPaintBox);
  end;

implementation

uses
  System.Diagnostics,
  System.SysUtils,
  Colors.Hsl,
  WinApi.Windows;

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

constructor TSortThread.Create(Count: Integer; ASwapPaintBox: TPaintBox);
begin
  FBoard := TBoard.Create(nil);
  FSwapPaintBox := ASwapPaintBox;
  FreeOnTerminate := True;
  FBoard.GenerateData(Count);
  DrawBoard (FSwapPaintBox,FBoard);
  // Nie ruszaæ Create (musi byæ na koñcu)
  inherited Create;
end;

procedure TSortThread.DoSwap(i, j: Integer);
begin
  FBoard.swap(i,j);
  Synchronize(
    procedure()
    begin
      DrawItem(FSwapPaintBox, i, FBoard.Data[i] );
      DrawItem(FSwapPaintBox, j, FBoard.Data[j] );
    end);
  WaitMilisecond (1.0);
end;

class function TSortThread.GetColor(value: Integer): TColor;
var
  Hue: Integer;
  col: TRgbColor;
begin
  Hue := round(value * 256 / (TBoard.MaxValue + 1));
  col := HSLtoRGB(Hue, 220, 120);
  Result := RGB(col.r, col.g, col.b);
end;

class procedure TSortThread.DrawItem(paintbox: TPaintBox; index, value: Integer);
var
  c: TCanvas;
  x: Integer;
  maxhg: Integer;
  j: Integer;
begin
  maxhg := paintbox.Height;
  j := round(value * maxhg / TBoard.MaxValue);
  c := paintbox.Canvas;
  x := index * 6;
  c.Pen.Style := psClear;
  c.Brush.Color := paintbox.Color;
  c.Rectangle(x, 0, x + 5, maxhg - (j) + 1);
  c.Brush.Color := GetColor(value);
  c.Rectangle(x, maxhg - (j), x + 5, maxhg);
end;

class procedure TSortThread.DrawBoard (paintbox: TPaintBox; Board:TBoard);
var
  i: Integer;
begin
  paintbox.Canvas.Brush.Color := paintbox.Color;
  paintbox.Canvas.FillRect( Rect(0,0,paintbox.Width,paintbox.Height) );
  for i := 0 to Board.Count-1 do
    TSortThread.DrawItem(paintbox, i, Board.Data[i]);
end;

class procedure TSortThread.DrawResults (paintbox: TPaintBox; const name: string;
  Board: TBoard; enlapsed: TTimeSpan);
begin
  paintbox.Canvas.Brush.Style := bsClear;
  paintbox.Canvas.Font.Height := 18;
  paintbox.Canvas.Font.Style := [fsBold];
  paintbox.Canvas.TextOut( 10,5, name );
  paintbox.Canvas.Font.Style := [];
  paintbox.Canvas.TextOut( 10,25, Format('items: %d',[Board.Count]) );
  paintbox.Canvas.TextOut( 10,45, Format('time: %.3f',[enlapsed.TotalSeconds]) );
  paintbox.Canvas.TextOut( 10,65, Format('swaps: %d',[Board.SwapCounter]) );
end;


end.
