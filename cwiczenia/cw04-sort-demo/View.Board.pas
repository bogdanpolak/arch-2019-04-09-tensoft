{ * ------------------------------------------------------------------------
  * ♥ ♥ ♥  Akademia BSC © 2019
  * Informacja:
  *   Kod źródłowy stworzony na potrzeby ćwiczeniowe
  * Autor:
  *   Bogdan Polak
  *  ----------------------------------------------------------------------- * }
unit View.Board;

interface

uses
  System.Classes,
  Vcl.ExtCtrls, Vcl.Graphics,
  Model.Board;

type
  TBoardView = class
  private
    FBoard: TBoard;
    FPaintBox: TPaintBox;
    function GetColor(value: Integer): TColor;
  public
    FAlgorithmName: string;
    constructor Create(ABoard: TBoard; APaintBox: TPaintBox);
    function CalculateTotalVisibleItems: Integer;
    procedure DrawItem(index: Integer);
    procedure DrawBoard();
    procedure DrawResults();
    property Board: TBoard read FBoard; // write FBoard;
    property PaintBox: TPaintBox read FPaintBox; // write FPaintBox;
  end;

implementation

uses
  System.SysUtils,
  Colors.Hsl;

function TBoardView.CalculateTotalVisibleItems: Integer;
begin
  Result := FPaintBox.Width div 6
end;

constructor TBoardView.Create(ABoard: TBoard; APaintBox: TPaintBox);
begin
  FBoard := ABoard;
  FPaintBox := APaintBox;
end;

procedure TBoardView.DrawBoard;
var
  i: Integer;
begin
  FPaintBox.Canvas.Brush.Color := FPaintBox.Color;
  FPaintBox.Canvas.FillRect(Rect(0, 0, FPaintBox.Width, FPaintBox.Height));
  for i := 0 to FBoard.Count - 1 do
    DrawItem(i);
end;

procedure TBoardView.DrawItem(index: Integer);
var
  c: TCanvas;
  x: Integer;
  maxhg: Integer;
  j: Integer;
  value: Integer;
begin
  maxhg := FPaintBox.Height;
  value := FBoard.Data[Index];
  j := round(value * maxhg / TBoard.MaxValue);
  c := FPaintBox.Canvas;
  x := index * 6;
  c.Pen.Style := psClear;
  c.Brush.Color := FPaintBox.Color;
  c.Rectangle(x, 0, x + 5, maxhg - (j) + 1);
  c.Brush.Color := GetColor(value);
  c.Rectangle(x, maxhg - (j), x + 5, maxhg);
end;

procedure TBoardView.DrawResults;
var
  c: TCanvas;
begin
  c := FPaintBox.Canvas;
  c.Brush.Style := bsClear;
  c.Font.Height := 18;
  c.Font.Style := [fsBold];
  c.TextOut(10, 5, FAlgorithmName);
  c.Font.Style := [];
  c.TextOut(10, 25, Format('items: %d', [FBoard.Count]));
  c.TextOut(10, 45, Format('time: %.3f',
    [FBoard.FSortResults.TotalTime.TotalSeconds]));
  c.TextOut(10, 65, Format('swaps: %d', [FBoard.FSortResults.SwapCounter]));
end;

function TBoardView.GetColor(value: Integer): TColor;
var
  Hue: Integer;
  col: TRgbColor;
begin
  Hue := round(value * 256 / (TBoard.MaxValue + 1));
  col := HSLtoRGB(Hue, 220, 120);
  Result := (col.r or (col.g shl 8) or (col.b shl 16));
end;

end.
