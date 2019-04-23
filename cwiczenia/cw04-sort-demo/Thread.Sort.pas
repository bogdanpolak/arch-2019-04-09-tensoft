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
  System.SysUtils,
  Model.Board,
  View.Board;

type
  TSortThread = class(TThread)
  private
    FProcessTime: double;
  protected
    FBoard: TBoard;
    FView: TBoardView;
    procedure DoSwap(i, j: Integer);
    procedure Sort; virtual; abstract;
  public
    constructor Create(ABoard: TBoard; AView: TBoardView; SwapTime: double);
    procedure Execute; override;
  end;

implementation

uses
  WinApi.Windows, // QueryPerformanceCounter
  System.Diagnostics;

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

constructor TSortThread.Create(ABoard: TBoard; AView: TBoardView;
  SwapTime: double);
var
  IsSuspended: Boolean;
begin
  FBoard := ABoard;
  FView := AView;
  FreeOnTerminate := False;
  IsSuspended := False;
  FProcessTime := SwapTime;
  inherited Create(IsSuspended);
end;

procedure TSortThread.Execute;
var
  sw: TStopwatch;
begin
  NameThreadForDebugging(FView.FAlgorithmName);
  sw := TStopwatch.StartNew;
  Sort;
  FBoard.FSortResults.TotalTime := sw.Elapsed;
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
  WaitMilisecond(FProcessTime);
end;

end.
