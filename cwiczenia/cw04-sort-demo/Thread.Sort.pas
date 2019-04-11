{ * ------------------------------------------------------------------------
  * ♥ ♥ ♥  Akademia BSC © 2019
  * Informacja:
  *   Kod źródłowy stworzony na potrzeby ćwiczeniowe
  * Autor:
  *   Bogdan Polak
  *  ----------------------------------------------------------------------- * }
unit Thread.Sort;

interface

uses
  System.Classes,
  Model.Board,
  View.Board;

type
  TSortThread = class(TThread)
  protected
    FBoard: TBoard;
    FView: TBoardView;
    procedure DoSynchroDrawSummary;
    procedure DoSwap(i, j: Integer);
  public
    constructor Create(ABoard: TBoard; AView: TBoardView);
  end;

implementation

uses
  WinApi.Windows;

procedure WaitMilisecond(timeMs: double);
var
  startTime64, endTime64, frequency64: Int64;
begin
  WinApi.Windows.QueryPerformanceFrequency(frequency64);
  WinApi.Windows.QueryPerformanceCounter(startTime64);
  WinApi.Windows.QueryPerformanceCounter(endTime64);
  while ((endTime64 - startTime64) / frequency64 * 1000 < timeMs) do
    WinApi.Windows.QueryPerformanceCounter(endTime64);
end;

constructor TSortThread.Create(ABoard: TBoard; AView: TBoardView);
begin
  FBoard := ABoard;
  FreeOnTerminate := True;
  FView := AView;
  // Nie ruszać Create (musi być na końcu)
  inherited Create;
end;

procedure TSortThread.DoSynchroDrawSummary();
begin
  Synchronize(
    procedure()
    begin
      FView.DrawResults();
    end);
end;

procedure TSortThread.DoSwap(i, j: Integer);
begin
  FBoard.swap(i, j);
  Synchronize(
    procedure()
    begin
      FView.DrawItem(i);
      FView.DrawItem(j);
    end);
  WaitMilisecond(1.3);
end;

end.
