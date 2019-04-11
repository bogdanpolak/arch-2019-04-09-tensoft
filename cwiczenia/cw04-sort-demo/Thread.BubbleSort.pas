{ * ------------------------------------------------------------------------
  * ♥ ♥ ♥  Akademia BSC © 2019
  * Informacja:
  *   Kod źródłowy stworzony na potrzeby ćwiczeniowe
  * Autor:
  *   Bogdan Polak
  *  ----------------------------------------------------------------------- * }
unit Thread.BubbleSort;

interface

uses
  System.Classes,
  Thread.Sort;

type
  TBubbleThread = class(TSortThread)
  private
    procedure Sort;
  protected
    procedure Execute; override;
  end;

implementation

uses
  System.Diagnostics;

{ TBubleThread }

procedure TBubbleThread.Execute;
var
  sw: TStopwatch;
begin
  inherited;
  sw := TStopwatch.StartNew;
  Sort;
  FBoard.FSortResults.TotalTime := sw.Elapsed;
  DoSynchroDrawSummary();
end;

procedure TBubbleThread.Sort;
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to FBoard.Count - 1 do
    for j := 0 to FBoard.Count - 2 do
      if FBoard.Data[j] > FBoard.Data[j + 1] then
      begin
        if Self.Terminated then
          break;
        DoSwap(j, j + 1);
      end;
end;

end.
