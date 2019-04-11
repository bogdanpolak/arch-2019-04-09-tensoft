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
  Vcl.ExtCtrls,
  Thread.Sort;

type
  TBubbleThread = class(TSortThread)
  const
    ALGO_NAME = 'Bubble Sort';
  private
    procedure Sort;
  protected
    procedure Execute; override;
  end;

var
  BubbleSortIsWorking: boolean;

implementation

uses
  System.Diagnostics,
  WinApi.Windows;

{ TBubleThread }

procedure TBubbleThread.Execute;
var
  sw: TStopwatch;
begin
  FBoard.FAlgorithmName := ALGO_NAME;
  BubbleSortIsWorking := True;
  try
    sw := TStopwatch.StartNew;
    Sort;
    FBoard.FSortResults.TotalTime := sw.Elapsed;
    DoSynchroDrawSummary();
  finally
    BubbleSortIsWorking := False;
  end;
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
