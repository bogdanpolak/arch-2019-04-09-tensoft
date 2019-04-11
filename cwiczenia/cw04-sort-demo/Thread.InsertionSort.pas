{ * ------------------------------------------------------------------------
  * ♥ ♥ ♥  Akademia BSC © 2019
  * Informacja:
  *   Kod źródłowy stworzony na potrzeby ćwiczeniowe
  * Autor:
  *   Bogdan Polak
  *  ----------------------------------------------------------------------- * }
unit Thread.InsertionSort;

interface

uses
  System.Classes,
  Thread.Sort;

type
  TInsertionThread = class(TSortThread)
  private
    procedure Sort;
  protected
    procedure Execute; override;
  end;

implementation

uses
  System.Diagnostics;

{ TBubleThread }

procedure TInsertionThread.Execute;
var
  sw: TStopwatch;
begin
  inherited;
  sw := TStopwatch.StartNew;
  Sort;
  FBoard.FSortResults.TotalTime := sw.Elapsed;
  DoSynchroDrawSummary();
end;

procedure TInsertionThread.Sort;
var
  i: Integer;
  j: Integer;
  minIdx: Integer;
  minv: Integer;
begin
  for i := 0 to FBoard.Count - 1 do
  begin
    minIdx := i;
    minv := FBoard.Data[i];
    for j := i + 1 to FBoard.Count - 1 do
    begin
      if FBoard.Data[j] < minv then
      begin
        minIdx := j;
        minv := FBoard.Data[j];
      end;
    end;
    if minIdx <> i then
      DoSwap(i, minIdx);
    if Terminated then
      break;
  end;
end;

end.
