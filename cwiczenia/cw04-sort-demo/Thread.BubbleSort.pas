unit Thread.BubbleSort;

interface

uses
  System.Classes,
  Vcl.ExtCtrls,
  Thread.Sort;

type
  TBubleThread = class(TSortThread)
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

procedure TBubleThread.Execute;
var
  i: Integer;
  j: Integer;
  sw: TStopwatch;
begin
  BubbleSortIsWorking := True;
  sw := TStopwatch.StartNew;
  for i := 0 to Length(data) - 1 do
    for j := 0 to Length(data) - 2 do
      if data[j] > data[j + 1] then
      begin
        if Self.Terminated then
          break;
        Self.swap(j, j + 1);
      end;
  Synchronize(
    procedure()
    begin
      DrawResults(FSwapPaintBox, 'Bubble Sort', Length(data), sw.Elapsed,
        SwapCounter);
    end);
  BubbleSortIsWorking := False;
end;

end.
